import User from "../models/User.js";
import Vinyl from "../models/Vinyl.js";
import OrderHistory from "../models/OrderHistory.js";
import OrderVinyl from "../models/OrderVinyl.js";
import { Sequelize, Op } from "sequelize";
import bcrypt from "bcryptjs";

export const getDashboardStats = async (req, res) => {
  try {
    const [totalUsers, totalVinyls, orderStats] = await Promise.all([
      User.count(),
      Vinyl.count(),

      OrderHistory.findOne({
        attributes: [
          [Sequelize.fn("COUNT", Sequelize.col("id")), "totalOrders"],
          [Sequelize.fn("SUM", Sequelize.col("total_amount")), "totalRevenue"],
        ],
        raw: true,
      }),
    ]);

    res.json({
      success: true,
      data: {
        totalUsers,
        totalVinyls,
        totalOrders: parseInt(orderStats.totalOrders) || 0,
        totalRevenue: parseFloat(orderStats.totalRevenue || 0).toFixed(2),
      },
    });
  } catch (error) {
    console.error("Error al obtener estadísticas de admin:", error);
    res.status(500).json({
      success: false,
      message: "Error interno del servidor al recopilar estadísticas.",
    });
  }
};

export const getAdminOrders = async (req, res) => {
  try {
    const {
      page = 1,
      limit = 25,
      search = "",
      sortBy = "order_date",
      order = "DESC",
    } = req.query;

    const offset = (parseInt(page) - 1) * parseInt(limit);

    const whereCondition = search
      ? {
          [Op.or]: [
            ...(!isNaN(search) ? [{ id: parseInt(search) }] : []),

            ...(!isNaN(search) ? [{ user_id: parseInt(search) }] : []),

            Sequelize.where(Sequelize.col("User.username"), {
              [Op.like]: `%${search}%`,
            }),
            Sequelize.where(Sequelize.col("User.email"), {
              [Op.like]: `%${search}%`,
            }),
          ],
        }
      : {};

    const allowedSortFields = ["order_date", "total_amount", "quantity", "id"];
    const activeSortField = allowedSortFields.includes(sortBy)
      ? sortBy
      : "order_date";
    const activeOrder = order.toUpperCase() === "ASC" ? "ASC" : "DESC";

    const { count, rows: orders } = await OrderHistory.findAndCountAll({
      where: whereCondition,
      limit: parseInt(limit),
      offset: offset,
      distinct: true,
      order: [[activeSortField, activeOrder]],
      include: [
        {
          model: User,
          attributes: ["id", "username", "email", "name", "surname"],
        },
      ],
    });

    res.json({
      success: true,
      data: orders,
      pagination: {
        totalItems: count,
        totalPages: Math.ceil(count / limit),
        currentPage: parseInt(page),
      },
    });
  } catch (error) {
    console.error("Error al obtener todas las ventas:", error);
    res.status(500).json({ success: false, message: "Error interno" });
  }
};

export const getOrderDetail = async (req, res) => {
  try {
    const { id } = req.params;

    const order = await OrderHistory.findByPk(id, {
      include: [
        {
          model: User,
          attributes: [
            "username",
            "email",
            "name",
            "surname",
            "city",
            "country",
            "street",
            "number",
            "postcode",
          ],
        },
        {
          model: OrderVinyl,
          include: [
            {
              model: Vinyl,
              attributes: ["artist", "album", "album_cover"],
            },
          ],
        },
      ],
    });

    if (!order) {
      return res
        .status(404)
        .json({ success: false, message: "Pedido no encontrado" });
    }

    res.json({ success: true, data: order });
  } catch (error) {
    console.error("Error al obtener detalle:", error);
    res.status(500).json({ success: false, message: error.message });
  }
};

export const getAdminUsers = async (req, res) => {
  try {
    const {
      page = 1,
      limit = 10,
      search = "",
      sortBy = "created_at",
      order = "DESC",
    } = req.query;

    const offset = (parseInt(page) - 1) * parseInt(limit);

    const whereCondition = search
      ? {
          [Op.or]: [
            ...(!isNaN(search) ? [{ id: parseInt(search) }] : []),
            { username: { [Op.like]: `%${search}%` } },
            { email: { [Op.like]: `%${search}%` } },
            { name: { [Op.like]: `%${search}%` } },
            { surname: { [Op.like]: `%${search}%` } },
          ],
        }
      : {};

    const allowedSortFields = [
      "id",
      "username",
      "email",
      "created_at",
      "is_admin",
    ];
    const activeSortField = allowedSortFields.includes(sortBy)
      ? sortBy
      : "created_at";
    const activeOrder = order.toUpperCase() === "ASC" ? "ASC" : "DESC";

    const { count, rows: users } = await User.findAndCountAll({
      where: whereCondition,
      limit: parseInt(limit),
      offset: offset,
      attributes: { exclude: ["password"] },
      order: [[activeSortField, activeOrder]],
    });

    res.json({
      success: true,
      data: users,
      pagination: {
        totalItems: count,
        totalPages: Math.ceil(count / limit),
        currentPage: parseInt(page),
      },
    });
  } catch (error) {
    console.error("Error al obtener usuarios:", error);
    res
      .status(500)
      .json({ success: false, message: "Error al obtener usuarios" });
  }
};

export const createUser = async (req, res) => {
  try {
    const userData = { ...req.body };

    const passwordToHash = userData.password || "password123";

    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(passwordToHash, saltRounds);

    userData.password = hashedPassword;

    const newUser = await User.create(userData);

    const userResponse = newUser.toJSON();
    delete userResponse.password;

    res.status(201).json({
      success: true,
      message: "Usuario creado correctamente",
      data: userResponse,
    });
  } catch (error) {
    console.error("Error al crear usuario (Admin):", error);

    if (error.name === "SequelizeUniqueConstraintError") {
      return res.status(400).json({
        success: false,
        message: "El email o username ya están en uso.",
      });
    }

    if (error.name === "SequelizeValidationError") {
      return res.status(400).json({
        success: false,
        message: "Datos de usuario inválidos",
        errors: error.errors.map((err) => err.message),
      });
    }

    res.status(500).json({
      success: false,
      message: "Error interno al crear el usuario",
    });
  }
};

export const updateUser = async (req, res) => {
  try {
    const { id } = req.params;
    const updateData = { ...req.body };

    const user = await User.findByPk(id);
    if (!user) {
      return res
        .status(404)
        .json({ success: false, message: "Usuario no encontrado" });
    }

    if (updateData.password && updateData.password.trim() !== "") {
      const saltRounds = 10;
      updateData.password = await bcrypt.hash(updateData.password, saltRounds);
    } else {
      delete updateData.password;
    }

    await user.update(updateData);

    const userResponse = user.toJSON();
    delete userResponse.password;

    res.json({
      success: true,
      message: "Usuario actualizado correctamente",
      data: userResponse,
    });
  } catch (error) {
    console.error("Error al actualizar usuario:", error);

    if (error.name === "SequelizeUniqueConstraintError") {
      return res
        .status(400)
        .json({ success: false, message: "El email o username ya existen" });
    }

    res
      .status(500)
      .json({ success: false, message: "Error al actualizar el usuario" });
  }
};

export const deleteUser = async (req, res) => {
  try {
    const { id } = req.params;
    const user = await User.findByPk(id);

    if (!user) {
      return res
        .status(404)
        .json({ success: false, message: "Usuario no encontrado" });
    }

    await user.destroy();
    res.json({ success: true, message: "Usuario eliminado con éxito" });
  } catch (error) {
    res
      .status(500)
      .json({ success: false, message: "Error al eliminar usuario" });
  }
};
