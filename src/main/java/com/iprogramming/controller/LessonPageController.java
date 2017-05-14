package com.iprogramming.controller;

import Beans.Lesson;
import com.google.appengine.api.blobstore.*;
import com.google.appengine.api.images.*;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.nio.ByteBuffer;
import java.util.*;

import Beans.Course;
import com.googlecode.objectify.ObjectifyFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.PostConstruct;


import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobInfoFactory;

/* GCS import */
//[START gcs_imports]
import com.google.appengine.tools.cloudstorage.GcsFileOptions;
import com.google.appengine.tools.cloudstorage.GcsFilename;
import com.google.appengine.tools.cloudstorage.GcsService;
import com.google.appengine.tools.cloudstorage.GcsServiceFactory;
import com.google.appengine.tools.cloudstorage.RetryParams;
//[END gcs_imports]
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Jiaqi Zhang
 * Edited by Gangdi Huang
 * Edited by Yanda Wu
 */

@Controller
public class LessonPageController {

    /* lecture upload/serve section, use Blobstore, Cloud Storage */
    /* all blobs need this */
    private BlobstoreService blobstoreService;

    @PostConstruct
    public void init(){
        blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    }
////////////////////////////////////////////////////////////////////////////////////////////////// debugging /////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/editLessonReal")
    public ModelAndView editLessonReal(@RequestParam(value = "lessonId") String lessonId,
                                     @RequestParam(value = "userEmail") String userEmail,
                                     @RequestParam(value = "courseId") String courseId,
                                     @RequestParam(value = "numEnrolled") int numEnrolled,
                                     @RequestParam(value = "courseTitle") String courseTitle,
                                     @RequestParam(value = "instructor") String instructor,
                                     @RequestParam(value = "description") String description,
                                     @RequestParam(value = "status") String status,
                                     @RequestParam(value = "accessCode", required = false) String accessCode) {
        System.out.println("edit LESSON REAL lessonId: " + lessonId);
        System.out.println("edit LESSON REAL userEmail: " + userEmail);
        System.out.println("edit LESSON REAL courseId: " + courseId);
        System.out.println("edit LESSON REAL numEnrolled: " + numEnrolled);
        System.out.println("edit LESSON REAL courseTitle: " + courseTitle);
        System.out.println("edit LESSON REAL instructor: " + instructor);
        System.out.println("edit LESSON REAL description: " + description);
        System.out.println("edit LESSON REAL status: " + status);
        System.out.println("edit LESSON REAL accessCode: " + accessCode);

        ModelAndView mav = new ModelAndView();
        /* create uploadUrl for upload form */
        BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
        UploadOptions uploadOptions = UploadOptions.Builder.withGoogleStorageBucketName("i-programming.appspot.com");
        String uploadUrl = blobstoreService.createUploadUrl("/editLessonRealConfirm", uploadOptions);
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

        mav.addObject("lessonId",lessonId);

        mav.setViewName("editLesson");
        return mav;
    }

