package com.cdweb.springboot.service.Impl;

import java.util.List;
import java.util.stream.Collectors;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdweb.springboot.entities.Order;
import com.cdweb.springboot.entities.OrderItem;
import com.cdweb.springboot.entities.User;
import com.cdweb.springboot.repository.OrderItemRepository;
import com.cdweb.springboot.repository.OrderRepository;
import com.cdweb.springboot.response.OrderItemResponse;
import com.cdweb.springboot.response.OrderResponse;
import com.cdweb.springboot.service.OrderService;


@Service
public class OrderServiceImpl implements OrderService{
    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Transactional
    public Order saveOrder(Order order) {
//        for (OrderItem item : order.getOrderItems()) {
//            item.setOrder(order);
//        }
        return orderRepository.save(order);
    }

	@Override
	public List<Order> getOrderByUser(Long userId) {
		// TODO Auto-generated method stub
	 	User u = new User();
    	u.setId(userId);
        return orderRepository.findByUser(u);
	}

    @Override
    @Transactional
    public boolean deleteOrder(Long orderId) {
        Optional<Order> order = orderRepository.findById(orderId);
        if (order.isPresent()) {
            orderRepository.delete(order.get());
            return true;
        }
        return false;
    }

    // Update the order status
    @Override
    @Transactional
    public OrderResponse updateStatus(Long orderId, int status) {
        Optional<Order> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            order.setOrderStatus(status);
            Order updatedOrder = orderRepository.save(order);
            return mapToOrderResponse(updatedOrder);  // Map to OrderResponse after update
        }
        return null;
    }

    // Helper method to map Order entity to OrderResponse DTO
    private OrderResponse mapToOrderResponse(Order order) {
        OrderResponse response = new OrderResponse();
        response.setId(order.getId().toString());
        response.setDate(order.getPaymentTime()); // Assuming payment time is a String; convert if needed
        response.setPaymentStatus(order.getPaymentStatus() == 1 ? "Paid" : "Unpaid");
        response.setFulfillmentStatus(order.getOrderStatus() == 1 ? "Fulfilled" : "Pending");
        response.setTotal(String.format("%.2f", order.getTotalPrice() / 100.0)); // Assuming total price is in cents
        response.setOrderItems(order.getOrderItems().stream()
                .map(this::mapToOrderItemResponse)
                .collect(Collectors.toList()));  // Map each order item to OrderItemResponse
        return response;
    }

    // Helper method to map OrderItem entity to OrderItemResponse DTO
    private OrderItemResponse mapToOrderItemResponse(OrderItem item) {
        OrderItemResponse response = new OrderItemResponse();
        response.setProductName(item.getProduct().getProductName());
        response.setQuantity(String.valueOf(item.getQuantity()));
        response.setProductPrice(String.valueOf(item.getProduct().getPrice())); // Assuming price is stored as a number (e.g., double)
        return response;
    }

    @Override
    public List<OrderResponse> getAllOrders() {
        // Fetch all orders from the repository
        List<Order> orders = orderRepository.findAll();

        // Map the list of orders to a list of OrderResponse
        return orders.stream()
                .map(this::mapToOrderResponse)  // Map each order to an OrderResponse
                .collect(Collectors.toList());
    }

}
