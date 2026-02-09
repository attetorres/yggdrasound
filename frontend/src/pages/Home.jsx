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
      const res = await getAllVinyls(1, 25, "", "", "newest");
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
    <div className="min-h-screen flex flex-col bg-neutral-300">
      {/* Contenedor Superior: Texto y Logo */}
      <section className="pt-12 pb-8 px-6 md:px-12 lg:px-20">
        <div className="max-w-350 mx-auto">
          <div className="space-y-6">
            <h1 className="text-7xl md:text-8xl xl:text-9xl font-black italic tracking-tighter uppercase leading-[0.8] text-primary-600">
              YGGDRA <br />
              <span className="text-neutral-700">SOUND</span>
            </h1>

            <p className="text-neutral-600 max-w-md font-medium text-lg">
              Descubre las últimas novedades en vinilos y sumérgete en el sonido
              analógico.
            </p>

            <Link
              to="/shop"
              className="inline-block bg-primary-600 text-white px-10 py-4 rounded-full font-bold uppercase tracking-widest hover:bg-primary-700 transition-all hover:scale-105 active:scale-95"
            >
              Explorar Tienda
            </Link>
          </div>
        </div>
      </section>

      {/* Contenedor Inferior: Carrusel de lado a lado */}
      <section className="w-full pb-20">
        {loading ? (
          <div className="h-64 flex items-center justify-center">
            <span className="animate-pulse text-neutral-500 font-bold uppercase tracking-tighter">
              Cargando Sonido...
            </span>
          </div>
        ) : (
          /* El carrusel ahora ocupa todo el ancho disponible */
          <div className="w-full overflow-visible">
            <CarouselHome vinyls={newVinyls} />
          </div>
        )}
      </section>
    </div>
  );
};

export default Home;
