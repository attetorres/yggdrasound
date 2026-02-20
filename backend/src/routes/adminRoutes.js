import express from "express";
import {
  getDashboardStats,
  getAdminOrders,
  getOrderDetail,
  getAdminUsers,
  createUser,
  updateUser,
  deleteUser
} from "../controllers/adminController.js";
import { verifyToken, isAdmin } from "../middlewares/authMiddleware.js";

const router = express.Router();

// GET
router.get("/stats", verifyToken, isAdmin, getDashboardStats);
router.get("/orders", verifyToken, isAdmin, getAdminOrders);
router.get("/order-detail/:id", verifyToken, isAdmin, getOrderDetail);

router.get("/users", verifyToken, isAdmin, getAdminUsers);

// POST
router.post("/create-user", verifyToken, isAdmin, createUser);


// PUT
router.put("/update-user/:id", verifyToken, isAdmin, updateUser);

// DELETE
router.delete("/delete-user/:id", verifyToken, isAdmin, deleteUser);

export default router;
