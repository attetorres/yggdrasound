import { api } from "./api";

export const getAdminDashboardStats = async () => {
  try {
    const response = await api.get("/admin/stats");
    return response.data;
  } catch (error) {
    console.error("Error en el servicio de stats:", error);
    throw error;
  }
};

export const getRecentOrders = async (limit = 5) => {
  try {
    const response = await api.get("/admin/recent-orders", {
      params: {
        page: 1,
        limit: limit,
      },
    });
    return response.data;
  } catch (error) {
    console.error("Error al obtener ventas recientes:", error);
    throw error;
  }
};
