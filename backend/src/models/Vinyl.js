import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";

const Vinyl = sequelize.define(
  "Vinyl",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    artist: {
      type: DataTypes.STRING(150),
      allowNull: false,
    },
    album: {
      type: DataTypes.STRING(200),
      allowNull: false,
    },
    album_url: {
      type: DataTypes.STRING(500),
      allowNull: true,
    },
    band_location: {
      type: DataTypes.STRING(100),
      allowNull: true,
    },
    release_date: {
      type: DataTypes.DATEONLY,
      allowNull: true,
    },
    album_cover: {
      type: DataTypes.STRING(500),
      allowNull: true,
    },
    price: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
      validate: {
        min: 0,
      },
    },
    track_list: {
      type: DataTypes.ARRAY(DataTypes.TEXT),
      allowNull: true,
      defaultValue: [],
    },
    track_count: {
      type: DataTypes.INTEGER,
      defaultValue: 0,
      validate: {
        min: 0,
      },
    },
    duration: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    band_url: {
      type: DataTypes.STRING(500),
      allowNull: true,
    },
  },
  {
    tableName: "vinyl",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    underscored: true,
  }
);

export default Vinyl;
