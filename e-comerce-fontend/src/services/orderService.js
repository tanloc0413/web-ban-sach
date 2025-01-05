import axios from 'axios';

const API_URL = 'http://localhost:8080/api/orders';

export const orderService = {
  getAllOrders: async () => {
    const response = await axios.get(`${API_URL}/all`);
    return response.data;
  },

  getOrdersByUser: async (userId) => {
    const response = await axios.get(`${API_URL}/${userId}`);
    return response.data;
  },

  updateOrderStatus: async (orderId, status) => {
    const response = await axios.put(`${API_URL}/${orderId}/status/${status}`);
    return response.data;
  },

  deleteOrder: async (orderId) => {
    const response = await axios.delete(`${API_URL}/${orderId}`);
    return response.data;
  }
};