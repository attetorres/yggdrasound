import express from "express";
import {
  getVinyls,
  getVinylsByArtist,
} from "../controllers/vinylsController.js";

const router = express.Router();

// GET
router.get("/", getVinyls);
router.get("/get-vinyls-by-artist/", getVinylsByArtist);

// POST

// PUT

export default router;
