package com.haroong.haroong1.controller;

import com.haroong.haroong1.model.UserModel;
import com.haroong.haroong1.response.ResponseBuilder;
import com.haroong.haroong1.security.JwtTokenFactory;
import com.haroong.haroong1.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class AuthController {
    @Autowired
    UserService userService;

    @Autowired
    JwtTokenFactory jwtTokenFactory;

    @GetMapping("/auth/signin")
    @ResponseBody
    public ResponseBuilder signIn(@RequestParam(value = "userId") String userId, @RequestParam(value = "userPw") String userPw) {
        ResponseBuilder rb = userService.verifyUser(userId, userPw);
        if (rb.getStatusCode() == 200) {
            UserModel userModel = (UserModel) rb.getData();
            userModel.setAccessToken(jwtTokenFactory.createAccessJwtToken(userModel));
            userModel.setRefreshToken(jwtTokenFactory.createRefreshToken(userModel));
            rb.setData(userModel);
        }
        return rb;
    }

    @PostMapping("/auth/register")
    @ResponseBody
    public ResponseBuilder registerUser(@RequestBody UserModel userModel) {
        return userService.registerUser(userModel);
    }

    @GetMapping("/auth/search-id")
    @ResponseBody
    public ResponseBuilder searchId(@RequestParam(value = "userId") String userId) {
        return userService.searchId(userId);
    }
}
