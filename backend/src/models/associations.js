import Vinyl from "./Vinyl.js";
import Genre from "./Genre.js";
import VinylGenre from "./VinylGenre.js";

const setupAssociations = () => {
  Vinyl.belongsToMany(Genre, { 
    through: VinylGenre, 
    foreignKey: "vinyl_id", 
    otherKey: "genre_id" 
  });

  Genre.belongsToMany(Vinyl, { 
    through: VinylGenre, 
    foreignKey: "genre_id", 
    otherKey: "vinyl_id" 
  });
};

export default setupAssociations;