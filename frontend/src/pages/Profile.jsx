import React, { useEffect, useState } from "react";
import { User, Heart, CreditCard, ShoppingBag } from "lucide-react";
import { useAuthStore } from "../store/useAuthStore";
import { getUserProfile } from "../services/userService";

const Profile = () => {
  const [activeSection, setActiveSection] = useState("information");
  const [profileData, setProfileData] = useState(null);
  const [loading, setLoading] = useState(true);

  const { logout } = useAuthStore();

  const fetchUserData = async () => {
    try {
      setLoading(true);
      const response = await getUserProfile();
      setProfileData(response.user);
    } catch (error) {
      console.error("Error a cargar el perfil.", error);
      if (error.response?.status === 401) {
        logout();
      }
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUserData();
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
        {/* COLUMNA IZQUIERDA: PERFIL Y MENÚ */}
        <div className="flex-1 flex flex-col gap-6">
          {/* FOTO Y NOMBRE */}
          <div className="bg-neutral-900 border border-neutral-800 p-8 rounded-[2.5rem] flex flex-col items-center gap-4">
            <div className="relative group">
              <div className="w-32 h-32 md:w-40 md:h-40 rounded-full overflow-hidden border-4 border-neutral-800 group-hover:border-neutral-700 transition-all duration-500">
                <img
                  src={`https://api.dicebear.com/9.x/initials/svg?seed=Atteneri&backgroundColor=9a7b84,7d4c5a,583742`}
                  alt="User Avatar"
                  className="w-full h-full object-cover grayscale hover:grayscale-0 transition-all"
                />
              </div>
            </div>
            <div className="text-center">
              <h2 className="text-xl font-black text-primary-400 uppercase tracking-tight">
                {profileData.name}
              </h2>
              <p className="text-[10px] tracking-widest uppercase text-primary-300">
                Miembro desde{" "}
                {profileData?.created_at
                  ? profileData.created_at.split("-")[0]
                  : "..."}
              </p>
            </div>
          </div>

          {/* MENÚ DE NAVEGACIÓN */}
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

        {/* COLUMNA DERECHA: CONTENIDO DINÁMICO */}
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
                <div className="grid grid-cols-1 md:grid-cols-2 gap-8 animate-in fade-in duration-500">
                  <div className="flex flex-col gap-1">
                    <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                      Nombre Completo
                    </label>
                    <p className="text-lg font-bold border-b border-neutral-300 pb-2">
                      {profileData.name}
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
                  <div className="flex flex-col gap-1">
                    <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                      Apellido
                    </label>
                    <p className="text-lg font-bold border-b border-neutral-300 pb-2">
                      {profileData.surname}
                    </p>
                  </div>
                </div>
              )}

              {activeSection === "wish" && (
                <div className="text-neutral-400 italic">
                  No hay artículos en tu lista de deseos todavía.
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
