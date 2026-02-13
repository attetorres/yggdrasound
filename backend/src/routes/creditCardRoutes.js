import express from "express";
import {
  getCreditCards,
  getCreditCardById,
  getCreditCardsByUser,
  createCreditCard,
  deleteCreditCard,
  setDefaultCard,
} from "../controllers/creditCardController.js";
import { verifyToken } from "../middlewares/authMiddleware.js";

const router = express.Router();

// GET
router.get("/", getCreditCards);
router.get("/get-credit-card-by-id/:id", getCreditCardById);
router.get("/get-credit-cards-by-user", verifyToken, getCreditCardsByUser);

// POST
router.post("/create-credit-card", verifyToken, createCreditCard);

// PUT
router.put("/set-default-card/:id", setDefaultCard);

// DELETE
router.delete("/delete-credit-card/:id", deleteCreditCard);

export default router;
