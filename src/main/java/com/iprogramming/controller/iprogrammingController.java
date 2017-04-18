package com.iprogramming.controller;

import com.googlecode.objectify.ObjectifyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.appengine.api.users.User;

import Beans.Users;

@Controller
public class iprogrammingController {

	@RequestMapping("/")
	public String home() {
		return "TestHomePage";
	}

	@RequestMapping("/main")
	public String main(){return "main";}

	@RequestMapping("/createCourse")
	public String createCourse(){return "createCourse";}

	@RequestMapping("/editCourse")
	public String editCourse(){return "editCourse";}

	@RequestMapping("/editUnit")
	public String edit_unit(){return "editUnit";}

	@RequestMapping("/editLesson")
	public String editLesson(){return "editLesson";}

	@RequestMapping("/searchCourse")
	public String searchCourse(){
		return "searchCourse";
	}

	@RequestMapping("/course_page")
	public String coursePage(){
		return "courseInfo";
	}

    /* test pages */
	@RequestMapping("/hello")
//	public String hello(){return "HelloWorld";}
	public String hello(Model model){
		Users user;
		String email = "ff20";
		String email2 = "ff30";
		user = new Users(email);
		ObjectifyService.ofy().save().entity(user).now();
		user = new Users(email2);
		ObjectifyService.ofy().save().entity(user).now();
		return "HelloWorld";
	}
}