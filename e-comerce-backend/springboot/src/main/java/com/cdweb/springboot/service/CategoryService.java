package com.cdweb.springboot.service;

import java.util.List;
import java.util.Optional;

import com.cdweb.springboot.entities.Category;
import com.cdweb.springboot.request.CategoryRequest;
import com.cdweb.springboot.response.CategoryResponse;
import com.cdweb.springboot.response.CategoryResponseDefault;

public interface CategoryService {

    List<CategoryResponseDefault> getListCategory();
    
    List<CategoryResponse> findTop10ByCategoryId();

    Optional<CategoryResponseDefault> getCategoryById(Long id);

    CategoryResponseDefault addCategory(CategoryRequest categoryRequest);

    CategoryResponseDefault updateCategory(Long id, CategoryRequest categoryRequest);

    boolean deleteCategory(Long id);
}
