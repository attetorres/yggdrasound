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

export const checkVinylInWishList = async (vinyl_id) => {
  try {
    const response = await api.get(`/wish-list/check-item/${vinyl_id}`, {
      vinyl_id: vinyl_id,
    });
    return response.data;
  } catch (error) {
    console.log(
      "Error en el servicio al checkear si el vinilo está añadido a favoritos; ",
      error,
    );
    throw error;
  }
};
