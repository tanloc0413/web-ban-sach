package com.cdweb.springboot.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cdweb.springboot.entities.Order;
import com.cdweb.springboot.entities.OrderItem;
import com.cdweb.springboot.request.OrderRequest;
import com.cdweb.springboot.response.OrderItemResponse;
import com.cdweb.springboot.response.OrderResponse;
import com.cdweb.springboot.service.OrderService;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

	@Autowired
	private OrderService orderService;

	@PostMapping("/")
	public Map<String, Object> saveOrder(@RequestBody OrderRequest orderRequest) {
		Map<String, Object> response = new HashMap<>();

		try {
			// Save the order using the service
			OrderResponse savedOrder = orderService.createOrder(orderRequest);

			// Set the response as success with the saved order
			response.put("success", true);
			response.put("message", "Order created successfully");
			response.put("order", savedOrder);
		} catch (Exception e) {
			// Handle the error case
			response.put("success", false);
			response.put("message", "Failed to create order: " + e.getMessage());
			response.put("order", null);
		}

		return response;
	}


	@GetMapping("/{userId}")
public List<OrderResponse> createOrder(@PathVariable("userId") Long userId) {
    List<Order> orders = orderService.getOrderByUser(userId);
    List<OrderResponse> responses = new ArrayList<>();

    for (Order o : orders) {
        OrderResponse orderResponse = new OrderResponse();
        orderResponse.setId("#" + o.getId());
        
        // Define the input format to match the timestamp format in 'paymentTime'
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS");

        try {
            // Convert the string to LocalDateTime using the formatter
            LocalDateTime dateTime = LocalDateTime.parse(o.getPaymentTime(), inputFormatter);

            // Define the output format for displaying the date
            DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

            // Convert LocalDateTime to the desired output format
            orderResponse.setDate(dateTime.format(outputFormatter));
        } catch (DateTimeParseException e) {
            // Handle parsing error, e.g., truncate the timestamp
            System.out.println("Error parsing payment time: " + e.getMessage());
            // You can choose to set a default date if parsing fails
            orderResponse.setDate("Invalid date format");
        }

        orderResponse.setPaymentStatus(o.getPaymentStatus() == 1 ? "Thanh toán thành công" : "Chưa thanh toán");

        String[] mang = { "Đang xử lý", "Đã nhận hàng", "Đã hủy", "Đang giao hàng" };
        Random rd = new Random();
        orderResponse.setFulfillmentStatus(mang[o.getOrderStatus() - 1]);
        orderResponse.setTotal(o.getTotalPrice() + "");

        List<OrderItemResponse> itemResponses = new ArrayList<>();
        for (OrderItem orderItem : o.getOrderItems()) {
            OrderItemResponse orderItemResponse = new OrderItemResponse();
            orderItemResponse.setProductId(orderItem.getId());
            orderItemResponse.setProductName(orderItem.getProduct().getProductName());
            orderItemResponse.setProductImg(orderItem.getProduct().getImageUrl());
            orderItemResponse.setProductPrice(orderItem.getProduct().getDiscountedPrice() + "");
            orderItemResponse.setQuantity(orderItem.getQuantity() + "");
            itemResponses.add(orderItemResponse);
        }
        orderResponse.setOrderItems(itemResponses);
        responses.add(orderResponse);
    }

    return responses;
}

	

	// Update the status of an order
	@PutMapping("/{orderId}/status/{status}")
	public OrderResponse updateOrderStatus(@PathVariable("orderId") Long orderId, @PathVariable("status") int status) {
		return orderService.updateStatus(orderId, status);
	}

	// Delete an order
	@DeleteMapping("/{orderId}")
	public boolean deleteOrder(@PathVariable("orderId") Long orderId) {
		return orderService.deleteOrder(orderId);
	}

	// Helper method to map Order entity to OrderResponse DTO
	private OrderResponse mapToOrderResponse(Order order) {
		OrderResponse response = new OrderResponse();
		response.setId("#" + order.getId());

		// Format the payment time
		DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		LocalDateTime dateTime = LocalDateTime.parse(order.getPaymentTime(), inputFormatter);
		DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
		response.setDate(dateTime.format(outputFormatter));

		response.setPaymentStatus(order.getPaymentStatus() == 1 ? "Thanh toán thành công" : "Chưa thanh toán");

		// Set random fulfillment status
		String[] statuses = { "Đang xử lý", "Đã nhận hàng", "Đã hủy", "Đang giao hàng" };
		Random rd = new Random();
		response.setFulfillmentStatus(statuses[rd.nextInt(statuses.length)]);

		response.setTotal(order.getTotalPrice() + "");

		// Set order items
		List<OrderItemResponse> itemResponses = new ArrayList<>();
		for (OrderItem orderItem : order.getOrderItems()) {
			OrderItemResponse orderItemResponse = new OrderItemResponse();
			orderItemResponse.setProductId(orderItem.getId());
			orderItemResponse.setProductName(orderItem.getProduct().getProductName());
			orderItemResponse.setProductImg(orderItem.getProduct().getImageUrl());
			orderItemResponse.setProductPrice(orderItem.getProduct().getDiscountedPrice() + "");
			orderItemResponse.setQuantity(orderItem.getQuantity() + "");
			itemResponses.add(orderItemResponse);
		}

		response.setOrderItems(itemResponses);
		return response;
	}

	@GetMapping("/all")
	public List<OrderResponse> getAllOrders() {
		// Fetch all orders from the service
		List<OrderResponse> orders = orderService.getAllOrders();

		// Return the list of OrderResponse objects
		return orders;
	}

}
