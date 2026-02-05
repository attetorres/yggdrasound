import axios from "axios";

const API_URL = "http://localhost:3000/api/vinyl";

export const getAllVinyls = async (page, limit, search, genre, sort) => {
  try {
    const response = await axios.get(`${API_URL}/`, {
      params: {
        page: page,
        limit: limit,
        search: search,
        genre: genre,
        sort: sort,
      },
    });
    return response.data;
  } catch (error) {
    console.error("Error en el servicio de vinilos:", error);
    throw error;
  }
};

export const getVinylById = async (id) => {
  try {
    const response = await axios.get(`${API_URL}/get-vinyl-by-id/${id}`);
    return response.data;
  } catch (error) {
    console.error(
      "Error en el servicio de vinilos al traer vinilo por ID:",
      error,
    );
    throw error;
  }
};
