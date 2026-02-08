import React, { useEffect } from "react";
import { useAuthStore } from "../store/useAuthStore";
import CarouselHome from "../components/common/CarouselHome";

const Home = () => {
  const { user, token, isLoggedIn } = useAuthStore();

  useEffect(() => {
    console.log("--- ESTADO GLOBAL DEL STORE ---");
    console.log("¿Logueado?:", isLoggedIn);
    console.log("Usuario:", user);
    console.log("JWT Token:", token);
    console.log("Avatar img:", user.avatar_img);
  }, [user, token, isLoggedIn]);

  const fakeVinyls = [
    {
      id: 1,
      artist: "Pink Floyd",
      album: "The Dark Side of the Moon",
      album_cover:
        "https://upload.wikimedia.org/wikipedia/en/3/3b/Dark_Side_of_the_Moon.png",
      price: 34.95,
      release_date: "1973-03-01",
      band_location: "London, UK",
    },
    {
      id: 2,
      artist: "Daft Punk",
      album: "Random Access Memories",
      album_cover:
        "https://i.scdn.co/image/ab67616d0000b273b06380628e8f855e9752d585",
      price: 39.99,
      release_date: "2013-05-17",
      band_location: "Paris, FR",
    },
    {
      id: 3,
      artist: "Arctic Monkeys",
      album: "AM",
      album_cover:
        "https://i.scdn.co/image/ab67616d0000b2734ae0782241c77ac40ef66d22",
      price: 28.5,
      release_date: "2013-09-09",
      band_location: "Sheffield, UK",
    },
    {
      id: 4,
      artist: "The Strokes",
      album: "Is This It",
      album_cover:
        "https://upload.wikimedia.org/wikipedia/en/0/09/The_Strokes_-_Is_This_It.png",
      price: 31.0,
      release_date: "2001-07-30",
      band_location: "New York, USA",
    },
    {
      id: 5,
      artist: "Nirvana",
      album: "Nevermind",
      album_cover:
        "https://upload.wikimedia.org/wikipedia/en/b/b3/Nevermind_album_cover.jpg",
      price: 25.0,
      release_date: "1991-09-24",
      band_location: "Aberdeen, USA",
    },
    {
      id: 6,
      artist: "Tame Impala",
      album: "Currents",
      album_cover:
        "https://i.scdn.co/image/ab67616d0000b2739e4954846061386125026c0a",
      price: 33.5,
      release_date: "2015-07-17",
      band_location: "Perth, AU",
    },
    {
      id: 7,
      artist: "Radiohead",
      album: "OK Computer",
      album_cover:
        "https://upload.wikimedia.org/wikipedia/en/a/a1/Radiohead.okcomputer.albumart.jpg",
      price: 32.0,
      release_date: "1997-06-16",
      band_location: "Oxfordshire, UK",
    },
    {
      id: 8,
      artist: "Fleetwood Mac",
      album: "Rumours",
      album_cover:
        "https://upload.wikimedia.org/wikipedia/en/f/fb/Fleetwood_Mac_Rumours_Lp_cover.jpg",
      price: 29.99,
      release_date: "1977-02-04",
      band_location: "London, UK",
    },
    {
      id: 9,
      artist: "The Beatles",
      album: "Abbey Road",
      album_cover:
        "https://upload.wikimedia.org/wikipedia/en/4/42/Beatles_-_Abbey_Road.jpg",
      price: 35.5,
      release_date: "1969-09-26",
      band_location: "Liverpool, UK",
    },
  ];

  return (
    <div className="min-h-screen bg-black">
      <section className="py-20">
        <div className="container mx-auto px-4 mb-10">
          <h2 className="text-4xl font-black text-white uppercase tracking-tighter">
            Novedades <span className="text-primary-500">Recientes</span>
          </h2>
          <p className="text-neutral-500">
            Explora los últimos vinilos añadidos a la colección.
          </p>
        </div>

        <CarouselHome vinyls={fakeVinyls} />
      </section>
    </div>
  );
};

export default Home;
