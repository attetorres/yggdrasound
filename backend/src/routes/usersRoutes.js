import express from "express";
import { getUserById } from "../controllers/usersController.js";

const router = express.Router();

// GET
router.get("/get-user/:id", getUserById);

// POST

// PUT

export default router;
