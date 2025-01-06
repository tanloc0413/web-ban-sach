package com.cdweb.springboot.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.cdweb.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cdweb.springboot.config.JwtProvider;
import com.cdweb.springboot.entities.PasswordResetToken;
//import com.cdweb.springboot.entities.Token;
import com.cdweb.springboot.entities.User;
import com.cdweb.springboot.repository.AuthResponse;
import com.cdweb.springboot.repository.PasswordResetTokenRepository;
//import com.cdweb.springboot.repository.TokenRepository;
import com.cdweb.springboot.repository.UserRepository;
import com.cdweb.springboot.request.LoginRequest;
import com.cdweb.springboot.request.UserRequest;
import com.cdweb.springboot.response.ResponseApi;
import com.cdweb.springboot.response.UserResponse;
import com.cdweb.springboot.service.EmailService;
import com.cdweb.springboot.service.Impl.UserDetailsServiceImpl;

@RestController
@RequestMapping("/api/users")
public class UserController {
    @Autowired
    private UserService userService; // Inject UserService
    @GetMapping()
    public ResponseEntity<List<UserResponse>> getAllUsers() {
        List<UserResponse> users = userService.getAllUsers();
        return ResponseEntity.ok(users);
    }
    @GetMapping("/{id}")
    public ResponseEntity<UserResponse> getUserById(@PathVariable Long id) {
        try {
            UserResponse user = userService.getUserById(id);
            return ResponseEntity.ok(user); // Return the user details
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null); // Return 404 if user not found
        }
    }
    @PutMapping("{id}")
    public ResponseEntity<UserResponse> updateUser(@PathVariable Long id, @RequestBody UserRequest userRequest) {
        try {
            UserResponse updatedUser = userService.updateUser(id, userRequest);
            return ResponseEntity.ok(updatedUser);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @DeleteMapping("{id}")
    public ResponseEntity<String> deleteUser(@PathVariable Long id) {
        try {
            userService.deleteUser(id);
            return ResponseEntity.ok("User deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }
    }
}
