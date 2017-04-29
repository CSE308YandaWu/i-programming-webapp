package com.iprogramming.controller;

import Beans.Users;

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

    @RequestMapping(value = "/createCourse1")
    public ModelAndView createCourse1(@RequestParam(value = "userEmail") String userEmail,
                                      @RequestParam(value = "courseTitle") String courseTitle,
                                      @RequestParam(value = "instructor") String instructor,
                                      @RequestParam(value = "description") String description,
                                      @RequestParam(value = "status") String status) {

        String id = new ObjectifyFactory().allocateId(Course.class).getString();
        Course newCourse = new Course(userEmail, id, courseTitle, instructor, description, status);

//        User existUser = ofy().load().type(User.class).id(userEmail).now();
//        if(existUser.getCreatedCourse() == null){
//            List<Course> newCreatedCourse = new ArrayList<Course> ();
//            newCreatedCourse.add(newCourse);
//            existUser.setCreatedCourse(newCreatedCourse);
//        }
//        else existUser.addCreatedCourse(newCourse);
//        ofy().save().entity(existUser).now();

        ofy().save().entity(newCourse).now();


        return new ModelAndView("editCourse", "model", newCourse);
    }
    @RequestMapping(value = "/enrollCourse")
    public ModelAndView enrollCourse(@RequestParam(value = "courseId")String courseId,
                                     @RequestParam(value = "userEmail") String userEmail){

        Course course = ofy().load().type(Course.class).id(courseId).now();
        User existUser = ofy().load().type(User.class).id(userEmail).now();
        if(existUser.getJoinedCourse() == null){
            List<String> newCreatedCourse = new ArrayList<String> ();
            newCreatedCourse.add(course.getId());
            existUser.setJoinedCourse(newCreatedCourse);
        }
        else if(!(existUser.getJoinedCourse()).contains(course.getId())){
            existUser.getJoinedCourse().add(course.getId());
        }
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

    @RequestMapping("/logout")
	public String logout(HttpSession session){
		session.invalidate();
		return "home";
	}

/* Blobstore, upload/serve slides/video/image/pdf controllers */
    Map<String, String> model = new HashMap<String, String>();
    /*  Upload pages */
    /* When confirm button is clicked in editLesson Page */
    @RequestMapping(value = "/editLessonConfirm")
    public ModelAndView editLessonConfirm(@RequestParam(value = "pptLink", required = false) String pptLink,
                                          @RequestParam(value = "videoLink", required = false) String videoLink, HttpServletRequest req) throws IOException {

        model.put("pptLink", pptLink);
        model.put("videoLink",videoLink);
//        Course newCourse = new Course(userEmail, courseId, courseTitle, instructor, description, status);
//        ObjectifyService.ofy().save().entity(newCourse).now();

        Map<String,List<FileInfo>> finfos = blobstoreService.getFileInfos(req);
        String gcsVideoFileName = finfos.get("myFileVideo").get(0).getGsObjectName();
        BlobKey videoBlobKey = blobstoreService.createGsBlobKey(gcsVideoFileName);

        if (videoBlobKey == null) {
            System.out.println("uploadVideo error");
        } else {
            //String blob = blobKeys.get(0).getKeyString();                                         Bulk upload
            String blob = videoBlobKey.getKeyString();
            model.put("blobKeyV", blob);
            System.out.println("VIDEO KEY: " + blob);
        }

        String gcsAssignmentFileName = finfos.get("myFileAssignment").get(0).getGsObjectName();
        BlobKey assignmentBlobKey = blobstoreService.createGsBlobKey(gcsAssignmentFileName);
        String gcsAssignmentFileName1 = finfos.get("myFileAssignment").get(1).getGsObjectName();
        BlobKey assignmentBlobKey1 = blobstoreService.createGsBlobKey(gcsAssignmentFileName1);

        if (assignmentBlobKey == null) {
            System.out.println("uploadAssignment error");
        } else {
            //String blob = blobKeys.get(0).getKeyString();                                         Bulk upload
            String blob = assignmentBlobKey.getKeyString();
            model.put("blobKeyA", blob);
            String blob1 = assignmentBlobKey1.getKeyString();
            model.put("blobKeyA1", blob1);
        }

        String gcsImageFileName = finfos.get("myFileImage").get(0).getGsObjectName();
        BlobKey imageBlobKey = blobstoreService.createGsBlobKey(gcsImageFileName);

        if (imageBlobKey == null) {
            System.out.println("uploadImage error");
        } else {
            //String blob = blobKeys.get(0).getKeyString();                                         Bulk upload
            String blob = imageBlobKey.getKeyString();
            System.out.println("blob:" + blob);
            ImagesService services = ImagesServiceFactory.getImagesService();
            // Make an image from a Cloud Storage object, and transform it.
            Image blobImage = ImagesServiceFactory.makeImageFromBlob(imageBlobKey);
            Transform resize = ImagesServiceFactory.makeResize(100, 100);
            Image resizedImage = services.applyTransform(resize, blobImage);
            // Write the transformed image back to a Cloud Storage object.
            gcsService.createOrReplace(
                    new GcsFilename("i-programming.appspot.com", "resizedImage.jpeg"),
                    new GcsFileOptions.Builder().mimeType("image/jpeg").build(),
                    ByteBuffer.wrap(resizedImage.getImageData()));
            //ServingUrlOptions serve = ServingUrlOptions.Builder.withBlobKey(blobKeys.get(0));     Bulk upload
            ServingUrlOptions serve = ServingUrlOptions.Builder.withGoogleStorageFileName("/gs/i-programming.appspot.com/resizedImage.jpeg");
            String url = services.getServingUrl(serve);
            //System.out.println("url:" + url);
            model.put("url", url);
            model.put("blobKeyI", blob);
        }

    return new ModelAndView("courseContent", "model", model);
    }
    /* courseContent Page */
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

    /* NO MORE */
        /* NO MORE */
            /* NO MORE */
                /* NO MORE */
//    /* courseContent Page upload Assignment mapping */
//    @RequestMapping(value = "/uploadAssignment")
//    public String hold(HttpServletRequest req) throws IOException {
//        Map<String,List<FileInfo>> finfos = blobstoreService.getFileInfos(req);
//        String gcsFileName = finfos.get("myFileAssignment").get(0).getGsObjectName();
//        BlobKey blobKeys = blobstoreService.createGsBlobKey(gcsFileName);
//
//        if (blobKeys == null) {
//            System.out.println("uploadAssignment error");
//        } else {
//            //String blob = blobKeys.get(0).getKeyString();                                         Bulk upload
//            String blob = blobKeys.getKeyString();
//            model.put("blobKeyA", blob);
//        }
//        return "editLesson";
//    }
//    /* courseContent Page upload Image mapping */
//    @RequestMapping(value = "/uploadImage")
//    public String door(HttpServletRequest req) throws IOException {
//        Map<String,List<FileInfo>> finfos = blobstoreService.getFileInfos(req);
//        String gcsFileName = finfos.get("myFileImage").get(0).getGsObjectName();
//        BlobKey blobKeys = blobstoreService.createGsBlobKey(gcsFileName);
//
//        if (blobKeys == null) {
//            System.out.println("uploadImage error");
//        } else {
//            //String blob = blobKeys.get(0).getKeyString();                                         Bulk upload
//            String blob = blobKeys.getKeyString();
//            System.out.println("blob:" + blob);
//            ImagesService services = ImagesServiceFactory.getImagesService();
//            // Make an image from a Cloud Storage object, and transform it.
//            Image blobImage = ImagesServiceFactory.makeImageFromBlob(blobKeys);
//            Transform resize = ImagesServiceFactory.makeResize(100,100);
//            Image resizedImage = services.applyTransform(resize, blobImage);
//            // Write the transformed image back to a Cloud Storage object.
//            gcsService.createOrReplace(
//                    new GcsFilename("i-programming.appspot.com", "resizedImage.jpeg"),
//                    new GcsFileOptions.Builder().mimeType("image/jpeg").build(),
//                    ByteBuffer.wrap(resizedImage.getImageData()));
//            //ServingUrlOptions serve = ServingUrlOptions.Builder.withBlobKey(blobKeys.get(0));     Bulk upload
//            ServingUrlOptions serve = ServingUrlOptions.Builder.withGoogleStorageFileName("/gs/i-programming.appspot.com/resizedImage.jpeg");
//            String url = services.getServingUrl(serve);
//            //System.out.println("url:" + url);
//            model.put("url", url);
//            model.put("blobKeyI", blob);
//        }
//        return "editLesson";
//    }
//
//    /* courseContent Page upload Video mapping */
//    @RequestMapping(value = "/uploadVideo")
//    public String holdDoor(HttpServletRequest req) throws IOException {
//        Map<String,List<FileInfo>> finfos = blobstoreService.getFileInfos(req);
//        String gcsFileName = finfos.get("myFileVideo").get(0).getGsObjectName();
//        BlobKey blobKeys = blobstoreService.createGsBlobKey(gcsFileName);
//
//        if (blobKeys == null) {
//            System.out.println("uploadVideo error");
//        } else {
//            //String blob = blobKeys.get(0).getKeyString();                                         Bulk upload
//            String blob = blobKeys.getKeyString();
//            model.put("blobKeyV", blob);
//        }
//        return "editLesson";
//    }
                /* NO MORE */
            /* NO MORE */
        /* NO MORE */
    /* NO MORE */

    /* test blobstore functions between index.jsp and HelloWorld */
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