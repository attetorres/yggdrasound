import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";

const OrderVinyl = sequelize.define(
  "OrderVinyl",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    order_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "order_history",
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
      validate: {
        min: 1,
      },
    },
    unit_price: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
      validate: {
        min: 0,
      },
    },
  },
  {
    tableName: "order_vinyl",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: false,
    underscored: true,
    indexes: [
      {
        unique: true,
        fields: ["order_id", "vinyl_id"],
      },
    ],
  },
);

export default OrderVinyl;