    /* Blobstore, upload/serve slides/video/image/pdf controllers */
    /* When confirm button is clicked in editLesson Page */
//    @SuppressWarnings("Duplicates")
    @RequestMapping(value = "/editLessonRealConfirm")
    public ModelAndView editLessonRealConfirm(@RequestParam(value = "lessonTitle", required = false) String lessonTitle,
                                          @RequestParam(value = "lessonBody", required = false) String lessonBody,
                                          @RequestParam(value = "pptLink", required = false) String pptLink,
                                          @RequestParam(value = "pptDescription", required = false) String pptDescription,
                                          @RequestParam(value = "videoLinks[]", required = false) List<String> videoLinks,
                                          @RequestParam(value = "videoDescriptions[]", required = false) List<String> videoDescriptions,
                                          @RequestParam(value = "videoTypes[]", required = false) List<String> videoTypes,
                                          @RequestParam(value = "imageDescriptions[]", required = false) List<String> imageDescriptions,
                                          @RequestParam(value = "assignmentDescriptions[]", required = false) List<String> assignmentDescriptions,
                                          HttpServletRequest req,
                                          @RequestParam(value = "lessonId") String lessonId,
                                          @RequestParam(value = "userEmail") String userEmail,
                                          @RequestParam(value = "courseId") String courseId,
                                          @RequestParam(value = "numEnrolled") int numEnrolled,
                                          @RequestParam(value = "courseTitle") String courseTitle,
                                          @RequestParam(value = "instructor") String instructor,
                                          @RequestParam(value = "description") String description,
                                          @RequestParam(value = "status") String status,
                                          @RequestParam(value = "accessCode", required = false) String accessCode) throws IOException {

        System.out.println("edit LESSON REAL CONFIRM lessonId: " + lessonId);

        /* not saving it until user click save in editCourse page */
        String lessonOrder = null;
        Course course = new Course(userEmail, courseId, courseTitle, instructor, description, status,lessonOrder);
        course.setAccessCode(accessCode);
        course.setNumEnrolled(numEnrolled);

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
//                    System.out.println("editLessonRealConfirm VIDEO KEY: " + blob);
                }
            }
        }
        /* save uploaded image files to blob store, and get the serving url */
        List<String> imageServingUrlList = new ArrayList<String>();
        List<String> imageBlobKeysList = new ArrayList<String>();
        if (finfos.get("myFileImage[]") != null) {
             /* image processing */
            final GcsService gcsService  = GcsServiceFactory.createGcsService(new RetryParams.Builder()
                    .initialRetryDelayMillis(10)
                    .retryMaxAttempts(10)
                    .totalRetryPeriodMillis(15000)
                    .build());

            for (int i = 0; i < finfos.get("myFileImage[]").size(); i++) {
                String gcsImageFileName = finfos.get("myFileImage[]").get(i).getGsObjectName();
                BlobKey imageBlobKey = blobstoreService.createGsBlobKey(gcsImageFileName);
                if (imageBlobKey == null) {
                    //System.out.println("uploadImage error");
                } else {
                    String blob = imageBlobKey.getKeyString();
                    imageBlobKeysList.add(blob);

                    ImagesService services = ImagesServiceFactory.getImagesService();
                    // Make an image from a Cloud Storage object, and transform it.
                    Image blobImage = ImagesServiceFactory.makeImageFromBlob(imageBlobKey);
                    Transform resize = ImagesServiceFactory.makeResize(800, 500);
                    Image resizedImage = services.applyTransform(resize, blobImage);
                    // Write the transformed image back to a Cloud Storage object.
                    gcsService.createOrReplace(
                            new GcsFilename("i-programming.appspot.com", "resizedImage" + i + ".jpeg"),
                            new GcsFileOptions.Builder().mimeType("image/jpeg").build(),
                            ByteBuffer.wrap(resizedImage.getImageData()));
                    ServingUrlOptions serve = ServingUrlOptions.Builder.withGoogleStorageFileName("/gs/i-programming.appspot.com/resizedImage" + i + ".jpeg");
                    String url = services.getServingUrl(serve);
                    imageServingUrlList.add(url);
                }
            }
        }
        /* save uploaded assignment files to blob store */
        List<String> assignmentBlobKeysList = new ArrayList<String>();
        List<String> assignmentFileNameList = new ArrayList<String>();
        if (finfos.get("myFileAssignment[]") != null) {
            for (int i = 0; i < finfos.get("myFileAssignment[]").size(); i++) {
                String gcsAssignmentFileName = finfos.get("myFileAssignment[]").get(i).getGsObjectName();

                BlobKey assignmentBlobKey = blobstoreService.createGsBlobKey(gcsAssignmentFileName);

                if (assignmentBlobKey == null) {
                    System.out.println("uploadAssignment error");
                } else {
                    BlobInfoFactory blobInfoFactory = new BlobInfoFactory();
                    BlobInfo blobInfo = blobInfoFactory.loadBlobInfo(assignmentBlobKey);

                    String blob = assignmentBlobKey.getKeyString();
                    assignmentBlobKeysList.add(blob);
                    assignmentFileNameList.add(blobInfo.getFilename());
                }
            }
            //mav.addObject("assignmentBlobKeysList",assignmentBlobKeysList);
        }

        /* load the to-be-edited lesson from datastore to get the VideoBlobKeysList and AssignmentBlobKeysList */
        Lesson lesson = ofy().load().type(Lesson.class).id(lessonId).now();

        lesson.setLessonTitle(lessonTitle);
        lesson.setLessonBody(lessonBody);
        lesson.setPptLink(pptLink);
        lesson.setPptDescription(pptDescription);
        lesson.setVideoLinks(videoLinks);
        //System.out.println("??????????????"+ lesson.getVideoBlobKeysList());
        lesson.setVideoBlobKeysList(videoBlobKeysList);
        //System.out.println("And ?????????????????????????"+ lesson.getVideoBlobKeysList());
        lesson.setVideoDescriptions(videoDescriptions);
        lesson.setVideoTypes(videoTypes);
        lesson.setImageServingUrlList(imageServingUrlList);
        System.out.println("And ?????????????????????????"+ lesson.getImageServingUrlList());
        lesson.setImageBlobKeysList(imageBlobKeysList);
        lesson.setImageDescriptions(imageDescriptions);
        lesson.setAssignmentBlobKeysList(assignmentBlobKeysList);
        lesson.setAssignmentFileNameList(assignmentFileNameList);
        lesson.setAssignmentDescriptions(assignmentDescriptions);
        System.out.println("editLessonRealConfirm lesson edited");
