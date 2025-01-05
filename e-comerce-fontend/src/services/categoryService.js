import axios from 'axios';

const API_URL = 'http://localhost:8080/api/categories';

export const categoryService = {
  getAllCategories: async () => {
    const response = await axios.get(API_URL);
    return response.data;
  },

  getCategoryById: async (id) => {
    const response = await axios.get(`${API_URL}/${id}`);
    return response.data;
  },

  createCategory: async (category) => {
    const response = await axios.post(API_URL, category);
    return response.data;
  },

  updateCategory: async (id, category) => {
    const response = await axios.put(`${API_URL}/${id}`, category);
    return response.data;
  },

  deleteCategory: async (id) => {
    const response = await axios.delete(`${API_URL}/${id}`);
    return response.data;
  }
};