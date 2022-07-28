package com.haroong.haroong1.controller;

import com.haroong.haroong1.model.UserModel;
import com.haroong.haroong1.response.ResponseBuilder;
import com.haroong.haroong1.security.JwtTokenFactory;
import com.haroong.haroong1.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api")
public class BoardController {
    @Autowired
    BoardService boardService;

    @Autowired
    JwtTokenFactory jwtTokenFactory;

    @PostMapping("/board/insert")
    public ResponseBuilder insertBoard(@RequestParam MultipartFile file,
                                       @RequestParam String title,
                                       @RequestParam String category,
                                       HttpServletRequest request
    ) {
        String token = request.getHeader("Authorization");
        UserModel userModel = jwtTokenFactory.getUserModel(token);
        return boardService.insertBoard(file, title, category, userModel);
    }

    @GetMapping("/board/list")
    public ResponseBuilder getBoardList(@RequestParam(value = "lastNum") Integer lastNum,
                                        @RequestParam(value = "category") String category,
                                        HttpServletRequest request
    ) {
        String token = request.getHeader("Authorization");
        UserModel userModel = jwtTokenFactory.getUserModel(token);
        return boardService.getBoardList(lastNum, category, userModel);
    }

    @GetMapping("/board/{boardNo}")
    public ResponseBuilder getBoard(@PathVariable Integer boardNo) {
        return boardService.getBoard(boardNo);
    }

    @PostMapping("/board/like/{boardNo}")
    public ResponseBuilder likeBoard(@PathVariable Integer boardNo,
                                     HttpServletRequest request
    ) {
        String token = request.getHeader("Authorization");
        UserModel userModel = jwtTokenFactory.getUserModel(token);
        return boardService.likeBoard(boardNo, userModel);
    }

    @GetMapping("/board/like/my")
    public ResponseBuilder myLike(HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        UserModel userModel = jwtTokenFactory.getUserModel(token);
        return boardService.myLike(userModel);
    }
}
