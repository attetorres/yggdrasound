import Comment from "../models/Comment.js";
import User from "../models/User.js";
import Vinyl from "../models/Vinyl.js";

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
  // Implementaremos después
};

export const getCommentByAlbum = async (req, res) => {
  // Implementaremos después
};
