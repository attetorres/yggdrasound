import express from "express";
import {
  getCommentById,
  getCommentByUsername,
  getCommentByAlbum,
  createComment,
  updateComment,
  deleteComment,
} from "../controllers/commentsController.js";

const router = express.Router();

// GET
router.get("/get-comment-by-id/:id", getCommentById);
router.get("/get-comment-by-username/:username", getCommentByUsername);
router.get("/get-comment-by-album/:album", getCommentByAlbum);

// POST
router.post("/create-comment", createComment);

// PUT
router.put("/update-comment/:id", updateComment);

// DELETE
router.delete("/delete-comment/:id", deleteComment);

export default router;
