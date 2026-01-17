import Vinyl from "../models/Vinyl.js";
import Genre from "../models/Genre.js";
import VinylGenre from "../models/VinylGenre.js";
import sequelize from "../config/database.js";
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

export const getVinylById = async (req, res) => {
  try {
    const { id } = req.params;

    const vinyl = await Vinyl.findByPk(id);

    if (!vinyl) {
      return res.status(404).json({
        success: false,
        message: `Vinilo con ID ${id} no encontrado`,
      });
    }

    res.json({
      success: true,
      data: vinyl,
    });
  } catch (error) {
    console.error("Error en getVinylById:", error);

    res.status(500).json({
      success: false,
      message: "Error al obtener vinilo",
      error: error.message,
    });
  }
};

export const getVinylsByArtist = async (req, res) => {
  try {
    const { artist, page = 1, limit = 50 } = req.query;

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

export const getVinylsByAlbum = async (req, res) => {
  try {
    const { album, page = 1, limit = 50 } = req.query;

    if (!album) {
      return res.status(400).json({
        success: false,
        message: 'Se requiere el parámetro "album" para la búsqueda',
      });
    }

    const offset = (page - 1) * limit;

    const { count, rows } = await Vinyl.findAndCountAll({
      where: {
        album: {
          [Op.iLike]: `%${album}%`,
        },
      },
      limit: parseInt(limit),
      offset: parseInt(offset),
      order: [
        ["album", "ASC"],
        ["release_date", "DESC"],
      ],
    });

    res.json({
      success: true,
      data: rows,
      searchTerm: album,
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
    console.error("Error en getVinylsByAlbum:", error);
    res.status(500).json({
      success: false,
      message: "Error al buscar vinilos por álbum",
    });
  }
};

export const getVinylsByGenre = async (req, res) => {
  try {
    const { genre, page = 1, limit = 50 } = req.query;

    if (!genre) {
      return res.status(400).json({
        success: false,
        message: 'Se requiere el parámetro "genre"',
      });
    }

    const offset = (page - 1) * limit;

    // Buscar el ID del género EXACTO
    const genreVinyl = await Genre.findOne({
      where: { name: genre },
    });

    if (!genreVinyl) {
      return res.status(404).json({
        success: false,
        message: `Género "${genre}" no encontrado`,
      });
    }

    const { count, rows } = await Vinyl.findAndCountAll({
      where: {
        id: {
          [Op.in]: sequelize.literal(`
            (SELECT vinyl_id FROM vinyl_genre WHERE genre_id = ${genreVinyl.id})
          `),
        },
      },
      limit: parseInt(limit),
      offset: offset,
      order: [["artist", "ASC"]],
    });

    res.json({
      success: true,
      data: rows,
      genre: genreVinyl.name,
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
    console.error("Error en getVinylsByGenre:", error);
    res.status(500).json({
      success: false,
      message: "Error al buscar vinilos por género",
    });
  }
};
