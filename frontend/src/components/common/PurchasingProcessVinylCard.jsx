import React from "react";
import { Plus, Minus, Trash2 } from "lucide-react";

const PurchasingProcessVinylCard = ({
  cartItem,
  onIncrease,
  onDecrease,
  onRemove,
}) => {
  const vinyl = cartItem?.vinyl;

  return (
    <div className="group flex items-center gap-3 p-2 md:p-3 bg-neutral-900 border border-neutral-800 rounded-xl hover:border-neutral-700 transition-all w-full min-w-0">
      <div className="relative w-16 h-16 shrink-0 shadow-lg shadow-black/40">
        <img
          src={vinyl?.album_cover}
          alt={vinyl?.album}
          className="w-full h-full object-cover rounded-lg"
        />
      </div>

      <div className="flex-1 min-w-0 flex flex-col justify-center">
        <h3 className="text-sm font-bold text-white truncate leading-none">
          {vinyl?.album}
        </h3>
        <p className="text-[10px] text-neutral-500 mt-1 truncate">
          {vinyl?.artist}
        </p>
        <p className="text-[10px] font-medium text-primary-400 mt-1">
          {vinyl?.price}€
        </p>
      </div>

      <div className="flex items-center bg-neutral-950 border border-neutral-800 rounded-full p-1 gap-2 shrink-0">
        <button
          onClick={(e) => {
            e.preventDefault();
            onDecrease(cartItem);
          }}
          className="p-1 text-neutral-500 hover:text-red-400 transition-colors cursor-pointer"
        >
          <Minus size={12} />
        </button>

        <span className="text-xs font-bold text-white w-4 text-center select-none">
          {cartItem.quantity}
        </span>

        <button
          onClick={(e) => {
            e.preventDefault();
            onIncrease(cartItem);
          }}
          className="p-1 text-neutral-500 hover:text-primary-400 transition-colors cursor-pointer"
        >
          <Plus size={12} />
        </button>
      </div>

      <div className="flex flex-col items-end justify-between self-stretch shrink-0 min-w-15">
        <button
          onClick={(e) => {
            e.preventDefault();
            onRemove?.(cartItem.id);
          }}
          className="text-neutral-600 hover:text-red-500 transition-colors p-1 cursor-pointer"
        >
          <Trash2 size={16} />
        </button>

        <div className="text-right">
          <span className="block text-[9px] text-neutral-500 uppercase font-black leading-none">
            Total
          </span>
          <span className="text-sm font-black text-white whitespace-nowrap">
            {cartItem.subtotal}€
          </span>
        </div>
      </div>
    </div>
  );
};

export default PurchasingProcessVinylCard;
