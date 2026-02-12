import React from "react";
import { Plus, Minus } from "lucide-react";

const ShoppingCartMenuCard = ({ cartItem, onIncrease, onDecrease }) => {
  const vinyl = cartItem?.vinyl;

  return (
    <div className="p-3 border-b border-neutral-800 flex items-center gap-3 hover:bg-neutral-800/50 transition-colors">
      <img
        src={vinyl?.album_cover}
        alt={vinyl?.album}
        className="w-10 h-10 object-cover rounded"
      />

      <div className="flex-1 min-w-0">
        <p className="text-xs font-bold text-white truncate">{vinyl?.album}</p>
        <p className="text-[10px] text-neutral-400 truncate">{vinyl?.artist}</p>

        <div className="flex justify-between items-center mt-1">
          <span className="text-[10px] text-primary-400 font-medium">
            {vinyl?.price}€
          </span>
          <span className="text-[10px] text-neutral-500">
            Total: {cartItem.subtotal}€
          </span>
        </div>
      </div>

      <div className="flex flex-col items-center gap-1 ml-2 bg-neutral-900 rounded-md p-1 border border-neutral-700">
        <button
          onClick={(e) => {
            e.preventDefault();
            e.stopPropagation();
            onIncrease(cartItem);
          }}
          className="p-0.5 hover:text-primary-400 text-neutral-400 transition-colors cursor-pointer"
        >
          <Plus size={12} />
        </button>

        <span
          onClick={(e) => {
            e.preventDefault();
            e.stopPropagation();
          }}
          className="text-[10px] font-bold text-white leading-none cursor-default"
        >
          {cartItem.quantity}
        </span>

        <button
          onClick={(e) => {
            e.preventDefault();
            e.stopPropagation();
            onDecrease(cartItem);
          }}
          className="p-0.5 hover:text-red-400 text-neutral-400 transition-colors cursor-pointer"
        >
          <Minus size={12} />
        </button>
      </div>
    </div>
  );
};

export default ShoppingCartMenuCard;
