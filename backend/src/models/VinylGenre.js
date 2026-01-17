import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";

const VinylGenre = sequelize.define(
  "VinylGenre",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    vinyl_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "vinyl",
        key: "id",
      },
    },
    genre_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "genre",
        key: "id",
      },
    },
  },
  {
    tableName: "vinyl_genre",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: false,
    underscored: true,
    indexes: [
      {
        unique: true,
        fields: ["vinyl_id", "genre_id"],
      },
    ],
  }
);

export default VinylGenre;
