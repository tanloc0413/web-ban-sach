package com.cdweb.springboot.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cdweb.springboot.request.CategoryRequest;
import com.cdweb.springboot.response.CategoryResponse;
import com.cdweb.springboot.response.CategoryResponseDefault;
import com.cdweb.springboot.service.CategoryService;

@RestController
@RequestMapping("/api/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    // Fetch all categories
    @GetMapping()
    public List<CategoryResponseDefault> getListCategory() {
        return categoryService.getListCategory();
    }

    // Fetch category by ID
    @GetMapping("/{id}")
    public Optional<CategoryResponseDefault> getCategoryById(@PathVariable Long id) {
        return categoryService.getCategoryById(id);
    }

    // Create a new category
    @PostMapping()
    public CategoryResponseDefault addCategory(@RequestBody CategoryRequest categoryRequest) {
        return categoryService.addCategory(categoryRequest);
    }

    // Update an existing category
    @PutMapping("/{id}")
    public CategoryResponseDefault updateCategory(@PathVariable Long id, @RequestBody CategoryRequest categoryRequest) {
        return categoryService.updateCategory(id, categoryRequest);
    }

    // Delete a category
    @DeleteMapping("/{id}")
    public boolean deleteCategory(@PathVariable Long id) {
        return categoryService.deleteCategory(id);
    }

    // Get products by category
    @GetMapping("/products")
    public List<CategoryResponse> getProducts() {
        return categoryService.findTop10ByCategoryId();
    }
}
