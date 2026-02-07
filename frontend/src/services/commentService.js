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
