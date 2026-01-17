import express from "express";
import usersRoutes from "./routes/usersRoutes.js";
import vinylsRoutes from "./routes/vinylsRoutes.js";
import commentsRoutes from "./routes/commentsRoutes.js";

const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.send({
    api: "Yggdrasound",
    version: "1.0.0",
    endpoints: {
      users: "/api/users",
      vinyls: "/api/vinyls",
    },
  });
});

app.use("/api/users", usersRoutes);
app.use("/api/vinyls", vinylsRoutes);
app.use("/api/comments", commentsRoutes);

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
