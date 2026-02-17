import OrderHistory from "../models/OrderHistory.js";
import OrderVinyl from "../models/OrderVinyl.js";
import User from "../models/User.js";
import Vinyl from "../models/Vinyl.js";

// MÉTODOS GET
export const getOrders = async (req, res) => {
  try {
    const { page = 1, limit = 20 } = req.query;
    const offset = (page - 1) * limit;

    const { count, rows: orders } = await OrderHistory.findAndCountAll({
      limit: parseInt(limit),
      offset: parseInt(offset),
      order: [["order_date", "DESC"]],
    });

    if (orders.length === 0) {
      return res.json({
        success: true,
        data: [],
        pagination: {
          total: 0,
          page: 1,
          limit: parseInt(limit),
          totalPages: 0,
        },
      });
    }

    const userIds = [...new Set(orders.map((order) => order.user_id))];
    const users = await User.findAll({
      where: { id: userIds },
      attributes: ["id", "username", "name", "email"],
    });

    const orderIds = orders.map((order) => order.id);
    const orderItems = await OrderVinyl.findAll({
      where: { order_id: orderIds },
    });

    const itemsByOrder = {};
    orderItems.forEach((item) => {
      if (!itemsByOrder[item.order_id]) {
        itemsByOrder[item.order_id] = [];
      }
      itemsByOrder[item.order_id].push(item);
    });

    const ordersWithDetails = orders.map((order) => {
      const user = users.find((u) => u.id === order.user_id);
      const items = itemsByOrder[order.id] || [];

      return {
        id: order.id,
        user_id: order.user_id,
        user: user || null,
        order_date: order.order_date,
        total_amount: order.total_amount,
        quantity: order.quantity,
        items_count: items.length,
        created_at: order.created_at,
      };
    });

    res.json({
      success: true,
      data: ordersWithDetails,
      pagination: {
        total: count,
        page: parseInt(page),
        limit: parseInt(limit),
        totalPages: Math.ceil(count / limit),
      },
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};

export const getOrderById = async (req, res) => {
  try {
    const order = await OrderHistory.findByPk(req.params.id);

    if (!order) {
      return res.status(404).json({
        success: false,
        message: "Pedido no encontrado",
      });
    }

    const user = await User.findByPk(order.user_id, {
      attributes: ["id", "username", "name", "email"],
    });

    const orderItems = await OrderVinyl.findAll({
      where: { order_id: order.id },
    });

    const vinylIds = orderItems.map((item) => item.vinyl_id);
    const vinyls = await Vinyl.findAll({
      where: { id: vinylIds },
      attributes: ["id", "artist", "album", "album_cover"],
    });

    const items = orderItems.map((item) => {
      const vinyl = vinyls.find((v) => v.id === item.vinyl_id);
      return {
        id: item.id,
        vinyl_id: item.vinyl_id,
        quantity: item.quantity,
        unit_price: item.unit_price,
        subtotal: (item.quantity * item.unit_price).toFixed(2),
        vinyl: vinyl || null,
      };
    });

    res.json({
      success: true,
      data: {
        order: {
          id: order.id,
          user_id: order.user_id,
          user: user,
          order_date: order.order_date,
          total_amount: order.total_amount,
          quantity: order.quantity,
          created_at: order.created_at,
        },
        items: items,
        summary: {
          items_count: items.length,
          total_items: order.quantity,
          total_amount: order.total_amount,
        },
      },
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};

export const getOrdersByUser = async (req, res) => {
  try {
    const user_id = req.user.id;
    const { page = 1, limit = 5 } = req.query;
    const offset = (parseInt(page) - 1) * parseInt(limit);

    const { count, rows: orders } = await OrderHistory.findAndCountAll({
      where: { user_id },
      order: [["order_date", "DESC"]],
      limit: parseInt(limit),
      offset: offset,
    });

    if (count === 0) {
      return res.json({
        success: true,
        data: {
          orders: [],
          pagination: {
            totalItems: 0,
            totalPages: 0,
            currentPage: parseInt(page),
          },
        },
      });
    }

    const orderIds = orders.map((o) => o.id);
    const orderItems = await OrderVinyl.findAll({
      where: { order_id: orderIds },
    });

    const vinylIds = [...new Set(orderItems.map((i) => i.vinyl_id))];
    const vinyls = await Vinyl.findAll({
      where: { id: vinylIds },
      attributes: ["id", "artist", "album", "album_cover"],
    });

    const formattedOrders = orders.map((order) => {
      const items = orderItems
        .filter((item) => item.order_id === order.id)
        .map((item) => {
          const vinylInfo = vinyls.find((v) => v.id === item.vinyl_id);
          return {
            ...item.toJSON(),
            vinyl: vinylInfo,
          };
        });

      return { ...order.toJSON(), items: items };
    });

    res.json({
      success: true,
      data: {
        orders: formattedOrders,
        pagination: {
          totalItems: count,
          totalPages: Math.ceil(count / limit),
          currentPage: parseInt(page),
          limit: parseInt(limit),
        },
      },
    });
  } catch (error) {
    console.error("Error detallado:", error);
    res
      .status(500)
      .json({ success: false, message: "Error al cargar historial" });
  }
};

// MÉTODOS POST
export const createOrder = async (req, res) => {
  try {
    const user_id = req.user.id;
    const { items } = req.body;

    if (!items || !Array.isArray(items)) {
      return res.status(400).json({
        success: false,
        message: "Datos inválidos",
      });
    }

    const vinylIds = items.map((item) => item.vinyl_id);
    const vinyls = await Vinyl.findAll({
      where: { id: vinylIds },
      attributes: ["id", "price"],
    });

    let total_amount = 0;
    let total_quantity = 0;
    const orderItems = [];

    items.forEach((item) => {
      const vinyl = vinyls.find((v) => v.id === item.vinyl_id);
      const quantity = item.quantity || 1;
      const unit_price = vinyl ? parseFloat(vinyl.price) : 0;

      total_amount += unit_price * quantity;
      total_quantity += quantity;

      orderItems.push({
        vinyl_id: item.vinyl_id,
        quantity: quantity,
        unit_price: unit_price,
      });
    });

    const order = await OrderHistory.create({
      user_id,
      total_amount: parseFloat(total_amount.toFixed(2)),
      quantity: total_quantity,
      order_date: new Date(),
    });

    const itemsToCreate = orderItems.map((item) => ({
      order_id: order.id,
      vinyl_id: item.vinyl_id,
      quantity: item.quantity,
      unit_price: item.unit_price,
    }));

    await OrderVinyl.bulkCreate(itemsToCreate);

    res.status(201).json({
      success: true,
      message: "Pedido creado",
      data: {
        id: order.id,
        user_id: order.user_id,
        total_amount: order.total_amount,
        items_count: items.length,
        created_at: order.created_at,
      },
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
      error: error.message,
    });
  }
};
