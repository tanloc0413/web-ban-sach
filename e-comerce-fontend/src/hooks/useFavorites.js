import { useState, useEffect } from 'react';
import { storageKeys, getStorageItem, setStorageItem } from '../utils/storage';

const useFavorites = () => {
  const [favorites, setFavorites] = useState(() => 
    getStorageItem(storageKeys.FAVORITES) || []
  );

  useEffect(() => {
    setStorageItem(storageKeys.FAVORITES, favorites);
  }, [favorites]);

  const toggleFavorite = (product) => {
    setFavorites(prevFavorites => {
      const exists = prevFavorites.some(item => item.id === product.id);
      if (exists) {
        return prevFavorites.filter(item => item.id !== product.id);
      }
      return [...prevFavorites, product];
    });
  };

  const isFavorite = (productId) => {
    return favorites.some(item => item.id === productId);
  };

  return {
    favorites,
    toggleFavorite,
    isFavorite
  };
};

export default useFavorites;