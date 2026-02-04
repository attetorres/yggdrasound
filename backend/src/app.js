import 'dotenv/config';
import express from "express";
import cors from "cors";
import userRoutes from "./routes/userRoutes.js";
import vinylRoutes from "./routes/vinylRoutes.js";
import creditCardRoutes from "./routes/creditCardRoutes.js";
import commentRoutes from "./routes/commentRoutes.js";
import genreRoutes from "./routes/genreRoutes.js";
import cartRoutes from "./routes/cartRoutes.js";
import wishlistRoutes from "./routes/wishlistRoutes.js";
import ordersHistoryRoutes from "./routes/ordersHistoryRoutes.js";

const app = express();
const port = process.env.PORT || 3000;

//MIDDLEWARE
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send({
    api: "Yggdrasound",
    version: "1.0.0",
    author: "Atteneri de Jesús Torres González",
    endpoints: {
      users: "/api/user",
      vinyls: "/api/vinyl",
      credit_card: "/api/credit-card",
      comments: "/api/comment",
      genres: "/api/genre",
      shopping_cart: "/api/shopping-cart",
      wish_list: "/api/wish-list", 
      orders_history: "/api/orders-history",
    },
  });
});

app.use("/api/user", userRoutes);
app.use("/api/vinyl", vinylRoutes);
app.use("/api/credit-card", creditCardRoutes);
app.use("/api/comment", commentRoutes);
app.use("/api/genre", genreRoutes);
app.use("/api/shopping-cart", cartRoutes);
app.use("/api/wish-list", wishlistRoutes);
app.use("/api/orders-history", ordersHistoryRoutes);

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
