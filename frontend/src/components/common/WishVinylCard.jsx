import React from "react";
import { Trash2, ShoppingCart } from "lucide-react";

const WishVinylCard = ({ vinyl, onRemove, onAddToCart }) => {
  return (
    <div className="group relative bg-neutral-900/90 border border-neutral-800 hover:border-neutral-700 rounded-xl p-3 transition-all duration-300 hover:bg-neutral-900/80 cursor-pointer ">
      <button
        onClick={(e) => {
          e.preventDefault();
          e.stopPropagation();
          onRemove();
        }}
        className="cursor-pointer absolute z-10 -top-2 -right-2 p-2 bg-red-950 backdrop-blur-md text-white/70 hover:text-red-400 rounded-full opacity-0 group-hover:opacity-100 transition-opacity duration-300"
      >
        <Trash2 size={18} />
      </button>
      <div className="aspect-square overflow-hidden rounded-lg mb-3">
        <img
          src={vinyl.album_cover || "/placeholder-vinyl.png"}
          alt={vinyl.album}
          className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105"
        />
      </div>

      <div className="px-1">
        <h3 className="text-primary-300 font-bold text-sm truncate leading-none mb-1">
          {vinyl.album}
        </h3>
        <p className="text-primary-200 text-[11px] uppercase tracking-wider truncate mb-3">
          {vinyl.artist}
        </p>

        <div className="flex items-center justify-between">
          <span className="text-primary-200 font-black text-lg">
            {vinyl.price}€
          </span>

          <button
            onClick={() => onAddToCart(vinyl)}
            className="p-2 bg-primary-600 hover:bg-primary-500 text-white rounded-lg transition-colors"
          >
            <ShoppingCart size={14} />
          </button>
        </div>
      </div>
    </div>
  );
};

export default WishVinylCard;
