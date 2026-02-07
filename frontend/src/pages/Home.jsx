import React, { useEffect } from "react";
import { useAuthStore } from "../store/useAuthStore";

const Home = () => {
  const { user, token, isLoggedIn } = useAuthStore();

  useEffect(() => {
    console.log("--- ESTADO GLOBAL DEL STORE ---");
    console.log("¿Logueado?:", isLoggedIn);
    console.log("Usuario:", user);
    console.log("JWT Token:", token);
    console.log("Avatar img:", user.avatar_img);
  }, [user, token, isLoggedIn]);

  return <div>Bienvenido a Yggdrasound</div>;
};

export default Home;
