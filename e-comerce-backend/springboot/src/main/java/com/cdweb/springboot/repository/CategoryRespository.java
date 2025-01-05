package com.cdweb.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.cdweb.springboot.entities.Category;
import com.cdweb.springboot.entities.Product;

public interface CategoryRespository extends JpaRepository<Category, Long>{
    List<Category> findByPareCategoryId(Long parentId);
      @Query("SELECT MAX(c.id) FROM Category c")
    Long findMaxId(); 
}
