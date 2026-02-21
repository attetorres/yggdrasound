import User from "../models/User.js";
import Vinyl from "../models/Vinyl.js";
import OrderHistory from "../models/OrderHistory.js";
import OrderVinyl from "../models/OrderVinyl.js";
import { Sequelize, Op } from "sequelize";
import bcrypt from "bcryptjs";
import Genre from "../models/Genre.js";

// FUNCIÓN AUXILIAR PARA FORMATEAR DURACIÓN
const formatDurationForPostgres = (duration) => {
  let raw = typeof duration === "object" ? duration?.total : duration;
  if (!raw || typeof raw !== "string" || raw.trim() === "") return null;

  const parts = raw.split(":");
  if (parts.length === 2) {
    return `00:${parts[0].padStart(2, "0")}:${parts[1].padStart(2, "0")}`;
  }
  if (parts.length === 3) {
    return raw;
  }
  return null;
};

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
            ...(!isNaN(search) && Number.isInteger(Number(search))
              ? [{ id: parseInt(search) }]
              : []),
            { username: { [Op.iLike]: `%${search}%` } },
            { email: { [Op.iLike]: `%${search}%` } },
            { name: { [Op.iLike]: `%${search}%` } },
            { surname: { [Op.iLike]: `%${search}%` } },
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

export const getAdminVinyls = async (req, res) => {
  try {
    const {
      page = 1,
      limit = 10,
      search = "",
      sortBy = "created_at",
      order = "DESC",
      genre = "",
    } = req.query;

    const offset = (parseInt(page) - 1) * parseInt(limit);

    const whereCondition = search
      ? {
          [Op.or]: [
            { artist: { [Op.iLike]: `%${search}%` } },
            { album: { [Op.iLike]: `%${search}%` } },

            ...(!isNaN(search) && Number.isInteger(Number(search))
              ? [{ id: parseInt(search) }]
              : []),
          ],
        }
      : {};

    const allowedSortFields = [
      "id",
      "artist",
      "album",
      "price",
      "release_date",
      "created_at",
    ];
    const activeSortField = allowedSortFields.includes(sortBy)
      ? sortBy
      : "created_at";
    const activeOrder = order.toUpperCase() === "ASC" ? "ASC" : "DESC";

    const genreInclude = {
      model: Genre,
      as: "genres",
      attributes: ["name"],
      through: { attributes: [] },
    };

    if (genre && genre !== "") {
      genreInclude.where = { name: genre };
      genreInclude.required = true;
    }

    const { count, rows: vinyls } = await Vinyl.findAndCountAll({
      where: whereCondition,
      limit: parseInt(limit),
      offset: offset,
      order: [[activeSortField, activeOrder]],
      distinct: true,
      include: [genreInclude],
    });

    res.json({
      success: true,
      data: vinyls,
      pagination: {
        totalItems: count,
        totalPages: Math.ceil(count / limit),
        currentPage: parseInt(page),
      },
    });
  } catch (error) {
    console.error("Error detallado en getAdminVinyls:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener catálogo: " + error.message,
    });
  }
};

export const createVinyl = async (req, res) => {
  try {
    const {
      artist,
      album,
      price,
      release_date,
      album_cover,
      band_location,
      duration,
      track_list,
      genres,
    } = req.body;

    const validDate =
      release_date && release_date.trim() !== "" ? release_date : null;
    const postgresDuration = formatDurationForPostgres(duration);

    const newVinyl = await Vinyl.create({
      artist,
      album,
      price: parseFloat(price),
      release_date: validDate,
      album_cover,
      band_location,
      duration: postgresDuration,
      track_list: Array.isArray(track_list) ? track_list : [],
      track_count: track_list?.length || 0,
    });

    if (genres && genres.length > 0) {
      const genreNames = genres.map((g) =>
        typeof g === "string" ? g : g.name,
      );
      const foundGenres = await Genre.findAll({ where: { name: genreNames } });
      await newVinyl.setGenres(foundGenres);
    }

    res
      .status(201)
      .json({ success: true, message: "Creado con éxito", data: newVinyl });
  } catch (error) {
    console.error("Error al crear:", error);
    res.status(500).json({ success: false, message: error.message });
  }
};

export const updateVinyl = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      artist,
      album,
      price,
      release_date,
      album_cover,
      band_location,
      duration,
      track_list,
      genres,
    } = req.body;

    const vinyl = await Vinyl.findByPk(id);
    if (!vinyl)
      return res.status(404).json({ success: false, message: "No encontrado" });

    const validDate =
      release_date && release_date.trim() !== "" ? release_date : null;
    const postgresDuration = formatDurationForPostgres(duration);

    await vinyl.update({
      artist,
      album,
      price: parseFloat(price),
      release_date: validDate,
      album_cover,
      band_location,
      duration: postgresDuration,
      track_list: Array.isArray(track_list) ? track_list : [],
      track_count: track_list?.length || 0,
    });

    if (genres) {
      const namesToFind = genres.map((g) =>
        typeof g === "string" ? g : g.name,
      );
      const foundGenres = await Genre.findAll({ where: { name: namesToFind } });
      await vinyl.setGenres(foundGenres);
    }

    res.json({
      success: true,
      message: "Actualizado correctamente",
      data: vinyl,
    });
  } catch (error) {
    console.error("Error en update:", error);
    res.status(500).json({ success: false, message: error.message });
  }
};

export const deleteVinyl = async (req, res) => {
  try {
    const { id } = req.params;

    const vinyl = await Vinyl.findByPk(id);

    if (!vinyl) {
      return res.status(404).json({
        success: false,
        message: "El vinilo que intentas eliminar no existe.",
      });
    }

    await vinyl.destroy();

    res.json({
      success: true,
      message: `El vinilo "${vinyl.album}" ha sido eliminado correctamente.`,
    });
  } catch (error) {
    console.error("--- ERROR AL ELIMINAR VINILO ---");
    console.error(error);
    res.status(500).json({
      success: false,
      message: "Error interno del servidor al eliminar: " + error.message,
    });
  }
};
