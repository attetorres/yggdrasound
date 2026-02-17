import { api } from "./api";

export const getOrdersHistory = async () => {
  try {
    const response = await api.get("/orders-history/get-orders-by-user");
    return response.data;
  } catch (error) {
    console.error(
      "Error al cargar el historial del pedido:",
      error.response?.data || error.message,
    );
    throw error;
  }
};

export const addOrder = async (cartItems) => {
  try {
    const formattedItems = cartItems.map((item) => ({
      vinyl_id: item.vinyl?.id || item.vinyl_id,
      quantity: item.quantity,
    }));

    const response = await api.post("/orders-history/create-order", {
      items: formattedItems,
    });

    return response.data;
  } catch (error) {
    console.error(
      "Error al crear el historial del pedido:",
      error.response?.data || error.message,
    );
    throw error;
  }
};
