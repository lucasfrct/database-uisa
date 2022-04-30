package com.environment.aplication;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class Health {
    
    @RequestMapping("/health")
    public String index() {
        return "UP";
    }
    
}
