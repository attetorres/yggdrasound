import express from "express";
import {
  getCreditCards,
  getCreditCardById,
  getCreditCardsByUserId,
  createCreditCard,
  deleteCreditCard,
  setDefaultCard,
} from "../controllers/creditCardController.js";

const router = express.Router();

// GET
router.get("/", getCreditCards);
router.get("/get-credit-card-by-id/:id", getCreditCardById);
router.get("/get-credit-cards-by-user-id/:user_id", getCreditCardsByUserId);

// POST
router.post("/create-credit-card", createCreditCard);

// PUT
router.put("/set-default-card/:id", setDefaultCard);

// DELETE
router.delete("/delete-credit-card/:id", deleteCreditCard);

export default router;
