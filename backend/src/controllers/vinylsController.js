import Vinyl from "../models/Vinyl.js";
import { Op } from "sequelize";

export const getVinyls = async (req, res) => {
  try {
    const { page = 1, limit = 50 } = req.query;
    const offset = (page - 1) * limit;

    const { count, rows } = await Vinyl.findAndCountAll({
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
    console.error("Error en getVinyls:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener vinilos",
    });
  }
};

export const getVinylsByArtist = async (req, res) => {
  try {
    const { artist, page = 1, limit = 20 } = req.query;

    if (!artist) {
      return res.status(400).json({
        success: false,
        message: 'Se requiere el parámetro "artist" para la búsqueda',
      });
    }

    const offset = (page - 1) * limit;

    const { count, rows } = await Vinyl.findAndCountAll({
      where: {
        artist: {
          [Op.iLike]: `%${artist}%`,
        },
      },
      limit: parseInt(limit),
      offset: parseInt(offset),
      order: [
        ["artist", "ASC"],
        ["release_date", "DESC"],
      ],
    });

    res.json({
      success: true,
      data: rows,
      searchTerm: artist,
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
    console.error("Error en getVinylsByArtist:", error);
    res.status(500).json({
      success: false,
      message: "Error al buscar vinilos por artista",
    });
  }
};
