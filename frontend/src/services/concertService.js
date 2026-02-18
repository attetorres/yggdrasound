import { api } from "./api";

export const getConcerts = async (album_url) => {
  try {
    const response = await api.post(`/concert/`, {
      album_url: album_url,
    });
    return response.data;
  } catch (error) {
    console.log("Error en el servicio de obtención de conciertos; ", error);
    throw error;
  }
};
