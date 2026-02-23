import React, { useState, useEffect } from "react";
import {
  createUser,
  deleteUser,
  getUsers,
  updateUser,
} from "../../../services/adminService";
import {
  ChevronLeft,
  ChevronRight,
  User as UserIcon,
  ShieldCheck,
  MoreVertical,
  X,
  Plus,
} from "lucide-react";

const AdminUsers = () => {
  const [users, setUsers] = useState([]);
  const [pagination, setPagination] = useState({});
  const [currentPage, setCurrentPage] = useState(1);
  const [loading, setLoading] = useState(true);

  const [openMenuId, setOpenMenuId] = useState(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedUser, setSelectedUser] = useState(null);
  const [isUpdating, setIsUpdating] = useState(false);

  const [filters, setFilters] = useState({
    search: "",
    sortBy: "created_at",
    order: "DESC",
  });

  const fetchUsers = async (page) => {
    try {
      setLoading(true);
      const { search, sortBy, order } = filters;
      const response = await getUsers(page, 10, search, sortBy, order);

      if (response.success) {
        setUsers(response.data);
        setPagination(response.pagination);
      }
    } catch (error) {
      console.error("Error cargando usuarios:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleSave = async () => {
    try {
      setIsUpdating(true);
      let response;

      if (selectedUser.id) {
        response = await updateUser(selectedUser.id, selectedUser);
      } else {
        response = await createUser(selectedUser);
      }

      if (response.success) {
        setIsModalOpen(false);
        fetchUsers(currentPage);
      }
    } catch (error) {
      alert(error.response?.data?.message || "Error en la operación");
    } finally {
      setIsUpdating(false);
    }
  };

  const handleDeleteUser = async (id) => {
    if (
      window.confirm(
        "¿Estás seguro de que deseas eliminar este usuario? Esta acción no se puede deshacer.",
      )
    ) {
      try {
        const response = await deleteUser(id);
        if (response.success) {
          fetchUsers(currentPage);
        }
      } catch (error) {
        alert("Error al eliminar");
      }
    }
  };

  useEffect(() => {
    const timer = setTimeout(() => {
      fetchUsers(currentPage);
    }, 400);
    return () => clearTimeout(timer);
  }, [currentPage, filters]);

  const inputClass =
    "w-full bg-neutral-800 border border-neutral-700 rounded-xl py-2 px-4 text-sm focus:outline-none focus:border-primary-500 text-white transition-colors placeholder:text-neutral-600";

  return (
    <div className="p-6 bg-neutral-950 min-h-screen text-white rounded-3xl">
      <div className="flex flex-col gap-6">
        <div className="flex justify-between items-end">
          <div className="flex justify-between items-center mb-8 w-full">
            <h2 className="text-3xl font-black uppercase tracking-tighter text-white">
              Gestión de Usuarios
            </h2>
            <span className="bg-neutral-800 px-4 py-1 rounded-full text-[10px] font-black uppercase tracking-widest">
              {pagination.totalItems || 0} Usuarios
            </span>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-2">
          <div className="md:col-span-2 relative">
            <input
              type="text"
              placeholder="Buscar por Username, Email o Nombre..."
              className="w-full bg-neutral-900 border border-neutral-800 rounded-2xl py-3 px-5 text-sm focus:outline-none focus:border-primary-500 transition-colors"
              value={filters.search}
              onChange={(e) => {
                setFilters({ ...filters, search: e.target.value });
                setCurrentPage(1);
              }}
            />
          </div>

          <select
            className="bg-neutral-900 border border-neutral-800 rounded-2xl py-3 px-5 text-sm focus:outline-none focus:border-primary-500 cursor-pointer text-white"
            value={filters.sortBy}
            onChange={(e) => {
              setFilters({ ...filters, sortBy: e.target.value });
              setCurrentPage(1);
            }}
          >
            <option value="created_at">Fecha Registro</option>
            <option value="username">Username</option>
            <option value="is_admin">Rol (Admin)</option>
          </select>

          <select
            className="bg-neutral-900 border border-neutral-800 rounded-2xl py-3 px-5 text-sm focus:outline-none focus:border-primary-500 cursor-pointer text-white"
            value={filters.order}
            onChange={(e) => {
              setFilters({ ...filters, order: e.target.value });
              setCurrentPage(1);
            }}
          >
            <option value="DESC">Más recientes ↓</option>
            <option value="ASC">Más antiguos ↑</option>
          </select>
          <button
            onClick={() => {
              setSelectedUser({
                username: "",
                email: "",
                name: "",
                is_admin: false,
              });
              setIsModalOpen(true);
            }}
            className="bg-primary-500 hover:bg-primary-400 text-black items-center px-6 py-3 rounded-2xl text-xs font-black uppercase tracking-widest transition-all flex justify-center gap-2"
          >
            <Plus size={15} /> Nuevo Usuario
          </button>
        </div>
      </div>

      <div className="bg-neutral-900/50 border border-neutral-800/50 rounded-3xl overflow-hidden backdrop-blur-sm">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="border-b border-neutral-800 bg-neutral-900/50 text-[10px] font-black uppercase tracking-widest text-neutral-500">
                <th className="px-6 py-5">ID</th>
                <th className="px-6 py-5">Usuario</th>
                <th className="px-6 py-5">Email</th>
                <th className="px-6 py-5">Rol</th>
                <th className="px-6 py-5">Dirección Completa</th>
                <th className="px-6 py-5">Registro</th>
                <th className="px-6 py-5">Último Acceso</th>
                <th className="px-6 py-5 text-right">Acciones</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-neutral-800/50 relative">
              {loading ? (
                <tr>
                  <td colSpan="8" className="p-20 text-center text-neutral-500">
                    Cargando usuarios...
                  </td>
                </tr>
              ) : (
                users.map((user) => (
                  <tr
                    key={user.id}
                    className="hover:bg-white/5 transition-colors group"
                  >
                    <td className="px-6 py-4 text-xs font-mono text-neutral-500">
                      #{user.id}
                    </td>

                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <div className="w-10 h-10 rounded-full bg-neutral-800 border border-neutral-700 overflow-hidden flex items-center justify-center">
                          {user.avatar_img ? (
                            <img
                              src={user.avatar_img}
                              alt={user.username}
                              className="w-full h-full object-cover"
                            />
                          ) : (
                            <UserIcon size={18} className="text-neutral-600" />
                          )}
                        </div>
                        <div>
                          <p className="text-sm font-bold text-white">
                            {user.username}
                          </p>
                          <p className="text-xs text-neutral-500">
                            {user.name} {user.surname}
                          </p>
                        </div>
                      </div>
                    </td>

                    <td className="px-6 py-4 text-sm text-neutral-400">
                      {user.email}
                    </td>

                    <td className="px-6 py-4">
                      {user.is_admin ? (
                        <span className="flex items-center gap-1.5 px-3 py-1 bg-primary-500/10 text-primary-500 border border-primary-500/20 rounded-full text-[10px] font-black uppercase tracking-tight">
                          <ShieldCheck size={12} /> Admin
                        </span>
                      ) : (
                        <span className="px-3 py-1 bg-neutral-800 text-neutral-500 border border-neutral-700 rounded-full text-[10px] font-black uppercase tracking-tight">
                          Cliente
                        </span>
                      )}
                    </td>

                    <td className="px-6 py-4">
                      <div className="text-xs text-neutral-400">
                        <p className="font-medium text-neutral-300">
                          {user.street
                            ? `${user.street} ${user.number || ""}`
                            : "Sin dirección"}
                        </p>
                        <p className="text-neutral-500">
                          {user.postcode || ""} {user.city || ""}{" "}
                          {user.country ? `, ${user.country}` : ""}
                        </p>
                      </div>
                    </td>

                    <td className="px-6 py-4 text-xs text-neutral-500">
                      {new Date(user.created_at).toLocaleDateString()}
                    </td>

                    <td className="px-6 py-4 text-xs text-neutral-500">
                      {user.last_login_at
                        ? new Date(user.last_login_at).toLocaleString([], {
                            dateStyle: "short",
                            timeStyle: "short",
                          })
                        : "Nunca"}
                    </td>

                    <td className="px-6 py-4 text-right relative">
                      <button
                        onClick={() =>
                          setOpenMenuId(openMenuId === user.id ? null : user.id)
                        }
                        className="p-2 hover:bg-white/10 rounded-xl text-neutral-400 transition-colors"
                      >
                        <MoreVertical size={18} />
                      </button>

                      {openMenuId === user.id && (
                        <>
                          <div
                            className="fixed inset-0 z-10"
                            onClick={() => setOpenMenuId(null)}
                          ></div>
                          <div className="absolute right-6 mt-2 w-40 bg-neutral-900 border border-neutral-800 rounded-2xl shadow-2xl z-20 overflow-hidden py-2">
                            <button
                              onClick={() => {
                                setSelectedUser(user);
                                setIsModalOpen(true);
                                setOpenMenuId(null);
                              }}
                              className="w-full flex items-center gap-3 px-4 py-2 text-sm text-neutral-300 hover:bg-primary-500 hover:text-black transition-colors"
                            >
                              Modificar
                            </button>
                            <div className="h-px bg-neutral-800 my-1 mx-2"></div>
                            <button
                              onClick={() => handleDeleteUser(user.id)}
                              className="w-full flex items-center gap-3 px-4 py-2 text-sm text-red-500 hover:bg-red-500 hover:text-white transition-colors"
                            >
                              Eliminar
                            </button>
                          </div>
                        </>
                      )}
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>

          <div className="p-6 border-t border-neutral-800 flex justify-between items-center bg-neutral-900/80 sticky left-0 w-full">
            <p className="text-xs text-neutral-500 font-bold uppercase tracking-widest">
              Página {currentPage} de {pagination.totalPages || 1}
            </p>
            <div className="flex gap-2">
              <button
                onClick={() => setCurrentPage((p) => Math.max(p - 1, 1))}
                disabled={currentPage === 1 || loading}
                className="p-2 border border-neutral-800 rounded-xl hover:bg-neutral-800 disabled:opacity-20 cursor-pointer transition-colors text-white"
              >
                <ChevronLeft size={20} />
              </button>
              <button
                onClick={() =>
                  setCurrentPage((p) => Math.min(p + 1, pagination.totalPages))
                }
                disabled={currentPage === pagination.totalPages || loading}
                className="p-2 border border-neutral-800 rounded-xl hover:bg-neutral-800 disabled:opacity-20 cursor-pointer transition-colors text-white"
              >
                <ChevronRight size={20} />
              </button>
            </div>
          </div>
        </div>
      </div>
      {isModalOpen && selectedUser && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
          <div
            className="absolute inset-0 bg-black/90 backdrop-blur-md"
            onClick={() => setIsModalOpen(false)}
          />

          <div className="relative bg-neutral-900 border border-neutral-800 w-full max-w-4xl rounded-4xl shadow-2xl overflow-hidden animate-in fade-in zoom-in duration-200">
            <div className="p-6 border-b border-neutral-800 flex justify-between items-center bg-neutral-900/50">
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 rounded-full bg-primary-500/10 border border-primary-500/20 flex items-center justify-center text-primary-500">
                  <UserIcon size={24} />
                </div>
                <div>
                  <h3 className="text-xl font-black uppercase tracking-tighter text-white">
                    {selectedUser?.id
                      ? `Editar Usuario: ${selectedUser.username}`
                      : "Crear Nuevo Usuario"}
                  </h3>
                  <p className="text-xs text-neutral-500 font-mono">
                    ID: #{selectedUser.id}
                  </p>
                </div>
              </div>
              <button
                onClick={() => setIsModalOpen(false)}
                className="p-2 hover:bg-white/5 rounded-full text-neutral-500 hover:text-white transition-colors"
              >
                <X size={24} />
              </button>
            </div>

            <div className="p-8 max-h-[70vh] overflow-y-auto custom-scrollbar">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-10">
                <div className="space-y-6">
                  <h4 className="text-[10px] font-black uppercase tracking-[0.2em] text-primary-500 border-b border-primary-500/10 pb-2">
                    Información de Cuenta
                  </h4>

                  <div className="space-y-4">
                    <div className="grid grid-cols-2 gap-4">
                      <div className="space-y-1">
                        <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                          Username
                        </label>
                        <input
                          type="text"
                          className={inputClass}
                          value={selectedUser.username}
                          onChange={(e) =>
                            setSelectedUser({
                              ...selectedUser,
                              username: e.target.value,
                            })
                          }
                        />
                      </div>
                      <div className="space-y-1">
                        <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                          Email
                        </label>
                        <input
                          type="email"
                          className={inputClass}
                          value={selectedUser.email}
                          onChange={(e) =>
                            setSelectedUser({
                              ...selectedUser,
                              email: e.target.value,
                            })
                          }
                        />
                      </div>
                      <div className="space-y-1">
                        <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                          {selectedUser?.id
                            ? "Nueva Contraseña (dejar en blanco para no cambiar)"
                            : "Contraseña"}
                        </label>
                        <input
                          type="password"
                          className={inputClass}
                          value={selectedUser.password || ""}
                          placeholder={
                            selectedUser?.id
                              ? "••••••••"
                              : "Escribe una contraseña segura"
                          }
                          onChange={(e) =>
                            setSelectedUser({
                              ...selectedUser,
                              password: e.target.value,
                            })
                          }
                        />
                      </div>
                    </div>

                    <div className="grid grid-cols-2 gap-4">
                      <div className="space-y-1">
                        <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                          Nombre
                        </label>
                        <input
                          type="text"
                          className={inputClass}
                          value={selectedUser.name || ""}
                          onChange={(e) =>
                            setSelectedUser({
                              ...selectedUser,
                              name: e.target.value,
                            })
                          }
                        />
                      </div>
                      <div className="space-y-1">
                        <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                          Apellido
                        </label>
                        <input
                          type="text"
                          className={inputClass}
                          value={selectedUser.surname || ""}
                          onChange={(e) =>
                            setSelectedUser({
                              ...selectedUser,
                              surname: e.target.value,
                            })
                          }
                        />
                      </div>
                    </div>

                    <div className="space-y-1">
                      <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                        URL Avatar (Imagen)
                      </label>
                      <input
                        type="text"
                        className={inputClass}
                        value={selectedUser.avatar_img || ""}
                        onChange={(e) =>
                          setSelectedUser({
                            ...selectedUser,
                            avatar_img: e.target.value,
                          })
                        }
                        placeholder="https://..."
                      />
                    </div>

                    <div className="pt-4">
                      <label className="relative flex items-center gap-3 p-4 bg-neutral-800/30 border border-neutral-800 rounded-2xl cursor-pointer hover:bg-neutral-800/50 transition-colors">
                        <input
                          type="checkbox"
                          className="w-5 h-5 accent-primary-500 rounded-lg"
                          checked={selectedUser.is_admin}
                          onChange={(e) =>
                            setSelectedUser({
                              ...selectedUser,
                              is_admin: e.target.checked,
                            })
                          }
                        />
                        <div className="flex flex-col">
                          <span className="text-sm font-bold text-white">
                            Privilegios de Administrador
                          </span>
                          <span className="text-[10px] text-neutral-500 uppercase tracking-wider">
                            Permite acceso al panel de control
                          </span>
                        </div>
                      </label>
                    </div>
                  </div>
                </div>

                <div className="space-y-6">
                  <h4 className="text-[10px] font-black uppercase tracking-[0.2em] text-neutral-500 border-b border-neutral-800 pb-2">
                    Dirección y Envío
                  </h4>

                  <div className="space-y-4">
                    <div className="space-y-1">
                      <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                        Calle / Avenida
                      </label>
                      <input
                        type="text"
                        className={inputClass}
                        value={selectedUser.street || ""}
                        onChange={(e) =>
                          setSelectedUser({
                            ...selectedUser,
                            street: e.target.value,
                          })
                        }
                      />
                    </div>

                    <div className="grid grid-cols-3 gap-4">
                      <div className="col-span-2 space-y-1">
                        <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                          Número / Portal / Piso
                        </label>
                        <input
                          type="text"
                          className={inputClass}
                          value={selectedUser.number || ""}
                          onChange={(e) =>
                            setSelectedUser({
                              ...selectedUser,
                              number: e.target.value,
                            })
                          }
                        />
                      </div>
                      <div className="space-y-1">
                        <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                          C. Postal
                        </label>
                        <input
                          type="text"
                          className={inputClass}
                          value={selectedUser.postcode || ""}
                          onChange={(e) =>
                            setSelectedUser({
                              ...selectedUser,
                              postcode: e.target.value,
                            })
                          }
                        />
                      </div>
                    </div>

                    <div className="grid grid-cols-2 gap-4">
                      <div className="space-y-1">
                        <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                          Ciudad
                        </label>
                        <input
                          type="text"
                          className={inputClass}
                          value={selectedUser.city || ""}
                          onChange={(e) =>
                            setSelectedUser({
                              ...selectedUser,
                              city: e.target.value,
                            })
                          }
                        />
                      </div>
                      <div className="space-y-1">
                        <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                          País
                        </label>
                        <input
                          type="text"
                          className={inputClass}
                          value={selectedUser.country || ""}
                          onChange={(e) =>
                            setSelectedUser({
                              ...selectedUser,
                              country: e.target.value,
                            })
                          }
                        />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div className="p-6 border-t border-neutral-800 bg-neutral-900/50 flex justify-end gap-3">
              <button
                onClick={() => setIsModalOpen(false)}
                className="px-6 py-3 rounded-2xl text-xs font-black uppercase tracking-widest text-neutral-500 hover:text-white transition-colors"
              >
                Cancelar
              </button>
              <button
                onClick={handleSave}
                disabled={isUpdating}
                className="px-8 py-3 bg-primary-500 hover:bg-primary-400 text-black rounded-2xl text-xs font-black uppercase tracking-widest transition-all disabled:opacity-50"
              >
                {isUpdating ? "Guardando..." : "Guardar Cambios"}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default AdminUsers;
