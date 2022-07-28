package com.haroong.haroong1.service;

import com.haroong.haroong1.model.UserModel;
import com.haroong.haroong1.response.ResponseBuilder;

public interface UserService {
    /**
     * 유저 검증
     * @param userId
     * @param userPw
     * @return
     */
    ResponseBuilder verifyUser(String userId, String userPw);

    /**
     * 유저 등록
     * @param userModel
     * @return
     */
    ResponseBuilder registerUser(UserModel userModel);

    /**
     * ID 중복 체크
     * @param userId
     * @return
     */
    ResponseBuilder searchId(String userId);
}
