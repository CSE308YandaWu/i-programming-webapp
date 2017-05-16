package Beans;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

import java.util.Date;
import java.util.List;

/**
 * Created by JIAQI ZHANG on 5/1/2017.
 * Edited by YANDA WU on 5/4/2017.
 */
/*
 * A Bean representing a lesson entity. It contains several basic info for a lesson.
 */
@Entity
public class Lesson {
    @Id
    private String lessonId;
    @Index
    private String courseId;
    private String lessonTitle;
    private String lessonBody;
    private String pptLink;
    private String pptDescription;
    private List<String> videoLinks;
    private List<String> videoBlobKeysList;
    private List<String> videoDescriptions;
    private List<String> videoTypes;
    private List<String> imageServingUrlList;
    private List<String> imageBlobKeysList;
    private List<String> imageDescriptions;
    private List<String> assignmentBlobKeysList;
    private List<String> assignmentFileNameList;
    private List<String> assignmentDescriptions;

    @Index
    private Date dateCreated;

    //Constructors
    public Lesson(){
        dateCreated = new Date();
    }

    public Lesson(String courseId, String lessonId, String lessonTitle, String lessonBody, String pptLink, String pptDescription,
                  List<String> videoLinks, List<String> videoBlobKeysList, List<String> videoDescriptions, List<String> videoTypes,
                  List<String> imageServingUrlList, List<String> imageBlobKeysList, List<String> imageDescriptions,
                  List<String> assignmentBlobKeysList, List<String> assignmentFileNameList, List<String> assignmentDescriptions) {
        this.dateCreated = new Date();
        this.courseId = courseId;
        this.lessonId = lessonId;
        this.lessonTitle = lessonTitle;
        this.lessonBody = lessonBody;
        this.pptLink = pptLink;
        this.pptDescription = pptDescription;
        this.videoLinks = videoLinks;
        this.videoBlobKeysList = videoBlobKeysList;
        this.videoDescriptions = videoDescriptions;
        this.videoTypes = videoTypes;
        this.imageServingUrlList = imageServingUrlList;
        this.imageBlobKeysList = imageBlobKeysList;
        this.imageDescriptions = imageDescriptions;
        this.assignmentBlobKeysList = assignmentBlobKeysList;
        this.assignmentFileNameList = assignmentFileNameList;
        this.assignmentDescriptions = assignmentDescriptions;
    }

    /* getter */
    public String getLessonId() {
        return lessonId;
    }
    public String getCourseId() {
        return courseId;
    }
    public String getLessonTitle() {
        return lessonTitle;
    }
    public String getLessonBody() {
        return lessonBody;
    }
    public String getPptLink() {
        return pptLink;
    }
    public String getPptDescription() {
        return pptDescription;
    }
    public List<String> getVideoLinks() {
        return videoLinks;
    }
    public List<String> getVideoBlobKeysList() {
        return videoBlobKeysList;
    }
    public List<String> getVideoDescriptions() {
        return videoDescriptions;
    }
    public List<String> getVideoTypes() {
        return videoTypes;
    }
    public List<String> getImageServingUrlList() {
        return imageServingUrlList;
    }
    public List<String> getImageBlobKeysList() {
        return imageBlobKeysList;
    }
    public List<String> getImageDescriptions() {return imageDescriptions;}
    public List<String> getAssignmentBlobKeysList() {
        return assignmentBlobKeysList;
    }
    public List<String> getAssignmentFileNameList() {
        return assignmentFileNameList;
    }
    public List<String> getAssignmentDescriptions() {
        return assignmentDescriptions;
    }
    public Date getDateCreated() {
        return dateCreated;
    }

    /* setter */
    public void setLessonId(String lessonId) {
        this.lessonId = lessonId;
    }
    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }
    public void setLessonTitle(String lessonTitle) {
        this.lessonTitle = lessonTitle;
    }
    public void setLessonBody(String lessonBody) {
        this.lessonBody = lessonBody;
    }
    public void setPptLink(String pptLink) {
        this.pptLink = pptLink;
    }
    public void setPptDescription(String pptDescription) {
        this.pptDescription = pptDescription;
    }
    public void setVideoLinks(List<String> videoLinks) {
        this.videoLinks = videoLinks;
    }
    public void setVideoBlobKeysList(List<String> videoBlobKeysList) {
        this.videoBlobKeysList = videoBlobKeysList;
    }
    public void setVideoDescriptions(List<String> videoDescriptions) {
        this.videoDescriptions = videoDescriptions;
    }
    public void setVideoTypes(List<String> videoTypes) {
        this.videoTypes = videoTypes;
    }
    public void setImageServingUrlList(List<String> imageServingUrlList) {this.imageServingUrlList = imageServingUrlList;}
    public void setImageBlobKeysList(List<String> imageBlobKeysList) {
        this.imageBlobKeysList = imageBlobKeysList;
    }
    public void setImageDescriptions(List<String> imageDescriptions) {
        this.imageDescriptions = imageDescriptions;
    }
    public void setAssignmentBlobKeysList(List<String> assignmentBlobKeysList) {this.assignmentBlobKeysList = assignmentBlobKeysList;}
    public void setAssignmentFileNameList(List<String> assignmentFileNameList) {this.assignmentFileNameList = assignmentFileNameList;}
    public void setAssignmentDescriptions(List<String> assignmentDescriptions) {this.assignmentDescriptions = assignmentDescriptions;}
    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }
}
