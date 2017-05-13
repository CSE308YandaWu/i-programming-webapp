package com.iprogramming.controller;

import Beans.Course;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

import static com.googlecode.objectify.ObjectifyService.ofy;

/**
 * Created by GangdiHuang on 5/13/17.
 * Edited by Jiaqi Zhang
 * Edited by Yanda Wu
 */

@Controller
public class SearchCoursePageController {
    @RequestMapping("/searchCourse")
    public ModelAndView searchCourse(HttpSession session, HttpServletRequest request) {
        String input = request.getParameter("UserIn");
        String method = request.getParameter("Select_method");
        System.out.println(method);
        System.out.println(input);
        List<Course> courses;
        if (method != null && "title".equals(method)) {
            courses = ofy().load().type(Course.class).filter("title =", input).list();
            System.out.println("search by title");
            System.out.println(courses);
        } else {
            courses = ofy().load().type(Course.class).filter("instructor =", input).list();
            System.out.println("search by instructor");
            System.out.println(courses);
        }
        return new ModelAndView("searchCourse", "result", courses);
    }
}

