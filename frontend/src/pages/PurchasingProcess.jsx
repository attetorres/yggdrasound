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
  const { items, updateItem, deleteItem, total } = useShoppingCartStore();
  const [profile, setProfile] = useState(null);
  const [defaultCard, setDefaultCard] = useState(null);
  const [loading, setLoading] = useState(true);

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
      deleteItem(item.id);
      showToast.success(`"${item.vinyl?.album}" eliminado del carrito`);
    }
  };

  const handleRemove = (item) => {
    deleteItem(item.id);

    const message =
      item.quantity > 1
        ? `Todas las unidades de "${item.vinyl?.album}" eliminadas`
        : `"${item.vinyl?.album}" eliminado del carrito`;

    showToast.success(message);
  };

  const formatCardNumber = (num) => {
    if (!num) return "**** **** **** ****";
    const cleanNum = String(num).replace(/\s+/g, "");
    const lastFour = cleanNum.slice(-4);
    return `**** **** **** ${lastFour}`;
  };

  const hasAddress =
    profile?.name &&
    profile?.surname &&
    profile?.street &&
    profile?.number &&
    profile?.postcode &&
    profile?.city &&
    profile?.country;

  const hasPayment = !!defaultCard;
  const canCheckout = hasAddress && hasPayment && items.length > 0;

  return (
    <div className="min-h-screen flex flex-col gap-4 md:gap-6 p-4 md:p-6 bg-neutral-200">
      <div className="p-6 md:p-8 rounded-2xl border border-neutral-800 bg-neutral-950 text-white shrink-0">
        <h1 className="text-2xl md:text-3xl font-black italic tracking-tighter uppercase leading-none text-center md:text-left">
          Tramitar pedido
        </h1>
      </div>

      <div className="flex flex-col md:flex-row flex-1 gap-6">
        <div className="flex-1 flex flex-col gap-3 order-2 md:order-1">
          {items.length > 0 ? (
            items.map((item) => (
              <PurchasingProcessVinylCard
                key={item.id}
                cartItem={item}
                onIncrease={() => handleIncrease(item)}
                onDecrease={() => handleDecrease(item)}
                onRemove={() => handleRemove(item)}
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

        <div className="w-full md:w-85 flex-none order-1 md:order-2">
          <div className="md:sticky md:top-6 flex flex-col gap-2">
            <div className="bg-neutral-900 border border-neutral-800 rounded-3xl p-6 shadow-2xl">
              <span className="text-[10px] text-neutral-500 uppercase font-black tracking-widest">
                Resumen del pedido
              </span>
              <div className="flex justify-between items-end md:block mt-3">
                <h2 className="text-lg font-bold text-primary-400">
                  Total a pagar:
                </h2>
                <span className="text-white text-3xl font-black block tracking-tighter italic">
                  {total || 0} €
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
                  <p className="text-[11px] text-neutral-400 mt-1 tracking-tight">
                    {profile.street}, {profile.number}
                  </p>
                  <p className="text-[11px] text-neutral-500">
                    {profile.postcode} • {profile.city}
                  </p>
                  <p className="text-[11px] text-neutral-500">
                    {profile.country}
                  </p>
                </div>
              ) : (
                <p className="text-xs text-red-400/80 italic">
                  Añade dirección en perfil
                </p>
              )}
            </SummarySection>

            <SummarySection
              title="Método de pago"
              icon={<CreditCard size={14} />}
              linkTo="/profile?section=credit-card"
              isEmpty={!hasPayment}
            >
              {hasPayment ? (
                <div className="flex items-center gap-3">
                  <div className="px-2 py-1 bg-neutral-800 border border-neutral-700 rounded text-[9px] font-black italic text-primary-400 uppercase tracking-tighter">
                    {defaultCard.brand || "Card"}
                  </div>

                  <div className="flex flex-col leading-tight">
                    <p className="font-bold text-neutral-200 tracking-widest">
                      {formatCardNumber(
                        defaultCard.card_number ||
                          defaultCard.last4 ||
                          defaultCard.number,
                      )}
                    </p>
                    <p className="text-[10px] text-neutral-500 uppercase font-medium mt-0.5">
                      Expira{" "}
                      {defaultCard.exp_month ||
                        defaultCard.expiration_date?.split("-")[1]}
                      /
                      {defaultCard.exp_year ||
                        defaultCard.expiration_date?.split("-")[0]?.slice(-2)}
                    </p>
                  </div>
                </div>
              ) : (
                <p className="text-xs text-red-400/80 italic">
                  No hay tarjeta configurada
                </p>
              )}
            </SummarySection>
          </div>
        </div>
      </div>
    </div>
  );
};

export default PurchasingProcess;
