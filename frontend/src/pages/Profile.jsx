import React, { useEffect, useState } from "react";
import { showToast } from "../components/utils/toast";
import { Link } from "react-router-dom";
import { User, Heart, CreditCard, ShoppingBag } from "lucide-react";
import { useAuthStore } from "../store/useAuthStore";
import { getUserProfile } from "../services/userService";
import WishVinylCard from "../components/common/WishVinylCard";
import {
  getWishListByUser,
  removeFromFavourite,
} from "../services/wishListService";

const Profile = () => {
  const [activeSection, setActiveSection] = useState("information");
  const [profileData, setProfileData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [wishListData, setWishListData] = useState([]);
  const [loadingWishList, setLoadingWishList] = useState(true);

  const { logout } = useAuthStore();

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
      const response = await getWishListByUser();
      setWishListData(response);
    } catch (error) {
      console.error("Error al cargar la wishlist: ", error);
      setWishListData([]);
    } finally {
      setLoadingWishList(false);
    }
  };

  const handleRemoveWishListItem = async (vinylId) => {
    if (loadingWishList) return;
    const itemToRemove = wishListData.find((item) => item.vinyl.id === vinylId);
    const albumName = itemToRemove?.vinyl?.album || "Vinilo";
    try {
      setLoadingWishList(true);
      const response = await removeFromFavourite(vinylId);
      if (response.success) {
        setWishListData((prevList) =>
          prevList.filter((item) => item.vinyl.id !== vinylId),
        );
        showToast.success(`"${albumName}" eliminado de favoritos`);
      }
    } catch (error) {
      console.error("Error al eliminar favorito:", error);
      showToast.error("No se pudo eliminar el vinilo de favoritos");
    } finally {
      setLoadingWishList(false);
    }
  };

  useEffect(() => {
    fetchUserData();
    fetchWishListData();
  }, []);

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
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                    <div className="flex flex-col gap-1">
                      <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                        Nombre
                      </label>
                      <p className="text-lg font-bold border-b border-neutral-300 pb-2">
                        {profileData.name}
                      </p>
                    </div>

                    <div className="flex flex-col gap-1">
                      <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                        Apellido
                      </label>
                      <p className="text-lg font-bold border-b border-neutral-300 pb-2">
                        {profileData.surname || "---"}
                      </p>
                    </div>

                    <div className="flex flex-col gap-1">
                      <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                        Email
                      </label>
                      <p className="text-lg font-bold border-b border-neutral-300 pb-2">
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
                    <div className="md:col-span-2 flex flex-col gap-1">
                      <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                        Calle
                      </label>
                      <p className="text-lg font-bold border-b border-neutral-300 pb-2">
                        {profileData.street || "No especificada"}
                      </p>
                    </div>
                    <div className="flex flex-col gap-1">
                      <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                        Nº / Piso
                      </label>
                      <p className="text-lg font-bold border-b border-neutral-300 pb-2">
                        {profileData.number || "---"}
                      </p>
                    </div>
                    <div className="flex flex-col gap-1">
                      <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                        Ciudad
                      </label>
                      <p className="text-lg font-bold border-b border-neutral-300 pb-2">
                        {profileData.city || "---"}
                      </p>
                    </div>
                    <div className="flex flex-col gap-1">
                      <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                        País
                      </label>
                      <p className="text-lg font-bold border-b border-neutral-300 pb-2">
                        {profileData.country || "---"}
                      </p>
                    </div>
                    <div className="flex flex-col gap-1">
                      <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                        Código Postal
                      </label>
                      <p className="text-lg font-bold border-b border-neutral-300 pb-2">
                        {profileData.postcode || "---"}
                      </p>
                    </div>
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
                            onAddToCart={(v) =>
                              console.log("Añadir al carrito:", v.album)
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
                </div>
              )}

              {activeSection === "credit-card" && (
                <div className="text-neutral-400 italic">
                  No hay tarjetas de crédito en tu lista todavía.
                </div>
              )}

              {activeSection === "orders-history" && (
                <div className="text-neutral-400 italic">
                  No hay artículos en tu historial de pedidos todavía.
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Profile;
