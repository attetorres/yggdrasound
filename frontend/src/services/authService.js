import axios from "axios";

const API_URL = "http://localhost:3000/api/user";

export const loginUser = async (formData) => {
  try {
    const response = await axios.post(`${API_URL}/login`, formData);
    return response.data; 

  } catch (error) {
    console.error("Error en authService:", error);
    return error.response?.data || { success: false, message: "Error de conexión" };
  }
};

export const registerUser = async (formData) => {
  try {
    const response = await axios.post(`${API_URL}/create-user`,formData)
    return response.data

  } catch (error) {
    console.error("Error en el registerUser:", error);
    return error.response?.data || { success: false, message: "Error al crear cuenta" };
  }
}