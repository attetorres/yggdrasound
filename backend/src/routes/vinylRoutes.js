import express from "express";
import {
  getVinyls,
  getVinylById,
  getVinylsByArtist,
  getVinylsByAlbum,
  getVinylsByGenre,
  createVinyl,
  updateVinyl,
  deleteVinyl,
} from "../controllers/vinylController.js";

const router = express.Router();

// GET
router.get("/", getVinyls);
router.get("/get-vinyl-by-id/:id", getVinylById);
router.get("/get-vinyls-by-artist/", getVinylsByArtist);
router.get("/get-vinyls-by-album/", getVinylsByAlbum);
router.get("/get-vinyls-by-genre/", getVinylsByGenre);

// POST
router.post("/create-vinyl", createVinyl);

// PUT
router.put("/update-vinyl/:id", updateVinyl);

//DELETE
router.delete("/delete-vinyl/:id", deleteVinyl);

export default router;
