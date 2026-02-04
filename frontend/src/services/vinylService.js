import axios from "axios";

const API_URL = "http://localhost:3000/api/vinyl";

export const getAllVinyls = async (page, limit) => {
    try {
        const response = await axios.get(`${API_URL}/`, {
            params: { 
                page: page, 
                limit: limit 
            }
        });
        return response.data;
    } catch (error) {
        console.error("Error en el servicio de vinilos:", error);
        throw error;
    }
}