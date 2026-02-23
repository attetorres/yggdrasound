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

export const getUsers = async (
  page = 1,
  limit = 10,
  search = "",
  sortBy = "created_at",
  order = "DESC",
) => {
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

export const getVinyls = async (
  page = 1,
  limit = 10,
  search = "",
  sortBy = "created_at",
  order = "DESC",
  genre = "",
) => {
  try {
    const response = await api.get("/admin/vinyls", {
      params: { page, limit, search, sortBy, order, genre },
    });
    return response.data;
  } catch (error) {
    console.error("Error al obtener vinilos:", error);
    throw error;
  }
};

export const createVinyl = async (vinylData) => {
  try {
    const response = await api.post("/admin/create-vinyl", vinylData);
    return response.data;
  } catch (error) {
    console.error("Error en servicio createVinyl:", error);
    throw error;
  }
};

export const updateVinyl = async (id, vinylData) => {
  try {
    const response = await api.put(`/admin/update-vinyl/${id}`, vinylData);
    return response.data;
  } catch (error) {
    console.error("Error en servicio updateVinyl:", error);
    throw error;
  }
};

export const deleteVinyl = async (id) => {
  try {
    const response = await api.delete(`/admin/delete-vinyl/${id}`);
    return response.data;
  } catch (error) {
    console.error("Error en deleteVinyl service:", error);
    throw error.response?.data || error.message;
  }
};

export const getComments = async (
  page = 1,
  limit = 10,
  search = "",
  sortBy = "created_at",
  order = "DESC",
) => {
  try {
    const response = await api.get("/admin/comments", {
      params: { page, limit, search, sortBy, order },
    });
    return response.data;
  } catch (error) {
    console.error("Error al obtener comentarios:", error);
    throw error;
  }
};

export const deleteComment = async (id) => {
  try {
    const response = await api.delete(`/admin/delete-comment/${id}`);
    return response.data;
  } catch (error) {
    console.error("Error en servicio deleteComment:", error);
    throw error.response?.data || error.message;
  }
};
