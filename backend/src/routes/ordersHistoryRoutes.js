import express from "express";
import {
  getOrders,
  getOrderById,
  getOrdersByUser,
  createOrder,
} from "../controllers/ordersHistoryController.js";
import { verifyToken } from "../middlewares/authMiddleware.js";

const router = express.Router();

// GET
router.get("/", getOrders);
router.get("/get-order-by-id/:id", getOrderById);
router.get("/get-orders-by-user", verifyToken, getOrdersByUser);

// POST
router.post("/create-order", verifyToken, createOrder);

export default router;
