package com.haroong.haroong1.service;

import com.haroong.haroong1.model.UserModel;
import com.haroong.haroong1.response.ResponseBuilder;
import org.springframework.web.multipart.MultipartFile;

public interface BoardService {
    /**
     * 게시글 작성
     * @param boardModel
     * @return
     */
    ResponseBuilder insertBoard(MultipartFile file, String title, String category, UserModel userModel);

    /**
     * 게시글 리스트 검색
     * @param lastNum
     * @return
     */
    ResponseBuilder getBoardList(Integer lastNum, String category, UserModel userModel);

    /**
     * 게시글 하나 검색
     * @param boardNo
     * @return
     */
    ResponseBuilder getBoard(Integer boardNo);

    /**
     * 좋아요
     * @param boardNo
     * @return
     */
    ResponseBuilder likeBoard(Integer boardNo, UserModel userModel);

    ResponseBuilder myLike(UserModel userModel);
}
