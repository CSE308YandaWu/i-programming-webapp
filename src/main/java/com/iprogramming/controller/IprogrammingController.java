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
public class IprogrammingController {

    @RequestMapping("/")
    public String home() {
        return "home";
    }

	@RequestMapping("/main")
	public String main(){return "main";}

	@RequestMapping("/createCourse")
	public String createCourse(){return "createCourse_edit";}

	@RequestMapping("/editCourse")
	public ModelAndView editCourse(@RequestParam(value = "courseId") String courseId){
	    Course c = ofy().load().type(Course.class).id(courseId).now();
	    return new ModelAndView("editCourse", "model", c);
	}

    @RequestMapping("/deleteCourse")
    public String deleteCourse(@RequestParam(value = "courseId") String courseId) {
        ofy().delete().type(Course.class).id(courseId).now();
        return "main";
    }

	@RequestMapping("/editUnit")
	public String edit_unit(){return "editUnit";}

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

        ofy().save().entity(newCourse).now();


        return new ModelAndView("editCourse", "model", newCourse);
    }

    @RequestMapping(value = "/enrollCourse")
    public ModelAndView enrollCourse(@RequestParam(value = "courseId") String courseId,
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
//        if(existUser.getJoinedCourse() == null){
//            System.out.print("heheheheh!");
//            List<Course> newCreatedCourse = new ArrayList<Course> ();
//            newCreatedCourse.add(course);
//            existUser.setJoinedCourse(newCreatedCourse);
//            System.out.println(existUser.getJoinedCourse().size());
//
//
//        }
//        if(!(existUser.getJoinedCourse()).contains(course)) {
//            System.out.println("I don't know!");
//            existUser.getJoinedCourse().add(course);
//        }
//        ofy().save().entity(existUser).now();
//        System.out.println(existUser.getJoinedCourse().size());
        return new ModelAndView("main", "model", null);
    }

    @RequestMapping("/enterCourse")
    public ModelAndView enterCourse(@RequestParam(value = "courseId") String courseId) {
        Course c = ofy().load().type(Course.class).id(courseId).now();
        List<Lesson> lessons = ofy().load().type(Lesson.class).ancestor(c).order("-dateCreated").list();

        ModelAndView mav = new ModelAndView("courseInfo");
        mav.addObject("course", c);
        mav.addObject("lessons", lessons);

        return mav;
    }

    @RequestMapping("/dropCourse")
    public String dropCourse(@RequestParam(value = "courseId") String courseId,
                             @RequestParam(value = "userEmail") String userEmail) {
        Course course = ofy().load().type(Course.class).id(courseId).now();
        User user = ofy().load().type(User.class).id(userEmail).now();

        if (user.getJoinedCourse().contains(course.getId())) {
            user.dropJoinedCourse(course);
            course.decreEnroll();
        }

        ofy().save().entity(course).now();
        ofy().save().entity(user).now();
        return "main";
    }

    @RequestMapping("/logout")
	public String logout(HttpSession session){
		session.invalidate();
		return "home";
	}

    @RequestMapping("/editLesson")
    public ModelAndView editLesson(@RequestParam(value = "userEmail") String userEmail,
                                   @RequestParam(value = "courseId") String courseId,
                                   @RequestParam(value = "courseTitle") String courseTitle,
                                   @RequestParam(value = "instructor") String instructor,
                                   @RequestParam(value = "description") String description,
                                   @RequestParam(value = "status") String status,
                                   @RequestParam(value = "accessCode",required = false) String accessCode) {
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
        mav.addObject("courseTitle", courseTitle);
        mav.addObject("instructor", instructor);
        mav.addObject("description", description);
        mav.addObject("status", status);
        if(accessCode!=null){
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
                                          @RequestParam(value = "courseTitle") String courseTitle,
                                          @RequestParam(value = "instructor") String instructor,
                                          @RequestParam(value = "description") String description,
                                          @RequestParam(value = "status") String status,
                                          @RequestParam(value = "accessCode",required = false) String accessCode) throws IOException {
        System.out.println("userEmail: " + userEmail);
        System.out.println("courseId: " + courseId);
        System.out.println("courseTitle: " + courseTitle);
        System.out.println("instructor: " + instructor);
        System.out.println("description: " + description);
        System.out.println("status: " + status);
        System.out.println("accessCode: " + accessCode);

        ModelAndView mav = new ModelAndView();
        mav.addObject("lessonTitle", lessonTitle);
        mav.addObject("lessonBody", lessonBody);
        mav.addObject("pptLink", pptLink);
        mav.addObject("pptDescription", pptDescription);
        mav.addObject("videoLinks", videoLinks);
        mav.addObject("videoDescriptions", videoDescriptions);
        mav.addObject("imageDescriptions", imageDescriptions);


        mav.addObject("assignmentDescriptions",assignmentDescriptions);
//        Course newCourse = new Course(userEmail, courseId, courseTitle, instructor, description, status);
//        ObjectifyService.ofy().save().entity(newCourse).now();
        /* get the uploaded video files */
        Map<String,List<FileInfo>> finfos = blobstoreService.getFileInfos(req);

        /* save uploaded video files to blob store */
        if(finfos.get("myFileVideo[]") != null){//if user uploaded video files
            List<String> videoBlobKeysList = new ArrayList<String>();//video BlobKeys List that saves the video blobkeys
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
            mav.addObject("videoBlobKeysList",videoBlobKeysList);
        }
        /* save uploaded assignment files to blob store */
        if(finfos.get("myFileAssignment[]") != null){
            List<String> assignmentBlobKeysList = new ArrayList<String>();
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
            mav.addObject("assignmentBlobKeysList",assignmentBlobKeysList);
        }
        /* save uploaded image files to blob store, and get the serving url */
        if(finfos.get("myFileImage[]") != null){
            List<String> imageServingUrlList = new ArrayList<String>();
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
                            new GcsFilename("i-programming.appspot.com", "resizedImage"+i+".jpeg"),
                            new GcsFileOptions.Builder().mimeType("image/jpeg").build(),
                            ByteBuffer.wrap(resizedImage.getImageData()));
                    //ServingUrlOptions serve = ServingUrlOptions.Builder.withBlobKey(blobKeys.get(0));     Bulk upload
                    ServingUrlOptions serve = ServingUrlOptions.Builder.withGoogleStorageFileName("/gs/i-programming.appspot.com/resizedImage"+i+".jpeg");
                    String url = services.getServingUrl(serve);
                    imageServingUrlList.add(url);
                }
            }
            mav.addObject("imageServingUrlList",imageServingUrlList);
        }
        /* redirect to courseContent Page */
        mav.setViewName("courseContent");
        return mav;
    }

    /* courseContent Page */
    @RequestMapping("/courseContent")
    public ModelAndView courseContent(){
//        return new ModelAndView("courseContent","model",model);
        return new ModelAndView("courseContent");
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