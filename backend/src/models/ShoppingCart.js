import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";

const ShoppingCart = sequelize.define(
  "ShoppingCart",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      unique: true,
      references: {
        model: "user",
        key: "id",
      },
    },
  },
  {
    tableName: "shopping_cart",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    underscored: true,
  }
);

export default ShoppingCart;