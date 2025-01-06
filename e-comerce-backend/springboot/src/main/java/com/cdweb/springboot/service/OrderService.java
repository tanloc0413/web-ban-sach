package com.cdweb.springboot.service;

import java.util.List;

import com.cdweb.springboot.entities.Order;
import com.cdweb.springboot.request.OrderRequest;
import com.cdweb.springboot.response.OrderResponse;

public interface OrderService {
    public Order saveOrder(Order order);
    public List<Order> getOrderByUser(Long userId);
     List<OrderResponse> getAllOrders();
    boolean deleteOrder(Long orderId);
    OrderResponse updateStatus(Long orderId, int status);
     OrderResponse createOrder(OrderRequest orderRequest);
}
