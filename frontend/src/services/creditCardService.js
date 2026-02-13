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
