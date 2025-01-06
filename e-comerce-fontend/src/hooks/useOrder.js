import { useEffect, useState } from "react";
import orderAPi from "../api/orderApi";

export default function useOrder(userId, refreshFlag) {
  const [orders, setOrders] = useState([]);

  useEffect(() => {
    const fetchOrders = async () => {
      try {
        const res = await orderAPi.get(userId);
        console.log('Loi lay ds orders', res);
        setOrders(res);
      } catch (error) {
        console.log('Loi lay ds orders', error);
      }
    };

    fetchOrders();
  }, [userId, refreshFlag]); // Re-fetch orders when userId or refreshFlag changes

  return orders;
}
