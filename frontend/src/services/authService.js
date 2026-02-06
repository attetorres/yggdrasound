import axios from "axios";
import { api } from "./api";

export const loginUser = async (formData) => {
  try {
    const response = await api.post("/user/login", formData);
    return response.data;
  } catch (error) {
    console.error("Error en authService:", error);
    return (
      error.response?.data || { success: false, message: "Error de conexión" }
    );
  }
};

export const registerUser = async (formData) => {
  try {
    const response = await api.post("/user/create-user", formData);
    return response.data;
  } catch (error) {
    console.error("Error en el registerUser:", error);
    return (
      error.response?.data || {
        success: false,
        message: "Error al crear cuenta",
      }
    );
  }
};
