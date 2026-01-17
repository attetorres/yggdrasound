import express from "express";
import userRoutes from "./routes/usersRoutes.js";

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

app.use("/api/users", userRoutes);

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
