import { api } from "./api";

export const addToWishList = async (vinyl_id) => {
  try {
    const response = await api.post("/wish-list/add-item", {
      vinyl_id: vinyl_id,
    });
    return response.data;
  } catch (error) {
    console.log("Error en el servicio al añadir a favoritos; ", error);
    throw error;
  }
};
