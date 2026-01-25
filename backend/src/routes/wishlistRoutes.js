import express from "express";
import {
  getWishlistByUserId,
  checkVinylInWishList,
  addToWishList,
  deleteFromWishList,
  clearWishList,
} from "../controllers/wishlistController.js";

const router = express.Router();

// GET
router.get("/get-wishlist-by-user-id/:user_id", getWishlistByUserId);
router.get("/check-vinyl-in-wishlist/:user_id/:vinyl_id", checkVinylInWishList);

// POST
router.post("/add-item", addToWishList);

// DELETE
router.delete("/delete-item/:wish_item_id", deleteFromWishList);
router.delete("/clear/:user_id", clearWishList);

export default router;
