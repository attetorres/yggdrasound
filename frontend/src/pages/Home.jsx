import React, { useEffect, useState } from "react";
import { useAuthStore } from "../store/useAuthStore";
import { getAllVinyls } from "../services/vinylService";
import CarouselHome from "../components/common/CarouselHome";
import { Link } from "react-router-dom";
import Yggsologo from "../assets/yggso_logo.png";

const Home = () => {
  const { user, isLoggedIn } = useAuthStore();
  const [newVinyls, setNewVinyls] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchVinyls = async () => {
    try {
      setLoading(true);
      const res = await getAllVinyls(1, 9, "", "", "newest");
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
    <div className="flex flex-col relative overflow-x-hidden min-h-[calc(100vh-200px)] pr-48">
      <section className="flex-1 flex flex-col pt-8 lg:pt-12 pb-0 relative z-10">
        <div className="max-w-450 mx-auto w-full grid grid-cols-1 lg:grid-cols-12 gap-4 items-start h-full relative">
          <div className="lg:col-span-5 space-y-6 pt-6 lg:pt-10 z-10">
            <div className="space-y-2 relative">
              <h1 className="text-7xl md:text-8xl xl:text-9xl font-black italic tracking-tighter uppercase leading-[0.8] text-primary-600">
                YGGDRA <br />
                <span className="text-neutral-700">SOUND</span>
              </h1>
            </div>

            <div className="flex items-center gap-6 py-2">
              <div className="relative">
                <img
                  src={Yggsologo}
                  className="w-28 h-28 md:w-36 md:h-36 opacity-90 relative z-10"
                  alt="Logo"
                />
              </div>
            </div>

            <div className="max-w-md space-y-8">
              <p className="text-neutral-500 text-sm leading-relaxed tracking-wide border-l-2 border-neutral-300 pl-6">
                Explora nuestra colección de{" "}
                <span className="text-neutral-900 font-bold">vinyls</span> y
                decide tu próxima adquisición. Lee opiniones reales, descubre
                conciertos y asegura tu copia física.
                <span className="block mt-4 text-primary-500 italic font-bold">
                  Busca, comenta, vive y colecciona.
                </span>
              </p>

              <div className="pt-2">
                <Link
                  to="/catalog"
                  className="inline-block bg-white text-black font-black uppercase text-[10px] tracking-[0.3em] px-12 py-5 rounded-full hover:bg-primary-500 hover:text-white transition-all duration-500 shadow-2xl"
                >
                  Explorar Catálogo
                </Link>
              </div>
            </div>
          </div>

          {/* PARTE DERECHA: CAROUSEL HUNDIDO */}
          <div className="lg:col-span-7 relative self-end mt-auto lg:mt-0 pt-20 lg:pt-0 mb-[-60px] lg:mb-[-120px]">
            <div className="relative translate-y-20 lg:translate-y-80">
              <div className="absolute inset-y-0 left-0 w-32 bg-linear-to-r from-neutral-200 via-transparent to-transparent z-20 pointer-events-none hidden lg:block" />

              {loading ? (
                <div className="h-64 flex flex-col items-center justify-center">
                  <div className="w-6 h-6 border-2 border-neutral-300 border-t-primary-500 rounded-full animate-spin"></div>
                </div>
              ) : (
                <div className="scale-100 lg:scale-110 xl:scale-120 origin-bottom-left transition-transform duration-700">
                  <CarouselHome vinyls={newVinyls} />
                </div>
              )}
            </div>
          </div>
        </div>
      </section>

      {/* ESPACIADOR FINAL */}
      <div className="h-12 lg:h-32" />
    </div>
  );
};

export default Home;
