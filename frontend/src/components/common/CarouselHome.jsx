// import React from "react";
// import { Swiper, SwiperSlide } from "swiper/react";
// import { Autoplay } from "swiper/modules";
// import VinylCard from "./VinylCard";

// // Estilos de Swiper
// import "swiper/css";

// export default function CarouselHome({ vinyls }) {
//   if (!vinyls || vinyls.length === 0) {
//     return (
//       <div className="w-full h-64 flex items-center justify-center">
//         <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-primary-600"></div>
//       </div>
//     );
//   }

//   return (
//     <div className="w-full relative group/carousel">
//       <Swiper
//         modules={[Autoplay]}
//         spaceBetween={30} // Menos espacio ahora que son pequeños
//         loop={true}
//         speed={8000}
//         autoplay={{
//           delay: 0,
//           disableOnInteraction: false,
//           pauseOnMouseEnter: true,
//         }}
//         breakpoints={{
//           // En móviles mostramos 3 (antes 1)
//           320: { slidesPerView: 3, spaceBetween: 20 },
//           // En tablets mostramos 5
//           768: { slidesPerView: 5, spaceBetween: 30 },
//           // En desktop grande mostramos 7 u 8
//           1280: { slidesPerView: 8, spaceBetween: 40 },
//         }}
//         className="linear-swiper overflow-visible!"
//       >
//         {vinyls.map((vinyl, index) => (
//           <SwiperSlide
//             key={vinyl.id || index}
//             className="h-auto! flex items-center"
//           >
//             <VinylCard vinyl={vinyl} />
//           </SwiperSlide>
//         ))}
//       </Swiper>

//       {/* CSS inyectado para el movimiento lineal constante */}
//       <style>{`
//         .linear-swiper .swiper-wrapper {
//           transition-timing-function: linear !important;
//         }
//       `}</style>
//     </div>
//   );
// }

import React from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { Autoplay } from "swiper/modules";
import VinylCard from "./VinylCard";

import "swiper/css";

export default function CarouselHome({ vinyls }) {
  if (!vinyls || vinyls.length === 0) {
    return (
      <div className="w-full h-64 flex items-center justify-center">
        <div className="animate-spin rounded-full h-8 w-8 border-t-2 border-primary-600"></div>
      </div>
    );
  }

  const displayVinyls =
    vinyls.length < 15 ? [...vinyls, ...vinyls, ...vinyls] : vinyls;

  return (
    <div className="w-full relative group/carousel overflow-hidden">
      <Swiper
        modules={[Autoplay]}
        spaceBetween={20}
        loop={true}
        // loopAdditionalSlides ayuda a que el salto sea invisible
        loopAdditionalSlides={5}
        speed={8000} // Ajusta esto para velocidad (más bajo = más rápido)
        autoplay={{
          delay: 0,
          disableOnInteraction: false,
          pauseOnMouseEnter: true, // Se detiene al pasar el ratón
        }}
        // Importante para que el movimiento sea fluido y no por pasos
        allowTouchMove={true}
        breakpoints={{
          320: { slidesPerView: 3, spaceBetween: 15 },
          768: { slidesPerView: 5, spaceBetween: 25 },
          1280: { slidesPerView: 8, spaceBetween: 30 },
        }}
        className="linear-swiper !ease-linear"
      >
        {displayVinyls.map((vinyl, index) => (
          <SwiperSlide
            key={`${vinyl.id}-${index}`}
            className="flex items-center justify-center"
          >
            <VinylCard vinyl={vinyl} />
          </SwiperSlide>
        ))}
      </Swiper>

      {/* 3. CSS para forzar fluidez constante */}
      <style>{`
        /* Elimina el efecto de aceleración/frenado por defecto */
        .linear-swiper .swiper-wrapper {
          transition-timing-function: linear !important;
          -webkit-transition-timing-function: linear !important;
        }

        /* Opcional: Máscara de desvanecimiento en los bordes para un look pro */
        .group\\/carousel {
          mask-image: linear-gradient(
            to right,
            transparent,
            black 10%,
            black 90%,
            transparent
          );
          -webkit-mask-image: linear-gradient(
            to right,
            transparent,
            black 10%,
            black 90%,
            transparent
          );
        }
      `}</style>
    </div>
  );
}
