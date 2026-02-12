import React from "react";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import ScrollToTop from "../components/utils/ScrollToTop";
import { Toaster } from "react-hot-toast";
import { useAuthStore } from "../store/useAuthStore";
import MainLayout from "../components/layout/MainLayout";
import Home from "../pages/Home";
import Register from "../pages/Register";
import Login from "../pages/Login";
import Profile from "../pages/Profile";
import Catalog from "../pages/Catalog";
import VinylDetails from "../pages/VinylDetails";

const AppRouter = () => {
  const isLoggedIn = useAuthStore((state) => state.isLoggedIn);

  return (
    <BrowserRouter>
      <ScrollToTop />
      <Toaster
        position="top-center"
        toastOptions={{
          style: {
            background: "#30302e", // neutral-900
            color: "#e5e1d8", // primary-100
            border: "1px solid #414143", // neutral-700
          },
        }}
      />
      <Routes>
        <Route element={<MainLayout />}>
          <Route path="/" element={<Home />} />
          <Route path="/register" element={<Register />} />
          <Route path="/login" element={<Login />} />
          <Route
            path="/profile"
            element={isLoggedIn ? <Profile /> : <Navigate to="/login" />}
          />
          <Route path="/catalog/:param_genre?" element={<Catalog />} />
          <Route path="/vinyl-details/:id" element={<VinylDetails />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
};

export default AppRouter;
