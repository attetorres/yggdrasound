import express from "express";
import { getVinyls } from "../controllers/vinylsController.js";

const router = express.Router();

// GET
router.get("/", getVinyls);

// POST

// PUT

export default router;
