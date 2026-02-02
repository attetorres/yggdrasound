import { Sequelize } from "sequelize";
import 'dotenv/config';

const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
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
