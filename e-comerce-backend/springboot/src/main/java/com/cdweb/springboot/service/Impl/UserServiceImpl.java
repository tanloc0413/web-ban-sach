package com.cdweb.springboot.service.Impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.cdweb.springboot.entities.User;
import com.cdweb.springboot.repository.UserRepository;
import com.cdweb.springboot.request.UserRequest;
import com.cdweb.springboot.response.UserResponse;
import com.cdweb.springboot.service.UserService;
@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserRepository userRepository;
	  @Autowired
    private PasswordEncoder passwordEncoder;
	// @Override
	// public User getUserById(Long userld) {
	// 	// TODO Auto-generated method stub
		
	// 	return null;
	// }

	// @Override
	// public User getUserProfileByJwt(String jwt) {
	// 	// TODO Auto-generated method stub
		
	// 	return null;
	// }

	// @Override
	// public User getUserByEmailAndPassword(String email, String password) {
	// 	// TODO Auto-generated method stub
	// 	return userRepository.f;
	// }


    @Override
    public UserResponse createUser(UserRequest userRequest) {
        User user = new User();
        user.setEmail(userRequest.getEmail());
        user.setUserName(userRequest.getUserName());
        user.setPassword(userRequest.getPassword());  // Add proper password encryption
        user.setMobile(userRequest.getMobile());
        user.setFullName(userRequest.getFullName());
        user.setRole(userRequest.getRole());
        user.setCreatedAt(java.time.LocalDateTime.now());

        User savedUser = userRepository.save(user);
        return mapToUserResponse(savedUser);
    }

    @Override
    public UserResponse updateUser(Long id, UserRequest userRequest) {
        // Find the existing user
        User existingUser = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
    
        // Update the fields
        if (userRequest.getEmail() != null) {
            existingUser.setEmail(userRequest.getEmail());
        }
    
        if (userRequest.getUserName() != null) {
            existingUser.setUserName(userRequest.getUserName());
        }
    
        // Only update password if it's not null or empty
        if (userRequest.getPassword() != null && !userRequest.getPassword().isEmpty()) {
            existingUser.setPassword(passwordEncoder.encode(userRequest.getPassword()));
        }
    
        if (userRequest.getRole() != null) {
            existingUser.setRole(userRequest.getRole());
        }
    
        if (userRequest.getMobile() != null) {
            existingUser.setMobile(userRequest.getMobile());
        }
    
        if (userRequest.getFullName() != null) {
            existingUser.setFullName(userRequest.getFullName());
        }
    
        // Save the updated user and return the response
        User updatedUser = userRepository.save(existingUser);
        return mapToUserResponse(updatedUser);
    }
    

    @Override
    public UserResponse getUserById(Long id) {
        User user = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        
        return mapToUserResponse(user);
    }

    @Override
    public List<UserResponse> getAllUsers() {
        List<User> users = userRepository.findAll();
        return users.stream()
                .map(this::mapToUserResponse)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteUser(Long id) {
        User user = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        userRepository.delete(user);
    }

    private UserResponse mapToUserResponse(User user) {
        return new UserResponse(
                user.getId(),
                user.getEmail(),
                user.getUserName(),
                user.getMobile(),
                user.getFullName(),
                user.getRole(),
                user.getCreatedAt()
        );
    }
}
