package com.cdweb.springboot.service.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cdweb.springboot.entities.Category;
import com.cdweb.springboot.repository.CategoryRespository;
import com.cdweb.springboot.repository.ProductRepository;
import com.cdweb.springboot.request.CategoryRequest;
import com.cdweb.springboot.response.CategoryResponse;
import com.cdweb.springboot.response.CategoryResponseDefault;
import com.cdweb.springboot.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryRespository categoryRespository;

    @Autowired
    private ProductRepository productRepository;

    @Override
    public List<CategoryResponseDefault> getListCategory() {
        List<CategoryResponseDefault> categoryResponses = new ArrayList<>();
        List<Category> categories = categoryRespository.findAll();
        for (Category category : categories) {
            categoryResponses.add(new CategoryResponseDefault(
                category.getId(), 
                category.getName(), 
                category.getPareCategory() != null ? category.getPareCategory().getId() : null, 
                category.getLevel()
            ));
        }
        return categoryResponses;
    }

    @Override
    public List<CategoryResponse> findTop10ByCategoryId() {
        List<CategoryResponse> categoryResponses = new ArrayList<>();
        List<Category> categories = categoryRespository.findAll();
        for (Category category : categories) {
            categoryResponses.add(new CategoryResponse(
                category.getId(), 
                category.getName(), 
                productRepository.findTop10ByCategoryId(category.getId())
            ));
        }
        return categoryResponses;
    }

    @Override
    public Optional<CategoryResponseDefault> getCategoryById(Long id) {
        Optional<Category> category = categoryRespository.findById(id);
        if (category.isPresent()) {
            Category cat = category.get();
            return Optional.of(new CategoryResponseDefault(
                cat.getId(), 
                cat.getName(), 
                cat.getPareCategory() != null ? cat.getPareCategory().getId() : null, 
                cat.getLevel()
            ));
        }
        return Optional.empty();
    }

	@Override
	public CategoryResponseDefault addCategory(CategoryRequest categoryRequest) {
		// Generate the id manually (e.g., using the max id in the table)
		Long newId = categoryRespository.findMaxId(); // Assuming you have a query for this
	
		// If no records exist, start with id = 1
		if (newId == null) {
			newId = 1L;
		} else {
			newId += 1;
		}
	
		Category category = new Category();
		category.setId(newId); // Manually setting the id
		category.setName(categoryRequest.getName());
		category.setLevel(categoryRequest.getLevel());
		
		if (categoryRequest.getParentCategoryId() != null) {
			Optional<Category> parentCategory = categoryRespository.findById(categoryRequest.getParentCategoryId());
			parentCategory.ifPresent(category::setPareCategory);
		}
	
		// Save the new category to the repository
		Category savedCategory = categoryRespository.save(category);
		
		// Return the saved category in a response
		return new CategoryResponseDefault(
			savedCategory.getId(), 
			savedCategory.getName(), 
			savedCategory.getPareCategory() != null ? savedCategory.getPareCategory().getId() : null, 
			savedCategory.getLevel()
		);
	}
	

    @Override
    public CategoryResponseDefault updateCategory(Long id, CategoryRequest categoryRequest) {
        Optional<Category> categoryOptional = categoryRespository.findById(id);
        if (categoryOptional.isPresent()) {
            Category category = categoryOptional.get();
            category.setName(categoryRequest.getName());
            category.setLevel(categoryRequest.getLevel());
            if (categoryRequest.getParentCategoryId() != null) {
                Optional<Category> parentCategory = categoryRespository.findById(categoryRequest.getParentCategoryId());
                parentCategory.ifPresent(category::setPareCategory);
            }
            Category updatedCategory = categoryRespository.save(category);
            return new CategoryResponseDefault(
                updatedCategory.getId(), 
                updatedCategory.getName(), 
                updatedCategory.getPareCategory() != null ? updatedCategory.getPareCategory().getId() : null, 
                updatedCategory.getLevel()
            );
        }
        return null; // Return null if category not found
    }

    @Override
    public boolean deleteCategory(Long id) {
        if (categoryRespository.existsById(id)) {
            categoryRespository.deleteById(id);
            return true;
        }
        return false; // Return false if category does not exist
    }
}
