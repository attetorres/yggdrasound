import React, { useState, useEffect } from "react";
import { getOrders, getOrderDetailAdmin } from "../../../services/adminService";
import {
  ChevronLeft,
  ChevronRight,
  Eye,
  X,
  Calendar,
  User,
  ShoppingBag,
} from "lucide-react";

const AdminOrders = () => {
  const [orders, setOrders] = useState([]);
  const [pagination, setPagination] = useState({});
  const [currentPage, setCurrentPage] = useState(1);
  const [loading, setLoading] = useState(true);

  const [selectedOrder, setSelectedOrder] = useState(null);
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const [detailLoading, setDetailLoading] = useState(false);

  const fetchOrders = async (page) => {
    try {
      setLoading(true);
      const response = await getOrders(page, 6);
      if (response.success) {
        setOrders(response.data);
        setPagination(response.pagination);
      }
    } catch (error) {
      console.error("Error cargando pedidos:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleViewOrder = async (orderId) => {
    try {
      setDetailLoading(true);
      setIsDrawerOpen(true);
      const response = await getOrderDetailAdmin(orderId);
      if (response.success) {
        setSelectedOrder(response.data);
      }
    } catch (error) {
      console.error("Error al obtener el detalle:", error);
      setIsDrawerOpen(false);
    } finally {
      setDetailLoading(false);
    }
  };

  useEffect(() => {
    fetchOrders(currentPage);
  }, [currentPage]);

  return (
    <div className="p-6 bg-black min-h-screen text-white relative">
      <div className="flex justify-between items-center mb-8">
        <h2 className="text-3xl font-black italic uppercase tracking-tighter">
          Historial de Ventas
        </h2>
        <span className="bg-neutral-800 px-4 py-1 rounded-full text-[10px] font-black uppercase tracking-widest">
          {pagination.totalItems || 0} Registros
        </span>
      </div>

      <div className="bg-neutral-900 border border-neutral-800 rounded-4xl overflow-hidden">
        <table className="w-full text-left">
          <thead>
            <tr className="text-[10px] uppercase font-black text-neutral-500 border-b border-neutral-800 bg-neutral-900/50">
              <th className="p-6">ID</th>
              <th className="p-6">Fecha</th>
              <th className="p-6">ID Cliente</th>
              <th className="p-6">Cliente</th>
              <th className="p-6 text-center">Cantidad</th>
              <th className="p-6 text-right">Total</th>
              <th className="p-6 text-center">Ver Detalles</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-neutral-800/50">
            {orders.map((order) => (
              <tr
                key={order.id}
                className="hover:bg-white/5 transition-colors group"
              >
                <td className="p-6 font-mono text-neutral-500 text-xs">
                  #{order.id}
                </td>
                <td className="p-6 text-sm text-neutral-300">
                  {new Date(order.order_date).toLocaleDateString()}
                </td>
                <td className="p-6 font-mono text-xs text-neutral-500">
                  {order.User?.id || "???"}
                </td>
                <td className="p-6 font-bold">{order.User?.username}</td>
                <td className="p-6 text-sm font-bold text-center">
                  {order.quantity}
                </td>
                <td className="p-6 text-right font-black text-primary-400">
                  {order.total_amount}€
                </td>
                <td className="p-6 text-center">
                  <button
                    onClick={() => handleViewOrder(order.id)}
                    className="p-2 hover:bg-primary-500/20 text-primary-400 rounded-xl transition-all cursor-pointer"
                  >
                    <Eye size={18} />
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>

        <div className="p-6 border-t border-neutral-800 flex justify-between items-center bg-neutral-900/80">
          <p className="text-xs text-neutral-500 font-bold uppercase tracking-widest">
            Página {currentPage} de {pagination.totalPages || 1}
          </p>
          <div className="flex gap-2">
            <button
              onClick={() => setCurrentPage((p) => Math.max(p - 1, 1))}
              disabled={currentPage === 1}
              className="p-2 border border-neutral-800 rounded-xl hover:bg-neutral-800 disabled:opacity-20 cursor-pointer"
            >
              <ChevronLeft size={20} />
            </button>
            <button
              onClick={() =>
                setCurrentPage((p) => Math.min(p + 1, pagination.totalPages))
              }
              disabled={currentPage === pagination.totalPages}
              className="p-2 border border-neutral-800 rounded-xl hover:bg-neutral-800 disabled:opacity-20 cursor-pointer"
            >
              <ChevronRight size={20} />
            </button>
          </div>
        </div>
      </div>

      {isDrawerOpen && (
        <div
          className="fixed inset-0 bg-black/80 backdrop-blur-md z-40 transition-all"
          onClick={() => setIsDrawerOpen(false)}
        />
      )}

      <div
        className={`fixed top-0 right-0 h-full w-full max-w-lg bg-neutral-900 border-l border-neutral-800 z-50 transform transition-transform duration-500 ease-in-out shadow-2xl ${isDrawerOpen ? "translate-x-0" : "translate-x-full"}`}
      >
        <div className="h-full flex flex-col">
          <div className="p-8 border-b border-neutral-800 flex justify-between items-center">
            <div>
              <h3 className="text-2xl font-black italic uppercase tracking-tighter">
                Detalle de Compra
              </h3>
              <p className="text-xs font-mono text-neutral-500 mt-1">
                Ref: #{selectedOrder?.id}
              </p>
            </div>
            <button
              onClick={() => setIsDrawerOpen(false)}
              className="p-2 hover:bg-white/10 rounded-full transition-colors cursor-pointer"
            >
              <X size={24} />
            </button>
          </div>

          <div className="grow overflow-y-auto p-8 space-y-8">
            {detailLoading ? (
              <div className="h-full flex items-center justify-center text-primary-400 animate-pulse font-black uppercase tracking-widest">
                Cargando...
              </div>
            ) : (
              selectedOrder && (
                <>
                  <section className="space-y-4">
                    <div className="flex items-center gap-2 text-neutral-500">
                      <User size={14} />
                      <span className="text-[10px] font-black uppercase tracking-widest">
                        Información de Envío
                      </span>
                    </div>

                    <div className="bg-neutral-800/30 p-6 rounded-3xl border border-neutral-800">
                      <div className="mb-6 border-b border-neutral-800 pb-4">
                        <p className="text-xl font-bold text-white">
                          {selectedOrder.User?.name}{" "}
                          {selectedOrder.User?.surname}
                        </p>
                        <p className="text-neutral-400 text-sm">
                          @{selectedOrder.User?.username}
                        </p>
                        <p className="text-primary-400 text-xs mt-1 font-mono">
                          {selectedOrder.User?.email}
                        </p>
                      </div>

                      {selectedOrder.User?.street ? (
                        <div className="space-y-1">
                          <p className="text-sm text-white font-bold uppercase tracking-tight">
                            {selectedOrder.User.street}{" "}
                            {selectedOrder.User.number}
                          </p>
                          <p className="text-sm text-neutral-400">
                            {selectedOrder.User.postcode} -{" "}
                            {selectedOrder.User.city}
                          </p>
                          <p className="text-[10px] text-primary-400 font-black uppercase tracking-widest mt-2">
                            {selectedOrder.User.country}
                          </p>
                        </div>
                      ) : (
                        <p className="text-sm text-neutral-500 italic">
                          Sin dirección registrada
                        </p>
                      )}
                    </div>
                  </section>

                  <section className="space-y-4">
                    <div className="flex items-center gap-2 text-neutral-500">
                      <ShoppingBag size={14} />{" "}
                      <span className="text-[10px] font-black uppercase tracking-widest">
                        Artículos
                      </span>
                    </div>
                    <div className="space-y-3">
                      {selectedOrder.OrderVinyls?.map((item) => (
                        <div
                          key={item.id}
                          className="flex gap-4 p-3 bg-white/5 rounded-2xl border border-white/5 items-center"
                        >
                          <img
                            src={item.Vinyl?.album_cover}
                            className="w-16 h-16 rounded-xl object-cover shadow-2xl"
                            alt="cover"
                          />
                          <div className="grow">
                            <p className="font-bold leading-tight">
                              {item.Vinyl?.album}
                            </p>
                            <p className="text-xs text-neutral-500">
                              {item.Vinyl?.artist}
                            </p>
                          </div>
                          <div className="text-right">
                            <p className="text-xs text-neutral-500 font-bold">
                              x{item.quantity}
                            </p>
                            <p className="font-black text-primary-400">
                              {item.unit_price}€
                            </p>
                          </div>
                        </div>
                      ))}
                    </div>
                  </section>
                </>
              )
            )}
          </div>

          <div className="p-8 border-t border-neutral-800 bg-neutral-900/50">
            <div className="flex justify-between items-end">
              <div>
                <p className="text-[10px] font-black uppercase text-neutral-500 tracking-widest mb-1">
                  Total del pedido
                </p>
                <p className="text-5xl font-black italic text-green-400 tracking-tighter">
                  {selectedOrder?.total_amount}€
                </p>
              </div>
              <div className="text-right text-neutral-500 text-[10px] font-black uppercase">
                <Calendar size={14} className="inline mr-1 mb-1" />
                {selectedOrder &&
                  new Date(selectedOrder.order_date).toLocaleDateString()}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AdminOrders;
