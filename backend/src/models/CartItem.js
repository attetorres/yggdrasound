import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";

const CartItem = sequelize.define(
  "CartItem",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    cart_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "shopping_cart",
        key: "id",
      },
    },
    vinyl_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "vinyl",
        key: "id",
      },
    },
    quantity: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1,
      validate: {
        min: 1,
      },
    },
  },
  {
    tableName: "cart_item",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    underscored: true,
    indexes: [
      {
        unique: true,
        fields: ["cart_id", "vinyl_id"],
      },
    ],
  },
);

export default CartItem;
