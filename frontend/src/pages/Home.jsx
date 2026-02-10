import React, { useEffect, useState } from "react";
import { getAllVinyls } from "../services/vinylService";
import VinylCard from "../components/common/VinylCard";
import { Link } from "react-router-dom";

const Home = () => {
  const [newVinyls, setNewVinyls] = useState([]);
  const [loading, setLoading] = useState(true);

  const genres = [
    { value: "rock", label: "Rock" },
    { value: "electronic", label: "Electronic" },
    { value: "metal", label: "Metal" },
    { value: "alternative", label: "Alternative" },
    { value: "hip-hop-rap", label: "Hip Hop / Rap" },
    { value: "experimental", label: "Experimental" },
    { value: "punk", label: "Punk" },
    { value: "pop", label: "Pop" },
    { value: "ambient", label: "Ambient" },
  ];

  const fetchVinyls = async () => {
    try {
      setLoading(true);
      const res = await getAllVinyls(1, 10, "", "", "newest");
      if (res.success) {
        setNewVinyls(res.data);
      }
    } catch (error) {
      console.error("Error al cargar novedades:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchVinyls();
  }, []);

  return (
    <div className="min-h-screen flex flex-col bg-neutral-200">
      <section className="pt-16 pb-8 md:pt-20 md:pb-12 px-6 md:px-12 lg:px-20 linear-gradient-to-b from-neutral-950 to-neutral-900">
        <div className="mx-auto w-full max-w-6xl 2xl:max-w-7xl">
          <div className="space-y-8 flex flex-col lg:flex-row lg:items-start lg:space-y-0 lg:space-x-12">
            <div className="relative lg:w-2/3">
              <h1 className="text-7xl md:text-8xl xl:text-9xl font-black italic tracking-tighter uppercase leading-[0.8] text-primary-600 ">
                YGGDRA
                <br />
                <span className="text-neutral-700 -right-2.56 sm:pl-64">
                  SOUND
                </span>
              </h1>
            </div>
            <div className="lg:w-1/3 lg:pt-12 xl:pt-30">
              <p className="text-neutral-700 max-w-md font-medium italic text-lg md:text-xl lg:text-2xl leading-relaxed">
                La mejor selección de vinilos para amantes de la música.
              </p>
            </div>
          </div>
        </div>
      </section>
      <section className=" rounded-3xl py-16 md:py-20 px-6 md:px-12 lg:px-20 bg-neutral-900 ">
        <div className="mx-auto max-w-6xl 2xl:max-w-7xl">
          <div className="flex flex-col md:flex-row md:items-end justify-between mb-12">
            <div>
              <h2 className="text-3xl md:text-4xl lg:text-5xl font-black text-primary-100 italic mb-3">
                Explora las Novedades
              </h2>
              <p className="text-primary-400 font-medium text-lg">
                Los últimos lanzamientos agregados a nuestra colección
              </p>
            </div>
            <Link
              to="/catalog"
              className="mt-4 md:mt-0 inline-block bg-primary-600 text-white px-8 py-4 rounded-full font-bold uppercase tracking-widest hover:bg-primary-700 transition-all hover:scale-105 active:scale-95 shadow-lg hover:shadow-xl border border-primary-500/30"
            >
              Ver Catálogo Completo
            </Link>
          </div>

          {loading ? (
            <div className="flex justify-center items-center py-20">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
            </div>
          ) : newVinyls.length > 0 ? (
            <>
              <div className="grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-5 gap-6">
                {newVinyls.slice(0, 8).map((vinyl, index) => (
                  <Link
                    key={vinyl.id}
                    to={`/vinyl-details/${vinyl.id}`}
                    className={`block ${index >= 6 ? "hidden sm:block" : ""} ${index >= 5 ? "lg:hidden" : ""}`}
                  >
                    <VinylCard vinyl={vinyl} />
                  </Link>
                ))}
              </div>
            </>
          ) : (
            <div className="text-center py-16 bg-neutral-900/50 rounded-2xl border border-neutral-800">
              <p className="text-neutral-400 text-lg">
                No hay novedades disponibles en este momento
              </p>
            </div>
          )}
        </div>
      </section>

      <section className="py-16 md:py-20 px-6 md:px-12 lg:px-20 linear-gradient-to-b from-neutral-900 to-neutral-950">
        <div className="mx-auto max-w-6xl">
          <div className="text-center mb-12">
            <h3 className="text-2xl md:text-3xl lg:text-4xl font-black italic text-neutral-900 mb-4">
              Explora por Género
            </h3>
            <p className="text-neutral-400 font-medium text-lg max-w-2xl mx-auto">
              Navega nuestra extensa colección organizada por estilos musicales
            </p>
          </div>

          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4 font-bold">
            {genres.map((genre) => (
              <Link
                key={genre.value}
                to={`/catalog/${genre.value}`}
                className="group relative overflow-hidden bg-neutral-900 rounded-xl p-6 text-center border border-neutral-800 hover:border-primary-500/50 transition-all duration-300 hover:-translate-y-1 backdrop-blur-sm hover:bg-primary-900"
              >
                <div className="absolute inset-0 linear-gradient-to-br from-primary-600/0 to-primary-600/0 group-hover:from-primary-600/10 group-hover:to-primary-600/5 transition-all duration-300"></div>

                <h4 className="text-primary-100 text-lg mb-1">{genre.label}</h4>
                <p className="text-sm text-neutral-400 group-hover:text-primary-400 transition-colors">
                  Ver colección
                </p>
              </Link>
            ))}

            <Link
              to="/catalog"
              className="group font-bold relative overflow-hidden linear-gradient-to-br from-primary-600 to-primary-700 rounded-xl p-6 text-center border border-primary-500/50 hover:border-primary-400 transition-all duration-300 hover:-translate-y-1 bg-primary-900 hover:bg-neutral-600 text-primary-400 hover:text-primary-300"
            >
              <h4 className="font-bold text-lg mb-1">Todos los Géneros</h4>
              <p className="text-sm text-white/90">Ver colección completa</p>
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
};

export default Home;
