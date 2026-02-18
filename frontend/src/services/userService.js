import { api } from "./api";

/* export const getAllUsers = async (page = 1, limit = 50) => {
  try {
    const response = await api.get(`/user/`, {
      params: { page, limit },
    });

    return response.data;
  } catch (error) {
    console.error("Error en getAllUsers service:", error);
    throw error;
  }
}; */

export const getUserProfile = async () => {
  try {
    const response = await api.get("/user/profile");
    return response.data;
  } catch (error) {
    console.error("Error en el servicio de obtener perfil:", error);
    throw error;
  }
};

export const updateUser = async (userData) => {
  try {
    const response = await api.put("/user/update-user/", userData);
    return response.data;
  } catch (error) {
    console.error("Error al actualizar usuario:", error);
    throw error;
  }
};
