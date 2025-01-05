package com.cdweb.springboot.response;


import java.time.LocalDateTime;

public class UserResponse {

    private Long id;
    private String email;
    private String userName;
    private String mobile;
    private String fullName;
    private String role;
    private LocalDateTime createdAt;

    // Constructor

    public UserResponse(Long id, String email, String userName, String mobile, String fullName, String role, LocalDateTime createdAt) {
        this.id = id;
        this.email = email;
        this.userName = userName;
        this.mobile = mobile;
        this.fullName = fullName;
        this.role = role;
        this.createdAt = createdAt;
    }

    // Getters and Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}