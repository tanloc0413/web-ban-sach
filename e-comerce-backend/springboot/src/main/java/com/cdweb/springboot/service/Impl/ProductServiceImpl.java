package com.cdweb.springboot.service.Impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;

import com.cdweb.springboot.entities.Category;
import com.cdweb.springboot.entities.Product;
import com.cdweb.springboot.repository.ProductRepository;
import com.cdweb.springboot.request.ProductRequest;
import com.cdweb.springboot.response.ProductResponse;
import com.cdweb.springboot.service.ProductService;

import jakarta.transaction.Transactional;

@Service
public class ProductServiceImpl implements ProductService{

	private ProductRepository productRepository;
	
	public ProductServiceImpl(ProductRepository productRepository) {
		this.productRepository = productRepository;
	}
	
	@Override
	public Product getProductById(Long id) {
		// TODO Auto-generated method stub
		Optional<Product> opt = productRepository.findById(id);
		
		if(opt.isPresent()) {
			return opt.get();
		}
		return null;
//		System.out.print("Product not found with id: "+id);
	}
	
	@PostAuthorize("hasRole('SCOPE_ADMIN')")
	@Override
	public Page<Product> getListProductAdminByCategory(String category,Integer minPrice, Integer maxPrice,String sort, Integer page, Integer limit){
		// TODO Auto-generated method stub
		System.out.println("pagenumber truoc: ROLE_ADMIN");
		page = page>0 ? page-1:page;
//		System.out.println("pagenumber sau:"+pageNumber);
		
		Pageable pageable = PageRequest.of(page, limit);
		
		List<Product> products = productRepository.filterProductsByCategory(category, minPrice, maxPrice, sort);
		
		int startIndex = (int)pageable.getOffset();
		int endIndex = Math.min(startIndex+ pageable.getPageSize(), products.size());
		
		List<Product> pageContent = products.subList(startIndex, endIndex);
		
		Page<Product> filteredProducts = new PageImpl<>(pageContent, pageable,products.size());
		
		return filteredProducts;
	}
//    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @Override
    public Page<Product> getListProductByCategory(String category, Integer minPrice, Integer maxPrice, String sort, Integer page, Integer limit) {
        page = page > 0 ? page - 1 : page;
        Pageable pageable = PageRequest.of(page, limit);
        List<Product> products = productRepository.filterProductsByCategory(category, minPrice, maxPrice, sort);
        int startIndex = (int) pageable.getOffset();
        int endIndex = Math.min(startIndex + pageable.getPageSize(), products.size());
        List<Product> pageContent = products.subList(startIndex, endIndex);
        return new PageImpl<>(pageContent, pageable, products.size());
    }
	@Override
	public List<String> getProductNameSuggest(String suggest) {
		// TODO Auto-generated method stub
		return productRepository.getProductNameSuggest(suggest);
	}

	@Override
	public Page<Product> getListProductByProductName(String productName,Integer minPrice, Integer maxPrice,String sort, Integer page, Integer limit) {
		// TODO Auto-generated method stub
//		System.out.println("pagenumber truoc:"+pageNumber);
		page = page>0 ? page-1:page;
//		System.out.println("pagenumber sau:"+pageNumber);
		
		Pageable pageable = PageRequest.of(page, limit);
		
		List<Product> products = productRepository.filterProductsByProductName(productName, minPrice, maxPrice, sort);
		
		int startIndex = (int)pageable.getOffset();
		int endIndex = Math.min(startIndex+ pageable.getPageSize(), products.size());
		
		List<Product> pageContent = products.subList(startIndex, endIndex);
		
		Page<Product> filteredProducts = new PageImpl<>(pageContent, pageable,products.size());
		
		return filteredProducts;
	}


	@Transactional
	@Override
	public ProductResponse createProduct(ProductRequest productRequest) {
		Product product = new Product();
		Category category = new Category();
	
		// Assign category
		category.setId(productRequest.getCategoryId());
		
		// Find the current maximum ID and assign the next ID
		Long maxId = productRepository.findMaxId().orElse(0L); // Assuming the repository returns 0 if no records exist
		product.setId(maxId + 1);
	
		// Set other product details
		product.setProductName(productRequest.getProductName());
		product.setImageUrl(productRequest.getImageUrl());
		product.setDescription(productRequest.getDescription());
		product.setPrice(productRequest.getPrice());
		product.setDiscountedPrice(productRequest.getDiscountedPrice());
		product.setQuantity(productRequest.getQuantity());
		product.setAuthor(productRequest.getAuthor());
		product.setCategory(category);
		product.setCreateAt(LocalDateTime.now());
	
		// Save product to repository
		Product savedProduct = productRepository.save(product);
	
		// Return response
		return new ProductResponse(
			savedProduct.getId(),
			savedProduct.getProductName(),
			savedProduct.getImageUrl(),
			savedProduct.getDescription(),
			savedProduct.getPrice(),
			savedProduct.getDiscountedPrice(),
			savedProduct.getQuantity(),
			savedProduct.getAuthor(),
			savedProduct.getCategory().getId(),
			savedProduct.getCreateAt()
		);
	}
	

    @Transactional
    @Override
    public ProductResponse updateProduct(Long productId, ProductRequest productRequest) {
        Product product = productRepository.findById(productId).orElseThrow(() -> new IllegalArgumentException("Product not found"));

        product.setProductName(productRequest.getProductName());
        product.setImageUrl(productRequest.getImageUrl());
        product.setDescription(productRequest.getDescription());
        product.setPrice(productRequest.getPrice());
        product.setDiscountedPrice(productRequest.getDiscountedPrice());
        product.setQuantity(productRequest.getQuantity());
        product.setAuthor(productRequest.getAuthor());

        // Optionally update category if needed
        Category category = new Category();
        category.setId(productRequest.getCategoryId());
        product.setCategory(category);

        Product updatedProduct = productRepository.save(product);

        return new ProductResponse(
            updatedProduct.getId(),
            updatedProduct.getProductName(),
            updatedProduct.getImageUrl(),
            updatedProduct.getDescription(),
            updatedProduct.getPrice(),
            updatedProduct.getDiscountedPrice(),
            updatedProduct.getQuantity(),
            updatedProduct.getAuthor(),
            updatedProduct.getCategory().getId(),
            updatedProduct.getCreateAt()
        );
    }
	@Transactional
	@Override
	public boolean deleteProduct(Long productId) {
		if (productRepository.existsById(productId)) {
			productRepository.deleteById(productId); // Correct built-in method
			return true; // Deletion successful
		} else {
			return false; // Product not found
		}
	}
	

}
