package com.cdweb.springboot.response;

public class CategoryResponseDefault {
    private Long id;
    private String name;
    private Long parentCategoryId;
    private int level;

    public CategoryResponseDefault(Long id, String name, Long parentCategoryId, int level) {
        this.id = id;
        this.name = name;
        this.parentCategoryId = parentCategoryId;
        this.level = level;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getParentCategoryId() {
        return parentCategoryId;
    }

    public void setParentCategoryId(Long parentCategoryId) {
        this.parentCategoryId = parentCategoryId;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }
}
