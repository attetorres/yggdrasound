import express from "express";
import {
  getOrders,
  getOrderById,
  getOrdersByUserId,
  createOrder,
} from "../controllers/ordersHistoryController.js";

const router = express.Router();

// GET
router.get("/", getOrders);
router.get("/get-order-by-id/:id", getOrderById);
router.get("/get-orders-by-user-id/:user_id", getOrdersByUserId);

// POST
router.post("/create-order", createOrder);

export default router;
