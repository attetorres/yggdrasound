import express from "express";
import {
  getUsers,
  getUserById,
  getUserByUsername,
  createUser,
  loginUser,
  updateUser,
  deleteUser,
} from "../controllers/usersController.js";

const router = express.Router();

// GET
router.get("/", getUsers);
router.get("/get-user-by-id/:id", getUserById);
router.get("/get-user-by-username/:username", getUserByUsername);

// POST
router.post("/create-user", createUser);
router.post("/login", loginUser);

// PUT
router.put("/update-user/:id", updateUser);

//DELETE
router.delete("/delete-user/:id", deleteUser);

export default router;
