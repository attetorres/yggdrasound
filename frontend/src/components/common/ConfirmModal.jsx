import React from "react";
import { AlertTriangle, X } from "lucide-react";

const ConfirmModal = ({
  isOpen,
  onClose,
  onConfirm,
  title,
  message,
  confirmText = "Eliminar",
}) => {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-100 flex items-center justify-center p-4">
      {/* Backdrop (Fondo oscuro) */}
      <div
        className="absolute inset-0 bg-neutral-950/80 backdrop-blur-sm transition-opacity"
        onClick={onClose}
      />

      {/* Caja del Modal */}
      <div className="relative bg-neutral-900 border border-neutral-800 w-full max-w-md rounded-[2.5rem] p-8 shadow-2xl animate-in fade-in zoom-in duration-200">
        <button
          onClick={onClose}
          className="absolute top-6 right-6 text-neutral-500 hover:text-white transition-colors"
        >
          <X size={20} />
        </button>

        <div className="flex flex-col items-center text-center gap-4">
          <div className="w-16 h-16 bg-red-500/10 rounded-full flex items-center justify-center text-red-500 mb-2">
            <AlertTriangle size={32} />
          </div>

          <h3 className="text-xl font-black uppercase italic tracking-tighter text-white">
            {title}
          </h3>

          <p className="text-neutral-400 text-sm leading-relaxed">{message}</p>

          <div className="flex gap-3 w-full mt-6">
            <button
              onClick={onClose}
              className="flex-1 px-6 py-3 rounded-full border border-neutral-800 text-white text-xs font-black uppercase tracking-widest hover:bg-neutral-800 transition-all cursor-pointer"
            >
              Cancelar
            </button>
            <button
              onClick={() => {
                onConfirm();
                onClose();
              }}
              className="flex-1 px-6 py-3 rounded-full bg-red-600 text-white text-xs font-black uppercase tracking-widest hover:bg-red-500 transition-all shadow-lg shadow-red-900/20 cursor-pointer"
            >
              {confirmText}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ConfirmModal;
