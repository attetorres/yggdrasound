import User from "../models/User.js";
import Vinyl from "../models/Vinyl.js";
import OrderHistory from "../models/OrderHistory.js";
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

// Añade este método a tu adminController.js
export const getAdminOrders = async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;
    const offset = (parseInt(page) - 1) * parseInt(limit);

    const { count, rows: orders } = await OrderHistory.findAndCountAll({
      limit: parseInt(limit),
      offset: offset,
      order: [["order_date", "DESC"]],
      // Incluimos el modelo User para no tener que hacer búsquedas manuales
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
    res
      .status(500)
      .json({
        success: false,
        message: "Error al obtener historial de ventas",
      });
  }
};
