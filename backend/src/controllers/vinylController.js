import Vinyl from "../models/Vinyl.js";
import Genre from "../models/Genre.js";
import VinylGenre from "../models/VinylGenre.js";
import sequelize from "../config/database.js";
import { Op } from "sequelize";

// MÉTODOS GET

export const getVinyls = async (req, res) => {
  try {
    const {
      page = 1,
      limit = 30,
      search = "",
      genre = "",
      sort = "newest",
    } = req.query;

    const offset = (page - 1) * limit;

    const whereClause = {};

    if (search) {
      whereClause[Op.or] = [
        { artist: { [Op.iLike]: `%${search}%` } },
        { album: { [Op.iLike]: `%${search}%` } },
      ];
    }

    let orderClause = [];
    if (sort === "price-asc") {
      orderClause.push(["price", "ASC"]);
    } else if (sort === "price-desc") {
      orderClause.push(["price", "DESC"]);
    } else if (sort === "oldest") {
      orderClause.push(["created_at", "ASC"]);
    } else {
      orderClause.push(["created_at", "DESC"]);
    }

    // Consulta con JOIN a la tabla Genre
    const { count, rows } = await Vinyl.findAndCountAll({
      where: whereClause,
      limit: parseInt(limit),
      offset: parseInt(offset),
      order: orderClause,
      distinct: true, // Necesario para que el count sea correcto al usar include
      include: [
        {
          model: Genre,
          as: "Genres", // Asegúrate de que el alias coincida con tu asociación
          where: genre && genre !== "" ? { name: genre } : null,
          required: genre && genre !== "" ? true : false, // INNER JOIN si hay género, LEFT JOIN si no
          through: { attributes: [] }, // No traer datos de la tabla intermedia
        },
      ],
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
    console.error("Error detallado en getVinyls:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener vinilos",
      error: error.message,
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

// MÉTODOS POST

export const createVinyl = async (req, res) => {
  try {
    const {
      artist,
      album,
      album_url,
      band_location,
      release_date,
      album_cover,
      price,
      track_list,
      track_count,
      duration,
      band_url,
      genre,
    } = req.body;

    if (!artist || !album || !price || !genre) {
      return res.status(400).json({
        success: false,
        message: "Artista, álbum, precio y género son obligatorios",
      });
    }

    const existingVinyl = await Vinyl.findOne({
      where: {
        artist: { [Op.iLike]: artist },
        album: { [Op.iLike]: album },
      },
    });

    if (existingVinyl) {
      return res.status(409).json({
        success: false,
        message: `Ya existe un vinilo de "${artist}" - "${album}"`,
      });
    }

    const genreRecord = await Genre.findOne({
      where: {
        name: { [Op.iLike]: genre },
      },
    });

    if (!genreRecord) {
      return res.status(404).json({
        success: false,
        message: `Género "${genre}" no encontrado. Géneros válidos: rock, electronic, metal, alternative, hip-hop-rap, experimental, punk, pop, ambient`,
      });
    }

    const finalTrackCount = track_count || (track_list ? track_list.length : 0);

    const newVinyl = await Vinyl.create({
      artist,
      album,
      album_url: album_url || null,
      band_location: band_location || null,
      release_date: release_date || null,
      album_cover: album_cover || null,
      price: parseFloat(price),
      track_list: track_list || [],
      track_count: finalTrackCount,
      duration: duration || null,
      band_url: band_url || null,
    });

    await VinylGenre.create({
      vinyl_id: newVinyl.id,
      genre_id: genreRecord.id,
    });

    res.status(201).json({
      success: true,
      message: "Vinilo creado exitosamente",
      data: {
        id: newVinyl.id,
        artist: newVinyl.artist,
        album: newVinyl.album,
        price: newVinyl.price,
        genre: genreRecord.name,
        created_at: newVinyl.created_at,
      },
    });
  } catch (error) {
    console.error("Error en createVinyl:", error);

    if (error.name === "SequelizeValidationError") {
      return res.status(400).json({
        success: false,
        message: "Error de validación",
        errors: error.errors.map((err) => ({
          field: err.path,
          message: err.message,
        })),
      });
    }

    if (error.name === "SequelizeUniqueConstraintError") {
      return res.status(409).json({
        success: false,
        message: "Error de duplicado en la relación género-vinilo",
      });
    }

    res.status(500).json({
      success: false,
      message: "Error al crear vinilo",
      error: error.message,
    });
  }
};

// MÉTODOS PUT
export const updateVinyl = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      artist,
      album,
      album_url,
      band_location,
      release_date,
      album_cover,
      price,
      track_list,
      track_count,
      duration,
      band_url,
    } = req.body;

    const vinyl = await Vinyl.findByPk(id);

    if (!vinyl) {
      return res.status(404).json({
        success: false,
        message: `Vinilo con ID ${id} no encontrado`,
      });
    }

    // Verificar si se está cambiando artista/álbum y si ya existe
    if (
      (artist || album) &&
      (artist !== vinyl.artist || album !== vinyl.album)
    ) {
      const newArtist = artist || vinyl.artist;
      const newAlbum = album || vinyl.album;

      const existingVinyl = await Vinyl.findOne({
        where: {
          artist: { [Op.iLike]: newArtist },
          album: { [Op.iLike]: newAlbum },
          id: { [Op.ne]: id },
        },
      });

      if (existingVinyl) {
        return res.status(409).json({
          success: false,
          message: `Ya existe un vinilo de "${newArtist}" - "${newAlbum}"`,
        });
      }
    }

    const updateData = {};
    if (artist !== undefined) updateData.artist = artist;
    if (album !== undefined) updateData.album = album;
    if (album_url !== undefined) updateData.album_url = album_url;
    if (band_location !== undefined) updateData.band_location = band_location;
    if (release_date !== undefined) updateData.release_date = release_date;
    if (album_cover !== undefined) updateData.album_cover = album_cover;
    if (price !== undefined) updateData.price = parseFloat(price);
    if (track_list !== undefined) {
      updateData.track_list = track_list;
      // Si se actualiza track_list y no se da track_count, recalcular
      if (track_count === undefined) {
        updateData.track_count = track_list ? track_list.length : 0;
      }
    }
    if (track_count !== undefined) updateData.track_count = track_count;
    if (duration !== undefined) updateData.duration = duration;
    if (band_url !== undefined) updateData.band_url = band_url;

    await vinyl.update(updateData);

    res.json({
      success: true,
      message: "Vinilo actualizado exitosamente",
      data: vinyl,
    });
  } catch (error) {
    console.error("Error en updateVinyl:", error);
    res.status(500).json({
      success: false,
      message: "Error al actualizar vinilo",
      error: error.message,
    });
  }
};

// MÉTODOS DELETE
export const deleteVinyl = async (req, res) => {
  try {
    const { id } = req.params;

    const vinyl = await Vinyl.findByPk(id);

    if (!vinyl) {
      return res.status(404).json({
        success: false,
        message: `Vinilo con ID ${id} no encontrado`,
      });
    }

    await vinyl.destroy();

    res.json({
      success: true,
      message: `Vinilo "${vinyl.artist} - ${vinyl.album}" eliminado exitosamente`,
    });
  } catch (error) {
    console.error("Error en deleteVinyl:", error);
    res.status(500).json({
      success: false,
      message: "Error al eliminar vinilo",
      error: error.message,
    });
  }
};
