import Genre from "../models/Genre.js";
import Vinyl from "../models/Vinyl.js";
import VinylGenre from "../models/VinylGenre.js";
import { Op } from "sequelize";

// MÉTODOS GET

export const getGenres = async (req, res) => {
  try {
    const genres = await Genre.findAll({
      order: [["name", "ASC"]],
    });

    res.json({
      success: true,
      data: genres,
      count: genres.length,
    });
  } catch (error) {
    console.error("Error en getGenres:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener géneros",
      error: error.message,
    });
  }
};

export const getGenreById = async (req, res) => {
  try {
    const { id } = req.params;
    const genre = await Genre.findByPk(id);

    if (!genre) {
      return res.status(404).json({
        success: false,
        message: `Género con ID ${id} no encontrado`,
      });
    }

    res.json({
      success: true,
      data: genre,
    });
  } catch (error) {
    console.error("Error en getGenreById:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener género",
      error: error.message,
    });
  }
};

export const getGenreByName = async (req, res) => {
  try {
    const { name } = req.params;
    const genre = await Genre.findOne({
      where: { name },
    });

    if (!genre) {
      return res.status(404).json({
        success: false,
        message: `Género "${name}" no encontrado`,
      });
    }

    res.json({
      success: true,
      data: genre,
    });
  } catch (error) {
    console.error("Error en getGenreByName:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener género",
      error: error.message,
    });
  }
};

export const getGenresByVinylId = async (req, res) => {
  try {
    const { vinyl_id } = req.params;

    const vinyl = await Vinyl.findByPk(vinyl_id);
    if (!vinyl) {
      return res.status(404).json({
        success: false,
        message: `Vinilo con ID ${vinyl_id} no encontrado`,
      });
    }

    const vinylGenres = await VinylGenre.findAll({
      where: { vinyl_id },
      attributes: ["genre_id"],
    });

    const genreIds = vinylGenres.map((vg) => vg.genre_id);

    const genres = await Genre.findAll({
      where: { id: genreIds },
      attributes: ["id", "name"],
    });

    res.json({
      success: true,
      data: genres,
    });
  } catch (error) {
    console.error("Error en getGenresByVinylId:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener géneros del vinilo",
      error: error.message,
    });
  }
};

// MÉTODOS POST

export const createGenre = async (req, res) => {
  try {
    const { name } = req.body;

    if (!name) {
      return res.status(400).json({
        success: false,
        message: "El nombre del género es obligatorio",
      });
    }

    const existingGenre = await Genre.findOne({
      where: { name },
    });

    if (existingGenre) {
      return res.status(409).json({
        success: false,
        message: `El género "${name}" ya existe`,
      });
    }

    const newGenre = await Genre.create({ name });

    res.status(201).json({
      success: true,
      message: "Género creado exitosamente",
      data: newGenre,
    });
  } catch (error) {
    console.error("Error en createGenre:", error);
    res.status(500).json({
      success: false,
      message: "Error al crear género",
      error: error.message,
    });
  }
};

// MÉTODOS PUT

export const updateGenre = async (req, res) => {
  try {
    const { id } = req.params;
    const { name } = req.body;

    if (!name) {
      return res.status(400).json({
        success: false,
        message: "El nombre del género es obligatorio",
      });
    }

    const genre = await Genre.findByPk(id);

    if (!genre) {
      return res.status(404).json({
        success: false,
        message: `Género con ID ${id} no encontrado`,
      });
    }

    const existingGenre = await Genre.findOne({
      where: {
        name: name,
        id: { [Op.ne]: id },
      },
    });

    if (existingGenre) {
      return res.status(409).json({
        success: false,
        message: `El género "${name}" ya existe`,
      });
    }

    await genre.update({ name });

    res.json({
      success: true,
      message: "Género actualizado exitosamente",
      data: genre,
    });
  } catch (error) {
    console.error("Error en updateGenre:", error);
    res.status(500).json({
      success: false,
      message: "Error al actualizar género",
      error: error.message,
    });
  }
};

// MÉTODOS DELETE

export const deleteGenre = async (req, res) => {
  try {
    const { id } = req.params;

    const genre = await Genre.findByPk(id);

    if (!genre) {
      return res.status(404).json({
        success: false,
        message: `Género con ID ${id} no encontrado`,
      });
    }

    const vinylsCount = await VinylGenre.count({
      where: { genre_id: id },
    });

    if (vinylsCount > 0) {
      return res.status(409).json({
        success: false,
        message: `No se puede eliminar. Hay ${vinylsCount} vinilo(s) asociados a este género`,
        vinyls_count: vinylsCount,
      });
    }

    await genre.destroy();

    res.json({
      success: true,
      message: `Género "${genre.name}" eliminado exitosamente`,
      deleted_genre: {
        id: genre.id,
        name: genre.name,
      },
    });
  } catch (error) {
    console.error("Error en deleteGenre:", error);
    res.status(500).json({
      success: false,
      message: "Error al eliminar género",
      error: error.message,
    });
  }
};
