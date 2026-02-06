import express from "express";
import {
  getUsers,
  getUserById,
  getUserByUsername,
  getUserProfile,
  createUser,
  loginUser,
  updateUser,
  deleteUser,
} from "../controllers/userController.js";
import { verifyToken } from "../middlewares/authMiddleware.js";

const router = express.Router();

// GET
router.get("/", getUsers);
router.get("/get-user-by-id/:id", getUserById);
router.get("/get-user-by-username/:username", getUserByUsername);
router.get("/profile", verifyToken, getUserProfile);

// POST
router.post("/create-user", createUser);
router.post("/login", loginUser);

// PUT
router.put("/update-user/:id", updateUser);

//DELETE
router.delete("/delete-user/:id", deleteUser);

export default router;
