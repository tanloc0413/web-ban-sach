import axios from 'axios';

const API_URL = 'http://localhost:8080/api/products';

export const productService = {
  getAllProducts: async (params) => {
    const response = await axios.get(API_URL, { params });
    return response.data;
  },

  getProductById: async (id) => {
    const response = await axios.get(`${API_URL}/${id}`);
    return response.data;
  },

  createProduct: async (product) => {
    const response = await axios.post(API_URL, product);
    return response.data;
  },

  updateProduct: async (id, product) => {
    const response = await axios.put(`${API_URL}/${id}`, product);
    return response.data;
  },

  deleteProduct: async (id) => {
    const response = await axios.delete(`${API_URL}/${id}`);
    return response.data;
  },

  convertImageToBase64: (file) => {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => resolve(reader.result);
      reader.onerror = error => reject(error);
    });
  }
};