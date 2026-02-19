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

export const getOrders = async (
  page = 1,
  limit = 25,
  search = "",
  sortBy = "order_date",
  order = "DESC",
) => {
  try {
    const response = await api.get("/admin/orders", {
      params: { page, limit, search, sortBy, order },
    });
    return response.data;
  } catch (error) {
    console.error("Error al obtener ventas:", error);
    throw error;
  }
};

export const getOrderDetailAdmin = async (orderId) => {
  const response = await api.get(`/admin/order-detail/${orderId}`);
  return response.data;
};
