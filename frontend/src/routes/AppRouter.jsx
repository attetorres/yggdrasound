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
import PurchasingProcess from "../pages/PurchasingProcess";
import AdminDashboard from "../pages/admin/AdminDashboard";
import DashboardStats from "../pages/admin/views/DashboardStats";
import AdminVinyls from "../pages/admin/views/AdminVinyls";
import AdminUsers from "../pages/admin/views/AdminUsers";
import AdminOrders from "../pages/admin/views/AdminOrders";
import AdminComments from "../pages/admin/views/AdminComments";

const AppRouter = () => {
  const { isLoggedIn, user } = useAuthStore();

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
          <Route path="/purchasing-process" element={<PurchasingProcess />} />
        </Route>

        <Route
          path="/admin"
          element={
            isLoggedIn && user?.is_admin ? (
              <AdminDashboard />
            ) : (
              <Navigate to="/" />
            )
          }
        >
          <Route index element={<DashboardStats />} />
          <Route path="vinyls" element={<AdminVinyls />} />
          <Route path="users" element={<AdminUsers />} />
          <Route path="orders" element={<AdminOrders />} />
          <Route path="comments" element={<AdminComments />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
};

export default AppRouter;