//        /* now delete the lesson from datastore */
//        ofy().delete().type(Lesson.class).id(lessonId).now();
//        Lesson lesson = new Lesson(courseId, lessonId, lessonTitle, lessonBody, pptLink, pptDescription, videoLinks, videoBlobKeysList, videoDescriptions, videoTypes,
//                imageServingUrlList, imageBlobKeysList, imageDescriptions, assignmentBlobKeysList,assignmentFileNameList, assignmentDescriptions);
        /* save the lesson back into datastore  */
        System.out.println(lesson.getLessonId()+"===========");
        ofy().save().entity(lesson).now();
        Lesson lesson1 = ofy().load().type(Lesson.class).id(lessonId).now();
        //System.out.println("now where >>>>>>??????????????????????"+ lesson1.getLessonId());
        //System.out.println("now where >>>>>>??????????????????????"+ lesson1.getLessonTitle());
        System.out.println("now where >>>>>>??????????????????????"+ lesson1.getVideoBlobKeysList());
        System.out.println("now where >>>>>>???!!!!!!!!!!!!!!!!?????????"+ lesson1.getImageServingUrlList());

        /* get lesson list from the datastore */
        List<Lesson> lessonList = ofy().load().type(Lesson.class).filter("courseId", courseId).order("dateCreated").list();
        ModelAndView mav = new ModelAndView();
        /* add course object to the model */
        mav.addObject("course", course);
        mav.addObject("lessonList", lessonList);

        /* redirect to courseContent Page */
        mav.setViewName("editCourse");
        return mav;
    }
