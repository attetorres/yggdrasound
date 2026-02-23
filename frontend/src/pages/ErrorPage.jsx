import React from "react";
import { useNavigate } from "react-router-dom";
import { AlertCircle, ArrowLeft, Home } from "lucide-react";

const ErrorPage = () => {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-black flex flex-col items-center justify-center p-6 text-center">
      <div className="mb-8 flex flex-col gap-6">
        <div className="flex items-center justify-center">
          <span className="text-6xl font-black text-primary-500 tracking-tighter">
            404
          </span>
        </div>
        <AlertCircle size={120} className="text-red-800/30" strokeWidth={1} />
      </div>

      <h1 className="text-3xl md:text-5xl font-black uppercase tracking-tighter text-white mb-4">
        Página no encontrada<span className="text-primary-500">.</span>
      </h1>

      <p className="text-neutral-500 max-w-md mx-auto mb-12 uppercase text-[10px] font-bold tracking-[0.2em] leading-relaxed">
        Lo sentimos, el recurso que estás buscando no existe, ha sido movido o
        no se encuentra disponible en este momento.
      </p>

      <div className="flex flex-col sm:flex-row gap-4">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center justify-center gap-2 px-8 py-4 bg-neutral-900 hover:bg-neutral-800 text-white rounded-2xl text-xs font-black uppercase tracking-widest transition-all border border-neutral-800"
        >
          <ArrowLeft size={16} /> Volver atrás
        </button>

        <button
          onClick={() => navigate("/")}
          className="flex items-center justify-center gap-2 px-8 py-4 bg-primary-500 hover:bg-primary-400 text-black rounded-2xl text-xs font-black uppercase tracking-widest transition-all shadow-[0_0_20px_rgba(var(--primary-rgb),0.2)]"
        >
          <Home size={16} /> Ir al inicio
        </button>
      </div>

      <div className="mt-24 opacity-20">
        <h2 className="text-sm font-black uppercase tracking-[0.5em] text-neutral-200 italic">
          Control de Yggdrasound
        </h2>
      </div>
    </div>
  );
};

export default ErrorPage;
