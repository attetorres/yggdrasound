import React from "react";
import { ShoppingBag, ChevronRight } from "lucide-react";
import { Link } from "react-router-dom";

const OrderHistorySection = ({
  orders,
  loading,
  expandedOrderId,
  setExpandedOrderId,
}) => {
  if (loading) {
    return (
      <div className="flex flex-col items-center justify-center py-20">
        <div className="w-10 h-10 border-4 border-primary-400 border-t-transparent rounded-full animate-spin mb-4"></div>
        <p className="text-xs uppercase font-black tracking-widest text-neutral-500">
          Cargando tu historial...
        </p>
      </div>
    );
  }

  if (orders.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-20 text-neutral-400 animate-in fade-in duration-500">
        <ShoppingBag size={48} className="mb-4 opacity-20" />
        <p className="italic uppercase tracking-widest text-xs">
          No hay artículos en tu historial todavía
        </p>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-4 animate-in fade-in slide-in-from-bottom-4 duration-500">
      <div className="flex flex-col gap-4">
        {orders.map((order) => (
          <div
            key={order.id}
            className="bg-white border border-neutral-200 rounded-2rem overflow-hidden transition-all duration-300 shadow-sm"
          >
            <button
              onClick={() =>
                setExpandedOrderId(
                  expandedOrderId === order.id ? null : order.id,
                )
              }
              className="w-full p-6 md:p-8 flex flex-wrap items-center justify-between gap-4 hover:bg-neutral-50 transition-colors cursor-pointer text-left"
            >
              <div className="flex items-center gap-6 md:gap-12">
                <div className="flex flex-col">
                  <span className="text-[10px] font-black uppercase text-neutral-400 tracking-widest">
                    Pedido
                  </span>
                  <span className="font-bold text-lg text-neutral-900">
                    #{order.id}
                  </span>
                </div>
                <div className="flex flex-col">
                  <span className="text-[10px] font-black uppercase text-neutral-400 tracking-widest">
                    Fecha
                  </span>
                  <span className="font-bold text-neutral-700">
                    {new Date(order.order_date).toLocaleDateString("es-ES", {
                      day: "2-digit",
                      month: "short",
                      year: "numeric",
                    })}
                  </span>
                </div>
              </div>

              <div className="flex items-center gap-8 ml-auto">
                <div className="flex flex-col items-end">
                  <span className="text-[10px] font-black uppercase text-neutral-400 tracking-widest">
                    Total
                  </span>
                  <span className="font-black text-xl text-neutral-950">
                    {order.total_amount} €
                  </span>
                </div>
                <div
                  className={`transition-transform duration-300 ${
                    expandedOrderId === order.id ? "rotate-90" : ""
                  }`}
                >
                  <ChevronRight size={20} className="text-neutral-400" />
                </div>
              </div>
            </button>

            <div
              className={`transition-all duration-500 ease-in-out ${
                expandedOrderId === order.id
                  ? "max-h-250 opacity-100"
                  : "max-h-0 opacity-0"
              } overflow-hidden bg-neutral-50/50`}
            >
              <div className="p-6 md:p-8 border-t border-neutral-100 flex flex-col gap-6">
                {order.items && order.items.length > 0 ? (
                  order.items.map((item) => (
                    <Link to={`/vinyl-details/${item.vinyl.id}`} key={item.id}>
                      <div className="flex items-center justify-between group">
                        <div className="flex items-center gap-4">
                          <div className="w-16 h-16 rounded-lg overflow-hidden border border-neutral-200 shadow-sm">
                            <img
                              src={item.vinyl?.album_cover}
                              alt={item.vinyl?.album}
                              className="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500"
                            />
                          </div>
                          <div className="flex flex-col">
                            <span className="font-black uppercase text-sm italic tracking-tighter text-neutral-900">
                              {item.vinyl?.album}
                            </span>
                            <span className="text-xs text-neutral-500 font-bold">
                              {item.vinyl?.artist}
                            </span>
                            <div className="flex gap-3 mt-1">
                              <span className="text-[10px] font-black text-neutral-400 uppercase">
                                Cant: {item.quantity}
                              </span>
                              <span className="text-[10px] font-black text-neutral-400 uppercase">
                                |
                              </span>
                              <span className="text-[10px] font-black text-neutral-400 uppercase">
                                {item.unit_price} €/u
                              </span>
                            </div>
                          </div>
                        </div>
                      </div>
                    </Link>
                  ))
                ) : (
                  <p className="text-[10px] uppercase font-black text-neutral-400 italic">
                    No se pudieron cargar los detalles de este pedido.
                  </p>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default OrderHistorySection;
