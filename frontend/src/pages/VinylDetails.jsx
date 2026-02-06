import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { getVinylById } from "../services/vinylService";
import { Heart, ShoppingCart } from "lucide-react";

const VinylDetails = () => {
  const { id } = useParams();
  const [vinyl, setVinyl] = useState(null);
  const [loading, setLoading] = useState(true);

  const formatDate = (dateString) => {
    if (!dateString) return "N/A";

    const parts = dateString.split("-");
    if (parts.length !== 3) return dateString;

    const [year, month, day] = parts;
    return `${day}-${month}-${year}`;
  };

  const formatDuration = (duration) => {
    if (!duration) return "--:--";

    if (typeof duration === "object") {
      const { hours, minutes, seconds } = duration;

      const hh = hours ? `${hours}:` : "";
      const mm = String(minutes || 0).padStart(2, "0");
      const ss = String(seconds || 0).padStart(2, "0");

      return `${hh}${mm}:${ss}`;
    }

    return "--:--";
  };

  const fetchDetails = async () => {
    try {
      setLoading(true);
      const res = await getVinylById(id);
      if (res.success) {
        setVinyl(res.data);
      }
    } catch (error) {
      console.error("Error al cargar el detalle:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchDetails();
  }, [id]);

  if (loading)
    return (
      <div className="min-h-screen bg-neutral-950 flex items-center justify-center">
        <div className="text-white uppercase tracking-[0.5em] text-xs animate-pulse">
          Cargando Vinilo...
        </div>
      </div>
    );

  if (!vinyl)
    return (
      <div className="min-h-screen bg-neutral-950 flex items-center justify-center">
        <div className="text-red-500 uppercase tracking-widest">
          Vinilo no encontrado
        </div>
      </div>
    );

  return (
    <div className="min-h-screen flex flex-col gap-6">
      <div className="p-8 rounded-2xl border border-neutral-800 bg-neutral-950 text-white flex flex-col md:flex-row justify-between items-center gap-4">
        <div className="w-full lg:w-auto text-center lg:text-left">
          <h1 className="text-3xl font-black italic tracking-tighter uppercase leading-none">
            Detalles
          </h1>
          <p className="text-neutral-500 text-[10px] tracking-[0.3em] uppercase mt-1">
            {vinyl.artist} — {vinyl.album}
          </p>
        </div>
      </div>

      <div className="flex flex-col lg:flex-row gap-6">
        <div className="flex-2 flex flex-col gap-4">
          <div className="relative group bg-neutral-900 border border-neutral-800 p-3 rounded-[2.5rem] shadow-2xl transition-all hover:border-neutral-700">
            <img
              src={vinyl?.album_cover}
              alt={vinyl?.album}
              className="w-full aspect-square object-cover rounded-4xl grayscale-[0.2] group-hover:grayscale-0 transition-all duration-700"
            />
          </div>

          <div className="flex justify-around items-center px-4 mt-2">
            <button className="flex items-center gap-3 group">
              <div className="w-10 h-10 flex items-center justify-center">
                <span className="text-lg">
                  <Heart
                    size={40}
                    strokeWidth={3}
                    className="group-hover:text-red-500 transition-all cursor-pointer"
                  />
                </span>
              </div>
            </button>

            <button className="flex items-center group">
              <span className="font-black uppercase text-xs tracking-tight">
                <ShoppingCart
                  size={40}
                  strokeWidth={3}
                  className="group-hover:text-primary-500 transition-all cursor-pointer"
                />
              </span>
            </button>
          </div>
        </div>

        <div className="flex-3 bg-neutral-100 rounded-[2.5rem] p-8 md:p-12 text-neutral-900 flex flex-col gap-10 shadow-inner">
          <div className="space-y-8">
            <div className="space-y-2 flex flex-row justify-between">
              <div className="flex-2">
                <h2 className="text-6xl font-black uppercase italic tracking-tighter leading-[0.85] text-neutral-950">
                  {vinyl?.album}
                </h2>
                <p className="text-2xl font-medium text-neutral-500 uppercase tracking-tight italic">
                  {vinyl?.artist}
                </p>
              </div>
              <div className="flex flex-1 justify-center items-center">
                <p className="text-3xl font-bold">{vinyl.price}€</p>
              </div>
            </div>

            <div className="grid grid-cols-2 md:grid-cols-4 gap-6 border-y border-neutral-200 py-6">
              <div className="flex flex-col">
                <span className="text-[10px] uppercase tracking-widest text-neutral-400 font-bold mb-1">
                  Lanzamiento
                </span>
                <span className="text-sm font-bold">
                  {formatDate(vinyl?.release_date)}
                </span>
              </div>
              <div className="flex flex-col">
                <span className="text-[10px] uppercase tracking-widest text-neutral-400 font-bold mb-1">
                  Origen del artista
                </span>
                <span className="text-sm font-bold">
                  {vinyl?.band_location || "Unknown"}
                </span>
              </div>
              <div className="flex flex-col">
                <span className="text-[10px] uppercase tracking-widest text-neutral-400 font-bold mb-1">
                  Duración
                </span>
                <span className="text-sm font-bold">
                  {formatDuration(vinyl?.duration)}
                </span>
              </div>
              <div className="flex flex-col">
                <span className="text-[10px] uppercase tracking-widest text-neutral-400 font-bold mb-1">
                  Canciones
                </span>
                <span className="text-sm font-bold">
                  {vinyl?.track_count || "0"} Canciones
                </span>
              </div>
            </div>
          </div>

          <div className="flex-1">
            <h3 className="text-[10px] font-black uppercase tracking-[0.4em] mb-6 text-neutral-400 flex items-center gap-3">
              <span className="w-12 h-0.5 bg-primary-300"></span> Lista de
              canciones
            </h3>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-x-12 gap-y-2">
              {vinyl?.track_list?.length > 0 ? (
                vinyl.track_list.map((track, index) => (
                  <div
                    key={index}
                    className="flex items-center justify-between py-2 border-b border-neutral-200/60 group transition-colors px-2 rounded-lg"
                  >
                    <div className="flex items-center gap-4">
                      <span className="text-[10px] font-black text-neutral-300">
                        {(index + 1).toString().padStart(2, "0")}
                      </span>
                      <span className="text-sm font-bold text-neutral-800 uppercase tracking-tight">
                        {track}
                      </span>
                    </div>
                  </div>
                ))
              ) : (
                <p className="text-neutral-400 text-xs italic">
                  No hay lista de canciones que mostrar
                </p>
              )}
            </div>
          </div>
        </div>

        <div className="flex-1 flex lg:flex-col gap-4">
          <div className="flex-1 bg-neutral-900 border border-neutral-800 rounded-[2.5rem] flex items-center justify-center p-8 relative overflow-hidden group cursor-pointer">
            {/* <div className="absolute inset-0 bg-white translate-y-full group-hover:translate-y-0 transition-transform duration-500 ease-out"></div> */}
            <button className="relative z-10 text-white group-hover:text-black font-black uppercase text-2xl lg:[writing-mode:vertical-lr] tracking-[0.4em] transition-colors duration-300">
              Conciertos
            </button>
          </div>
        </div>
      </div>

      <div className="bg-neutral-950 border border-neutral-800 rounded-[2.5rem] p-10 mt-4">
        <div className="flex justify-between items-end mb-10">
          <div>
            <h3 className="text-3xl font-black uppercase italic tracking-tighter text-white">
              Comentarios
            </h3>
          </div>
          <button className="text-white border-b border-white pb-1 text-[10px] uppercase font-bold hover:text-amber-400 hover:border-amber-400 transition-all">
            Escribe un comentario
          </button>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div className="border border-neutral-800 bg-neutral-700/50 rounded-2xl p-8 text-center flex flex-col items-center justify-center min-h-40">
            <p className="text-neutral-500 uppercase text-[10px] tracking-[0.2em] font-bold">
              Comenta aquí
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default VinylDetails;
