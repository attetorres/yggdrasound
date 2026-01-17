import express from "express";
import {
  getVinyls,
  getVinylById,
  getVinylsByArtist,
  getVinylsByAlbum,
  getVinylsByGenre,
} from "../controllers/vinylsController.js";

const router = express.Router();

// GET
router.get("/", getVinyls);
router.get("/get-vinyl-by-id/:id", getVinylById);
router.get("/get-vinyls-by-artist/", getVinylsByArtist);
router.get("/get-vinyls-by-album/", getVinylsByAlbum);
router.get("/get-vinyls-by-genre/", getVinylsByGenre);

// POST

// PUT

export default router;
