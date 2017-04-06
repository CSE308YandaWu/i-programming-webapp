package com.iprogramming.controller;

import java.util.ArrayList;
import java.util.Date;

import com.google.appengine.api.datastore.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@Controller
public class iprogrammingController {

	@RequestMapping("/")
	public String home() {
		return "edit_lesson";
	}
	@RequestMapping("/main")
	public String main(){return "main";}

//	@RequestMapping("/hello")
//	public String hello(){return "HelloWorld";}
//

	@RequestMapping("/search_course")
	public String searchCourse(){
		return "search_course";
	}

	@RequestMapping("/course_page")
	public String coursePage(){
		return "coursepage";
	}
}
