package com.iprogramming.controller;

import Beans.Course;
import Beans.Lesson;
import com.googlecode.objectify.ObjectifyFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

import static com.googlecode.objectify.ObjectifyService.ofy;

/**
 * Created by GangdiHuang on 5/13/17.
 *
 * Edited by Jiaqi Zhang
 * Edited by Yanda Wu
 */

@Controller
public class CoursePageController {

    @RequestMapping("/course_page")
    public String coursePage() {
        return "courseInfo";
    }



    @RequestMapping(value = "/createCourse1")
    public ModelAndView createCourse1(@RequestParam(value = "userEmail") String userEmail,
                                      @RequestParam(value = "courseTitle") String courseTitle,
                                      @RequestParam(value = "instructor") String instructor,
                                      @RequestParam(value = "description") String description,
                                      @RequestParam(value = "status") String status,
                                      @RequestParam(value = "accessCode") String accessCode) {

        String id = new ObjectifyFactory().allocateId(Course.class).getString();
        Course newCourse = new Course(userEmail, id, courseTitle, instructor, description, status);

        if ((accessCode != null))
            newCourse.setAccessCode(accessCode);



        return new ModelAndView("editCourse", "course", newCourse);
    }



    @RequestMapping("/enterCourse")
    public ModelAndView enterCourse(@RequestParam(value = "courseId") String courseId) {
        Course c = ofy().load().type(Course.class).id(courseId).now();
        List<Lesson> lessonList = ofy().load().type(Lesson.class).filter("courseId", courseId).order("dateCreated").list();

        ModelAndView mav = new ModelAndView("courseInfo");
        mav.addObject("course", c);
        mav.addObject("lessons", lessonList);

        return mav;
    }



    @RequestMapping(value = "/editCourse")
    public ModelAndView editCourse(@RequestParam(value = "userEmail", required = false) String userEmail,
                                   @RequestParam(value = "courseId") String courseId,
                                   @RequestParam(value = "numEnrolled", required = false) Integer numEnrolled,
                                   @RequestParam(value = "courseTitle", required = false) String courseTitle,
                                   @RequestParam(value = "instructor", required = false) String instructor,
                                   @RequestParam(value = "description", required = false) String description,
                                   @RequestParam(value = "status", required = false) String status,
                                   @RequestParam(value = "accessCode", required = false) String accessCode) {
        Course c = ofy().load().type(Course.class).id(courseId).now();
        if (c == null){
            c = new Course(userEmail, courseId, courseTitle, instructor,description, status);
            c.setAccessCode(accessCode);
            c.setNumEnrolled(numEnrolled);
        }
        List<Lesson> lessonList = ofy().load().type(Lesson.class).filter("courseId", courseId).order("dateCreated").list();
        ModelAndView mav = new ModelAndView("editCourse");
        mav.addObject("course", c);
        mav.addObject("lessonList", lessonList);
        return mav;
    }

    /* courseContent Page */
    @RequestMapping("/courseContent")
    public ModelAndView courseContent(@RequestParam(value = "lessonId", required = false) String lessonId,
                                      @RequestParam(value = "userEmail", required = false) String userEmail,
                                      @RequestParam(value = "courseId") String courseId,
                                      @RequestParam(value = "numEnrolled", required = false) Integer numEnrolled,
                                      @RequestParam(value = "courseTitle", required = false) String courseTitle,
                                      @RequestParam(value = "instructor", required = false) String instructor,
                                      @RequestParam(value = "description", required = false) String description,
                                      @RequestParam(value = "status", required = false) String status,
                                      @RequestParam(value = "accessCode", required = false) String accessCode,
                                      @RequestParam(value = "originalPlace", required = false) String originalPlace) {//indicate where to go back

        Lesson lesson = ofy().load().type(Lesson.class).id(lessonId).now();
        Course course = ofy().load().type(Course.class).id(courseId).now();
        if (course == null){
            course = new Course(userEmail, courseId, courseTitle, instructor,description, status);
            course.setAccessCode(accessCode);
            course.setNumEnrolled(numEnrolled);
        }
        ModelAndView mav = new ModelAndView();

        mav.addObject("lesson", lesson);
        mav.addObject("course", course);//needed when go back to editCourse Page
        mav.addObject("originalPlace",originalPlace);//indicate where to go back
        mav.setViewName("courseContent");
        return mav;
    }



}
