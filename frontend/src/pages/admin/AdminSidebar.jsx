import React from "react";
import { NavLink } from "react-router-dom"; // Importamos NavLink
import { LayoutDashboard, Disc, Users, ShoppingBag } from "lucide-react";

const AdminSidebar = () => {
  const menuItems = [
    {
      id: "dashboard",
      label: "Dashboard",
      icon: <LayoutDashboard size={18} />,
      path: "/admin",
    },
    {
      id: "vinyls",
      label: "Vinilos",
      icon: <Disc size={18} />,
      path: "/admin/vinyls",
    },
    {
      id: "users",
      label: "Usuarios",
      icon: <Users size={18} />,
      path: "/admin/users",
    },
    {
      id: "orders",
      label: "Ventas",
      icon: <ShoppingBag size={18} />,
      path: "/admin/orders",
    },
  ];

  return (
    <aside className="w-72 bg-neutral-950 border-r border-neutral-900 p-8 flex flex-col sticky top-0 h-screen">
      <h1 className="text-2xl font-black uppercase italic tracking-tighter mb-12 px-2">
        Admin<span className="text-primary-500">.</span>Panel
      </h1>

      <nav className="flex-1 space-y-3">
        {menuItems.map((item) => (
          <NavLink
            key={item.id}
            to={item.path}
            end={item.id === "dashboard"}
            className={({ isActive }) =>
              `w-full flex items-center gap-4 px-5 py-4 rounded-2xl transition-all uppercase text-[10px] font-black tracking-[0.2em] ${
                isActive
                  ? "bg-white text-black scale-[1.02] shadow-[0_0_20px_rgba(255,255,255,0.1)]"
                  : "text-neutral-500 hover:text-white hover:bg-neutral-900"
              }`
            }
          >
            {item.icon} {item.label}
          </NavLink>
        ))}
      </nav>

      <div className="pt-8 border-t border-neutral-900">
        <div className="flex items-center gap-3 px-2">
          <div className="w-2 h-2 rounded-full bg-green-500 animate-pulse" />
          <span className="text-[9px] font-black uppercase tracking-[0.2em] text-neutral-600">
            System Online v1.0
          </span>
        </div>
      </div>
    </aside>
  );
};

export default AdminSidebar;
