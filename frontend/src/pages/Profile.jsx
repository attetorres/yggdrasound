import React, { useEffect, useState } from "react";
import { showToast } from "../components/utils/toast";
import { Link, useLocation } from "react-router-dom";
import { User, Heart, CreditCard, ShoppingBag } from "lucide-react";
import { useAuthStore } from "../store/useAuthStore";
import { useShoppingCartStore } from "../store/useShoppingCartStore";
import { getUserProfile, updateUser } from "../services/userService";
import WishVinylCard from "../components/common/WishVinylCard";
import CreditCardComponent from "../components/common/CreditCardComponent";
import OrderHistorySection from "../components/common/OrderHistorySection";
import {
  getWishListByUser,
  removeFromFavourite,
} from "../services/wishListService";
import AddCreditCardModal from "../components/common/AddCreditCardModal";
import ConfirmModal from "../components/common/ConfirmModal";
import {
  getCreditCards,
  createCreditCard,
  deleteCreditCard,
  setDefaultCard,
} from "../services/creditCardService";
import { getOrdersHistory } from "../services/orderHistoryService";

const EditableField = ({
  label,
  value,
  name,
  isEditing,
  onChange,
  placeholder,
  className = "",
}) => (
  <div className={`flex flex-col gap-1 ${className}`}>
    <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
      {label}
    </label>
    {isEditing ? (
      <input
        type="text"
        name={name}
        value={value || ""}
        onChange={onChange}
        placeholder={placeholder}
        className="text-lg font-bold border-b-2 border-primary-400 pb-2 bg-neutral-200/50 outline-none animate-in fade-in duration-300 px-2 rounded-t-md text-neutral-900"
      />
    ) : (
      <p className="text-lg font-bold border-b border-neutral-300 pb-2 text-neutral-800">
        {value || "---"}
      </p>
    )}
  </div>
);

