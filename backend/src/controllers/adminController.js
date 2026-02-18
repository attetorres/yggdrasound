import User from "../models/User.js";
import Vinyl from "../models/Vinyl.js";
import OrderHistory from "../models/OrderHistory.js";
import OrderVinyl from "../models/OrderVinyl.js";
import { Sequelize } from "sequelize";

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

/* export const getAdminRecentOrders = async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;
    const offset = (parseInt(page) - 1) * parseInt(limit);

    const { count, rows: orders } = await OrderHistory.findAndCountAll({
      limit: parseInt(limit),
      offset: offset,
      order: [["order_date", "DESC"]],
      include: [
        {
          model: User,
          attributes: ["id", "username", "email"],
        },
      ],
    });

    res.json({
      success: true,
      data: orders,
      pagination: {
        total: count,
        page: parseInt(page),
        limit: parseInt(limit),
        totalPages: Math.ceil(count / limit),
      },
    });
  } catch (error) {
    console.error("Error al obtener pedidos para admin:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener historial de ventas",
    });
  }
}; */

export const getAdminOrders = async (req, res) => {
  try {
    // Recogemos page y limit de la query, por defecto 1 y 25
    const { page = 1, limit = 25 } = req.query;
    const offset = (parseInt(page) - 1) * parseInt(limit);

    const { count, rows: orders } = await OrderHistory.findAndCountAll({
      limit: parseInt(limit),
      offset: offset,
      distinct: true,
      order: [["order_date", "DESC"]], // Lo más nuevo primero
      include: [
        {
          model: User,
          attributes: ["id", "username", "email", "name", "surname"], // Todos los datos del comprador
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
        itemsPerPage: parseInt(limit),
      },
    });
  } catch (error) {
    console.error("Error al obtener todas las ventas:", error);
    res
      .status(500)
      .json({ success: false, message: "Error interno del servidor" });
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
