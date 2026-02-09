import React, { useEffect, useState } from "react";
import { useAuthStore } from "../store/useAuthStore";
import { getAllVinyls } from "../services/vinylService";
import CarouselHome from "../components/common/CarouselHome";
import { Link } from "react-router-dom";

const Home = () => {
  const { user, isLoggedIn } = useAuthStore();
  const [newVinyls, setNewVinyls] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchVinyls = async () => {
    try {
      setLoading(true);
      const res = await getAllVinyls(1, 12, "", "", "newest");
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
      <section className="pt-12 pb-8 px-6 md:px-12 lg:px-20">
        <div className="mx-auto w-full max-w-6xl 2xl:max-w-7xl">
          <div className="space-y-8 flex flex-col lg:flex-row lg:items-start lg:space-y-0">
            <h1 className="text-7xl md:text-8xl xl:text-9xl font-black italic tracking-tighter uppercase leading-[0.8] text-primary-600">
              YGGDRA <br />
              <span className="text-neutral-700 lg:ml-40 xl:ml-60 block lg:inline">
                SOUND
              </span>
            </h1>
            <div className="lg:transform lg:translate-y-25 xl:translate-y-25 lg:translate-x-30 xl:translate-x-30">
              <p className="text-neutral-600 max-w-md font-medium text-base md:text-lg">
                Descubre las últimas novedades en vinilos y sumérgete en el
                sonido analógico.
              </p>

              <Link
                to="/catalog"
                className="w-fit mt-3 inline-block bg-primary-600 text-white px-6 py-3 md:px-10 md:py-4 rounded-full font-bold uppercase tracking-widest hover:bg-primary-700 transition-all hover:scale-105 active:scale-95 text-sm md:text-base"
              >
                Explorar Tienda
              </Link>
            </div>
          </div>
        </div>
      </section>

      <section className="w-full pb-20 mt-8 md:mt-12 lg:mt-16">
        {loading ? (
          <div className="h-64 flex items-center justify-center">
            <span className="animate-pulse text-neutral-500 font-bold uppercase tracking-tighter">
              Cargando ...
            </span>
          </div>
        ) : (
          <div className="w-full overflow-visible">
            <CarouselHome vinyls={newVinyls} />
          </div>
        )}
      </section>
    </div>
  );
};

export default Home;