const Profile = () => {
  const { logout } = useAuthStore();
  const { addItem } = useShoppingCartStore();

  const [activeSection, setActiveSection] = useState("information");
  const [profileData, setProfileData] = useState(null);
  const [loading, setLoading] = useState(true);

  const [wishListData, setWishListData] = useState([]);
  const [loadingWishList, setLoadingWishList] = useState(true);
  const [wishCurrentPage, setWishCurrentPage] = useState(1);
  const [wishPagination, setWishPagination] = useState({
    totalPages: 1,
    totalItems: 0,
  });

  const [isEditing, setIsEditing] = useState(false);
  const [formUserData, setFormUserData] = useState({});

  const [creditCards, setCreditCards] = useState([]);
  const [loadingCards, setLoadingCards] = useState(false);
  const [creditCardCurrentPage, setCreditCardCurrentPage] = useState(1);
  const [creditCardPagination, setCreditCardPagination] = useState({
    totalPages: 1,
    totalItems: 0,
  });

  const [orders, setOrders] = useState([]);
  const [loadingOrders, setLoadingOrders] = useState(false);
  const [orderHistoryCurrentPage, setOrderHistoryCurrentPage] = useState(1);
  const [orderHistoryPagination, setOrderHistoryPagination] = useState({
    totalPages: 1,
    totalItems: 0,
  });
  const [expandedOrderId, setExpandedOrderId] = useState(null);

  const [isAddCreditCardModalOpen, setIsAddCreditCardModalOpen] =
    useState(false);

  const [isConfirmModalOpen, setIsConfirmModalOpen] = useState(false);
  const [itemToDelete, setItemToDelete] = useState(null);

  const triggerDeleteFlow = (id) => {
    setItemToDelete(id);
    setIsConfirmModalOpen(true);
  };

  const handleConfirmAction = async () => {
    if (!itemToDelete) return;

    await handleDeleteCreditCard(itemToDelete); // Tu lógica de borrado real

    setIsConfirmModalOpen(false); // Cerramos
    setItemToDelete(null); // Limpiamos
  };

  const location = useLocation();
  useEffect(() => {
    const params = new URLSearchParams(location.search);
    const sectionParam = params.get("section");

    if (sectionParam) {
      setActiveSection(sectionParam);
    }
  }, [location]);

  const fetchUserData = async () => {
    try {
      setLoading(true);
      const response = await getUserProfile();
      if (response.success) {
        setProfileData(response.user);
      }
    } catch (error) {
      console.error("Error a cargar el perfil.", error);
      if (error.response?.status === 401) {
        logout();
      }
    } finally {
      setLoading(false);
    }
  };

  const fetchWishListData = async () => {
    try {
      setLoadingWishList(true);
      const response = await getWishListByUser(wishCurrentPage, 8);

      if (response.success) {
        setWishListData(response.data.items);
        setWishPagination(response.data.pagination);
      }
    } catch (error) {
      console.error("Error al cargar la wishlist: ", error);
      setWishListData([]);
    } finally {
      setLoadingWishList(false);
    }
  };

  const fetchCreditCards = async () => {
    try {
      setLoadingCards(true);
      const response = await getCreditCards(creditCardCurrentPage, 4);

      if (response.success) {
        setCreditCards(response.data.credit_cards);
        setCreditCardPagination(response.data.pagination);
      }
    } catch (error) {
      console.error("Error al cargar tarjetas:", error);
    } finally {
      setLoadingCards(false);
    }
  };

  const fetchOrders = async () => {
    try {
      setLoadingOrders(true);
      const response = await getOrdersHistory(orderHistoryCurrentPage, 5);
      if (response.success && response.data) {
        setOrders(response.data.orders);
        setOrderHistoryPagination(response.data.pagination);
      }
    } catch (error) {
      console.error("Error al cargar pedidos:", error);
    } finally {
      setLoadingOrders(false);
    }
  };

  const handleStartEdit = () => {
    setFormUserData({
      name: profileData.name,
      surname: profileData.surname,
      street: profileData.street,
      number: profileData.number,
      city: profileData.city,
      country: profileData.country,
      postcode: profileData.postcode,
    });
    setIsEditing(true);
  };

  const handleSaveProfile = async () => {
    if (!formUserData.name?.trim() || !formUserData.surname?.trim()) {
      showToast.error("El nombre y el apellido son obligatorios");
      return;
    }

    try {
      const response = await updateUser(formUserData);
      if (response.success) {
        setProfileData(response.data);
        setIsEditing(false);
        showToast.success("Perfil actualizado con éxito");
      }
    } catch (error) {
      console.error(error);
      showToast.error("Error al actualizar el perfil");
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormUserData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleRemoveWishListItem = async (vinylId) => {
    if (loadingWishList) return;
    const itemToRemove = wishListData.find((item) => item.vinyl.id === vinylId);
    const albumName = itemToRemove?.vinyl?.album || "Vinilo";

    try {
      setLoadingWishList(true);
      const response = await removeFromFavourite(vinylId);

      if (response.success) {
        showToast.success(`"${albumName}" eliminado de favoritos`);

        if (wishCurrentPage > 1 && wishListData.length === 1) {
          setWishCurrentPage((prev) => prev - 1);
        } else {
          fetchWishListData();
        }
      }
    } catch (error) {
      console.error("Error al eliminar favorito:", error);
      showToast.error("No se pudo eliminar el vinilo de favoritos");
      setLoadingWishList(false);
    }
  };

  const handleAddToCartFromWishList = async (vinyl) => {
    try {
      await addItem(vinyl.id);
      showToast.cart(vinyl.album);
    } catch (error) {
      console.error("Error al añadir el vinilo:", error);
      showToast.error("No se pudo añadir al carrito");
    }
  };

  const handleAddCreditCard = async (cardData) => {
    try {
      const response = await createCreditCard(cardData);
      if (response.success) {
        showToast.success("Tarjeta de crédito añadida con éxito");
        setIsAddCreditCardModalOpen(false);
        fetchCreditCards();
      }
    } catch (error) {
      showToast.error(
        error.response?.data?.message || "Error al añadir tarjeta",
      );
    }
  };

  const handleSetDefaultCard = async (cardId) => {
    try {
      const response = await setDefaultCard(cardId);
      if (response.success) {
        showToast.success(response.message);
        if (creditCardCurrentPage === 1) {
          fetchCreditCards();
        } else {
          setCreditCardCurrentPage(1);
        }
      }
    } catch (error) {
      showToast.error("No se pudo cambiar la tarjeta predeterminada");
    }
  };

  const handleDeleteCreditCard = async (cardId) => {
    try {
      const response = await deleteCreditCard(cardId);
      if (response.success) {
        showToast.success(response.message || "Tarjeta eliminada");

        if (creditCardCurrentPage > 1 && creditCards.length === 1) {
          setCreditCardCurrentPage((prev) => prev - 1);
        } else {
          fetchCreditCards();
        }
      }
    } catch (error) {
      showToast.error("No se pudo eliminar la tarjeta");
    }
  };

  useEffect(() => {
    fetchUserData();
    fetchWishListData();
    fetchCreditCards();
    fetchOrders();
  }, []);

  useEffect(() => {
    fetchWishListData();
  }, [wishCurrentPage]);

  useEffect(() => {
    fetchCreditCards();
  }, [creditCardCurrentPage]);

  useEffect(() => {
    fetchOrders();
  }, [orderHistoryCurrentPage]);

  const menuItems = [
    {
      id: "information",
      label: "Información",
      icon: <User size={20} strokeWidth={3} />,
    },
    {
      id: "wish",
      label: "Lista de deseos",
      icon: <Heart size={20} strokeWidth={3} />,
    },
    {
      id: "credit-card",
      label: "Tarjetas",
      icon: <CreditCard size={20} strokeWidth={3} />,
    },
    {
      id: "orders-history",
      label: "Historial de pedidos",
      icon: <ShoppingBag size={20} strokeWidth={3} />,
    },
  ];

  if (loading && !profileData) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-neutral-950">
        <p className="text-primary-400 font-black italic animate-pulse">
          CARGANDO PERFIL...
        </p>
      </div>
    );
  }

  return (
    <div className="min-h-screen flex flex-col gap-6">
      <div className="p-8 rounded-2xl border border-neutral-800 bg-neutral-950 text-white flex flex-col md:flex-row justify-between items-center gap-4">
        <div>
          <h1 className="text-3xl font-black italic tracking-tighter uppercase leading-none">
            Mi Cuenta
          </h1>
        </div>
      </div>
      <div className="flex flex-col lg:flex-row gap-6">
        <div className="flex-1 flex flex-col gap-6">
          <div className="bg-neutral-900 border border-neutral-800 p-8 rounded-[2.5rem] flex flex-col items-center gap-4">
            <div className="relative group">
              <div className="w-32 h-32 md:w-40 md:h-40 rounded-full overflow-hidden border-4 border-neutral-800 group-hover:border-neutral-700 transition-all duration-500">
                <img
                  src={
                    profileData?.avatar_img
                      ? profileData.avatar_img
                      : `https://api.dicebear.com/9.x/initials/svg?seed=${profileData.username}&backgroundColor=9a7b84,7d4c5a,583742`
                  }
                  alt="User Avatar"
                  className="w-full h-full object-cover grayscale hover:grayscale-0 transition-all"
                />
              </div>
            </div>
            <div className="text-center">
              <h2 className="text-xl font-black text-primary-400 uppercase tracking-tight">
                {profileData.username}
              </h2>
              <p className="text-[10px] tracking-widest uppercase text-primary-300">
                Miembro desde{" "}
                {profileData?.created_at
                  ? profileData.created_at.split("-")[0]
                  : "..."}
              </p>
            </div>
          </div>

          <div className="flex flex-col gap-2">
            {menuItems.map((item) => (
              <button
                key={item.id}
                onClick={() => setActiveSection(item.id)}
                className={`flex items-center justify-between p-5 rounded-2xl border transition-all duration-300 uppercase font-black text-xs tracking-[0.2em] cursor-pointer ${
                  activeSection === item.id
                    ? "bg-primary-400 text-neutral-950 border-primary-300"
                    : "bg-neutral-700 text-white border-neutral-800 hover:border-neutral-600"
                }`}
              >
                <span>{item.label}</span>
                <span className="text-lg">{item.icon}</span>
              </button>
            ))}
          </div>
        </div>

        <div className="flex-3 bg-neutral-100 rounded-[2.5rem] p-8 md:p-12 text-neutral-900 shadow-inner">
          <div className="space-y-8">
            <div className="flex justify-between items-start">
              <h2 className="text-5xl font-black uppercase italic tracking-tighter leading-none text-neutral-950">
                {menuItems.find((item) => item.id === activeSection)?.label ||
                  activeSection}
              </h2>
            </div>

            <div className="h-2 bg-neutral-200 w-full" />

            <div className="min-h-100">
              {activeSection === "information" && (
                <div className="flex flex-col gap-12 animate-in fade-in duration-500">
                  <div className="flex justify-between items-center">
                    <div className="flex items-center gap-4 flex-1">
                      <h3 className="text-[11px] font-black uppercase tracking-[0.4em] text-neutral-400 whitespace-nowrap">
                        Datos Personales
                      </h3>
                      <div className="h-px bg-neutral-200 w-full" />
                    </div>
                    <div className="flex gap-2 ml-4">
                      {!isEditing ? (
                        <button
                          onClick={handleStartEdit}
                          className="bg-neutral-900 text-white px-6 py-2 rounded-full text-[10px] font-black uppercase tracking-widest hover:border-primary-400 border border-transparent transition-all cursor-pointer"
                        >
                          Editar Perfil
                        </button>
                      ) : (
                        <>
                          <button
                            onClick={handleSaveProfile}
                            className="bg-primary-400 text-neutral-950 px-6 py-2 rounded-full text-[10px] font-black uppercase tracking-widest hover:bg-primary-500 transition-all cursor-pointer"
                          >
                            Guardar
                          </button>
                          <button
                            onClick={() => setIsEditing(false)}
                            className="bg-neutral-200 text-neutral-500 px-6 py-2 rounded-full text-[10px] font-black uppercase tracking-widest hover:bg-neutral-300 transition-all cursor-pointer"
                          >
                            Cancelar
                          </button>
                        </>
                      )}
                    </div>
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                    <EditableField
                      label="Nombre"
                      name="name"
                      value={isEditing ? formUserData.name : profileData.name}
                      isEditing={isEditing}
                      onChange={handleInputChange}
                    />
                    <EditableField
                      label="Apellido"
                      name="surname"
                      value={
                        isEditing ? formUserData.surname : profileData.surname
                      }
                      isEditing={isEditing}
                      onChange={handleInputChange}
                    />
                    <div className="flex flex-col gap-1 opacity-60">
                      <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                        Email
                      </label>
                      <p className="text-lg font-bold border-b border-neutral-300 pb-2 text-neutral-800">
                        {profileData.email}
                      </p>
                    </div>
                  </div>

                  <div className="flex items-center gap-4">
                    <h3 className="text-[11px] font-black uppercase tracking-[0.4em] text-neutral-400 whitespace-nowrap">
                      Dirección de envío
                    </h3>
                    <div className="h-px bg-neutral-200 w-full" />
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <EditableField
                      label="Calle"
                      name="street"
                      value={
                        isEditing
                          ? formUserData.street
                          : profileData.street || "No especificada"
                      }
                      isEditing={isEditing}
                      onChange={handleInputChange}
                      className="md:col-span-2"
                    />
                    <EditableField
                      label="Nº / Piso"
                      name="number"
                      value={
                        isEditing ? formUserData.number : profileData.number
                      }
                      isEditing={isEditing}
                      onChange={handleInputChange}
                    />
                    <EditableField
                      label="Ciudad"
                      name="city"
                      value={isEditing ? formUserData.city : profileData.city}
                      isEditing={isEditing}
                      onChange={handleInputChange}
                    />
                    <EditableField
                      label="País"
                      name="country"
                      value={
                        isEditing ? formUserData.country : profileData.country
                      }
                      isEditing={isEditing}
                      onChange={handleInputChange}
                    />
                    <EditableField
                      label="Código Postal"
                      name="postcode"
                      value={
                        isEditing ? formUserData.postcode : profileData.postcode
                      }
                      isEditing={isEditing}
                      onChange={handleInputChange}
                    />
                  </div>
                </div>
              )}

              {activeSection === "wish" && (
                <div className="animate-in fade-in slide-in-from-bottom-4 duration-500">
                  {loadingWishList ? (
                    <div className="flex flex-col items-center justify-center py-20">
                      <div className="w-10 h-10 border-4 border-primary-400 border-t-transparent rounded-full animate-spin mb-4"></div>
                      <p className="text-xs uppercase font-black tracking-widest text-neutral-500">
                        Cargando tus favoritos...
                      </p>
                    </div>
                  ) : wishListData.length > 0 ? (
                    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                      {wishListData.map((vinylFav) => (
                        <Link
                          to={`/vinyl-details/${vinylFav.vinyl.id}`}
                          key={vinylFav.wish_item_id}
                        >
                          <WishVinylCard
                            vinyl={vinylFav.vinyl}
                            onRemove={() =>
                              handleRemoveWishListItem(vinylFav.vinyl.id)
                            }
                            onAddToCart={() =>
                              handleAddToCartFromWishList(vinylFav.vinyl)
                            }
                          />
                        </Link>
                      ))}
                    </div>
                  ) : (
                    <div className="flex flex-col items-center justify-center py-20 text-neutral-400">
                      <Heart size={48} className="mb-4 opacity-20" />
                      <p className="italic uppercase tracking-widest text-xs">
                        Tu lista de deseos está vacía
                      </p>
                    </div>
                  )}
                  {wishPagination.totalPages > 1 && (
                    <div className="mt-10 flex gap-6 items-center justify-center border-t border-neutral-200 pt-8">
                      <button
                        onClick={() =>
                          setWishCurrentPage((prev) => Math.max(prev - 1, 1))
                        }
                        disabled={wishCurrentPage === 1}
                        className="bg-neutral-900 hover:bg-neutral-800 text-white px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-[10px] font-black uppercase tracking-widest"
                      >
                        Anterior
                      </button>

                      <div className="flex flex-col items-center">
                        <span className="text-neutral-900 font-bold text-sm">
                          {wishCurrentPage}
                          <span className="text-neutral-400 font-normal mx-1">
                            {" "}
                            de{" "}
                          </span>
                          {wishPagination.totalPages}
                        </span>
                      </div>

                      <button
                        onClick={() => setWishCurrentPage((prev) => prev + 1)}
                        disabled={wishCurrentPage === wishPagination.totalPages}
                        className="bg-neutral-900 hover:bg-neutral-800 text-white px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-[10px] font-black uppercase tracking-widest"
                      >
                        Siguiente
                      </button>
                    </div>
                  )}
                </div>
              )}

              {activeSection === "credit-card" && (
                <div className="animate-in fade-in slide-in-from-bottom-4 duration-500">
                  <div className="flex justify-between items-center mb-8">
                    <p className="text-[10px] uppercase font-black text-neutral-400 tracking-[0.2em]">
                      Tus métodos de pago guardados
                    </p>
                    <button
                      className="text-[10px] font-black uppercase tracking-widest bg-neutral-900 text-white px-4 py-2 rounded-full border border-neutral-800 hover:border-primary-400 transition-all cursor-pointer"
                      onClick={() => setIsAddCreditCardModalOpen(true)}
                    >
                      + Añadir Tarjeta
                    </button>
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-2 gap-8 justify-items-center max-w-4xl mx-auto">
                    {loadingCards ? (
                      <p className="col-span-full text-center animate-pulse uppercase font-black text-xs text-neutral-400">
                        Cargando tus métodos de pago...
                      </p>
                    ) : creditCards.length > 0 ? (
                      creditCards.map((card) => (
                        <CreditCardComponent
                          key={card.id}
                          creditCard={card}
                          onDelete={() => triggerDeleteFlow(card.id)}
                          onSelectDefault={() => {
                            handleSetDefaultCard(card.id);
                          }}
                        />
                      ))
                    ) : (
                      <div className="col-span-full py-20 flex flex-col items-center opacity-20">
                        <p className="text-xs uppercase font-black tracking-widest">
                          No hay tarjetas guardadas
                        </p>
                      </div>
                    )}
                  </div>
                  {creditCardPagination?.totalPages > 1 && (
                    <div className="mt-10 flex gap-6 items-center justify-center border-t border-neutral-200 pt-8">
                      <button
                        onClick={() =>
                          setCreditCardCurrentPage((prev) =>
                            Math.max(prev - 1, 1),
                          )
                        }
                        disabled={creditCardCurrentPage === 1}
                        className="bg-neutral-900 hover:bg-neutral-800 text-white px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-[10px] font-black uppercase tracking-widest"
                      >
                        Anterior
                      </button>

                      <div className="flex flex-col items-center">
                        <span className="text-neutral-900 font-bold text-sm">
                          {creditCardCurrentPage}
                          <span className="text-neutral-400 font-normal mx-1">
                            {" "}
                            de{" "}
                          </span>
                          {creditCardPagination.totalPages}
                        </span>
                      </div>

                      <button
                        onClick={() =>
                          setCreditCardCurrentPage((prev) => prev + 1)
                        }
                        disabled={
                          creditCardCurrentPage ===
                          creditCardPagination.totalPages
                        }
                        className="bg-neutral-900 hover:bg-neutral-800 text-white px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-[10px] font-black uppercase tracking-widest"
                      >
                        Siguiente
                      </button>
                    </div>
                  )}
                </div>
              )}

              {activeSection === "orders-history" && (
                <div className="animate-in fade-in slide-in-from-bottom-4 duration-500">
                  <OrderHistorySection
                    orders={orders}
                    loading={loadingOrders}
                    expandedOrderId={expandedOrderId}
                    setExpandedOrderId={setExpandedOrderId}
                  />

                  {orderHistoryPagination?.totalPages > 1 && (
                    <div className="mt-10 flex gap-6 items-center justify-center border-t border-neutral-200 pt-8">
                      <button
                        onClick={() =>
                          setOrderHistoryCurrentPage((prev) =>
                            Math.max(prev - 1, 1),
                          )
                        }
                        disabled={orderHistoryCurrentPage === 1}
                        className="bg-neutral-900 hover:bg-neutral-800 text-white px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-[10px] font-black uppercase tracking-widest"
                      >
                        Anterior
                      </button>

                      <div className="flex flex-col items-center">
                        <span className="text-neutral-900 font-bold text-sm">
                          {orderHistoryCurrentPage}
                          <span className="text-neutral-400 font-normal mx-1">
                            {" "}
                            de{" "}
                          </span>
                          {orderHistoryPagination.totalPages}
                        </span>
                      </div>

                      <button
                        onClick={() =>
                          setOrderHistoryCurrentPage((prev) => prev + 1)
                        }
                        disabled={
                          orderHistoryCurrentPage ===
                          orderHistoryPagination.totalPages
                        }
                        className="bg-neutral-900 hover:bg-neutral-800 text-white px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-[10px] font-black uppercase tracking-widest"
                      >
                        Siguiente
                      </button>
                    </div>
                  )}
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
      <AddCreditCardModal
        isOpen={isAddCreditCardModalOpen}
        onClose={() => setIsAddCreditCardModalOpen(false)}
        onSuccess={handleAddCreditCard}
      />

      <ConfirmModal
        isOpen={isConfirmModalOpen}
        onClose={() => setIsConfirmModalOpen(false)}
        onConfirm={handleConfirmAction}
        title="Confirmar eliminación"
        message="¿Estás seguro de que deseas realizar esta acción? No se puede deshacer."
      />
    </div>
  );
};

export default Profile;
