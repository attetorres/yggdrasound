import express from "express";
import {
  getUsers,
  getUserById,
  getUserByUsername,
} from "../controllers/usersController.js";

const router = express.Router();

// GET
router.get("/", getUsers);
router.get("/get-user-by-id/:id", getUserById);
router.get("/get-user-by-username/:username", getUserByUsername);

// POST

// PUT

export default router;
