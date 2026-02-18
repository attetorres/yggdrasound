import React, { use, useEffect, useState } from "react";
import { showToast } from "../components/utils/toast";
import { useParams } from "react-router-dom";
import { getVinylById } from "../services/vinylService";
import {
  getComments,
  createComment,
  deleteComment,
} from "../services/commentService";
import { Heart, ShoppingCart } from "lucide-react";
import { useAuthStore } from "../store/useAuthStore";
import { useShoppingCartStore } from "../store/useShoppingCartStore";
import CommentCard from "../components/common/CommentCard";
import {
  addToWishList,
  checkVinylInWishList,
  removeFromFavourite,
} from "../services/wishListService";
import ConfirmModal from "../components/common/ConfirmModal";
import { getConcerts } from "../services/concertService";
import ConcertCard from "../components/common/ConcertCard";

const VinylDetails = () => {
  const { id } = useParams();

  const isLoggedIn = useAuthStore((state) => state.isLoggedIn);
  const user = useAuthStore((state) => state.user);
  const addItem = useShoppingCartStore((state) => state.addItem);

  const [vinyl, setVinyl] = useState(null);
  const [loading, setLoading] = useState(true);

  const [concerts, setConcerts] = useState([]);
  const [loadingConcerts, setLoadingConcerts] = useState(false);
  const [showConcerts, setShowConcerts] = useState(false);

  const [isFavorite, setIsFavorite] = useState(false);
  const [isWishLoading, setWishLoading] = useState(false);

  const [comments, setComments] = useState([]);
  const [newComment, setNewComment] = useState("");
  const [commentCurrentPage, setCommentCurrentPage] = useState(1);
  const [commentPagination, setCommentPagination] = useState({
    totalPages: 1,
    totalItems: 0,
  });

  const [isConfirmModalOpen, setIsConfirmModalOpen] = useState(false);
  const [itemToDelete, setItemToDelete] = useState(null);

  const triggerDeleteFlow = (id) => {
    setItemToDelete(id);
    setIsConfirmModalOpen(true);
  };

  const handleConfirmAction = async () => {
    if (!itemToDelete) return;

    await handleCommentRemove(itemToDelete);

    setIsConfirmModalOpen(false);
    setItemToDelete(null);
  };

  const formatDate = (dateString) => {
    if (!dateString) return "N/A";

    const parts = dateString.split("-");
    if (parts.length !== 3) return dateString;

    const [year, month, day] = parts;
    return `${day}-${month}-${year}`;
  };

  const formatDuration = (duration) => {
    if (!duration) return "--:--";

    if (typeof duration === "object") {
      const { hours, minutes, seconds } = duration;

      const hh = hours ? `${hours}:` : "";
      const mm = String(minutes || 0).padStart(2, "0");
      const ss = String(seconds || 0).padStart(2, "0");

      return `${hh}${mm}:${ss}`;
    }

    return "--:--";
  };

  const fetchDetails = async () => {
    try {
      setLoading(true);
      const res = await getVinylById(id);
      if (res.success) {
        setVinyl(res.data);
      }
    } catch (error) {
      console.error("Error al cargar el detalle:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleFetchConcerts = async () => {
    setShowConcerts(!showConcerts);

    if (concerts.length > 0 || loadingConcerts || showConcerts) return;

    if (!vinyl?.album_url) {
      showToast.error("Este vinilo no tiene una URL de Bandcamp asociada");
      return;
    }

    try {
      setLoadingConcerts(true);

      const res = await getConcerts(vinyl.album_url);
      if (res.success) {
        setConcerts(res.data);
      }
    } catch (error) {
      console.error("Error capturado en el Front:", error);
    } finally {
      setLoadingConcerts(false);
    }
  };

  const fetchCheckIsFavorite = async () => {
    try {
      setWishLoading(true);
      const res = await checkVinylInWishList(id);
      if (res.success) {
        setIsFavorite(res.in_wishlist);
      }
    } catch (error) {
      console.error("Error al cargar el estado de favorito:", error);
    } finally {
      setWishLoading(false);
    }
  };

  const handleFavouriteButton = async () => {
    if (isWishLoading) return;
    try {
      setWishLoading(true);
      if (isFavorite === false) {
        const res = await addToWishList(id);
        if (res.success) {
          setIsFavorite(true);
          showToast.success(`"${vinyl.album}" añadido a favoritos`);
        }
      } else {
        const res = await removeFromFavourite(id);
        if (res.success) {
          setIsFavorite(res.in_wishlist);
          showToast.success(`"${vinyl.album}" eliminado de favoritos`);
        }
      }
    } catch (error) {
      console.error("Error al actualizar favoritos:", error);
      showToast.error("No se pudo actualizar favoritos");
    } finally {
      setWishLoading(false);
    }
  };

  const handleAddToCart = async () => {
    try {
      await addItem(id);
      showToast.cart(vinyl.album);
    } catch (error) {
      console.error("Error al añadir el vinilo:", error);
      showToast.error("No se pudo añadir al carrito");
    }
  };

  const fetchComments = async () => {
    try {
      const res = await getComments(id, commentCurrentPage, 6);
      if (res.success) {
        setComments(res.data);
        setCommentPagination({
          totalPages: res.pagination.totalPages,
          totalItems: res.pagination.total,
        });
      }
    } catch (error) {
      console.error("Error al cargar comentarios:", error);
    }
  };

  const handlePostComment = async () => {
    try {
      const res = await createComment(id, newComment);
      if (res.success) {
        setNewComment("");
        showToast.success("Comentario publicado");

        if (commentCurrentPage !== 1) {
          setCommentCurrentPage(1);
        } else {
          fetchComments();
        }
      }
    } catch (error) {
      showToast.error("No se pudo publicar el comentario");
      console.error("Error al publicar el comentario:", error);
    }
  };

  const handleCommentRemove = async (comment_id) => {
    try {
      const res = await deleteComment(comment_id);
      if (res.success) {
        showToast.success("Comentario eliminado correctamente");
        if (commentCurrentPage > 1 && comments.length === 1) {
          setCommentCurrentPage((prev) => prev - 1);
        } else {
          fetchComments();
        }
      }
    } catch (error) {
      showToast.error("Error al borrar este comentario");
    }
  };

  useEffect(() => {
    fetchDetails();
    fetchCheckIsFavorite();
    setCommentCurrentPage(1);
  }, [id]);

  useEffect(() => {
    fetchComments();
  }, [id, commentCurrentPage]);

  if (loading)
    return (
      <div className="min-h-screen bg-neutral-950 flex items-center justify-center">
        <div className="text-white uppercase tracking-[0.5em] text-xs animate-pulse">
          Cargando Vinilo...
        </div>
      </div>
    );

  if (!vinyl)
    return (
      <div className="min-h-screen bg-neutral-950 flex items-center justify-center">
        <div className="text-red-500 uppercase tracking-widest">
          Vinilo no encontrado
        </div>
      </div>
    );

  return (
    <div className="min-h-screen flex flex-col gap-6">
      <div className="p-8 rounded-2xl border border-neutral-800 bg-neutral-950 text-white flex flex-col md:flex-row justify-between items-center gap-4">
        <div className="w-full lg:w-auto text-center lg:text-left">
          <h1 className="text-3xl font-black italic tracking-tighter uppercase leading-none">
            Detalles
          </h1>
          <p className="text-neutral-500 text-[10px] tracking-[0.3em] uppercase mt-1">
            {vinyl.artist} — {vinyl.album}
          </p>
        </div>
      </div>

      <div className="flex flex-col lg:flex-row gap-6">
        <div className="flex-2 flex flex-col gap-4">
          <div className="relative group bg-neutral-900 border border-neutral-800 p-3 rounded-[2.5rem] shadow-2xl transition-all hover:border-neutral-700">
            <img
              src={vinyl?.album_cover}
              alt={vinyl?.album}
              className="w-full aspect-square object-cover rounded-4xl grayscale-[0.2] group-hover:grayscale-0 transition-all duration-700"
            />
          </div>

          {isLoggedIn ? (
            <div className="flex justify-around items-center px-4 mt-2">
              <button
                onClick={handleFavouriteButton}
                className="flex items-center gap-3 group"
              >
                <div className="w-10 h-10 flex items-center justify-center">
                  <span className="text-lg">
                    <Heart
                      size={40}
                      strokeWidth={3}
                      className={
                        isFavorite
                          ? "text-red-500 transition-all cursor-pointer"
                          : "group-hover:text-red-500 transition-all cursor-pointer"
                      }
                    />
                  </span>
                </div>
              </button>

              <button
                onClick={handleAddToCart}
                className="flex items-center group"
              >
                <span className="font-black uppercase text-xs tracking-tight">
                  <ShoppingCart
                    size={40}
                    strokeWidth={3}
                    className="group-hover:text-primary-500 transition-all cursor-pointer"
                  />
                </span>
              </button>
            </div>
          ) : null}
        </div>

        <div className="flex-3 bg-neutral-100 rounded-[2.5rem] p-8 md:p-12 text-neutral-900 flex flex-col gap-10 shadow-inner">
          <div className="space-y-8">
            <div className="flex flex-col md:flex-row md:justify-between md:items-end gap-4">
              <div className="flex-1">
                <h2 className="text-4xl md:text-6xl font-black uppercase italic tracking-tighter leading-[0.85] text-neutral-950 wrap-break-words">
                  {vinyl?.album}
                </h2>
                <p className="text-xl md:text-2xl font-medium text-neutral-500 uppercase tracking-tight italic mt-2">
                  {vinyl?.artist}
                </p>
              </div>

              <div className="shrink-0">
                <p className="text-3xl md:text-4xl font-black text-neutral-950 leading-none">
                  {vinyl.price}€
                </p>
              </div>
            </div>

            <div className="grid grid-cols-2 md:grid-cols-4 gap-6 border-y border-neutral-200 py-6">
              <div className="flex flex-col">
                <span className="text-[10px] uppercase tracking-widest text-neutral-400 font-bold mb-1">
                  Lanzamiento
                </span>
                <span className="text-sm font-bold">
                  {formatDate(vinyl?.release_date)}
                </span>
              </div>
              <div className="flex flex-col">
                <span className="text-[10px] uppercase tracking-widest text-neutral-400 font-bold mb-1">
                  Origen del artista
                </span>
                <span className="text-sm font-bold">
                  {vinyl?.band_location || "Unknown"}
                </span>
              </div>
              <div className="flex flex-col">
                <span className="text-[10px] uppercase tracking-widest text-neutral-400 font-bold mb-1">
                  Duración
                </span>
                <span className="text-sm font-bold">
                  {formatDuration(vinyl?.duration)}
                </span>
              </div>
              <div className="flex flex-col">
                <span className="text-[10px] uppercase tracking-widest text-neutral-400 font-bold mb-1">
                  Canciones
                </span>
                <span className="text-sm font-bold">
                  {vinyl?.track_count || "0"} Canciones
                </span>
              </div>
            </div>
          </div>

          <div className="flex-1">
            <h3 className="text-[10px] font-black uppercase tracking-[0.4em] mb-6 text-neutral-400 flex items-center gap-3">
              <span className="w-12 h-0.5 bg-primary-300"></span> Lista de
              canciones
            </h3>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-x-12 gap-y-2">
              {vinyl?.track_list?.length > 0 ? (
                vinyl.track_list.map((track, index) => (
                  <div
                    key={index}
                    className="flex items-center justify-between py-2 border-b border-neutral-200/60 group transition-colors px-2 rounded-lg"
                  >
                    <div className="flex items-center gap-4">
                      <span className="text-[10px] font-black text-neutral-300">
                        {(index + 1).toString().padStart(2, "0")}
                      </span>
                      <span className="text-sm font-bold text-neutral-800 uppercase tracking-tight">
                        {track}
                      </span>
                    </div>
                  </div>
                ))
              ) : (
                <p className="text-neutral-400 text-xs italic">
                  No hay lista de canciones que mostrar
                </p>
              )}
            </div>
          </div>
        </div>

        <div className="flex-1 flex flex-col gap-4 min-w-[320px] transition-all duration-500">
          {showConcerts ? (
            <div className="flex-1 min-w-full max-w-100 self-stretch">
              <div className="bg-neutral-900 border border-neutral-800 rounded-[2.5rem] p-8 flex flex-col shadow-2xl h-full max-h-180 overflow-hidden">
                <div className="shrink-0 flex justify-between items-center mb-6">
                  <h3 className="text-white font-black uppercase italic tracking-tighter text-xl leading-none">
                    Eventos
                  </h3>
                  <button
                    onClick={() => setShowConcerts(false)}
                    className="text-neutral-500 hover:text-white uppercase text-[10px] font-black tracking-widest cursor-pointer transition-colors"
                  >
                    Cerrar ✕
                  </button>
                </div>

                <div
                  className="flex-1 overflow-y-auto pr-2 flex flex-col gap-4 min-h-0
        [&::-webkit-scrollbar]:w-1.5
        [&::-webkit-scrollbar-track]:bg-transparent
        [&::-webkit-scrollbar-thumb]:bg-neutral-700
        [&::-webkit-scrollbar-thumb]:rounded-full"
                >
                  {loadingConcerts ? (
                    <div className="h-full flex flex-col items-center justify-center gap-4 py-10">
                      <div className="w-6 h-6 border-2 border-neutral-700 border-t-white rounded-full animate-spin"></div>
                      <p className="text-[10px] text-neutral-500 uppercase tracking-[0.3em] animate-pulse">
                        Buscando...
                      </p>
                    </div>
                  ) : concerts.length > 0 ? (
                    concerts.map((c, index) => (
                      <ConcertCard key={index} concert={c} />
                    ))
                  ) : (
                    <div className="h-full flex flex-col items-center justify-center text-center p-6 border border-dashed border-neutral-800 rounded-3xl gap-4">
                      <p className="text-neutral-600 text-[10px] uppercase font-black tracking-widest leading-relaxed">
                        No hay fechas próximas
                      </p>
                    </div>
                  )}
                </div>
              </div>
            </div>
          ) : (
            <div
              onClick={handleFetchConcerts}
              className="flex-1 bg-neutral-900 border border-neutral-800 rounded-[2.5rem] flex items-center justify-center p-8 relative overflow-hidden group cursor-pointer hover:border-neutral-600 transition-all duration-300"
            >
              <button className="relative z-10 text-white group-hover:text-primary-400 font-black uppercase text-2xl lg:[writing-mode:vertical-lr] tracking-[0.4em] transition-colors duration-300 pointer-events-none">
                Conciertos
              </button>

              <div className="absolute inset-0 bg-linear-to-t from-primary-500/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
            </div>
          )}
        </div>
      </div>

      <div className="bg-neutral-950 border border-neutral-800 rounded-[2.5rem] p-10 mt-4">
        <div className="flex justify-between items-end mb-10">
          <div>
            <h3 className="text-3xl font-black uppercase italic tracking-tighter text-white">
              Comentarios
            </h3>
          </div>
        </div>
        {isLoggedIn ? (
          <div className="mb-10 flex flex-col gap-4">
            <textarea
              value={newComment}
              onChange={(e) => setNewComment(e.target.value)}
              placeholder="Escribe tu opinión sobre este vinilo..."
              className="w-full bg-neutral-900 border border-neutral-800 rounded-3xl p-6 text-white placeholder:text-neutral-600 focus:outline-none focus:border-neutral-500 transition-all resize-none min-h-30"
            />
            <div className="flex justify-end">
              <button
                onClick={handlePostComment}
                className="bg-white text-black font-black uppercase px-8 py-3 rounded-full hover:bg-primary-400 transition-colors disabled:opacity-50 disabled:cursor-not-allowed text-xs tracking-widest cursor-pointer"
              >
                Publicar Comentario
              </button>
            </div>
          </div>
        ) : (
          <div className="mb-10 p-6 border border-dashed border-neutral-800 rounded-3xl text-center">
            <p className="text-neutral-500 text-xs uppercase tracking-widest">
              Debes iniciar sesión para dejar un comentario
            </p>
          </div>
        )}

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {comments.map((comment) => {
            return (
              <CommentCard
                key={comment.id}
                comment={comment}
                currentUserId={user?.id}
                onRemove={() => triggerDeleteFlow(comment.id)}
              />
            );
          })}
        </div>
        {commentPagination.totalPages > 1 && (
          <div className="mt-10 flex gap-6 items-center justify-center border-t border-neutral-800/50 pt-8">
            <button
              onClick={() =>
                setCommentCurrentPage((prev) => Math.max(prev - 1, 1))
              }
              disabled={commentCurrentPage === 1}
              className="bg-neutral-800 hover:bg-neutral-700 text-white px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-sm font-medium"
            >
              Anterior
            </button>

            <div className="flex flex-col items-center">
              <span className="text-white font-bold text-sm">
                {commentCurrentPage}
                <span className="text-neutral-600 font-normal mx-1"> de </span>
                {commentPagination.totalPages}
              </span>
            </div>

            <button
              onClick={() => setCommentCurrentPage((prev) => prev + 1)}
              disabled={commentCurrentPage === commentPagination.totalPages}
              className="bg-neutral-800 hover:bg-neutral-700 text-white px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-sm font-medium"
            >
              Siguiente
            </button>
          </div>
        )}
      </div>
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

export default VinylDetails;
