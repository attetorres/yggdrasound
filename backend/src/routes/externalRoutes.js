import express from "express";
import { scraperBandcampConcerts } from "../services/scraperConcerts.js";

const router = express.Router();

// POST
router.post("/", scraperBandcampConcerts);

export default router;
