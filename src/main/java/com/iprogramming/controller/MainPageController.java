package com.iprogramming.controller;

import Beans.Course;
import Beans.Lesson;
import Beans.User;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.PostConstruct;
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
public class MainPageController {

    /* lecture upload/serve section, use Blobstore, Cloud Storage */
    /* all blobs need this */
    private BlobstoreService blobstoreService;

    @PostConstruct
    public void init(){
        blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

    }

    @RequestMapping("/main")
    public ModelAndView main(HttpSession session, HttpServletRequest request) {
        //Get and set user
        if (session.getAttribute("user") == null) {
            session.setAttribute("user", request.getParameter("userEmail"));
        }
        String user = (String) session.getAttribute("user");
        User existUser = ofy().load().type(User.class).id(user).now();
        if (existUser == null) {
            existUser = new User(user);
            ofy().save().entity(existUser).now();
        }
        if (existUser.getJoinedCourse() == null) {
            System.out.println("this is null");
        }
        session.setAttribute("userObject", existUser);

        //Retrieve lists of courses to display on the page
        List<Course> createdCourses, topCourses;
        createdCourses = ofy().load().type(Course.class).filter("email", user).order("-dateCreated").list();
        topCourses = ofy().load().type(Course.class).order("-numEnrolled").limit(5).list();

        List<Course> joinedCourses = new ArrayList<Course>();
        if (existUser.getJoinedCourse() != null) {
            Course c;
            for (String s : existUser.getJoinedCourse()) {
                c = ofy().load().type(Course.class).id(s).now();
                if (c != null)
                    joinedCourses.add(c);
            }
        }

        ModelAndView mav = new ModelAndView("main");

        mav.addObject("createdCourses", createdCourses);
        mav.addObject("topCourses", topCourses);
        mav.addObject("joinedCourses", joinedCourses);

        return mav;
    }

    @RequestMapping("/createCourse")
    public String createCourse() {
        return "createCourse_edit";
    }

    @RequestMapping("/deleteCourse")
    public ModelAndView deleteCourse(HttpSession session, HttpServletRequest request,
                                     @RequestParam(value = "courseId") String courseId) {
        //Delete the reference in every user's joinedCourse List
        List<User> users = ofy().load().type(User.class).list();
        for (User u : users) {
            Boolean b = u.getJoinedCourse().remove(courseId);
        }
        ofy().save().entities(users).now();

        //Delete the lessons belong to this course
        List<Lesson> lessons = ofy().load().type(Lesson.class).filter("courseId", courseId).list();
        for (Lesson l: lessons) {
            deleteLesson(l.getLessonId(),null,null, 0,null,null,null,null,null);
        }

        //Delete the course Entity
        ofy().delete().type(Course.class).id(courseId).now();
        return main(session, request);
    }

