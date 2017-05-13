package com.iprogramming.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * Created by GangdiHuang on 5/13/17.
 * Edited by Jiaqi Zhang
 * Edited by Yanda Wu
 */

@Controller
public class HomePageController {

    @RequestMapping("/")
    public String home() {
        return "home";
    }


}
