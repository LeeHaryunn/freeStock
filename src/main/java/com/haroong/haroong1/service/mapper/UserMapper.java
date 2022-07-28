package com.haroong.haroong1.service.mapper;

import com.haroong.haroong1.model.UserModel;
import com.haroong.haroong1.repository.entity.UserEntity;

import java.text.SimpleDateFormat;

public class UserMapper {
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public static UserModel mapUserModel(UserEntity userEntity) {
        if (userEntity == null) return null;

        UserModel userModel = new UserModel();
        if (userEntity.getUserNo() != null) {
            userModel.setUserNo(userEntity.getUserNo());
        }
        userModel.setUserId(userEntity.getUserId());
        if (userEntity.getUserPw() != null) {
            userModel.setUserPw(userEntity.getUserPw());
        }
        userModel.setUserName(userEntity.getUserName());
        if (userEntity.getCreateDt() != null) {
            userModel.setCreateDt(sdf.format(userEntity.getCreateDt()));
        }
        return userModel;
    }

    public static UserEntity mapUserEntity(UserModel userModel) {
        if (userModel == null) return null;

        UserEntity userEntity = new UserEntity();
        if (userModel.getUserNo() != null) {
            userEntity.setUserNo(userModel.getUserNo());
        }
        userEntity.setUserId(userModel.getUserId());
        userEntity.setUserPw(userModel.getUserPw());
        userEntity.setUserName(userModel.getUserName());
        return userEntity;
    }
}
