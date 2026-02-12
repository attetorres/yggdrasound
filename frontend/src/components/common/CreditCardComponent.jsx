import React from "react";
import { Trash2, CheckCircle2, CreditCard as CardIcon } from "lucide-react";

const CreditCardComponent = ({ creditCard, onDelete, onSelectDefault }) => {
  const formatCardNumber = (num) => {
    if (!num) return "**** **** **** ****";
    const cleanNum = num.replace(/\s+/g, "");
    const lastFour = cleanNum.slice(-4);
    return `**** **** **** ${lastFour}`;
  };

  const formatExpDate = (date) => {
    if (!date) return "MM/AA";
    const [year, month] = date.split("-");
    return `${month}/${year.slice(-2)}`;
  };

  return (
    <div className="relative group">
      <div
        className={`w-full max-w-85 h-48 rounded-4xl p-6 flex flex-col justify-between shadow-2xl transition-all duration-500 relative overflow-hidden
          ${
            creditCard.is_default
              ? "bg-linear-to-br from-primary-600 to-primary-950 border-2 border-primary-400"
              : "bg-neutral-900 border border-neutral-800 hover:border-neutral-700"
          }`}
      >
        <div className="absolute -right-6 -top-6 w-32 h-32 bg-white/5 rounded-full blur-3xl pointer-events-none" />

        <div className="flex justify-between items-start z-10">
          <CardIcon
            size={32}
            className={
              creditCard.is_default ? "text-primary-200" : "text-neutral-500"
            }
          />
          <span className="text-[10px] font-black uppercase tracking-[0.2em] text-white/40">
            {creditCard.brand || "Tarjeta"}
          </span>
        </div>

        <div className="z-10">
          <p className="text-xl font-mono tracking-[0.15em] text-white">
            {formatCardNumber(creditCard.card_number)}
          </p>
        </div>

        <div className="flex justify-between items-end z-10">
          <div>
            <p className="text-[8px] uppercase tracking-widest text-white/30 mb-1">
              Valida hasta
            </p>
            <p className="text-sm font-bold text-white">
              {formatExpDate(creditCard.expiration_date)}
            </p>
          </div>

          {creditCard.is_default ? (
            <div className="flex items-center gap-2 bg-white/10 px-3 py-1 rounded-full backdrop-blur-md border border-white/5">
              <CheckCircle2 size={12} className="text-primary-300" />
              <span className="text-[9px] font-black uppercase tracking-tighter text-white">
                Predeterminada
              </span>
            </div>
          ) : (
            <button
              onClick={() => onSelectDefault(creditCard.id)}
              className="text-[9px] font-black uppercase tracking-tighter text-neutral-400 hover:text-primary-400 transition-colors cursor-pointer"
            >
              Marcar como predeterminada
            </button>
          )}
        </div>

        {!creditCard.is_default && (
          <button
            onClick={() => onDelete(creditCard.id)}
            className="absolute top-4 right-4 p-2 text-neutral-500 hover:text-red-500 transition-colors opacity-0 group-hover:opacity-100 cursor-pointer"
          >
            <Trash2 size={18} />
          </button>
        )}
      </div>
    </div>
  );
};

export default CreditCardComponent;
