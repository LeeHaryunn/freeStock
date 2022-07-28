package com.haroong.haroong1.controller;

import com.haroong.haroong1.model.FileModel;
import com.haroong.haroong1.model.UserModel;
import com.haroong.haroong1.response.ResponseBuilder;
import com.haroong.haroong1.security.JwtTokenFactory;
import com.haroong.haroong1.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api")
public class FileController {
    @Autowired
    FileService fileService;

    @Autowired
    JwtTokenFactory jwtTokenFactory;

    @PostMapping("/file/upload")
    public ResponseBuilder upload(@RequestParam MultipartFile file, HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        UserModel userModel = jwtTokenFactory.getUserModel(token);
        return fileService.uploadFile(file, userModel);
    }

    @GetMapping("/file/download")
    public ResponseEntity<Resource> download(@ModelAttribute FileModel fileModel, HttpServletRequest request) {
        return fileService.downloadFile(fileModel);
    }
}
