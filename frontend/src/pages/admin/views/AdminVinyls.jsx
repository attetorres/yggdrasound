import React, { useState, useEffect } from "react";
import {
  getVinyls,
  createVinyl,
  updateVinyl,
  deleteVinyl,
} from "../../../services/adminService";
import {
  ChevronLeft,
  ChevronRight,
  Disc,
  MoreVertical,
  X,
  Plus,
  Search,
  ImageIcon,
} from "lucide-react";
import ConfirmModal from "../../../components/common/ConfirmModal";
import { showToast } from "../../../components/utils/toast";

const AdminVinyls = () => {
  const [vinyls, setVinyls] = useState([]);
  const [pagination, setPagination] = useState({});
  const [currentPage, setCurrentPage] = useState(1);
  const [loading, setLoading] = useState(true);

  const [openMenuId, setOpenMenuId] = useState(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedVinyl, setSelectedVinyl] = useState(null);

  const [filters, setFilters] = useState({
    search: "",
    sortBy: "created_at",
    order: "DESC",
  });

  const [isUpdating, setIsUpdating] = useState(false);

  const fetchVinyls = async (page) => {
    try {
      setLoading(true);
      const { search, sortBy, order, genre } = filters;

      const response = await getVinyls(page, 10, search, sortBy, order, genre);

      if (response.success) {
        setVinyls(response.data);
        setPagination(response.pagination);
      }
    } catch (error) {
      console.error("Error cargando vinilos:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleSave = async () => {
    const {
      artist,
      album,
      price,
      release_date,
      band_location,
      duration,
      track_list,
      genres,
    } = selectedVinyl;

    if (
      !artist?.trim() ||
      !album?.trim() ||
      !price ||
      parseFloat(price) <= 0 ||
      !release_date ||
      release_date === "" ||
      !band_location?.trim() ||
      !duration ||
      (typeof duration === "string" && !duration.trim()) ||
      !track_list ||
      track_list.length === 0 ||
      track_list.some((track) => !track.trim()) ||
      !genres ||
      genres.length === 0
    ) {
      showToast.info("Por favor, completa todos los campos obligatorios.");

      return;
    }

    try {
      setIsUpdating(true);
      let response;
      let message;

      if (selectedVinyl.id) {
        response = await updateVinyl(selectedVinyl.id, selectedVinyl);
        message = "Vinilo actualizado con éxito";
      } else {
        response = await createVinyl(selectedVinyl);
        message = "Vinilo creado con éxito";
      }

      if (response.success) {
        setIsModalOpen(false);
        fetchVinyls(currentPage);
        showToast.success(message);
      }
    } catch (error) {
      console.error("Error al guardar:", error);
      alert("Error al guardar los cambios");
    } finally {
      setIsUpdating(false);
    }
  };

  const [isConfirmModalOpen, setIsConfirmModalOpen] = useState(false);
  const [itemToDelete, setItemToDelete] = useState(null);

  const triggerDeleteFlow = (id) => {
    setItemToDelete(id);
    setIsConfirmModalOpen(true);
  };

  const handleDelete = async () => {
    if (!itemToDelete) return;
    try {
      setLoading(true);
      const response = await deleteVinyl(itemToDelete);

      if (response.success) {
        if (vinyls.length === 1 && currentPage > 1) {
          setCurrentPage(currentPage - 1);
        } else {
          await fetchVinyls(currentPage);
        }
        showToast.success("Vinilo eliminado con éxito");
      }
    } catch (error) {
      console.error("Error al eliminar:", error);
      showToast.error("Error al eliminar el vinilo");
    } finally {
      setLoading(false);
      setOpenMenuId(null);
      setIsConfirmModalOpen(false);
      setItemToDelete(null);
    }
  };

  const handleGenreToggle = (genreName) => {
    const currentGenres = selectedVinyl.genres || [];
    const exists = currentGenres.find((g) => g.name === genreName);

    if (exists) {
      setSelectedVinyl({
        ...selectedVinyl,
        genres: currentGenres.filter((g) => g.name !== genreName),
      });
    } else {
      setSelectedVinyl({
        ...selectedVinyl,
        genres: [...currentGenres, { name: genreName }],
      });
    }
  };

  const handleAddTrack = () => {
    const currentTracks = selectedVinyl.track_list || [];
    setSelectedVinyl({
      ...selectedVinyl,
      track_list: [...currentTracks, ""],
    });
  };

  const handleTrackChange = (index, value) => {
    const newTracks = [...selectedVinyl.track_list];
    newTracks[index] = value;
    setSelectedVinyl({
      ...selectedVinyl,
      track_list: newTracks,
      track_count: newTracks.length,
    });
  };

  const handleRemoveTrack = (index) => {
    const newTracks = selectedVinyl.track_list.filter((_, i) => i !== index);
    setSelectedVinyl({
      ...selectedVinyl,
      track_list: newTracks,
      track_count: newTracks.length,
    });
  };

  useEffect(() => {
    const timer = setTimeout(() => {
      fetchVinyls(currentPage);
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
              Catálogo de Vinilos
            </h2>
            <span className="bg-neutral-800 px-4 py-1 rounded-full text-[10px] font-black uppercase tracking-widest">
              {pagination.total || 0} Vinilos
            </span>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-2">
          <div className="md:col-span-2 relative">
            <input
              type="text"
              placeholder="Buscar por Artista o Álbum..."
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
            value={filters.genre}
            onChange={(e) => {
              setFilters({ ...filters, genre: e.target.value });
              setCurrentPage(1);
            }}
          >
            <option value="">Todos los Géneros</option>
            <option value="rock">Rock</option>
            <option value="electronic">Electronic</option>
            <option value="metal">Metal</option>
            <option value="alternative">Alternative</option>
            <option value="hip-hop-rap">Hip Hop / Rap</option>
            <option value="experimental">Experimental</option>
            <option value="punk">Punk</option>
            <option value="pop">Pop</option>
            <option value="ambient">Ambient</option>
          </select>

          <select
            className="bg-neutral-900 border border-neutral-800 rounded-2xl py-3 px-5 text-sm focus:outline-none focus:border-primary-500 cursor-pointer text-white"
            value={filters.sortBy}
            onChange={(e) => {
              setFilters({ ...filters, sortBy: e.target.value });
              setCurrentPage(1);
            }}
          >
            <option value="created_at">Novedades</option>
            <option value="artist">Artista</option>
            <option value="album">Álbum</option>
            <option value="price">Precio</option>
            <option value="release_date">Fecha Lanzamiento</option>
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

          <button
            onClick={() => {
              setSelectedVinyl({
                artist: "",
                album: "",
                price: "",
                release_date: "",
                album_cover: "",
                band_location: "",
                duration: "",
                track_list: [],
                genres: [],
              });
              setIsModalOpen(true);
            }}
            className="bg-primary-500 hover:bg-primary-400 text-black px-6 py-3 items-center rounded-2xl text-xs font-black uppercase tracking-widest transition-all flex justify-center gap-2"
          >
            <Plus size={15} /> Nuevo Vinilo
          </button>
        </div>
      </div>

      <div className="bg-neutral-900/50 border border-neutral-800/50 rounded-3xl overflow-hidden backdrop-blur-sm mt-6">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="border-b border-neutral-800 bg-neutral-900/50 text-[10px] font-black uppercase tracking-widest text-neutral-500">
                <th className="px-6 py-5">ID</th>
                <th className="px-6 py-5">Vinilo / Artista</th>
                <th className="px-6 py-5">Géneros</th>
                <th className="px-6 py-5">Origen</th>
                <th className="px-6 py-5">Duración</th>
                <th className="px-6 py-5">Precio</th>
                <th className="px-6 py-5">Lanzamiento</th>
                <th className="px-6 py-5">Tracks</th>
                <th className="px-6 py-5">Añadido</th>
                <th className="px-6 py-5 text-right">Acciones</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-neutral-800/50 relative">
              {loading ? (
                <tr>
                  <td
                    colSpan="8"
                    className="p-20 text-center text-neutral-500 font-mono text-xs uppercase tracking-widest"
                  >
                    Cargando catálogo...
                  </td>
                </tr>
              ) : (
                vinyls.map((vinyl) => (
                  <tr
                    key={vinyl.id}
                    className="hover:bg-white/5 transition-colors group"
                  >
                    <td className="px-6 py-4 text-xs font-mono text-neutral-500">
                      #{vinyl.id}
                    </td>

                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <div className="w-12 h-12 rounded-lg bg-neutral-800 border border-neutral-700 overflow-hidden flex items-center justify-center shadow-lg shrink-0">
                          {vinyl.album_cover ? (
                            <img
                              src={vinyl.album_cover}
                              alt={vinyl.album}
                              className="w-full h-full object-cover"
                            />
                          ) : (
                            <Disc size={20} className="text-neutral-600" />
                          )}
                        </div>
                        <div className="min-w-0">
                          <p className="text-sm font-bold text-white leading-tight truncate">
                            {vinyl.album}
                          </p>
                          <p className="text-xs text-neutral-500 truncate">
                            {vinyl.artist}
                          </p>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex flex-wrap gap-1 max-w-37.5">
                        {vinyl.genres && vinyl.genres.length > 0 ? (
                          vinyl.genres.map((genre) => (
                            <span
                              key={genre.id}
                              className="px-1.5 py-0.5 rounded-md bg-white/5 border border-white/10 text-[9px] font-bold uppercase tracking-wider text-neutral-400"
                            >
                              {genre.name}
                            </span>
                          ))
                        ) : (
                          <span className="text-[10px] text-neutral-600 italic">
                            ---
                          </span>
                        )}
                      </div>
                    </td>

                    <td className="px-6 py-4">
                      <span className="text-[10px] text-neutral-400 uppercase font-bold tracking-tight truncate block max-w-25">
                        {vinyl.band_location || "N/A"}
                      </span>
                    </td>

                    <td className="px-6 py-4">
                      <span className="text-xs font-mono font-bold text-primary-500/90 bg-primary-500/5 px-2 py-1 rounded-lg border border-primary-500/10">
                        {vinyl.duration && typeof vinyl.duration === "object"
                          ? `${String(vinyl.duration.minutes || 0).padStart(2, "0")}:${String(vinyl.duration.seconds || 0).padStart(2, "0")}`
                          : vinyl.duration || "--:--"}
                      </span>
                    </td>

                    <td className="px-6 py-4">
                      <span className="text-sm font-bold text-primary-500">
                        {vinyl.price}€
                      </span>
                    </td>

                    <td className="px-6 py-4 text-xs text-neutral-400 font-mono">
                      {vinyl.release_date || "N/A"}
                    </td>

                    <td className="px-6 py-4">
                      <span className="px-2 py-1 bg-neutral-800 text-neutral-400 rounded-md text-[10px] font-bold">
                        {vinyl.track_count || 0}
                      </span>
                    </td>

                    <td className="px-6 py-4 text-xs text-neutral-500">
                      {new Date(vinyl.created_at).toLocaleDateString()}
                    </td>

                    <td className="px-6 py-4 text-right relative">
                      <button
                        onClick={() =>
                          setOpenMenuId(
                            openMenuId === vinyl.id ? null : vinyl.id,
                          )
                        }
                        className="p-2 hover:bg-white/10 rounded-xl text-neutral-400 transition-colors"
                      >
                        <MoreVertical size={18} />
                      </button>

                      {openMenuId === vinyl.id && (
                        <>
                          <div
                            className="fixed inset-0 z-10"
                            onClick={() => setOpenMenuId(null)}
                          ></div>
                          <div className="absolute right-6 mt-2 w-40 bg-neutral-900 border border-neutral-800 rounded-2xl shadow-2xl z-20 overflow-hidden py-2 animate-in fade-in slide-in-from-top-2 duration-200">
                            <button
                              onClick={() => {
                                setSelectedVinyl(vinyl);
                                setIsModalOpen(true);
                                setOpenMenuId(null);
                              }}
                              className="w-full flex items-center gap-3 px-4 py-2 text-sm text-neutral-300 hover:bg-primary-500 hover:text-black transition-colors"
                            >
                              Editar Info
                            </button>
                            <div className="h-px bg-neutral-800 my-1 mx-2"></div>
                            <button
                              onClick={() => {
                                triggerDeleteFlow(vinyl.id);
                              }}
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

      {isModalOpen && selectedVinyl && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
          <div
            className="absolute inset-0 bg-black/90 backdrop-blur-md"
            onClick={() => setIsModalOpen(false)}
          />

          <div className="relative bg-neutral-900 border border-neutral-800 w-full max-w-5xl rounded-4xl shadow-2xl overflow-hidden animate-in fade-in zoom-in duration-200">
            <div className="p-6 border-b border-neutral-800 flex justify-between items-center bg-neutral-900/50">
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 rounded-full bg-primary-500/10 border border-primary-500/20 flex items-center justify-center text-primary-500">
                  <Disc size={24} />
                </div>
                <div>
                  <h3 className="text-xl font-black uppercase tracking-tighter text-white">
                    {selectedVinyl?.id
                      ? `Editar: ${selectedVinyl.album}`
                      : "Nuevo Vinilo"}
                  </h3>
                  <p className="text-xs text-neutral-500 font-mono">
                    {selectedVinyl?.id
                      ? `ID: #${selectedVinyl.id}`
                      : "Añadiendo a catálogo"}
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
                    Información del Álbum
                  </h4>
                  <div className="space-y-4">
                    <div className="space-y-1">
                      <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                        Artista *
                      </label>
                      <input
                        type="text"
                        className={inputClass}
                        value={selectedVinyl.artist}
                        onChange={(e) =>
                          setSelectedVinyl({
                            ...selectedVinyl,
                            artist: e.target.value,
                          })
                        }
                      />
                    </div>
                    <div className="space-y-1">
                      <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                        Nombre del Álbum *
                      </label>
                      <input
                        type="text"
                        className={inputClass}
                        value={selectedVinyl.album}
                        onChange={(e) =>
                          setSelectedVinyl({
                            ...selectedVinyl,
                            album: e.target.value,
                          })
                        }
                      />
                    </div>
                    <div className="pt-6 border-t border-neutral-800/50">
                      <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1 block mb-3">
                        Géneros Musicales *
                      </label>
                      <div className="grid grid-cols-2 gap-2">
                        {[
                          "rock",
                          "electronic",
                          "metal",
                          "alternative",
                          "hip-hop-rap",
                          "experimental",
                          "punk",
                          "pop",
                          "ambient",
                        ].map((genre) => {
                          const isSelected = selectedVinyl.genres?.some(
                            (g) => g.name === genre,
                          );
                          return (
                            <button
                              key={genre}
                              type="button"
                              onClick={() => handleGenreToggle(genre)}
                              className={`px-3 py-2 rounded-xl text-[10px] font-bold uppercase tracking-wider transition-all border ${
                                isSelected
                                  ? "bg-primary-500 border-primary-500 text-black shadow-[0_0_15px_rgba(var(--primary-rgb),0.3)]"
                                  : "bg-neutral-800 border-neutral-700 text-neutral-500 hover:border-neutral-500"
                              }`}
                            >
                              {genre.replace("-", " ")}
                            </button>
                          );
                        })}
                      </div>
                    </div>
                    <div className="space-y-1">
                      <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                        Origen / Ubicación del Artista *
                      </label>
                      <div className="relative">
                        <input
                          type="text"
                          className={`${inputClass} pl-10`}
                          placeholder="Ej: Finlandia, España"
                          value={selectedVinyl.band_location || ""}
                          onChange={(e) =>
                            setSelectedVinyl({
                              ...selectedVinyl,
                              band_location: e.target.value,
                            })
                          }
                        />
                      </div>
                    </div>
                    <div className="space-y-1">
                      <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                        URL de la Portada
                      </label>
                      <div className="flex gap-4">
                        <div className="flex-1">
                          <input
                            type="text"
                            className={inputClass}
                            placeholder="https://bandcamp.com/img/..."
                            value={selectedVinyl.album_cover || ""}
                            onChange={(e) =>
                              setSelectedVinyl({
                                ...selectedVinyl,
                                album_cover: e.target.value,
                              })
                            }
                          />
                          <p className="text-[9px] text-neutral-600 mt-1 ml-1 uppercase tracking-tighter">
                            Pega el enlace directo a la imagen (.jpg, .png)
                          </p>
                        </div>
                      </div>
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                      <div className="space-y-1">
                        <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                          Precio (€) *
                        </label>
                        <input
                          type="number"
                          step="0.01"
                          className={inputClass}
                          value={selectedVinyl.price}
                          onChange={(e) =>
                            setSelectedVinyl({
                              ...selectedVinyl,
                              price: e.target.value,
                            })
                          }
                        />
                      </div>
                      <div className="space-y-1">
                        <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                          Fecha Lanzamiento *
                        </label>
                        <input
                          type="date"
                          className={inputClass}
                          value={selectedVinyl.release_date || ""}
                          onChange={(e) =>
                            setSelectedVinyl({
                              ...selectedVinyl,
                              release_date: e.target.value,
                            })
                          }
                        />
                      </div>
                    </div>
                  </div>
                </div>

                <div className="space-y-6">
                  <h4 className="text-[10px] font-black uppercase tracking-[0.2em] text-neutral-500 border-b border-neutral-800 pb-2">
                    Media y Detalles
                  </h4>
                  <div className="space-y-4">
                    <div className="space-y-1">
                      <label className="text-[10px] uppercase font-bold text-neutral-500 ml-1">
                        Duración Total *
                      </label>
                      <input
                        type="text"
                        className={inputClass}
                        value={
                          selectedVinyl.duration &&
                          typeof selectedVinyl.duration === "object"
                            ? `${String(selectedVinyl.duration.minutes || 0).padStart(2, "0")}:${String(selectedVinyl.duration.seconds || 0).padStart(2, "0")}`
                            : selectedVinyl.duration || ""
                        }
                        onChange={(e) =>
                          setSelectedVinyl({
                            ...selectedVinyl,
                            duration: e.target.value,
                          })
                        }
                        placeholder="Ej: 45:20"
                      />
                    </div>

                    <div className="pt-4 space-y-4 border-t border-neutral-800/50">
                      <div className="flex justify-between items-center">
                        <h4 className="text-[10px] font-black uppercase tracking-[0.2em] text-primary-500">
                          Lista de Temas (
                          {selectedVinyl.track_list?.length || 0}) *
                        </h4>
                        <button
                          type="button"
                          onClick={handleAddTrack}
                          className="text-[10px] font-black uppercase tracking-widest text-primary-500 hover:text-primary-400 transition-colors flex items-center gap-1"
                        >
                          <Plus size={12} /> Añadir Tema
                        </button>
                      </div>

                      <div className="space-y-2 max-h-48 overflow-y-auto pr-2 custom-scrollbar">
                        {selectedVinyl.track_list?.map((track, index) => (
                          <div key={index} className="flex gap-2">
                            <div className="flex-none flex items-center justify-center w-6 h-10 text-[10px] font-mono text-neutral-600">
                              {String(index + 1).padStart(2, "0")}
                            </div>
                            <input
                              type="text"
                              className={inputClass}
                              placeholder="Nombre del tema..."
                              value={track}
                              onChange={(e) =>
                                handleTrackChange(index, e.target.value)
                              }
                            />
                            <button
                              type="button"
                              onClick={() => handleRemoveTrack(index)}
                              className="flex-none p-2 text-neutral-600 hover:text-red-500 transition-colors"
                            >
                              <X size={16} />
                            </button>
                          </div>
                        ))}
                        {(!selectedVinyl.track_list ||
                          selectedVinyl.track_list.length === 0) && (
                          <p className="text-center py-4 text-[10px] text-neutral-600 uppercase tracking-widest italic">
                            No hay temas añadidos
                          </p>
                        )}
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
                {isUpdating ? "Guardando..." : "Guardar Vinilo"}
              </button>
            </div>
          </div>
        </div>
      )}
      <ConfirmModal
        isOpen={isConfirmModalOpen}
        onClose={() => setIsConfirmModalOpen(false)}
        onConfirm={handleDelete}
        title="Confirmar eliminación"
        message="¿Estás seguro de que deseas realizar esta acción? No se puede deshacer."
      />
    </div>
  );
};

export default AdminVinyls;
