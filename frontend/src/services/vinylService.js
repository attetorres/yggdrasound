import axios from "axios";
import { api } from "./api";

export const getAllVinyls = async (page, limit, search, genre, sort) => {
  try {
    const response = await api.get("/vinyl/", {
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
    const response = await api.get(`vinyl/get-vinyl-by-id/${id}`);
    return response.data;
  } catch (error) {
    console.error(
      "Error en el servicio de vinilos al traer vinilo por ID:",
      error,
    );
    throw error;
  }
};
