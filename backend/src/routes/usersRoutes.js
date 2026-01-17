import express from "express";
import {
  getUsers,
  getUserById,
  getUserByUsername,
  createUser,
} from "../controllers/usersController.js";

const router = express.Router();

// GET
router.get("/", getUsers);
router.get("/get-user-by-id/:id", getUserById);
router.get("/get-user-by-username/:username", getUserByUsername);

// POST
router.post("/create-user", createUser);

// PUT

export default router;
