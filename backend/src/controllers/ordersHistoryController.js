import OrderHistory from "../models/OrderHistory.js";
import OrderVinyl from "../models/OrderVinyl.js";
import User from "../models/User.js";
import Vinyl from "../models/Vinyl.js";

// MÉTODOS GET
export const getOrders = async (req, res) => {
  try {
    const { page = 1, limit = 50 } = req.query;
    const offset = (page - 1) * limit;

    const { count, rows } = await OrderHistory.findAndCountAll({
      limit: parseInt(limit),
      offset: parseInt(offset),
      order: [["order_date", "DESC"]],
      // SIN include por ahora
    });

    // Opcional: Obtener usuarios por separado si los necesitas
    const userIds = rows.map((order) => order.user_id);
    const users = await User.findAll({
      where: { id: userIds },
      attributes: ["id", "username", "name", "email"],
    });

    // Combinar datos
    const ordersWithUsers = rows.map((order) => {
      const user = users.find((u) => u.id === order.user_id);
      return {
        ...order.toJSON(),
        user: user || null,
      };
    });

    res.json({
      success: true,
      data: ordersWithUsers,
      pagination: {
        total: count,
        page: parseInt(page),
        limit: parseInt(limit),
        totalPages: Math.ceil(count / limit),
        showingFrom: offset + 1,
        showingTo: Math.min(offset + parseInt(limit), count),
      },
    });
  } catch (error) {
    console.error("Error en getOrders:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener pedidos",
    });
  }
};

// MÉTODOS POST
export const createOrder = async (req, res) => {
  try {
    const { user_id, items } = req.body;

    // Validaciones mínimas
    if (!user_id || !items || !Array.isArray(items)) {
      return res.status(400).json({
        success: false,
        message: "user_id y array de items son obligatorios",
      });
    }

    // Verificar usuario
    const user = await User.findByPk(user_id);
    if (!user) {
      return res.status(404).json({
        success: false,
        message: "Usuario no encontrado",
      });
    }

    // Crear pedido
    const order = await OrderHistory.create({
      user_id,
      total_amount: 0, // Temporal
      quantity: items.reduce((sum, item) => sum + (item.quantity || 1), 0),
      order_date: new Date(),
    });

    // Crear items del pedido
    const orderItems = items.map((item) => ({
      order_id: order.id,
      vinyl_id: item.vinyl_id,
      quantity: item.quantity || 1,
      unit_price: item.unit_price || 0,
    }));

    await OrderVinyl.bulkCreate(orderItems);

    // Respuesta simple
    res.status(201).json({
      success: true,
      message: "Pedido creado",
      data: {
        id: order.id,
        user_id: order.user_id,
        created_at: order.created_at,
      },
    });
  } catch (error) {
    console.error("Error en createOrder:", error);
    res.status(500).json({
      success: false,
      message: "Error al crear pedido",
      error: error.message,
    });
  }
};
