package com.cdweb.springboot.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.cdweb.springboot.entities.Product;
import com.cdweb.springboot.request.ProductRequest;
import com.cdweb.springboot.response.ProductResponse;



public interface ProductService {

    Product getProductById(Long id);
    Page<Product> getListProductByCategory(String category, Integer minPrice, Integer maxPrice, String sort, Integer page, Integer limit);
    List<String> getProductNameSuggest(String suggest);
    Page<Product> getListProductByProductName(String productName, Integer minPrice, Integer maxPrice, String sort, Integer page, Integer limit);
    Page<Product> getListProductAdminByCategory(String category, Integer minPrice, Integer maxPrice, String sort, Integer page, Integer limit);

    ProductResponse createProduct(ProductRequest productRequest);
    ProductResponse updateProduct(Long productId, ProductRequest productRequest);
	boolean deleteProduct(Long productId);

}