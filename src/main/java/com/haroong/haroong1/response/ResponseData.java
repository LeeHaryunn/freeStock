package com.haroong.haroong1.response;

import org.springframework.http.HttpStatus;

/**
 * Http 상태 코드 기반 (RFC2616) 커스텀 메세지<br/>
 * 상태 코드 신규 생성 금지 (7XX...등)
 * @see HttpStatus
 */
public enum ResponseData {

    /**
     * @apiNote Common
     */
    OK(200, HttpStatus.OK.getReasonPhrase()),
    REQUEST_EMPTY(400, "요청 값이 비어있습니다."),
    INTERNAL_SERVER_ERROR(500, "서버 에러"),
    DUPLICATED_DATA(406, "이미 존재하는 데이터 입니다."),
    NO_SUCH_DATA(404, "존재하지 않는 데이터 입니다."),
    EXCEED_LENGTH(413, "데이터가 너무 큽니다."),

    /**
     * @apiNote Login exception
     */
    USER_NOT_EXIST(401,"등록되지 않은 사용자입니다."),
    PASSWORD_INCORRECT(401, "비밀번호가 맞지 않습니다."),

    /**
     * @apiNote Register exception
     */
    PASSWORD_NOT_EQUAL(400, "비밀번호가 일치하지 않습니다.");

    private final Integer code;
    private final String msg;

    ResponseData(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public Integer getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

}
