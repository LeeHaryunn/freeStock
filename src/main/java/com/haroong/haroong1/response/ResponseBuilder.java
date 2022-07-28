package com.haroong.haroong1.response;

import org.springframework.http.HttpStatus;

/**
 * 서버 - 클라이언트 통신 간 통일된 객체를 전달 하기 위한 클래스<br/>
 * 컨트롤러에서 {@code ResponseBuilder} 리턴
 * <p>사용법 =>
 * <blockquote>빌더패턴 : <pre>
 *     new ResponseBuilder
 *         .Builder(ResponseData.OK)
 *         .message("msg")
 *         .data(Object)
 *         .build();
 * </pre>축약형 :<pre>
 *     new ResponseBuilder().apiBuilder(ResponseData.OK, "msg", Object);
 * </pre>예외 처리: <pre>
 *     try {
 *         (code)
 *     } catch (Exception e) {
 *         return new ResponseBuilder.throwInternalError("msg");
 *     }
 * </pre></blockquote>
 * </p>
 * {@code message} : 클라이언트에서 표시할 문자 <br/>
 * {@code responseMessage} : {@link HttpStatus} 기반 상태 메세지 <br/>
 * {@code statusCode} : {@link HttpStatus} 기반 상태 코드 <br/>
 * {@code data} : 클라이언트로 전달할 데이터(Object) <br/>
 * {@code response} : {@link HttpStatus} 기반 Enum <br/>
 * <br/>
 * @see ResponseData
 */
public class ResponseBuilder {

    private String message;
    private String responseMessage;
    private Integer statusCode;
    private Object data;
    private ResponseData response;

    public ResponseBuilder() {}

    private ResponseBuilder(Builder builder) {
        this.message = builder.message;
        this.responseMessage = builder.responseMessage;
        this.statusCode = builder.statusCode;
        this.data = builder.data;
        this.response = builder.response;
    }

    public ResponseBuilder apiBuilder(ResponseData resp) {
        return new Builder(resp)
                .response(resp)
                .build();
    }

    public ResponseBuilder apiBuilder(ResponseData resp, String msg) {
        return new Builder(resp)
                .message(msg)
                .response(resp)
                .build();
    }

    public ResponseBuilder apiBuilder(ResponseData resp, Object data) {
        return new Builder(resp)
                .data(data)
                .response(resp)
                .build();
    }

    public ResponseBuilder apiBuilder(ResponseData resp, String msg, Object data) {
        return new Builder(resp)
                .message(msg)
                .data(data)
                .response(resp)
                .build();
    }

    public ResponseBuilder throwInternalError(String s) {
        return this.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, s);
    }

    public static class Builder {
        private String message;
        private String responseMessage;
        private Integer statusCode;
        private Object data;
        private ResponseData response;

        public Builder(ResponseData response) {
            this.statusCode = response.getCode();
            this.responseMessage = response.getMsg();
            this.response = response;
        }

        public Builder message(String v) {
            this.message = v;
            return this;
        }

        public Builder responseMessage(String v) {
            this.responseMessage = v;
            return this;
        }

        public Builder statusCode(Integer v) {
            this.statusCode = v;
            return this;
        }

        public Builder response(ResponseData v) {
            this.response = v;
            return this;
        }

        public Builder data(Object v) {
            this.data = v;
            return this;
        }

        public ResponseBuilder build() {
            return new ResponseBuilder(this);
        }

    }

    public String getMessage() {
        return message;
    }

    public String getResponseMessage() {
        return responseMessage;
    }

    public Integer getStatusCode() {
        return statusCode;
    }

    public Object getData() {
        return data;
    }

//    public HttpStatus getResponse() {
//        return HttpStatus.valueOf(this.response.getCode());
//    }

    public ResponseData getResponse() {
        return response;
    }

    public void setData(Object data) {
        this.data = data;
    }

}
