import React, { useEffect, useState } from "react";
import { showToast } from "../components/utils/toast";
import { useShoppingCartStore } from "../store/useShoppingCartStore";
import { Link } from "react-router-dom";
import { CreditCard, MapPin, ChevronRight, AlertCircle } from "lucide-react";
import PurchasingProcessVinylCard from "../components/common/PurchasingProcessVinylCard";
import CreditCardComponent from "../components/common/CreditCardComponent";
import { getUserProfile } from "../services/userService";
import { getCreditCards } from "../services/creditCardService";

const SummarySection = ({ title, icon, children, linkTo, isEmpty }) => (
  <div
    className={`bg-neutral-900 border ${isEmpty ? "border-red-900/50" : "border-neutral-800"} rounded-2xl p-4 mt-3 transition-colors`}
  >
    <div className="flex justify-between items-center mb-2">
      <div
        className={`flex items-center gap-2 ${isEmpty ? "text-red-400" : "text-neutral-500"}`}
      >
        {icon}
        <span className="text-[10px] uppercase font-black tracking-widest">
          {title}
        </span>
      </div>
      <Link to={linkTo} className="text-primary-400 hover:text-primary-300">
        <ChevronRight size={14} />
      </Link>
    </div>
    <div className="text-sm text-white">{children}</div>
  </div>
);

