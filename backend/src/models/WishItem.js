import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";

const WishItem = sequelize.define(
  "WishItem",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    wish_list_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "wish_list",
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
  },
  {
    tableName: "wish_item",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: false,
    underscored: true,
    indexes: [
      {
        unique: true,
        fields: ["wish_list_id", "vinyl_id"],
      },
    ],
  },
);

export default WishItem;
