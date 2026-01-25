import express from "express";
import usersRoutes from "./routes/usersRoutes.js";
import vinylsRoutes from "./routes/vinylsRoutes.js";
import commentsRoutes from "./routes/commentsRoutes.js";
import genresRoutes from "./routes/genresRoutes.js";
import cartRoutes from "./routes/cartRoutes.js";
import wishlistRoutes from "./routes/wishlistRoutes.js";
import ordersHistoryRoutes from "./routes/ordersHistoryRoutes.js";

const app = express();
const port = 3000;

//MIDDLEWARE
app.use(express.json());

app.get("/", (req, res) => {
  res.send({
    api: "Yggdrasound",
    version: "1.0.0",
    author: "Atteneri de Jesús Torres González",
    endpoints: {
      users: "/api/users",
      vinyls: "/api/vinyls",
      comments: "/api/comments",
      genres: "/api/genres",
      shopping_cart: "/api/shopping-cart",
      wish_list: "/api/wish-list",
      orders_history: "/api/orders-history",
    },
  });
});

app.use("/api/users", usersRoutes);
app.use("/api/vinyls", vinylsRoutes);
app.use("/api/comments", commentsRoutes);
app.use("/api/genres", genresRoutes);
app.use("/api/shopping-cart", cartRoutes);
app.use("/api/wish-list", wishlistRoutes);
app.use("/api/orders-history", ordersHistoryRoutes);

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
