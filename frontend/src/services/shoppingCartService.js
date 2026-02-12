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

export const updateItemCart = async (item_id, quantity) => {
  try {
    const response = await api.put(`/shopping-cart/update-item/${item_id}`, {
      quantity: quantity,
    });
    return response.data;
  } catch (error) {
    console.error("Error en el servicio al actualizar el item:", error);
    throw error;
  }
};

export const deleteItemCart = async (item_id) => {
  try {
    const response = await api.delete(`/shopping-cart/delete-item/${item_id}`);
    return response.data;
  } catch (error) {
    console.error("Error en el servicio al borrar el item: ", error);
    throw error;
  }
};
