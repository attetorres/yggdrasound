import React from "react";

const ConcertCard = ({ concert }) => {
  return (
    <div className="bg-neutral-800/30 border border-neutral-800 p-4 rounded-3xl hover:border-neutral-600 transition-all">
      <div className="flex flex-col gap-1">
        <span className="text-primary-400 text-[9px] font-black uppercase tracking-tighter">
          {concert.date}
        </span>
        <h4 className="text-sm font-bold text-white uppercase leading-tight tracking-tight">
          {concert.venue}
        </h4>
        <p className="text-[10px] text-neutral-500 uppercase font-bold">
          {concert.city}
        </p>
      </div>

      {concert.venueLink && (
        <a
          href={concert.venueLink}
          target="_blank"
          rel="noopener noreferrer"
          className="mt-3 inline-flex items-center justify-center text-[9px] font-black uppercase tracking-widest text-black bg-white px-4 py-2 rounded-full hover:bg-primary-400 transition-all"
        >
          Comprar entradas
        </a>
      )}
    </div>
  );
};

export default ConcertCard;
