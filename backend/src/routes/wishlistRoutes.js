import express from "express";
import {
  getWishlistByUser,
  checkVinylInWishList,
  addToWishList,
  deleteFromWishList,
  removeFromFavourite,
  clearWishList,
} from "../controllers/wishlistController.js";
import { verifyToken } from "../middlewares/authMiddleware.js";

const router = express.Router();

// GET
router.get("/get-wishlist-by-user", verifyToken, getWishlistByUser);
router.get("/check-item/:vinyl_id", verifyToken, checkVinylInWishList);

// POST
router.post("/add-item", verifyToken, addToWishList);

// DELETE
router.delete("/delete-item/:wish_item_id", deleteFromWishList);
router.delete(
  "/remove-favourite-item/:vinyl_id",
  verifyToken,
  removeFromFavourite,
);
router.delete("/clear/:user_id", clearWishList);

export default router;
