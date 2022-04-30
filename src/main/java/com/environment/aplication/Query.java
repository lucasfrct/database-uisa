package com.environment.aplication;


import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PostMapping;

@RestController
public class Query {
    
    @PostMapping("/query")
    public String index() {
        return "QUERY";
    }
}
