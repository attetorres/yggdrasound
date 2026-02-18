import axios from "axios";
import * as cheerio from "cheerio";

export const scraperBandcampConcerts = async (req, res) => {
  try {
    const { album_url } = req.body;

    if (!album_url) {
      return res.status(400).json({
        success: false,
        message: "La URL es obligatoria",
      });
    }

    const { data } = await axios.get(album_url);
    const $ = cheerio.load(data);
    const listItems = $("#showography ul li");

    const concerts = [];
    listItems.each((i, el) => {
      const item = $(el);
      concerts.push({
        date: item.find(".showDate").text().trim(),
        venue: item.find(".showVenue a").text().trim(),
        venueLink: item.find(".showVenue a").attr("href"),
        city: item.find(".showLoc").text().trim(),
      });
    });

    res.json({
      success: true,
      data: concerts,
    });
  } catch (error) {
    console.error("Error en scraping:", error.message);
    res.status(500).json({
      success: false,
      message: "Error al obtener conciertos de Bandcamp",
      error: error.message,
    });
  }
};
