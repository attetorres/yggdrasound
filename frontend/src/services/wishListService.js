import { api } from "./api";

export const getWishListByUser = async (page = 1, limit = 8) => {
  try {
    const response = await api.get("wish-list/get-wishlist-by-user", {
      params: { page, limit },
    });
    return response.data;
  } catch (error) {
    console.error("Error en el servicio de obtener wishlist:", error);
    throw error;
  }
};

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
    const response = await api.get(`/wish-list/check-item/${vinyl_id}`);
    return response.data;
  } catch (error) {
    console.log(
      "Error en el servicio al checkear si el vinilo está añadido a favoritos; ",
      error,
    );
    throw error;
  }
};

export const removeFromFavourite = async (vinyl_id) => {
  try {
    const response = await api.delete(
      `/wish-list/remove-favourite-item/${vinyl_id}`,
    );
    return response.data;
  } catch (error) {
    console.log(
      "Error en el servicio al eliminar el vinilo de favoritos; ",
      error,
    );
    throw error;
  }
};
