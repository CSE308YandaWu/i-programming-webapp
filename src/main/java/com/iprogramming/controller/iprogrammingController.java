package com.iprogramming.controller;

import Beans.Users;
import com.googlecode.objectify.ObjectifyService;

import Beans.Course;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class iprogrammingController {

    @RequestMapping("/")
    public String home() {
        return "home";
    }

	@RequestMapping("/main")
	public String main(){return "main";}

	@RequestMapping("/createCourse")
	public String createCourse(){return "createCourse_edit";}

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
    public String hello() {
        return "HelloWorld";
    }

    @RequestMapping("/test")
    public String test(@RequestParam(value = "email", required = false) String email,
                       @RequestParam(value = "title", required = false) String course) {

        if (email != null) {
            Course newCourse = new Course(email, course);

            ObjectifyService.ofy().save().entity(newCourse).now();
        }


        return "HelloWorld";
    }

    @RequestMapping(value = "/createCourse1")
    public ModelAndView createCourse1(@RequestParam(value = "userEmail") String userEmail,
                                      @RequestParam(value = "courseId") String courseId,
                                      @RequestParam(value = "courseTitle") String courseTitle,
                                      @RequestParam(value = "instructor") String instructor,
                                      @RequestParam(value = "description") String description,
                                      @RequestParam(value = "status") String status) {


        Course newCourse = new Course(userEmail, courseId, courseTitle, instructor, description, status);

        ObjectifyService.ofy().save().entity(newCourse).now();


        return new ModelAndView("editCourse", "model", newCourse);
    }

	@RequestMapping("/search")
	public ModelAndView search(@RequestParam(value = "CourseId") String title) {
    	System.out.print(title);
		return new ModelAndView("searchCourse","courseTitle", title);
	}

    @RequestMapping("/logout")
	public String logout(HttpSession session){
		session.invalidate();
		return "home";
	}


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