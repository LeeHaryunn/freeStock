package com.haroong.haroong1;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import javax.persistence.SharedCacheMode;
import javax.persistence.ValidationMode;
import javax.sql.DataSource;
import java.util.Objects;

/**
 * 어플리케이션 컨텍스트 설정
 */
@Configuration
@PropertySource({ "classpath:persistence.properties", "classpath:server.properties" })
@EnableJpaRepositories(basePackages = "com.haroong.haroong1")
public class ApplicationContextConfig {

    /**
     * 환경변수
     */
    @Autowired
    private Environment env;

    /**
     * 데이터 소스 등록
     *
     * @return
     */
    @Bean
    public DataSource getDataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName(env.getProperty("jdbc_driver"));
        dataSource.setUsername(env.getProperty("jdbc_username"));
        dataSource.setPassword(env.getProperty("jdbc_password"));
        dataSource.setUrl(env.getProperty("jdbc_url"));
        dataSource.setInitialSize(Integer.parseInt(Objects.requireNonNull(env.getProperty("jdbc_initial_size"))));
        dataSource.setMaxActive(Integer.parseInt(Objects.requireNonNull(env.getProperty("jdbc_max_size"))));
        dataSource.setTestWhileIdle(true);
        dataSource.setValidationQuery("SELECT 1");
        dataSource.setDefaultAutoCommit(false);

        return dataSource;
    }

    /**
     * 엔티티 매니저 펙토리 빈 생성
     *
     * @return
     */
    @Bean(name = "entityManagerFactory")
    public LocalContainerEntityManagerFactoryBean getEntityManagerFactoryBean() {

        HibernateJpaVendorAdapter adapter = new HibernateJpaVendorAdapter();
        adapter.setDatabasePlatform("org.hibernate.dialect.MySQL5InnoDBDialect");
        LocalContainerEntityManagerFactoryBean factory = new LocalContainerEntityManagerFactoryBean();
        factory.setJpaVendorAdapter(adapter);
        factory.setDataSource(getDataSource());
        factory.setPackagesToScan("com.haroong.haroong1");
        factory.setSharedCacheMode(SharedCacheMode.ENABLE_SELECTIVE);
        factory.setValidationMode(ValidationMode.NONE);

        return factory;
    }

    /**
     * JPA 트랜잭션 매니저 빈 생성
     *
     * @return
     */
    @Bean(name = "transactionManager")
    public JpaTransactionManager geJpaTransactionManager() {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(getEntityManagerFactoryBean().getObject());
        return transactionManager;
    }
}
