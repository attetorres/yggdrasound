import express from "express";
import {
  getCommentById,
  getCommentByUsername,
  getCommentByAlbum,
  createComment,
} from "../controllers/commentsController.js";

const router = express.Router();

// GET
router.get("/get-comment-by-id/:id", getCommentById);
router.get("/get-comment-by-username/:username", getCommentByUsername);
router.get("/get-comment-by-album/:album", getCommentByAlbum);

// POST
router.post("/create-comment", createComment);

// PUT

export default router;
