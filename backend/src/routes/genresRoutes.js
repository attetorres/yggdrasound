import express from "express";
import {
  getGenres,
  getGenreById,
  getGenreByName,
  createGenre,
  updateGenre,
  deleteGenre,
} from "../controllers/genresController.js";

const router = express.Router();

// GET
router.get("/", getGenres);
router.get("/get-genre-by-id/:id", getGenreById);
router.get("/get-genre-by-name/:name", getGenreByName);

// POST
router.post("/create-genre", createGenre);

// PUT
router.put("/update-genre/:id", updateGenre);

// DELETE
router.delete("/delete-genre/:id", deleteGenre);

export default router;
