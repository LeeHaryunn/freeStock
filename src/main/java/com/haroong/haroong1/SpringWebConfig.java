package com.haroong.haroong1;

import com.haroong.haroong1.interceptor.TokenInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.resource.PathResourceResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import java.util.concurrent.TimeUnit;

/**
 * 어플리케이션 웹서버 환경 설정
 */
@EnableTransactionManagement(proxyTargetClass = true)
@Configuration
@EnableWebMvc
@ComponentScan({ "com.haroong.haroong1" })
public class SpringWebConfig implements WebMvcConfigurer {

    /**
     * CORS 설정
     */
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**").allowedOrigins("*").allowedMethods("GET","POST","PUT", "DELETE");
    }

    /**
     * 서블릿 핸들러 설정
     */
    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    /**
     * 정적 리소스 경로 커스텀
     * @param registry
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**")
                .addResourceLocations("/WEB-INF/css/")
                .setCacheControl(CacheControl.maxAge(2, TimeUnit.HOURS).cachePublic())
                .resourceChain(true)
                .addResolver(new PathResourceResolver());

        registry.addResourceHandler("/js/**")
                .addResourceLocations("/WEB-INF/js/")
                .setCacheControl(CacheControl.maxAge(2, TimeUnit.HOURS).cachePublic())
                .resourceChain(true)
                .addResolver(new PathResourceResolver());

        registry.addResourceHandler("/resources/img/**")
                .addResourceLocations("/WEB-INF/resources/img/")
                .setCacheControl(CacheControl.maxAge(2, TimeUnit.HOURS).cachePublic())
                .resourceChain(true)
                .addResolver(new PathResourceResolver());

        registry.addResourceHandler("/resources/video/**")
                .addResourceLocations("/WEB-INF/resources/video/")
                .setCacheControl(CacheControl.maxAge(2, TimeUnit.HOURS).cachePublic())
                .resourceChain(true)
                .addResolver(new PathResourceResolver());

        registry.addResourceHandler("/resources/music/**")
                .addResourceLocations("/WEB-INF/resources/music/")
                .setCacheControl(CacheControl.maxAge(2, TimeUnit.HOURS).cachePublic())
                .resourceChain(true)
                .addResolver(new PathResourceResolver());

        registry.setOrder(-1);
    }

    /**
     * JSP 뷰 리졸버
     * @return
     */
    @Bean
    public InternalResourceViewResolver internalResourceViewResolver(){
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/view/");
//        viewResolver.setContentType("text/html; charset=UTF-8");
        viewResolver.setSuffix(".jsp");
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setOrder(2);
        return viewResolver;
    }

    /**
     * 파일 업로드/다운로드
     * @return
     */
    @Bean
    public MultipartResolver multipartResolver(){
        return new CommonsMultipartResolver();
    }

    /**
     * 관리자 인터셉터 Bean 등록
     *
     * @return
     */
    @Bean
    public TokenInterceptor tokenInterceptor(){
        return new TokenInterceptor();
    }

    /*
     * 인터셉터 적용 (FIFO)
     * */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        WebMvcConfigurer.super.addInterceptors(registry);

        // claim 토큰 정합성 검증 인터셉터
        registry.addInterceptor(tokenInterceptor())
                .addPathPatterns("/api/**")
                .excludePathPatterns("/api/file/download")
                .excludePathPatterns("/api/board/list")
                .excludePathPatterns("/api/auth/register")
                .excludePathPatterns("/api/auth/signin")
                .excludePathPatterns("/api/auth/search-id");
    }
}