///////////////////////////////////////////////////////////////////////// if debug fail maybe just delete above code ////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/editLesson")
    public ModelAndView editLesson(@RequestParam(value = "userEmail") String userEmail,
                                   @RequestParam(value = "courseId") String courseId,
                                   @RequestParam(value = "numEnrolled") int numEnrolled,
                                   @RequestParam(value = "courseTitle") String courseTitle,
                                   @RequestParam(value = "instructor") String instructor,
                                   @RequestParam(value = "description") String description,
                                   @RequestParam(value = "status") String status,
                                   @RequestParam(value = "accessCode", required = false) String accessCode) {
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
                                          @RequestParam(value = "videoTypes[]", required = false) List<String> videoTypes,
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

        /* not saving it until user click save in editCourse page */
        String lessonOrder = null;
        Course course = new Course(userEmail, courseId, courseTitle, instructor, description, status,lessonOrder);
        course.setAccessCode(accessCode);
        course.setNumEnrolled(numEnrolled);

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
                    //System.out.println("VIDEO KEY: " + blob);
                }
            }
        }
        /* save uploaded image files to blob store, and get the serving url */
        List<String> imageServingUrlList = new ArrayList<String>();
        List<String> imageBlobKeysList = new ArrayList<String>();
        if (finfos.get("myFileImage[]") != null) {
             /* image processing */
            final GcsService gcsService  = GcsServiceFactory.createGcsService(new RetryParams.Builder()
                    .initialRetryDelayMillis(10)
                    .retryMaxAttempts(10)
                    .totalRetryPeriodMillis(15000)
                    .build());

            for (int i = 0; i < finfos.get("myFileImage[]").size(); i++) {
                String gcsImageFileName = finfos.get("myFileImage[]").get(i).getGsObjectName();
                BlobKey imageBlobKey = blobstoreService.createGsBlobKey(gcsImageFileName);
                if (imageBlobKey == null) {
                    System.out.println("uploadImage error");
                } else {
                    String blob = imageBlobKey.getKeyString();
                    imageBlobKeysList.add(blob);

                    ImagesService services = ImagesServiceFactory.getImagesService();
                    // Make an image from a Cloud Storage object, and transform it.
                    Image blobImage = ImagesServiceFactory.makeImageFromBlob(imageBlobKey);
                    Transform resize = ImagesServiceFactory.makeResize(800, 500);
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
        }
        /* save uploaded assignment files to blob store */
        List<String> assignmentBlobKeysList = new ArrayList<String>();
        List<String> assignmentFileNameList = new ArrayList<String>();
        if (finfos.get("myFileAssignment[]") != null) {
            for (int i = 0; i < finfos.get("myFileAssignment[]").size(); i++) {
                String gcsAssignmentFileName = finfos.get("myFileAssignment[]").get(i).getGsObjectName();

                BlobKey assignmentBlobKey = blobstoreService.createGsBlobKey(gcsAssignmentFileName);

                if (assignmentBlobKey == null) {
                    System.out.println("uploadAssignment error");
                } else {
                    BlobInfoFactory blobInfoFactory = new BlobInfoFactory();
                    BlobInfo blobInfo = blobInfoFactory.loadBlobInfo(assignmentBlobKey);

                    String blob = assignmentBlobKey.getKeyString();
                    assignmentBlobKeysList.add(blob);
                    assignmentFileNameList.add(blobInfo.getFilename());
                }
            }
            //mav.addObject("assignmentBlobKeysList",assignmentBlobKeysList);
        }
        String id = new ObjectifyFactory().allocateId(Lesson.class).getString();
        Lesson lesson = new Lesson(courseId, id, lessonTitle, lessonBody, pptLink, pptDescription, videoLinks, videoBlobKeysList, videoDescriptions, videoTypes,
                imageServingUrlList, imageBlobKeysList, imageDescriptions, assignmentBlobKeysList,assignmentFileNameList, assignmentDescriptions);
        /* save the lesson into datastore  */
        ofy().save().entity(lesson).now();
        /* get lesson list from the datastore */
        List<Lesson> lessonList = ofy().load().type(Lesson.class).filter("courseId", courseId).order("dateCreated").list();
        ModelAndView mav = new ModelAndView();
        /* add course object to the model */
        mav.addObject("course", course);
        mav.addObject("lessonList", lessonList);

        /* redirect to courseContent Page */
        mav.setViewName("editCourse");
        return mav;
    }

    /* lecture upload/serve section, use Blobstore, Cloud Storage */
    /* serve assignment/video/image */
    /* courseContent Page serving(video/pdf/image) function */
    @RequestMapping(value = "/serve")
    public void see(HttpServletResponse res, @RequestParam(value = "key") String key) throws IOException {

        BlobKey bk = new BlobKey(key);
        BlobInfoFactory blobInfoFactory = new BlobInfoFactory();
        BlobInfo blobInfo = blobInfoFactory.loadBlobInfo(bk);
        res.setContentType(blobInfo.getContentType());
        res.setHeader("Content-Disposition","inline; filename=" + blobInfo.getFilename());
        blobstoreService.serve(bk, res);
    }
}