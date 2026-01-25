// routes/cartRoutes.js
import express from "express";
import {
  getCartByUserId,
  addToCart,
  updateCartItem,
  deleteFromCart,
  clearCart,
} from "../controllers/cartController.js";

const router = express.Router();

// GET
router.get("/get-cart-by-user-id/:user_id", getCartByUserId);

// POST
router.post("/add-item", addToCart);

// PUT
router.put("/update-item/:cart_item_id", updateCartItem);

// DELETE
router.delete("/delete-item/:cart_item_id", deleteFromCart);

// DELETE
router.delete("/clear/:user_id", clearCart);

export default router;