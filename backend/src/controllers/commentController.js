import Comment from "../models/Comment.js";
import User from "../models/User.js";
import Vinyl from "../models/Vinyl.js";
import { Op } from "sequelize";

// MÉTODOS GET

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
          [Op.iLike]: username,
        },
      },
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        message: `Usuario con nombre de usuario "${username}" no encontrado`,
      });
    }

    const { count, rows } = await Comment.findAndCountAll({
      where: { user_id: user.id },
      limit: parseInt(limit),
      offset: parseInt(offset),
      order: [["created_at", "DESC"]],
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

export const getCommentsByVinylId = async (req, res) => {
  try {
    const { id } = req.params;
    const { page = 1, limit = 10 } = req.query;
    const offset = (page - 1) * limit;

    Comment.belongsTo(User, { foreignKey: "user_id" });

    const { count, rows } = await Comment.findAndCountAll({
      where: { vinyl_id: id },
      limit: parseInt(limit),
      offset: parseInt(offset),
      order: [["created_at", "DESC"]],
      include: [
        {
          model: User,
          attributes: ["name", "avatar_img"],
        },
      ],
    });

    res.json({
      success: true,
      data: rows,
      pagination: {
        total: count,
        totalPages: Math.ceil(count / limit),
        currentPage: parseInt(page),
      },
    });
  } catch (error) {
    console.error("Error en getCommentsByVinylId:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener comentarios",
      error: error.message,
    });
  }
};

// MÉTODOS POST
export const createComment = async (req, res) => {
  try {
    const { vinyl_id, comment_text } = req.body;
    const user_id = req.user.id;

    if (!vinyl_id || !comment_text) {
      return res.status(400).json({ success: false, message: "Faltan datos" });
    }

    const newComment = await Comment.create({
      user_id,
      vinyl_id,
      comment_text,
    });

    const commentWithUser = await Comment.findByPk(newComment.id, {
      include: [{ model: User, attributes: ["name", "avatar_img"] }],
    });

    res.status(201).json({
      success: true,
      data: commentWithUser,
    });
  } catch (error) {
    console.error("Error en createComment:", error);
    res.status(500).json({
      success: false,
      message: "Error al crear comentario",
      error: error.message,
    });
  }
};

// MÉTODOS PUT

export const updateComment = async (req, res) => {
  try {
    const { id } = req.params;
    const { comment_text } = req.body;

    if (!comment_text || comment_text.trim() === "") {
      return res.status(400).json({
        success: false,
        message: "El texto del comentario es obligatorio",
      });
    }

    const comment = await Comment.findByPk(id);

    if (!comment) {
      return res.status(404).json({
        success: false,
        message: `Comentario con ID ${id} no encontrado`,
      });
    }

    await comment.update({
      comment_text: comment_text.trim(),
    });

    res.json({
      success: true,
      message: "Comentario actualizado exitosamente",
      data: comment,
    });
  } catch (error) {
    console.error("Error en updateComment:", error);
    res.status(500).json({
      success: false,
      message: "Error al actualizar comentario",
      error: error.message,
    });
  }
};

// MÉTODOS DELETE

export const deleteComment = async (req, res) => {
  try {
    const { id } = req.params;

    const comment = await Comment.findByPk(id);

    if (!comment) {
      return res.status(404).json({
        success: false,
        message: `Comentario con ID ${id} no encontrado`,
      });
    }

    await comment.destroy();

    res.json({
      success: true,
      message: "Comentario eliminado exitosamente",
    });
  } catch (error) {
    console.error("Error en deleteComment:", error);
    res.status(500).json({
      success: false,
      message: "Error al eliminar comentario",
      error: error.message,
    });
  }
};
