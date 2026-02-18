import express from "express";
import {
  getDashboardStats,
  getAdminOrders,
} from "../controllers/adminController.js";
import { verifyToken, isAdmin } from "../middlewares/authMiddleware.js";

const router = express.Router();

// GET
router.get("/stats", verifyToken, isAdmin, getDashboardStats);
router.get("/recent-orders", verifyToken, isAdmin, getAdminOrders);

// POST

// PUT

// DELETE

export default router;
