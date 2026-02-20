import express from "express";
import {
  getDashboardStats,
  getAdminOrders,
  getOrderDetail,
  getAdminUsers,
  createUser,
  updateUser,
  deleteUser,
  getAdminVinyls,
  createVinyl,
  updateVinyl,
  deleteVinyl
} from "../controllers/adminController.js";
import { verifyToken, isAdmin } from "../middlewares/authMiddleware.js";

const router = express.Router();

// GET
router.get("/stats", verifyToken, isAdmin, getDashboardStats);
router.get("/orders", verifyToken, isAdmin, getAdminOrders);
router.get("/order-detail/:id", verifyToken, isAdmin, getOrderDetail);

router.get("/users", verifyToken, isAdmin, getAdminUsers);


router.get("/vinyls", verifyToken, isAdmin, getAdminVinyls);

// POST
router.post("/create-user", verifyToken, isAdmin, createUser);
router.post("/create-vinyl", verifyToken, isAdmin, createVinyl);


// PUT
router.put("/update-user/:id", verifyToken, isAdmin, updateUser);
router.put("/update-vinyl/:id", verifyToken, isAdmin, updateVinyl);

// DELETE
router.delete("/delete-user/:id", verifyToken, isAdmin, deleteUser);
router.delete('/delete-vinyl/:id', deleteVinyl);

export default router;
