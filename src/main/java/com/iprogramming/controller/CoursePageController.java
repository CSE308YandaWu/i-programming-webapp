package com.iprogramming.controller;

import Beans.Course;
import Beans.Lesson;
import com.googlecode.objectify.ObjectifyFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Arrays;
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
        /* still creating course, no lesson no order */
        String lessonOrder = null;
        Course newCourse = new Course(userEmail, id, courseTitle, instructor, description, status,lessonOrder);

        if ((accessCode != null))
            newCourse.setAccessCode(accessCode);

        //ofy().save().entity(newCourse).now();

        return new ModelAndView("editCourse", "course", newCourse);
    }

    @RequestMapping("/enterCourse")
    public ModelAndView enterCourse(@RequestParam(value = "courseId") String courseId) {
        Course c = ofy().load().type(Course.class).id(courseId).now();
        List<Lesson> lessonList = ofy().load().type(Lesson.class).filter("courseId", courseId).order("dateCreated").list();

        ModelAndView mav = new ModelAndView("courseInfo");
        /* 1. not (nothing from the editCourse.jsp, empty course) , 2. not (nothing yet from other pages) */
        if( (!c.getLessonOrder().equalsIgnoreCase("[object Object]")) && (c.getLessonOrder() != null)){
            //System.out.println("Then we have something real: "+ c.getLessonOrder());
            List<Lesson> updatedLessonList = new ArrayList<Lesson>();
            List<String> lessonOrderList = new ArrayList<String>(Arrays.asList(c.getLessonOrder().split(",")));
            //System.out.println("Hi "+ lessonOrderList.size());
            //System.out.println("Here comes the real list: "+ lessonOrderList);
            for(int i = 0; i < lessonOrderList.size(); i++){
                updatedLessonList.add(lessonList.get(Integer.parseInt(lessonOrderList.get(i))));
            }
            mav.addObject("course", c);
            mav.addObject("lessons", updatedLessonList);

        }else{/* 1. nothing from the editCourse.jsp, empty course, 2. nothing yet from other pages */
            mav.addObject("course", c);
            mav.addObject("lessons", lessonList);
        }

        return mav;
    }

    @RequestMapping("/editCourse")
    public ModelAndView editCourse(@RequestParam(value = "userEmail", required = false) String userEmail,
                                   @RequestParam(value = "courseId") String courseId,
                                   @RequestParam(value = "numEnrolled", required = false) Integer numEnrolled,
                                   @RequestParam(value = "courseTitle", required = false) String courseTitle,
                                   @RequestParam(value = "instructor", required = false) String instructor,
                                   @RequestParam(value = "description", required = false) String description,
                                   @RequestParam(value = "status", required = false) String status,
                                   @RequestParam(value = "accessCode", required = false) String accessCode) {

        ModelAndView mav = new ModelAndView("editCourse");
        List<Lesson> lessonList = ofy().load().type(Lesson.class).filter("courseId", courseId).order("dateCreated").list();

        Course c = ofy().load().type(Course.class).id(courseId).now();
        if (c == null){
            /* no lesson if no course */
            String lessonOrder = null;
            c = new Course(userEmail, courseId, courseTitle, instructor,description, status,lessonOrder);
            c.setAccessCode(accessCode);
            c.setNumEnrolled(numEnrolled);

            mav.addObject("course", c);
            mav.addObject("lessonList", lessonList);

        }else{
            if( (!c.getLessonOrder().equalsIgnoreCase("[object Object]")) && (c.getLessonOrder() != null)){
                System.out.println("????"+ c.getLessonOrder());
                List<Lesson> updatedLessonList = new ArrayList<Lesson>();
//            System.out.println("Hello " + c.getLessonOrder());
                List<String> lessonOrderList = new ArrayList<String>(Arrays.asList(c.getLessonOrder().split(",")));
//            System.out.println("Hi "+ lessonOrderList.size());
//            System.out.println("what up "+ lessonOrderList);
                for(int i = 0; i < lessonOrderList.size(); i++){
                    int index = Integer.parseInt(lessonOrderList.get(i));
                    updatedLessonList.add(lessonList.get(index));
                }
                mav.addObject("course", c);
                mav.addObject("lessonList", updatedLessonList);

            }else{//no lesson no lesson order(empty class)
                mav.addObject("course", c);
                mav.addObject("lessonList", lessonList);
            }
        }
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
            /* no lesson if no course */
            String lessonOrder = null;
            course = new Course(userEmail, courseId, courseTitle, instructor,description, status, lessonOrder);
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
