package com.iprogramming.controller;

import Beans.Course;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
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


        List<Course> courses = ofy().load().type(Course.class).list();
        List<Course> result = new ArrayList<>();
        if (method != null && "title".equals(method)) {
            for (Course c: courses) {
                if (c.getTitle().toLowerCase().contains(input.toLowerCase()))
                    result.add(c);
            }
        } else if(method != null && "instructor".equals(method) ){
            for (Course c: courses) {
                if (c.getInstructor().toLowerCase().contains(input.toLowerCase()))
                    result.add(c);
            }
        }
        return new ModelAndView("searchCourse", "result", result);
    }
}

