import Vinyl from "./Vinyl.js";
import Genre from "./Genre.js";
import VinylGenre from "./VinylGenre.js";
import User from "./User.js";
import OrderHistory from "./OrderHistory.js";
import OrderVinyl from "../models/OrderVinyl.js";
import Comment from "./Comment.js";

const setupAssociations = () => {
  Vinyl.belongsToMany(Genre, {
    through: VinylGenre,
    foreignKey: "vinyl_id",
    otherKey: "genre_id",
    as: "genres",
  });

  Genre.belongsToMany(Vinyl, {
    through: VinylGenre,
    foreignKey: "genre_id",
    otherKey: "vinyl_id",
    as: "vinyls",
  });

  OrderHistory.belongsTo(User, {
    foreignKey: "user_id",
  });

  User.hasMany(OrderHistory, {
    foreignKey: "user_id",
  });

  OrderHistory.hasMany(OrderVinyl, {
    foreignKey: "order_id",
  });
  OrderVinyl.belongsTo(OrderHistory, {
    foreignKey: "order_id",
  });

  OrderVinyl.belongsTo(Vinyl, {
    foreignKey: "vinyl_id",
  });
  Vinyl.hasMany(OrderVinyl, {
    foreignKey: "vinyl_id",
  });

  Comment.belongsTo(User, {
    foreignKey: "user_id",
  });

  User.hasMany(Comment, {
    foreignKey: "user_id",
  });

  Comment.belongsTo(Vinyl, {
    foreignKey: "vinyl_id",
  });

  Vinyl.hasMany(Comment, {
    foreignKey: "vinyl_id",
  });
};

export default setupAssociations;
