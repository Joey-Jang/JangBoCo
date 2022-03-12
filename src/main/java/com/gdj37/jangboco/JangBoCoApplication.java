package com.gdj37.jangboco;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan(basePackages = "com.gdj37.jangboco")
public class JangBoCoApplication {

    public static void main(String[] args) {
        SpringApplication.run(JangBoCoApplication.class, args);
    }

}