const PurchasingProcess = () => {
  // 1. Funcionalidades de la Store restauradas
  const { items, updateItem, deleteItem, total } = useShoppingCartStore();
  const [profile, setProfile] = useState(null);
  const [defaultCard, setDefaultCard] = useState(null);
  const [loading, setLoading] = useState(true);

  // Carga de datos inicial
  useEffect(() => {
    const loadCheckoutData = async () => {
      try {
        setLoading(true);
        const [userRes, cardRes] = await Promise.all([
          getUserProfile(),
          getCreditCards(),
        ]);
        if (userRes.success) setProfile(userRes.user);
        if (cardRes.success) {
          const cards = cardRes.data.credit_cards;
          const mainCard = cards.find((c) => c.is_default) || cards[0];
          setDefaultCard(mainCard);
        }
      } catch (error) {
        console.error("Error cargando datos de checkout:", error);
      } finally {
        setLoading(false);
      }
    };
    loadCheckoutData();
  }, []);

  const handleIncrease = (item) => {
    updateItem(item.id, item.quantity + 1);
  };

  const handleDecrease = (item) => {
    if (item.quantity > 1) {
      updateItem(item.id, item.quantity - 1);
    } else {
      // Cuando es 1, directamente pasamos 0 para que se elimine
      updateItem(item.id, 0);
      showToast.success(`"${item.vinyl?.album}" eliminado del carrito`);
    }
  };

  const handleRemove = (id) => {
    deleteItem(id);
  };

  const hasAddress = profile?.street && profile?.city;
  const hasPayment = !!defaultCard;
  const canCheckout = hasAddress && hasPayment && items.length > 0;

  return (
    <div className="min-h-screen flex flex-col gap-4 md:gap-6 p-4 md:p-6 bg-black">
      {/* Header */}
      <div className="p-6 md:p-8 rounded-2xl border border-neutral-800 bg-neutral-950 text-white shrink-0">
        <h1 className="text-2xl md:text-3xl font-black italic tracking-tighter uppercase leading-none text-center md:text-left">
          Tramitar pedido
        </h1>
      </div>

      <div className="flex flex-col md:flex-row flex-1 gap-6">
        {/* Columna Izquierda: Productos */}
        <div className="flex-1 flex flex-col gap-3 order-2 md:order-1">
          {items.length > 0 ? (
            items.map((item) => (
              <PurchasingProcessVinylCard
                key={item.id}
                cartItem={item}
                onIncrease={() => handleIncrease(item)}
                onDecrease={() => handleDecrease(item)}
                onRemove={() => handleRemove(item.id)}
              />
            ))
          ) : (
            <div className="p-10 border border-dashed border-neutral-800 rounded-3xl text-center">
              <p className="text-xs text-neutral-500 uppercase font-bold">
                Tu bolsa está vacía
              </p>
              <Link
                to="/"
                className="inline-block mt-4 text-primary-400 font-bold hover:underline tracking-widest"
              >
                EXPLORAR TIENDA
              </Link>
            </div>
          )}
        </div>

        {/* Columna Derecha: Resumen Sticky */}
        <div className="w-full md:w-85 flex-none order-1 md:order-2">
          <div className="md:sticky md:top-6 flex flex-col gap-2">
            {/* Card de Pago/Precio */}
            <div className="bg-neutral-900 border border-neutral-800 rounded-3xl p-6 shadow-2xl">
              <span className="text-[10px] text-neutral-500 uppercase font-black tracking-widest">
                Resumen del pedido
              </span>
              <div className="flex justify-between items-end md:block mt-3">
                <h2 className="text-lg font-bold text-primary-400">
                  Total a pagar:
                </h2>
                <span className="text-white text-3xl font-black block tracking-tighter italic">
                  {total} €
                </span>
              </div>
              <button
                disabled={!canCheckout}
                className={`mt-6 w-full py-4 rounded-2xl font-black uppercase italic text-sm tracking-tighter transition-all 
                  ${
                    canCheckout
                      ? "bg-primary-500 hover:bg-primary-600 text-black cursor-pointer shadow-lg shadow-primary-500/20 active:scale-95"
                      : "bg-neutral-800 text-neutral-500 cursor-not-allowed opacity-50"
                  }`}
              >
                {canCheckout ? "Finalizar Compra" : "Faltan datos"}
              </button>
              {!canCheckout && items.length > 0 && (
                <p className="flex items-center gap-1.5 text-[9px] text-red-400 mt-3 font-bold uppercase tracking-tighter">
                  <AlertCircle size={12} /> Revisa envío y pago
                </p>
              )}
            </div>

            {/* Datos de Envío */}
            <SummarySection
              title="Dirección de envío"
              icon={<MapPin size={14} />}
              linkTo="/profile?section=information"
              isEmpty={!hasAddress}
            >
              {hasAddress ? (
                <div className="flex flex-col leading-tight">
                  <p className="font-bold text-neutral-200">
                    {profile.name} {profile.surname}
                  </p>
                  <p className="text-[11px] text-neutral-400 mt-1 uppercase tracking-tight">
                    {profile.street}, {profile.number}
                  </p>
                  <p className="text-[11px] text-neutral-500">
                    {profile.postcode} • {profile.city}
                  </p>
                </div>
              ) : (
                <p className="text-xs text-red-400/80 italic">
                  Añade dirección en perfil
                </p>
              )}
            </SummarySection>

            {/* Método de Pago con Tarjeta Física */}
            <div className="mt-2 flex flex-col">
              <div className="flex justify-between items-center px-2 mb-2">
                <div
                  className={`flex items-center gap-2 ${!hasPayment ? "text-red-400" : "text-neutral-500"}`}
                >
                  <CreditCard size={14} />
                  <span className="text-[10px] uppercase font-black tracking-widest">
                    Método de pago
                  </span>
                </div>
                <Link
                  to="/profile?section=credit-card"
                  className="text-primary-400 hover:text-primary-300"
                >
                  <ChevronRight size={16} />
                </Link>
              </div>

              {hasPayment ? (
                <div className="flex justify-center md:justify-start">
                  <div className="scale-[0.85] origin-top-center md:origin-top-left -mb-6">
                    <CreditCardComponent
                      creditCard={defaultCard}
                      onDelete={() => {}}
                      onSelectDefault={() => {}}
                    />
                  </div>
                </div>
              ) : (
                <div className="bg-neutral-900 border border-red-900/40 rounded-2xl p-6 text-center">
                  <p className="text-xs text-red-400/80 italic mb-3">
                    Falta tarjeta
                  </p>
                  <Link
                    to="/profile?section=credit-card"
                    className="text-[10px] font-black uppercase text-primary-400 border border-primary-400/20 px-4 py-2 rounded-full"
                  >
                    Añadir Tarjeta
                  </Link>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default PurchasingProcess;
