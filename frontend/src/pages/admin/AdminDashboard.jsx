import React from "react";
import { Outlet } from "react-router-dom";
import AdminSidebar from "./AdminSidebar";

const AdminDashboard = () => {
  return (
    <div className="flex min-h-screen bg-neutral-900 text-white selection:bg-primary-500/30 font-sans">
      <AdminSidebar />

      <main className="flex-1 min-w-0 overflow-hidden p-6 md:p-12">
        <Outlet />
      </main>
    </div>
  );
};

export default AdminDashboard;
