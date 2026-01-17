import { Sequelize } from "sequelize";

const sequelize = new Sequelize(
  "yggdrasound_db",
  "postgres",
  "yggdrasound_password",
  {
    host: "localhost",
    port: 5432,
    dialect: "postgres",
    logging: console.log,
  }
);

sequelize
  .authenticate()
  .then(() => {
    console.log("Conexión a PostgreSQL establecida correctamente");
  })
  .catch((err) => {
    console.error("Error al conectar a PostgreSQL:", err);
  });

export default sequelize;
