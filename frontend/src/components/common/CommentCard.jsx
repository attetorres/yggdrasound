import React from "react";
import { User, MessageSquare } from "lucide-react";

const CommentCard = ({ comment }) => {
  // 1. Destructuring limpio
  const {
    comment_text = "Sin contenido",
    created_at,
    User: userData = {},
  } = comment || {};

  const { name = "Usuario Anónimo", avatar_img = null } = userData;

  // 2. Formateador de fecha simplificado
  const formatDate = (dateString) => {
    if (!dateString) return "Fecha desconocida";
    return new Date(dateString).toLocaleDateString("es-ES", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
    });
  };

  // 3. Construimos la URL del avatar una sola vez
  const avatarSource = avatar_img
    ? avatar_img
    : `https://api.dicebear.com/9.x/initials/svg?seed=${name}&backgroundColor=9a7b84,7d4c5a,583742`;

  return (
    <div className="border border-neutral-800 bg-neutral-900/50 rounded-4xl p-6 flex flex-col gap-4 transition-all hover:border-neutral-700 group">
      <div className="flex justify-between items-start">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-neutral-800 border border-neutral-700 overflow-hidden flex items-center justify-center">
            <img
              src={avatarSource}
              alt={name}
              className="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500"
              onError={(e) => {
                e.target.src = `https://api.dicebear.com/9.x/initials/svg?seed=${name}`;
              }}
            />
          </div>
          <div>
            <h4 className="text-xs font-black uppercase tracking-widest text-primary-400">
              {name}
            </h4>
            <p className="text-[9px] uppercase tracking-[0.2em] text-neutral-500">
              Publicado el {formatDate(created_at)}
            </p>
          </div>
        </div>

        <MessageSquare
          size={20}
          className="text-neutral-700 group-hover:text-primary-400 transition-colors"
        />
      </div>

      <div className="relative pl-4 border-l-2 border-neutral-800 group-hover:border-primary-400 transition-colors">
        <p className="text-sm text-neutral-300 leading-relaxed font-medium italic">
          "{comment_text}"
        </p>
      </div>

      <div className="flex justify-end pt-2">
        <div className="h-px w-12 bg-neutral-800 group-hover:w-full transition-all duration-500"></div>
      </div>
    </div>
  );
};

export default CommentCard;
