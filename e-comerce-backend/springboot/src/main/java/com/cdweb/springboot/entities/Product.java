package com.cdweb.springboot.entities;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import org.springframework.data.annotation.CreatedDate;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "products")
public class Product {

	@Id 
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	@Column(name = "product_name")
	private String productName;
	
	@Column(name = "image_url", columnDefinition = "MEDIUMTEXT ")
	private String imageUrl;  // Can now hold Base64 encoded string

	@Column(name = "description", columnDefinition = "TEXT")
	private String description;

	@Column(name = "price")
	private int price;
	
	@Column(name = "discounted_price")
	private int discountedPrice;
	
	@Column(name = "quantity")
	private int quantity;
	
	@Column(name = "author")
	private String author;
	
	@JsonManagedReference
	@ManyToOne
	@JoinColumn(name = "category_id")
	private Category category;
	
	 @CreatedDate
	private LocalDateTime createAt;

	public Product() {
		super();
	}

	public Product(Long id, String productName, String imageUrl, String description, int price, int discountedPrice,
			 int quantity, String author, Category category, LocalDateTime createAt) {
		super();
		this.id = id;
		this.productName = productName;
		this.imageUrl = imageUrl;
		this.description = description;
		this.price = price;
		this.discountedPrice = discountedPrice;
		this.quantity = quantity;
		this.author = author;
		this.category = category;
		this.createAt = createAt;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getDiscountedPrice() {
		return discountedPrice;
	}

	public void setDiscountedPrice(int discountedPrice) {
		this.discountedPrice = discountedPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public LocalDateTime getCreateAt() {
		return createAt;
	}

	public void setCreateAt(LocalDateTime createAt) {
		this.createAt = createAt;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}
}
