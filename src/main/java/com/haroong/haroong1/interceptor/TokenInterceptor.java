package com.haroong.haroong1.interceptor;

import com.haroong.haroong1.security.JwtTokenFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Token 검증
 */
public class TokenInterceptor implements HandlerInterceptor {
    /**
     * 헤더명
     */
    private static final String HEADER_NAME = "Authorization";

    /**
     * 토큰 팩토리
     */
    @Autowired
    private JwtTokenFactory jwtTokenFactory;

    /**
     * 사전 검증
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        final String token = request.getHeader(HEADER_NAME);
        if(token != null && jwtTokenFactory.verify(token)) {
            return true;
        } else {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
        }
        return false;
    }

    /**
     * 사후 검증
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }

    /**
     * 완료
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
    }
}
