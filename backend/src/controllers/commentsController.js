import Comment from "../models/Comment.js";
import User from "../models/User.js";
import Vinyl from "../models/Vinyl.js";
import { Op } from "sequelize";

export const getCommentById = async (req, res) => {
  try {
    const { id } = req.params;

    const comment = await Comment.findByPk(id);

    if (!comment) {
      return res.status(404).json({
        success: false,
        message: `Comentario con ID ${id} no encontrado`,
      });
    }

    res.json({
      success: true,
      data: comment,
    });
  } catch (error) {
    console.error("Error en getCommentById:", error);

    res.status(500).json({
      success: false,
      message: "Error al obtener comentario",
      error: error.message,
    });
  }
};

export const getCommentByUsername = async (req, res) => {
  try {
    const { username } = req.params;
    const { page = 1, limit = 20 } = req.query;
    const offset = (page - 1) * limit;

    const user = await User.findOne({
      where: {
        username: {
          [Op.iLike]: username, // Búsqueda insensible a mayúsculas/minúsculas
        },
      },
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        message: `Usuario con nombre de usuario "${username}" no encontrado`,
      });
    }

    // 2. Buscar comentarios del usuario con paginación
    const { count, rows } = await Comment.findAndCountAll({
      where: { user_id: user.id },
      limit: parseInt(limit),
      offset: parseInt(offset),
      order: [["created_at", "DESC"]], // Más recientes primero
    });

    res.json({
      success: true,
      data: rows,
      username: username,
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
    console.error("Error en getCommentByUsername:", error);

    res.status(500).json({
      success: false,
      message: "Error al obtener comentarios por usuario",
      error: error.message,
    });
  }
};

export const getCommentByAlbum = async (req, res) => {
  // Implementaremos después
};
