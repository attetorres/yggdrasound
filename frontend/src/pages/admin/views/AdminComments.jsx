import React, { useState, useEffect } from "react";
import { getComments, deleteComment } from "../../../services/adminService";
import {
  ChevronLeft,
  ChevronRight,
  MoreVertical,
  Search,
  Trash2,
  User,
  Disc
} from "lucide-react";

const AdminComments = () => {
  const [comments, setComments] = useState([]);
  const [pagination, setPagination] = useState({});
  const [currentPage, setCurrentPage] = useState(1);
  const [loading, setLoading] = useState(true);

  const [openMenuId, setOpenMenuId] = useState(null);
  const [filters, setFilters] = useState({
    search: "",
    sortBy: "created_at",
    order: "DESC",
  });

  const fetchComments = async (page) => {
    try {
      setLoading(true);
      const { search, sortBy, order } = filters;
      const response = await getComments(page, 10, search, sortBy, order);

      if (response.success) {
        setComments(response.data);
        setPagination(response.pagination);
      }
    } catch (error) {
      console.error("Error cargando comentarios:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    const confirmed = window.confirm(
      "¿Eliminar este comentario? Esta acción no se puede deshacer y el usuario no será notificado."
    );

    if (confirmed) {
      try {
        setLoading(true);
        const response = await deleteComment(id);

        if (response.success) {
          if (comments.length === 1 && currentPage > 1) {
            setCurrentPage(currentPage - 1);
          } else {
            await fetchComments(currentPage);
          }
        }
      } catch (error) {
        console.error("Error al eliminar:", error);
        alert("No se pudo eliminar el comentario.");
      } finally {
        setLoading(false);
        setOpenMenuId(null);
      }
    }
  };

  useEffect(() => {
    const timer = setTimeout(() => {
      fetchComments(currentPage);
    }, 400);
    return () => clearTimeout(timer);
  }, [currentPage, filters]);

  return (
    <div className="p-6 bg-neutral-950 min-h-screen text-white rounded-3xl">
      <div className="flex flex-col gap-6">
        <div className="flex justify-between items-center mb-2 w-full">
          <h2 className="text-3xl font-black uppercase tracking-tighter text-white">
            Moderación de Comentarios
          </h2>
          <span className="bg-neutral-800 px-4 py-1 rounded-full text-[10px] font-black uppercase tracking-widest text-neutral-400">
            {pagination.totalItems || 0} Mensajes
          </span>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-2">
          <div className="md:col-span-2 relative">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-neutral-600" size={16} />
            <input
              type="text"
              placeholder="Buscar por contenido, usuario o álbum..."
              className="w-full bg-neutral-900 border border-neutral-800 rounded-2xl py-3 pl-12 pr-5 text-sm focus:outline-none focus:border-primary-500 transition-colors"
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
            <option value="created_at">Más recientes</option>
            <option value="id">ID Mensaje</option>
            <option value="user_id">Por Usuario</option>
          </select>

          <select
            className="bg-neutral-900 border border-neutral-800 rounded-2xl py-3 px-5 text-sm focus:outline-none focus:border-primary-500 cursor-pointer text-white"
            value={filters.order}
            onChange={(e) => {
              setFilters({ ...filters, order: e.target.value });
              setCurrentPage(1);
            }}
          >
            <option value="DESC">Descendente ↓</option>
            <option value="ASC">Ascendente ↑</option>
          </select>
        </div>
      </div>

      <div className="bg-neutral-900/50 border border-neutral-800/50 rounded-3xl overflow-hidden backdrop-blur-sm mt-6">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="border-b border-neutral-800 bg-neutral-900/50 text-[10px] font-black uppercase tracking-widest text-neutral-500">
                <th className="px-6 py-5">ID</th>
                <th className="px-6 py-5">Usuario</th>
                <th className="px-6 py-5">Vinilo Relacionado</th>
                <th className="px-6 py-5 w-1/3">Comentario</th>
                <th className="px-6 py-5">Fecha</th>
                <th className="px-6 py-5 text-right">Acciones</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-neutral-800/50">
              {loading ? (
                <tr>
                  <td colSpan="6" className="p-20 text-center text-neutral-500 font-mono text-xs uppercase tracking-widest">
                    Cargando comentarios...
                  </td>
                </tr>
              ) : (
                comments.map((comment) => (
                  <tr key={comment.id} className="hover:bg-white/5 transition-colors group">
                    <td className="px-6 py-4 text-xs font-mono text-neutral-500">
                      #{comment.id}
                    </td>

                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <div className="w-7 h-7 rounded-full bg-neutral-800 flex items-center justify-center text-neutral-500">
                          {comment.User?.avatar_img ? (
                            <img src={comment.User.avatar_img} alt="" className="w-full h-full rounded-2xl object-cover" />
                          ) : (
                            <User size={14} className="text-neutral-600" />
                          )}
                        </div>
                        <span className="text-sm font-bold text-white italic">
                          @{comment.User?.username || "usuario_borrado"}
                        </span>
                      </div>
                    </td>

                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <div className="w-8 h-8 rounded bg-neutral-800 border border-neutral-700 overflow-hidden flex items-center justify-center">
                          {comment.Vinyl?.album_cover ? (
                            <img src={comment.Vinyl.album_cover} alt="" className="w-full h-full object-cover" />
                          ) : (
                            <Disc size={14} className="text-neutral-600" />
                          )}
                        </div>
                        <p className="text-xs font-bold text-neutral-300 truncate max-w-37.5">
                          {comment.Vinyl?.album || "Desconocido"}
                        </p>
                      </div>
                    </td>

                    <td className="px-6 py-4">
                      <p className="text-sm text-neutral-400 leading-relaxed line-clamp-2">
                        "{comment.comment_text}"
                      </p>
                    </td>

                    <td className="px-6 py-4">
                      <div className="flex flex-col">
                        <span className="text-xs text-neutral-400 font-mono">
                          {new Date(comment.created_at).toLocaleDateString()}
                        </span>
                        <span className="text-[9px] text-neutral-600 font-mono">
                          {new Date(comment.created_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                        </span>
                      </div>
                    </td>

                    <td className="px-6 py-4 text-right relative">
                      <button
                        onClick={() => setOpenMenuId(openMenuId === comment.id ? null : comment.id)}
                        className="p-2 hover:bg-white/10 rounded-xl text-neutral-400 transition-colors"
                      >
                        <MoreVertical size={18} />
                      </button>

                      {openMenuId === comment.id && (
                        <>
                          <div className="fixed inset-0 z-10" onClick={() => setOpenMenuId(null)}></div>
                          <div className="absolute right-6 mt-2 w-48 bg-neutral-900 border border-neutral-800 rounded-2xl shadow-2xl z-20 overflow-hidden py-2 animate-in fade-in slide-in-from-top-2">
                            <button
                              onClick={() => {
                                handleDelete(comment.id);
                              }}
                              className="w-full flex items-center gap-3 px-4 py-2 text-sm text-red-500 hover:bg-red-500 hover:text-white transition-colors"
                            >
                              <Trash2 size={14} />
                              Eliminar Mensaje
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

          <div className="p-6 border-t border-neutral-800 flex justify-between items-center bg-neutral-900/80">
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
                onClick={() => setCurrentPage((p) => Math.min(p + 1, pagination.totalPages))}
                disabled={currentPage === pagination.totalPages || loading}
                className="p-2 border border-neutral-800 rounded-xl hover:bg-neutral-800 disabled:opacity-20 cursor-pointer transition-colors text-white"
              >
                <ChevronRight size={20} />
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AdminComments;