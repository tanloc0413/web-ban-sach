import axios from 'axios';

const API_URL = 'http://localhost:8080/api/users';

export const userService = {
  getAllUsers: async () => {
    const response = await axios.get(API_URL);
    return response.data;
  },
  getUserById: async (id) => {
    const response = await axios.get(`${API_URL}/${id}`);
    return response.data;
  },

  updateUser: async (id, userData) => {
    const response = await axios.put(`${API_URL}/${id}`, userData);
    return response.data;
  },

  deleteUser: async (id) => {
    const response = await axios.delete(`${API_URL}/${id}`);
    return response.data;
  }
};