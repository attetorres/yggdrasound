import React from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { Autoplay } from "swiper/modules";
import VinylCard from "./VinylCard";

// Estilos de Swiper
import "swiper/css";

export default function CarouselHome({ vinyls }) {
  if (!vinyls || vinyls.length === 0) {
    return (
      <div className="w-full h-64 flex items-center justify-center">
        <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-primary-600"></div>
      </div>
    );
  }

  return (
    <div className="w-full relative group/carousel">
      <Swiper
        modules={[Autoplay]}
        spaceBetween={30} // Menos espacio ahora que son pequeños
        loop={true}
        speed={8000}
        autoplay={{
          delay: 0,
          disableOnInteraction: false,
          pauseOnMouseEnter: true,
        }}
        breakpoints={{
          // En móviles mostramos 3 (antes 1)
          320: { slidesPerView: 3, spaceBetween: 20 },
          // En tablets mostramos 5
          768: { slidesPerView: 5, spaceBetween: 30 },
          // En desktop grande mostramos 7 u 8
          1280: { slidesPerView: 8, spaceBetween: 40 },
        }}
        className="linear-swiper overflow-visible!"
      >
        {vinyls.map((vinyl, index) => (
          <SwiperSlide
            key={vinyl.id || index}
            className="h-auto! flex items-center"
          >
            <VinylCard vinyl={vinyl} />
          </SwiperSlide>
        ))}
      </Swiper>

      {/* CSS inyectado para el movimiento lineal constante */}
      <style>{`
        .linear-swiper .swiper-wrapper {
          transition-timing-function: linear !important;
        }
      `}</style>
    </div>
  );
}
