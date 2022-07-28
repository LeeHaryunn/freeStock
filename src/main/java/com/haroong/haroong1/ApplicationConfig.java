package com.haroong.haroong1;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.Filter;

/**
 * 어플리케이션 설정
 */
public class ApplicationConfig extends AbstractAnnotationConfigDispatcherServletInitializer {

    /**
     * 스프링 컨테이너 전역 설정
     */
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[] { ApplicationContextConfig.class };
    }

    /**
     * 스프링 웹 설정
     */
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[] { SpringWebConfig.class };
    }

    /**
     * 기본요청정보 맵핑
     */
    @Override
    protected String[] getServletMappings() {
        return new String[] { "/" };
    }

    /**
     * UTF-8 인코딩
     */
    @Override
    protected Filter[] getServletFilters() {
        CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
        encodingFilter.setEncoding("UTF-8");
        encodingFilter.setForceEncoding(true);

        HiddenHttpMethodFilter httpFilter = new HiddenHttpMethodFilter();

        return new Filter[] { encodingFilter, httpFilter };
    }

    /**
     * 서블릿 명칭 설정
     */
    @Override
    protected String getServletName() {
        return "dispatcherServlet";
    }

    /**
     * 비동기 통신 설정
     */
    @Override
    protected boolean isAsyncSupported() {
        return false;
    }
}
