import Vinyl from "../models/Vinyl.js";

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
