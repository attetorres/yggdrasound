import express from "express";
import {
  getCommentById,
  getCommentByUsername,
  getCommentsByVinylId,
  createComment,
  updateComment,
  deleteComment,
} from "../controllers/commentController.js";
import { verifyToken } from "../middlewares/authMiddleware.js";

const router = express.Router();

// GET
router.get("/get-comment-by-id/:id", getCommentById);
router.get("/get-comment-by-username/:username", getCommentByUsername);
router.get("/get-comment-by-vinyl-id/:id", getCommentsByVinylId);

// POST
router.post("/create-comment", verifyToken, createComment);

// PUT
router.put("/update-comment/:id", updateComment);

// DELETE
router.delete("/delete-comment/:id", deleteComment);

export default router;