    @RequestMapping("/deleteLesson")
    public ModelAndView deleteLesson(@RequestParam(value = "lessonId", required = false) String lessonId,
                                     @RequestParam(value = "userEmail") String userEmail,
                                     @RequestParam(value = "courseId") String courseId,
                                     @RequestParam(value = "numEnrolled") int numEnrolled,
                                     @RequestParam(value = "courseTitle") String courseTitle,
                                     @RequestParam(value = "instructor") String instructor,
                                     @RequestParam(value = "description") String description,
                                     @RequestParam(value = "status") String status,
                                     @RequestParam(value = "accessCode", required = false) String accessCode) {
        /* load the to-be-deleted lesson from datastore to get the VideoBlobKeysList and AssignmentBlobKeysList */
        Lesson lesson = ofy().load().type(Lesson.class).id(lessonId).now();
        /* delete all videos in that lesson from blobstore */
        if(lesson.getVideoBlobKeysList() != null){
            for (String videoBlobKey : lesson.getVideoBlobKeysList()) {
                BlobKey blobKey = new BlobKey(videoBlobKey);
                blobstoreService.delete(blobKey);
            }
        }
        /* delete all images in that lesson from blobstore */
        if(lesson.getImageBlobKeysList() != null){
            for (String imageBlobKey : lesson.getImageBlobKeysList()) {
                BlobKey blobKey = new BlobKey(imageBlobKey);
                blobstoreService.delete(blobKey);
            }
        }
        /* delete all assignments in that lesson from blobstore */
        if(lesson.getAssignmentBlobKeysList() != null){
            for (String assignmentBlobKey : lesson.getAssignmentBlobKeysList()) {
                BlobKey blobKey = new BlobKey(assignmentBlobKey);
                blobstoreService.delete(blobKey);
            }
        }
        /* now delete the lesson from datastore */
        ofy().delete().type(Lesson.class).id(lessonId).now();

        /* not saving it until user click save in editCourse page */
        String lessonOrder = null;
        Course course = new Course(userEmail, courseId, courseTitle, instructor, description, status,lessonOrder);
        course.setNumEnrolled(numEnrolled);
        course.setAccessCode(accessCode);

        ModelAndView mav = new ModelAndView("editCourse");
        List<Lesson> lessonList = ofy().load().type(Lesson.class).filter("courseId", courseId).order("dateCreated").list();
        mav.addObject("lessonList", lessonList);
        mav.addObject("course", course);

        return mav;
    }


    @RequestMapping(value = "/enrollCourse")
    public ModelAndView enrollCourse(HttpSession session, HttpServletRequest request,
                                     @RequestParam(value = "courseId") String courseId,
                                     @RequestParam(value = "userEmail") String userEmail) {

        Course course = ofy().load().type(Course.class).id(courseId).now();
        User existUser = ofy().load().type(User.class).id(userEmail).now();
        if (existUser.getJoinedCourse() == null) {
            List<String> newCreatedCourse = new ArrayList<String>();
            newCreatedCourse.add(course.getId());
            course.increEnroll();
            existUser.setJoinedCourse(newCreatedCourse);
        } else if (!(existUser.getJoinedCourse()).contains(course.getId())) {
            existUser.getJoinedCourse().add(course.getId());
            course.increEnroll();
        }

        ofy().save().entity(course).now();
        ofy().save().entity(existUser).now();
        return main(session, request);
    }

    @RequestMapping("/dropCourse")
    public ModelAndView dropCourse(HttpSession session, HttpServletRequest request,
                                   @RequestParam(value = "courseId") String courseId,
                                   @RequestParam(value = "userEmail") String userEmail) {
        Course course = ofy().load().type(Course.class).id(courseId).now();
        User user = ofy().load().type(User.class).id(userEmail).now();

        if (user.getJoinedCourse().contains(course.getId())) {
            user.dropJoinedCourse(course);
            course.decreEnroll();
        }

        ofy().save().entity(course).now();
        ofy().save().entity(user).now();
        return main(session, request);
    }


    @RequestMapping(value = "/saveCourse")
    public ModelAndView saveCourse(HttpSession session, HttpServletRequest request,
                                   @RequestParam(value = "userEmail") String userEmail,
                                   @RequestParam(value = "courseId") String courseId,
                                   @RequestParam(value = "numEnrolled") int numEnrolled,
                                   @RequestParam(value = "courseTitle") String courseTitle,
                                   @RequestParam(value = "instructor") String instructor,
                                   @RequestParam(value = "description") String description,
                                   @RequestParam(value = "status") String status,
                                   @RequestParam(value = "accessCode", required = false) String accessCode,
                                   @RequestParam(value = "lessonOrder") String lessonOrder) {

        //System.out.println("From javascript: " + lessonOrder);

        Course newCourse = new Course(userEmail, courseId, courseTitle, instructor, description, status, lessonOrder);
        newCourse.setAccessCode(accessCode);
        newCourse.setNumEnrolled(numEnrolled);
        ofy().save().entity(newCourse).now();
        return main(session, request);
    }

}
