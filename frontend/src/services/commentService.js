import { api } from "./api";

export const getComments = async (id) => {
  try {
    const response = await api.get(`/comment/get-comment-by-vinyl-id/${id}`);
    return response.data;
  } catch (error) {
    console.log("Error en el servicio de obtención de comentarios; ", error);
    throw error;
  }
};

export const createComment = async (vinyl_id, comment_text) => {
  try {
    const response = await api.post("/comment/create-comment", {
      vinyl_id: vinyl_id,
      comment_text: comment_text,
    });
    return response.data;
  } catch (error) {
    console.log("Error en el servicio al crear el comentario; ", error);
    throw error;
  }
};

export const deleteComment = async (id) => {
  try {
    const response = await api.delete(`/comment/delete-comment/${id}`);
    return response.data;
  } catch (error) {
    console.error("Error al eliminar comentario:", error);
    throw error;
  }
};
