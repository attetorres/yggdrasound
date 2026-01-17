import User from "../models/User.js";

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
