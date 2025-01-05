package com.cdweb.springboot.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.cdweb.springboot.entities.Product;
import com.cdweb.springboot.entities.User;
import com.cdweb.springboot.request.UserRequest;
import com.cdweb.springboot.response.UserResponse;

public interface UserService {

	// public User getUserById(Long userld);
	// public User getUserProfileByJwt(String jwt);
	// public User getUserByEmailAndPassword(String email, String password);
	   UserResponse createUser(UserRequest userRequest);
	   UserResponse getUserById(Long id);
    UserResponse updateUser(Long id, UserRequest userRequest);

    List<UserResponse> getAllUsers();

    void deleteUser(Long id);
}
