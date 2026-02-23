import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";

import { TrendingUp, Users, Disc, AlertCircle } from "lucide-react";
import {
  getAdminDashboardStats,
  getOrders,
} from "../../../services/adminService";

const DashboardStats = () => {
  const [statsData, setStatsData] = useState({
    totalUsers: 0,
    totalVinyls: 0,
    totalOrders: 0,
    totalRevenue: "0.00",
  });

  const [recentOrders, setRecentOrders] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchDashboardData = async () => {
    try {
      setLoading(true);
      const [statsRes, ordersRes] = await Promise.all([
        getAdminDashboardStats(),
        getOrders(1, 5),
      ]);

      if (statsRes.success) {
        setStatsData(statsRes.data);
      }

      if (ordersRes.success) {
        setRecentOrders(ordersRes.data);
      }
    } catch (error) {
      console.error("Error al cargar datos del dashboard:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const statsCards = [
    {
      label: "Ingresos Totales",
      value: loading ? "..." : `${statsData.totalRevenue}€`,
      icon: <TrendingUp size={20} />,
      color: "text-green-400",
    },
    {
      label: "Usuarios",
      value: loading ? "..." : statsData.totalUsers,
      icon: <Users size={20} />,
      color: "text-white",
    },
    {
      label: "Vinilos Totales",
      value: loading ? "..." : statsData.totalVinyls,
      icon: <Disc size={20} />,
      color: "text-primary-400",
    },
    {
      label: "Pedidos Totales",
      value: loading ? "..." : statsData.totalOrders,
      icon: <AlertCircle size={20} />,
      color: "text-yellow-400",
    },
  ];

  return (
    <div className="animate-in fade-in slide-in-from-bottom-4 duration-700">
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
        {statsCards.map((stat, index) => (
          <div
            key={index}
            className="bg-neutral-950 border border-neutral-800 p-8 rounded-[2.5rem] group hover:border-neutral-700 transition-all"
          >
            <div className="flex justify-between items-start mb-4">
              <span className="text-[10px] uppercase font-black tracking-[0.2em] text-neutral-500 group-hover:text-neutral-300">
                {stat.label}
              </span>
              <span className="text-neutral-700 group-hover:text-primary-500 transition-colors">
                {stat.icon}
              </span>
            </div>
            <span
              className={`text-4xl font-black italic tracking-tighter ${stat.color}`}
            >
              {stat.value}
            </span>
          </div>
        ))}
      </div>

      <div className="bg-neutral-950 border border-neutral-800 rounded-[2.5rem] p-10">
        <div className="flex justify-between items-center mb-10">
          <h3 className="text-2xl font-black uppercase italic tracking-tighter">
            Ventas Recientes
          </h3>
          <Link to="/admin/orders">
            <button className="text-[10px] font-black uppercase tracking-[0.3em] text-neutral-500 hover:text-white transition-colors cursor-pointer">
              Ver historial completo →
            </button>
          </Link>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left">
            <thead>
              <tr className="text-[10px] uppercase font-black text-neutral-600 border-b border-neutral-800">
                <th className="pb-6">Pedido</th>
                <th className="pb-6">Usuario</th>
                <th className="pb-6">Fecha</th>
                <th className="pb-6 text-right">Total</th>
              </tr>
            </thead>
            <tbody className="text-sm">
              {loading ? (
                <tr>
                  <td
                    colSpan="4"
                    className="py-10 text-center text-neutral-500 animate-pulse"
                  >
                    Cargando pedidos...
                  </td>
                </tr>
              ) : recentOrders.length > 0 ? (
                recentOrders.map((order) => (
                  <tr
                    key={order.id}
                    className="border-b border-neutral-800/50 hover:bg-white/5 transition-colors group"
                  >
                    <td className="py-6 font-mono text-neutral-500 group-hover:text-neutral-300">
                      #{order.id}
                    </td>
                    <td className="py-6 font-bold">
                      {order.User ? order.User.username : "Desconocido"}
                    </td>
                    <td className="py-6 text-neutral-400">
                      {new Date(order.order_date).toLocaleDateString()}
                    </td>
                    <td className="py-6 text-right font-black text-primary-400 text-lg">
                      {order.total_amount}€
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td
                    colSpan="4"
                    className="py-10 text-center text-neutral-500"
                  >
                    No hay ventas recientes.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default DashboardStats;
