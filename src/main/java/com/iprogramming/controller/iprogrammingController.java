package com.iprogramming.controller;

import Beans.Lesson;
import com.google.appengine.api.blobstore.*;
import com.google.appengine.api.images.*;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.nio.ByteBuffer;
import java.security.KeyFactory;
import java.util.*;

import Beans.Course;
import Beans.User;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;


import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobInfoFactory;

/* GCS import */
//[START gcs_imports]
import com.google.appengine.tools.cloudstorage.GcsFileOptions;
import com.google.appengine.tools.cloudstorage.GcsFilename;
import com.google.appengine.tools.cloudstorage.GcsInputChannel;
import com.google.appengine.tools.cloudstorage.GcsOutputChannel;
import com.google.appengine.tools.cloudstorage.GcsService;
import com.google.appengine.tools.cloudstorage.GcsServiceFactory;
import com.google.appengine.tools.cloudstorage.RetryParams;
//[END gcs_imports]
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.channels.Channels;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class iprogrammingController {

    @RequestMapping("/")
    public String home() {
        return "home";
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

	/*-----------Test controller--------------*/
//    @RequestMapping("/backToEditCourse")
//    public ModelAndView backToEditCourse(ModelAndView mav){
//        Course c = new Course();
//        mav.addObject("course",c);
//        mav.setViewName("editCourse");
//	    return mav;
//    }
    /*-----------End Test controller----------*/

    @RequestMapping("/deleteCourse")
    public ModelAndView deleteCourse(HttpSession session, HttpServletRequest request,
                                     @RequestParam(value = "courseId") String courseId) {
        ofy().delete().type(Course.class).id(courseId).now();
        return main(session, request);
    }

    @RequestMapping("/editUnit")
    public String edit_unit() {
        return "editUnit";
    }

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

    @RequestMapping("/course_page")
    public String coursePage() {
        return "courseInfo";
    }

    /* test pages */
    @RequestMapping("/hello")
    public String hello() {
        return "HelloWorld";
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

        //ofy().save().entity(newCourse).now();

        return new ModelAndView("editCourse", "course", newCourse);
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

    @RequestMapping("/enterCourse")
    public ModelAndView enterCourse(@RequestParam(value = "courseId") String courseId) {
        Course c = ofy().load().type(Course.class).id(courseId).now();
        List<Lesson> lessonList = ofy().load().type(Lesson.class).filter("courseId", courseId).order("dateCreated").list();

        ModelAndView mav = new ModelAndView("courseInfo");
        mav.addObject("course", c);
        mav.addObject("lessons", lessonList);

        return mav;
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


    @RequestMapping("/editCourse")
    public ModelAndView editCourse(@RequestParam(value = "courseId") String courseId) {
        Course c = ofy().load().type(Course.class).id(courseId).now();
        List<Lesson> lessonList = ofy().load().type(Lesson.class).filter("courseId", courseId).order("dateCreated").list();
        ModelAndView mav = new ModelAndView("editCourse");
        mav.addObject("course", c);
        mav.addObject("lessonList",lessonList);
        return mav;
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
                                   @RequestParam(value = "accessCode", required = false) String accessCode) {

        Course newCourse = new Course(userEmail, courseId, courseTitle, instructor, description, status);
        newCourse.setAccessCode(accessCode);
        newCourse.setNumEnrolled(numEnrolled);
        ofy().save().entity(newCourse).now();
        return main(session, request);
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "home";
    }

    @RequestMapping("/editLesson")
    public ModelAndView editLesson(@RequestParam(value = "userEmail") String userEmail,
                                   @RequestParam(value = "courseId") String courseId,
                                   @RequestParam(value = "numEnrolled") int numEnrolled,
                                   @RequestParam(value = "courseTitle") String courseTitle,
                                   @RequestParam(value = "instructor") String instructor,
                                   @RequestParam(value = "description") String description,
                                   @RequestParam(value = "status") String status,
                                   @RequestParam(value = "accessCode", required = false) String accessCode) {
//	    System.out.println("userEmail: " + userEmail);
//        System.out.println("courseId: " + courseId);
//        System.out.println("courseTitle: " + courseTitle);
//        System.out.println("instructor: " + instructor);
//        System.out.println("description: " + description);
//        System.out.println("status: " + status);
//        System.out.println("accessCode: " + accessCode);
        ModelAndView mav = new ModelAndView();
        /* create uploadUrl for upload form */
        BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
        UploadOptions uploadOptions = UploadOptions.Builder.withGoogleStorageBucketName("i-programming.appspot.com");
        String uploadUrl = blobstoreService.createUploadUrl("/editLessonConfirm", uploadOptions);
        mav.addObject("uploadUrl", uploadUrl);
        /* pass the course info to editLesson.jsp */
        mav.addObject("userEmail", userEmail);
        mav.addObject("courseId", courseId);
        mav.addObject("numEnrolled", numEnrolled);
        mav.addObject("courseTitle", courseTitle);
        mav.addObject("instructor", instructor);
        mav.addObject("description", description);
        mav.addObject("status", status);
        if (accessCode != null) {
            mav.addObject("accessCode", accessCode);
        }
        mav.setViewName("editLesson");
        return mav;
    }

    /* Blobstore, upload/serve slides/video/image/pdf controllers */
    /* When confirm button is clicked in editLesson Page */
    @RequestMapping(value = "/editLessonConfirm")
    public ModelAndView editLessonConfirm(@RequestParam(value = "lessonTitle", required = false) String lessonTitle,
                                          @RequestParam(value = "lessonBody", required = false) String lessonBody,
                                          @RequestParam(value = "pptLink", required = false) String pptLink,
                                          @RequestParam(value = "pptDescription", required = false) String pptDescription,
                                          @RequestParam(value = "videoLinks[]", required = false) List<String> videoLinks,
                                          @RequestParam(value = "videoDescriptions[]", required = false) List<String> videoDescriptions,
                                          @RequestParam(value = "imageDescriptions[]", required = false) List<String> imageDescriptions,
                                          @RequestParam(value = "assignmentDescriptions[]", required = false) List<String> assignmentDescriptions,
                                          HttpServletRequest req,
                                          @RequestParam(value = "userEmail") String userEmail,
                                          @RequestParam(value = "courseId") String courseId,
                                          @RequestParam(value = "numEnrolled") int numEnrolled,
                                          @RequestParam(value = "courseTitle") String courseTitle,
                                          @RequestParam(value = "instructor") String instructor,
                                          @RequestParam(value = "description") String description,
                                          @RequestParam(value = "status") String status,
                                          @RequestParam(value = "accessCode", required = false) String accessCode) throws IOException {
//        System.out.println("userEmail: " + userEmail);
//        System.out.println("courseId: " + courseId);
//        System.out.println("courseTitle: " + courseTitle);
//        System.out.println("instructor: " + instructor);
//        System.out.println("description: " + description);
//        System.out.println("status: " + status);
//        System.out.println("accessCode: " + accessCode);

        Course course = new Course(userEmail, courseId, courseTitle, instructor, description, status);
        course.setAccessCode(accessCode);
        course.setNumEnrolled(numEnrolled);

//        ModelAndView mav = new ModelAndView();
//        mav.addObject("lessonTitle", lessonTitle);
//        mav.addObject("lessonBody", lessonBody);
//        mav.addObject("pptLink", pptLink);
//        mav.addObject("pptDescription", pptDescription);
//        mav.addObject("videoLinks", videoLinks);
//        mav.addObject("videoDescriptions", videoDescriptions);
//        mav.addObject("imageDescriptions", imageDescriptions);
//        mav.addObject("assignmentDescriptions",assignmentDescriptions);

        /* get the uploaded video files */
        Map<String, List<FileInfo>> finfos = blobstoreService.getFileInfos(req);

        /* save uploaded video files to blob store */
        List<String> videoBlobKeysList = new ArrayList<String>();//video BlobKeys List that saves the video blobkeys
        if (finfos.get("myFileVideo[]") != null) {//if user uploaded video files
            for (int i = 0; i < finfos.get("myFileVideo[]").size(); i++) {
                String gcsVideoFileName = finfos.get("myFileVideo[]").get(i).getGsObjectName();
                BlobKey videoBlobKey = blobstoreService.createGsBlobKey(gcsVideoFileName);
                if (videoBlobKey == null) {
                    System.out.println("uploadVideo error");
                } else {
                    String blob = videoBlobKey.getKeyString();
                    videoBlobKeysList.add(blob);
                    System.out.println("VIDEO KEY: " + blob);
                }
            }
            //mav.addObject("videoBlobKeysList",videoBlobKeysList);
        }
        /* save uploaded image files to blob store, and get the serving url */
        List<String> imageServingUrlList = new ArrayList<String>();
        if (finfos.get("myFileImage[]") != null) {
            for (int i = 0; i < finfos.get("myFileImage[]").size(); i++) {
                String gcsImageFileName = finfos.get("myFileImage[]").get(i).getGsObjectName();
                BlobKey imageBlobKey = blobstoreService.createGsBlobKey(gcsImageFileName);
                if (imageBlobKey == null) {
                    System.out.println("uploadImage error");
                } else {
                    //String blob = imageBlobKey.getKeyString();
                    ImagesService services = ImagesServiceFactory.getImagesService();
                    // Make an image from a Cloud Storage object, and transform it.
                    Image blobImage = ImagesServiceFactory.makeImageFromBlob(imageBlobKey);
                    Transform resize = ImagesServiceFactory.makeResize(100, 100);
                    Image resizedImage = services.applyTransform(resize, blobImage);
                    // Write the transformed image back to a Cloud Storage object.
                    gcsService.createOrReplace(
                            new GcsFilename("i-programming.appspot.com", "resizedImage" + i + ".jpeg"),
                            new GcsFileOptions.Builder().mimeType("image/jpeg").build(),
                            ByteBuffer.wrap(resizedImage.getImageData()));
                    //ServingUrlOptions serve = ServingUrlOptions.Builder.withBlobKey(blobKeys.get(0));     Bulk upload
                    ServingUrlOptions serve = ServingUrlOptions.Builder.withGoogleStorageFileName("/gs/i-programming.appspot.com/resizedImage" + i + ".jpeg");
                    String url = services.getServingUrl(serve);
                    imageServingUrlList.add(url);
                }
            }
            //mav.addObject("imageServingUrlList",imageServingUrlList);
        }
        /* save uploaded assignment files to blob store */
        List<String> assignmentBlobKeysList = new ArrayList<String>();
        if (finfos.get("myFileAssignment[]") != null) {
            for (int i = 0; i < finfos.get("myFileAssignment[]").size(); i++) {
                String gcsAssignmentFileName = finfos.get("myFileAssignment[]").get(i).getGsObjectName();
                BlobKey assignmentBlobKey = blobstoreService.createGsBlobKey(gcsAssignmentFileName);
                if (assignmentBlobKey == null) {
                    System.out.println("uploadAssignment error");
                } else {
                    String blob = assignmentBlobKey.getKeyString();
                    assignmentBlobKeysList.add(blob);
                }
            }
            //mav.addObject("assignmentBlobKeysList",assignmentBlobKeysList);
        }
        String id = new ObjectifyFactory().allocateId(Lesson.class).getString();
        Lesson lesson = new Lesson(courseId, id, lessonTitle, lessonBody, pptLink, pptDescription, videoLinks, videoBlobKeysList, videoDescriptions,
                imageServingUrlList, imageDescriptions, assignmentBlobKeysList, assignmentDescriptions);
        /* save the lesson into datastore  */
        ofy().save().entity(lesson).now();
        /* get lesson list from the datastore */

        List<Lesson> lessonList = ofy().load().type(Lesson.class).filter("courseId", courseId).order("dateCreated").list();
        System.out.println("fk: " + lessonList.size());
        ModelAndView mav = new ModelAndView();
        /* add course object to the model */
        mav.addObject("course", course);
        mav.addObject("lessonList", lessonList);

        /* redirect to courseContent Page */
        mav.setViewName("editCourse");
        return mav;
    }

    /* courseContent Page */
    @RequestMapping("/courseContent")
    public ModelAndView courseContent(@RequestParam(value = "lessonId", required = false) String lessonId) {
        Lesson lesson = ofy().load().type(Lesson.class).id(lessonId).now();
//        if (lesson == null)
//            System.out.println("lesson is null");
//        else
//            System.out.print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~lessonTitle: " + lesson.getLessonTitle());
        ModelAndView mav = new ModelAndView();
        mav.addObject("lesson",lesson);
        mav.setViewName("courseContent");
        return mav;
    }

    /* lecture upload/serve section, use Blobstore, Cloud Storage */
    /* all blobs need this */
    private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    /* image processing */
    private final GcsService gcsService = GcsServiceFactory.createGcsService(new RetryParams.Builder()
            .initialRetryDelayMillis(10)
            .retryMaxAttempts(10)
            .totalRetryPeriodMillis(15000)
            .build());

    /* serve assignment/video/image */
    /* courseContent Page serving(video/pdf/image) function */
    @RequestMapping(value = "/serve")
    public void see(HttpServletResponse res, @RequestParam(value = "key") String key) throws IOException {
        //System.out.println("Serving:" + key);
        //BlobKey bk = new BlobKey("encoded_gs_key:L2dzL2ktcHJvZ3JhbW1pbmcuYXBwc3BvdC5jb20vazc4UkZJeVdjQXotU0RRRDB1M1JqUQ");
//        res.setContentType("application/force-download");
//        res.setHeader("Content-Transfer-Encoding", "binary");
//        String fname = bi.loadBlobInfo(blobKey).getFilename();
//        res.setContentType("application/x-download");
//        res.setHeader("Content-Disposition", "attachment; filename=" + fname);
//        String ss = "wow";
//        res.setHeader("Content-Disposition","attachment; filename="+ss+".jpg");
        //res.setContentType("application/pdf");
        //res.setHeader("Content-Disposition", "attachment;filename=sample.pdf");
        BlobKey bk = new BlobKey(key);
        BlobInfoFactory blobInfoFactory = new BlobInfoFactory();
        BlobInfo blobInfo = blobInfoFactory.loadBlobInfo(bk);
        res.setContentType(blobInfo.getContentType());
        System.out.println(blobInfo.getContentType());
//        res.setHeader("Content-Disposition", "inline;");
        blobstoreService.serve(bk, res);
        //res.sendRedirect("/serve-blob?key=" + bk.getKeyString());
        //System.out.print(res);
    }


//    /* test blobstore functions between index.jsp and HelloWorld */
//    @RequestMapping(value = "/upload", method = RequestMethod.POST)
//    public ModelAndView helloWorld(HttpServletRequest req) throws IOException {
//        System.out.println("req:" + req);
////        Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);                          Bulk upload
////        List<BlobKey> blobKeys = blobs.get("myFile");                                                 Bulk upload
//        Map<String,List<FileInfo>> finfos = blobstoreService.getFileInfos(req);
//        String gcsFileName = finfos.get("myFile").get(0).getGsObjectName();
//        System.out.println("gcs:"+ gcsFileName);
//        BlobKey blobKeys = blobstoreService.createGsBlobKey(gcsFileName);
//
//        BlobInfoFactory blobInfoFactory = new BlobInfoFactory();
//        BlobInfo blobInfo = blobInfoFactory.loadBlobInfo(blobKeys);
//        System.out.println("fileName:"+ blobInfo.getFilename());
//        System.out.println("Creation:"+ blobInfo.getCreation());
//        System.out.println("getContentType:"+ blobInfo.getContentType());
//
//        if (blobKeys == null) {
//            String message = "EMPTY/NULL";
//            return new ModelAndView("home", "message", message);
//        } else {
//            //String blob = blobKeys.get(0).getKeyString();                                         Bulk upload
//            String blob = blobKeys.getKeyString();
//            System.out.println("blob:" + blob);
//            ImagesService services = ImagesServiceFactory.getImagesService();
//            // Make an image from a Cloud Storage object, and transform it.
//            Image blobImage = ImagesServiceFactory.makeImageFromBlob(blobKeys);
//            Transform resize = ImagesServiceFactory.makeResize(50,50);
//            Image resizedImage = services.applyTransform(resize, blobImage);
//            // Write the transformed image back to a Cloud Storage object.
//            gcsService.createOrReplace(
//                    new GcsFilename("i-programming.appspot.com", "resizedImage.jpeg"),
//                    new GcsFileOptions.Builder().mimeType("image/jpeg").build(),
//                    ByteBuffer.wrap(resizedImage.getImageData()));
//            //ServingUrlOptions serve = ServingUrlOptions.Builder.withBlobKey(blobKeys.get(0));     Bulk upload
//            ServingUrlOptions serve = ServingUrlOptions.Builder.withGoogleStorageFileName("/gs/i-programming.appspot.com/resizedImage.jpeg");
//            String url = services.getServingUrl(serve);
//            //String url = "empty url";
//            System.out.println("url:" + url);
//
//            model.put("url", url);
//            model.put("blobKey", blob);
//            return new ModelAndView("HelloWorld", "model", model);
//        }
//    }
}