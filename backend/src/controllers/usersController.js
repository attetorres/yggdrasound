import User from "../models/User.js";

export const getUsers = async (req, res) => {
  try {
    const { page = 1, limit = 50 } = req.query;
    const offset = (page - 1) * limit;

    const { count, rows } = await User.findAndCountAll({
      limit: parseInt(limit),
      offset: parseInt(offset),
      order: [["created_at", "DESC"]],
    });

    res.json({
      success: true,
      data: rows,
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
    console.error("Error en getUsers:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener usuarios",
    });
  }
};

export const getUserById = async (req, res) => {
  try {
    const { id } = req.params;

    const user = await User.findByPk(id);

    if (!user) {
      return res.status(404).json({
        success: false,
        message: `Usuario con ID ${id} no encontrado`,
      });
    }

    res.json({
      success: true,
      data: user,
    });
  } catch (error) {
    console.error("Error en getUserById:", error);

    res.status(500).json({
      success: false,
      message: "Error al obtener usuario",
      error: error.message,
    });
  }
};

export const getUserByUsername = async (req, res) => {
  try {
    const { username } = req.params;

    const user = await User.findOne({
      where: { username: username },
      attributes: { exclude: ["password"] },
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        message: `Usuario con nombre de usuario "${username}" no encontrado`,
      });
    }

    res.json({
      success: true,
      data: user,
    });
  } catch (error) {
    console.error("Error en getUserByUsername:", error);

    res.status(500).json({
      success: false,
      message: "Error al obtener usuario",
      error: error.message,
    });
  }
};
