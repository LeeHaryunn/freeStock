package com.haroong.haroong1.service.serviceImpl;

import com.haroong.haroong1.model.UserModel;
import com.haroong.haroong1.repository.UserRepository;
import com.haroong.haroong1.repository.entity.UserEntity;
import com.haroong.haroong1.response.ResponseBuilder;
import com.haroong.haroong1.response.ResponseData;
import com.haroong.haroong1.service.UserService;
import com.haroong.haroong1.service.mapper.UserMapper;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    UserRepository userRepository;

    /**
     * 유저 검증
     * @param userId
     * @param userPW
     * @return
     */
    @Override
    public ResponseBuilder verifyUser(String userId, String userPW) {
        ResponseBuilder responseBuilder = new ResponseBuilder();
        try {
            // 빈 값 체크
            if (userId == null || userPW == null) {
                return responseBuilder.apiBuilder(ResponseData.REQUEST_EMPTY, "로그인 실패");
            }

            // DB에 존재하는지 체크
            UserEntity userEntity = userRepository.findByUserId(userId);
            if (userEntity == null) {
                return responseBuilder.apiBuilder(ResponseData.USER_NOT_EXIST, "로그인 실패");
            }

            // 암호가 맞는지 체크
            if (StringUtils.hasText(userPW) &&
                    !BCrypt.checkpw(userPW, userEntity.getUserPw())) {
                return responseBuilder
                        .apiBuilder(ResponseData.PASSWORD_INCORRECT, "로그인 실패");
            }

            // 로그인 성공
            return responseBuilder.apiBuilder(ResponseData.OK, UserMapper.mapUserModel(userEntity));
        } catch (Exception e) {
            e.printStackTrace();
            return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "서버 에러");
        }
    }

    /**
     * 유저 등록
     * @param userModel
     * @return
     */
    @Override
    public ResponseBuilder registerUser(UserModel userModel) {
        ResponseBuilder responseBuilder = new ResponseBuilder();
        try {
            // 빈 값 체크
            if (userModel == null
                    || !StringUtils.hasText(userModel.getUserId())
                    || !StringUtils.hasText(userModel.getUserPw())
                    || !StringUtils.hasText(userModel.getUserName())
            ) {
                return responseBuilder.apiBuilder(ResponseData.REQUEST_EMPTY, "ID 또는 PW 또는 닉네임이 비어있습니다.");
            }

            // ID 중복 여부 체크
            UserEntity userEntity = userRepository.findByUserId(userModel.getUserId());
            if (userEntity != null) {
                return responseBuilder.apiBuilder(ResponseData.DUPLICATED_DATA, "이미 존재하는 ID 입니다.");
            }

            // ID 자릿수 체크
            if (userModel.getUserId().length() > 20) {
                return responseBuilder.apiBuilder(ResponseData.EXCEED_LENGTH, "ID는 20글자를 초과할 수 없습니다.");
            }

            if (!userModel.getUserPw().equals(userModel.getUserPwCheck())) {
                return responseBuilder.apiBuilder(ResponseData.PASSWORD_NOT_EQUAL, "패스워드 확인란을 다시 입력해주세요.");
            }

            // 암호 자릿수 체크
            if (userModel.getUserPw().length() > 100) {
                return responseBuilder.apiBuilder(ResponseData.EXCEED_LENGTH, "암호는 100글자를 초과할 수 없습니다.");
            }

            // pw 암호화
            String hashed = BCrypt.hashpw(userModel.getUserPw(), BCrypt.gensalt());
            userModel.setUserPw(hashed);
            userEntity = userRepository.save(UserMapper.mapUserEntity(userModel));

            if (userEntity.getUserNo() != null) {
                return responseBuilder.apiBuilder(ResponseData.OK, "환영합니다!");
            } else {
                return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "회원등록 실패");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "회원등록 실패");
        }
    }

    /**
     * ID 중복 체크
     * @param userId
     * @return
     */
    @Override
    public ResponseBuilder searchId(String userId) {
        ResponseBuilder responseBuilder = new ResponseBuilder();
        try {
            UserEntity userEntity = userRepository.findByUserId(userId);
            if (userEntity != null) {
                return responseBuilder.apiBuilder(ResponseData.DUPLICATED_DATA, "이미 존재하는 ID 입니다.");
            } else {
                return responseBuilder.apiBuilder(ResponseData.OK, "사용 가능한 ID 입니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "서버 에러");
        }
    }
}
