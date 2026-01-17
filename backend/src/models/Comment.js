import { DataTypes } from "sequelize";
import sequelize from "../config/database.js";

const Comment = sequelize.define(
  "Comment",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "user",
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
    comment_text: {
      type: DataTypes.TEXT,
      allowNull: false,
      validate: {
        notEmpty: {
          msg: "El comentario no puede estar vacío",
        },
        len: {
          args: [1, 2000],
          msg: "El comentario debe tener entre 1 y 2000 caracteres",
        },
      },
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
    updated_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
  },
  {
    tableName: "comment",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    underscored: true,
    indexes: [
      {
        fields: ["user_id"],
      },
      {
        fields: ["vinyl_id"],
      },
      {
        fields: ["created_at"],
      },
    ],
  }
);

export default Comment;
