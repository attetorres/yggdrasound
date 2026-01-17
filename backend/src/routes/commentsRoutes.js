import express from "express";
import {
  getCommentById,
  getCommentByUsername,
  getCommentByAlbum,
} from "../controllers/commentsController.js";

const router = express.Router();

// GET
router.get("/get-comment-by-id/:id", getCommentById);
router.get("/get-comment-by-username/:username", getCommentByUsername);
router.get("/get-comment-by-album/:album", getCommentByAlbum);

// POST

// PUT

export default router;
