import express from "express";
import {
  getCartByUserId,
  addToCart,
  updateCartItem,
  deleteFromCart,
  clearCart,
} from "../controllers/cartController.js";
import { verifyToken } from "../middlewares/authMiddleware.js";

const router = express.Router();

// GET
router.get("/get-cart-by-user", verifyToken, getCartByUserId);

// POST
router.post("/add-item", verifyToken, addToCart);

// PUT
router.put("/update-item/:cart_item_id", updateCartItem);

// DELETE
router.delete("/delete-item/:cart_item_id", deleteFromCart);
router.delete("/clear/:user_id", clearCart);

export default router;
