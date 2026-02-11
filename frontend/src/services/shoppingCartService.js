import { api } from "./api";

export const getCart = async () => {
  try {
    const response = await api.get("/shopping-cart/get-cart-by-user");
    return response.data;
  } catch (error) {
    console.error("Error al obtener el carrito:", error);
    throw error;
  }
};

export const addItemToCart = async (vinyl_id) => {
  try {
    const response = await api.post("/shopping-cart/add-item", {
      vinyl_id: vinyl_id,
    });
    return response.data;
  } catch (error) {
    console.error(
      "Error en el servicio al añadir un vinilo al carrito:",
      error,
    );
    throw error;
  }
};
