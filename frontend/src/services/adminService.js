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


export const getUsers = async (page = 1, limit = 10, search = "", sortBy = "created_at", order = "DESC") => {
  try {
    const response = await api.get("/admin/users", {
      params: { page, limit, search, sortBy, order },
    });
    return response.data;
  } catch (error) {
    console.error("Error al obtener usuarios:", error);
    throw error;
  }
};

export const createUser = async (userData) => {
  try {
    const response = await api.post("/admin/create-user", userData);
    return response.data;
  } catch (error) {
    console.error("Error en servicio createUser:", error);
    throw error;
  }
};

export const updateUser = async (id, userData) => {
  try {
    const response = await api.put(`/admin/update-user/${id}`, userData);
    return response.data;
  } catch (error) {
    console.error("Error en servicio updateUser:", error);
    throw error;
  }
};

export const deleteUser = async (id) => {
  try {
    const response = await api.delete(`/admin/delete-user/${id}`);
    return response.data;
  } catch (error) {
    console.error("Error en servicio deleteUser:", error);
    throw error;
  }
};