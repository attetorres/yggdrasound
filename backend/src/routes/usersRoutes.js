import express from "express";
import { getUserById } from "../controllers/usersController.js";

const router = express.Router();

// GET
router.get("/get-user-by-id/:id", getUserById);

// POST

// PUT

export default router;
