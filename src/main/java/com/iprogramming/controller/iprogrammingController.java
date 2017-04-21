package com.iprogramming.controller;

import Beans.Users;

import com.google.appengine.api.blobstore.*;
import com.google.appengine.api.images.*;
import static com.googlecode.objectify.ObjectifyService.ofy;

import java.nio.ByteBuffer;
import java.security.KeyFactory;
import java.util.*;

import Beans.Course;
import com.googlecode.objectify.Key;
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

            ofy().save().entity(newCourse).now();
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

        ofy().save().entity(newCourse).now();


        return new ModelAndView("editCourse", "model", newCourse);
    }
    
    @RequestMapping("/logout")
	public String logout(HttpSession session){
		session.invalidate();
		return "home";
	}


    /* UPLOAD CONTROLLERS */
    Map<String, String> model = new HashMap<String, String>();
    /*  Upload pages */
    @RequestMapping(value = "/editLessonConfirm")
    public ModelAndView editLessonConfirm(@RequestParam(value = "pptLink") String pptLink,
                                      @RequestParam(value = "docLink") String docLink) {
//        System.out.println("In controller, pptLink: " + pptLink);
//        System.out.println("In controller, docLink: " + docLink);
        model.put("pptLink", pptLink);
        model.put("docLink", docLink);
//        Course newCourse = new Course(userEmail, courseId, courseTitle, instructor, description, status);
//        ObjectifyService.ofy().save().entity(newCourse).now();
    return new ModelAndView("courseContent", "model", model);
}
    @RequestMapping("/courseContent")
    public ModelAndView courseContent(){
        return new ModelAndView("courseContent","model",model);
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
    @RequestMapping(value = "/serve")
    public void see(HttpServletResponse res, @RequestParam(value = "key") String key) throws IOException {
        System.out.println("Serving:" + key);
        //BlobKey bk = new BlobKey("encoded_gs_key:L2dzL2ktcHJvZ3JhbW1pbmcuYXBwc3BvdC5jb20vazc4UkZJeVdjQXotU0RRRDB1M1JqUQ");
        BlobKey bk = new BlobKey(key);
        blobstoreService.serve(bk, res);
    }

    @RequestMapping(value = "/uploadAssignment")
    public String hold(HttpServletRequest req) throws IOException {
        Map<String,List<FileInfo>> finfos = blobstoreService.getFileInfos(req);
        String gcsFileName = finfos.get("myFileAssignment").get(0).getGsObjectName();
        BlobKey blobKeys = blobstoreService.createGsBlobKey(gcsFileName);

        if (blobKeys == null) {
            System.out.println("uploadAssignment error");
        } else {
            //String blob = blobKeys.get(0).getKeyString();                                         Bulk upload
            String blob = blobKeys.getKeyString();
            model.put("blobKeyA", blob);
        }
        return "editLesson";
    }

    @RequestMapping(value = "/uploadImage")
    public String door(HttpServletRequest req) throws IOException {
        Map<String,List<FileInfo>> finfos = blobstoreService.getFileInfos(req);
        String gcsFileName = finfos.get("myFileImage").get(0).getGsObjectName();
        BlobKey blobKeys = blobstoreService.createGsBlobKey(gcsFileName);

        if (blobKeys == null) {
            System.out.println("uploadImage error");
        } else {
            //String blob = blobKeys.get(0).getKeyString();                                         Bulk upload
            String blob = blobKeys.getKeyString();
            model.put("blobKeyI", blob);
        }
        return "editLesson";
    }

    @RequestMapping(value = "/uploadVideo")
    public String holdDoor(HttpServletRequest req) throws IOException {
        Map<String,List<FileInfo>> finfos = blobstoreService.getFileInfos(req);
        String gcsFileName = finfos.get("myFileVideo").get(0).getGsObjectName();
        BlobKey blobKeys = blobstoreService.createGsBlobKey(gcsFileName);

        if (blobKeys == null) {
            System.out.println("uploadVideo error");
        } else {
            //String blob = blobKeys.get(0).getKeyString();                                         Bulk upload
            String blob = blobKeys.getKeyString();
            model.put("blobKeyV", blob);
        }
        return "editLesson";
    }
/* test functions between index.jsp and HelloWorld */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public ModelAndView helloWorld(HttpServletRequest req) throws IOException {
        System.out.println("req:" + req);
//        Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);                          Bulk upload
//        List<BlobKey> blobKeys = blobs.get("myFile");                                                 Bulk upload
        Map<String,List<FileInfo>> finfos = blobstoreService.getFileInfos(req);
        String gcsFileName = finfos.get("myFile").get(0).getGsObjectName();
        System.out.println("gcs:"+ gcsFileName);
        BlobKey blobKeys = blobstoreService.createGsBlobKey(gcsFileName);

        BlobInfoFactory blobInfoFactory = new BlobInfoFactory();
        BlobInfo blobInfo = blobInfoFactory.loadBlobInfo(blobKeys);
        System.out.println("fileName:"+ blobInfo.getFilename());
        System.out.println("Creation:"+ blobInfo.getCreation());
        System.out.println("getContentType:"+ blobInfo.getContentType());

        if (blobKeys == null) {
            String message = "EMPTY/NULL";
            return new ModelAndView("home", "message", message);
        } else {
            //String blob = blobKeys.get(0).getKeyString();                                         Bulk upload
            String blob = blobKeys.getKeyString();
            System.out.println("blob:" + blob);
            ImagesService services = ImagesServiceFactory.getImagesService();
            // Make an image from a Cloud Storage object, and transform it.
            Image blobImage = ImagesServiceFactory.makeImageFromBlob(blobKeys);
            Transform resize = ImagesServiceFactory.makeResize(50,50);
            Image resizedImage = services.applyTransform(resize, blobImage);
            // Write the transformed image back to a Cloud Storage object.
            gcsService.createOrReplace(
                    new GcsFilename("i-programming.appspot.com", "resizedImage.jpeg"),
                    new GcsFileOptions.Builder().mimeType("image/jpeg").build(),
                    ByteBuffer.wrap(resizedImage.getImageData()));
            //ServingUrlOptions serve = ServingUrlOptions.Builder.withBlobKey(blobKeys.get(0));     Bulk upload
            ServingUrlOptions serve = ServingUrlOptions.Builder.withGoogleStorageFileName("/gs/i-programming.appspot.com/resizedImage.jpeg");
            String url = services.getServingUrl(serve);
            //String url = "empty url";
            System.out.println("url:" + url);

            model.put("url", url);
            model.put("blobKey", blob);
            return new ModelAndView("HelloWorld", "model", model);
        }
    }
}