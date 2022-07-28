package com.haroong.haroong1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BaseController {
    @RequestMapping("/")
    public String homePage() {
        return "index";
    }

    @RequestMapping("{a}")
    public String router1(@PathVariable String a) {
        return a;
    }

    @RequestMapping("{a}/{b}")
    public String router2(@PathVariable String a, @PathVariable String b) {
        return a + "/" + b;
    }
}

