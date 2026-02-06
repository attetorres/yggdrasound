import { api } from "./api";

export const getUserProfile = async () => {
  try {
    const response = await api.get("/user/profile");
    return response.data;
  } catch (error) {
    console.error("Error en el servicio de obtener perfil:", error);
    throw error;
  }
};
