import React, { useEffect, useRef } from "react";
import VinylCard from "./VinylCard";

const CarouselHome = ({ vinyls = [] }) => {
  const scrollRef = useRef(null);
  const infiniteVinyls = [...vinyls, ...vinyls, ...vinyls];

  useEffect(() => {
    const container = scrollRef.current;
    if (!container || !vinyls || vinyls.length === 0) return;

    const cardWidth = 328;
    const resetPoint = vinyls.length * cardWidth;
    container.scrollLeft = resetPoint;

    let interval;
    const startAutoScroll = () => {
      interval = setInterval(() => {
        const { scrollLeft } = container;
        if (scrollLeft >= resetPoint * 2 - 10) {
          container.style.scrollBehavior = "auto";
          container.scrollLeft = scrollLeft - resetPoint;
          setTimeout(() => {
            if (container) {
              container.style.scrollBehavior = "smooth";
              container.scrollBy({ left: cardWidth, behavior: "smooth" });
            }
          }, 20);
        } else {
          container.style.scrollBehavior = "smooth";
          container.scrollBy({ left: cardWidth, behavior: "smooth" });
        }
      }, 3000);
    };

    startAutoScroll();
    const handleMouseEnter = () => clearInterval(interval);
    const handleMouseLeave = () => startAutoScroll();

    container.addEventListener("mouseenter", handleMouseEnter);
    container.addEventListener("mouseleave", handleMouseLeave);

    return () => {
      clearInterval(interval);
      container.removeEventListener("mouseenter", handleMouseEnter);
      container.removeEventListener("mouseleave", handleMouseLeave);
    };
  }, [vinyls]);

  return (
    <div className="w-full max-w-6xl mx-auto relative overflow-hidden bg-black select-none">
      <div className="absolute inset-y-0 left-0 w-40 bg-linear-to-r from-black via-black/95 to-transparent pointer-events-none z-30" />
      <div className="absolute inset-y-0 right-0 w-40 bg-linear-to-l from-black via-black/95 to-transparent pointer-events-none z-30" />
      <div
        ref={scrollRef}
        className="
          flex overflow-x-auto gap-12 px-24 py-32 
          snap-x snap-mandatory items-center min-h-160
          [&::-webkit-scrollbar]:hidden
          [scrollbar-width:none]
          [-ms-overflow-style:none]
          group
          antialiased
        "
      >
        {infiniteVinyls.map((vinyl, index) => (
          <div
            key={`${vinyl.id}-${index}`}
            className="
              flex-none w-70 snap-center relative z-10
              transition-all duration-500 ease-out
              transform-[translateZ(0)]
              backface-hidden
              blur-none
              group-hover:opacity-40 group-hover:scale-95 group-hover:blur-none
              hover:opacity-100! hover:scale-115! hover:blur-none! hover:z-50
              hover:drop-shadow-[0_0_30px_rgba(255,255,255,0.15)]
              cursor-pointer
            "
          >
            <VinylCard vinyl={vinyl} />
          </div>
        ))}
      </div>
    </div>
  );
};

export default CarouselHome;
