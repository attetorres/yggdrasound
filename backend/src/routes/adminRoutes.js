import express from "express";
import {
  getDashboardStats,
  getAdminOrders,
  getOrderDetail,
} from "../controllers/adminController.js";
import { verifyToken, isAdmin } from "../middlewares/authMiddleware.js";

const router = express.Router();

// GET
router.get("/stats", verifyToken, isAdmin, getDashboardStats);
router.get("/orders", verifyToken, isAdmin, getAdminOrders);
router.get("/order-detail/:id", verifyToken, isAdmin, getOrderDetail);

// POST

// PUT

// DELETE

export default router;
