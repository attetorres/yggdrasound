import { api } from "./api";

export const getCreditCards = async () => {
  try {
    const response = await api.get(`/credit-card/get-credit-cards-by-user`);
    return response.data;
  } catch (error) {
    console.error("Error al obtener las tarjetas:", error);
    throw error;
  }
};

export const createCreditCard = async (cardData) => {
  try {
    const response = await api.post(
      "/credit-card/create-credit-card",
      cardData,
    );
    return response.data;
  } catch (error) {
    console.error("Error en el servicio al crear la tarjeta:", error);
    throw error;
  }
};

export const setDefaultCard = async (cardId) => {
  try {
    const response = await api.put(`/credit-card/set-default-card/${cardId}`);
    return response.data;
  } catch (error) {
    console.error("Error al cambiar la tarjeta predeterminada:", error);
    throw error;
  }
};

export const deleteCreditCard = async (cardId) => {
  try {
    const response = await api.delete(
      `/credit-card/delete-credit-card/${cardId}`,
    );
    return response.data;
  } catch (error) {
    console.error("Error al eliminar la tarjeta:", error);
    throw error;
  }
};
