import express from "express";
import {
  getGenres,
  getGenreById,
  getGenreByName,
  getGenresByVinylId,
  createGenre,
  updateGenre,
  deleteGenre,
} from "../controllers/genreController.js";

const router = express.Router();

// GET
router.get("/", getGenres);
router.get("/get-genre-by-id/:id", getGenreById);
router.get("/get-genre-by-name/:name", getGenreByName);
router.get("/get-genres-by-vinylId/:vinyl_id", getGenresByVinylId);

// POST
router.post("/create-genre", createGenre);

// PUT
router.put("/update-genre/:id", updateGenre);

// DELETE
router.delete("/delete-genre/:id", deleteGenre);

export default router;
