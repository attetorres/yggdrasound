import React from "react";
import Atropos from "atropos/react";
import "atropos/css";

const VinylCard = ({ vinyl }) => {
  return (
    <div className="block group cursor-pointer w-full max-w-[260] mx-auto">
      <Atropos
        className="vinyl-atropos"
        rotateXMax={15}
        rotateYMax={15}
        rotateTouch={true}
        highlight={true}
        activeOffset={20}
        shadow={false}
      >
        {/* Cambiamos min-h por un diseño que se ajusta al contenido */}
        <div className="relative bg-neutral-900/40 p-4 rounded-2xl border border-neutral-800/50 flex flex-col backdrop-blur-sm overflow-hidden">
          
          {/* Imagen con margen inferior mínimo (mb-2) */}
          <div className="relative z-10 mb-2 shadow-2xl aspect-square overflow-hidden transition-all duration-700 ease-in-out rounded-lg group-hover:rounded-full group-hover:scale-95">
            <div className="w-full h-full transition-transform duration-700 ease-in-out group-hover:rotate-360">
              <img
                src={vinyl.album_cover || "/placeholder-vinyl.png"}
                alt={vinyl.album}
                className="w-full h-full object-cover"
                data-atropos-offset="5"
              />
              <div className="absolute inset-0 flex items-center justify-center opacity-0 transition-opacity duration-700 group-hover:opacity-100">
                <div className="w-2.5 h-2.5 bg-neutral-900 rounded-full border border-neutral-700/50 shadow-inner"></div>
              </div>
            </div>
          </div>

          {/* Bloque de texto: Eliminamos el flex-1 para que no rellene espacio */}
          <div className="relative z-10">
            <h3 className="text-base font-bold text-white line-clamp-1 italic leading-tight">
              {vinyl.album}
            </h3>
            <p className="text-primary-400 font-semibold text-[10px] uppercase tracking-widest opacity-80 mb-2">
              {vinyl.artist}
            </p>

            {/* Precio: Quitamos el mt-auto y reducimos el padding superior */}
            <div className="flex justify-end items-center pt-2 border-t border-neutral-800/30">
              <span className="text-xl font-black text-white">
                {vinyl.price}€
              </span>
            </div>
          </div>
        </div>
      </Atropos>
    </div>
  );
};

export default VinylCard;