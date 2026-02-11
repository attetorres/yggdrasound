import React from "react";

const ShoppingCartMenuCard = ({ cartItem }) => {
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
            {cartItem.quantity} x {vinyl?.price}€
          </span>
          {/* Opcional: puedes mostrar el subtotal del item si quieres */}
          <span className="text-[10px] text-neutral-500">
            {cartItem.subtotal}€
          </span>
        </div>
      </div>
    </div>
  );
};

export default ShoppingCartMenuCard;
