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
@Entity
public class Lesson {
    @Id
    private long lessonId;
    @Index
    private String courseId;
    private String lessonTitle;
    private String lessonBody;
    private String pptLink;
    private String pptDescription;
    private List<String> videoLinks;
    private List<String> videoBlobKeysList;
    private List<String> videoDescriptions;
    private List<String> imageServingUrlList;
    private List<String> imageDescriptions;
    private List<String> assignmentBlobKeysList;
    private List<String> assignmentDescriptions;

    @Index
    private Date dateCreated;

    //Constructors
    public Lesson(){
        dateCreated = new Date();
    }

    public Lesson(String courseId, long lessonId, String lessonTitle, String lessonBody, String pptLink, String pptDescription, List<String> videoLinks,
                  List<String> videoBlobKeysList, List<String> videoDescriptions, List<String> imageServingUrlList, List<String> imageDescriptions,
                  List<String> assignmentBlobKeysList, List<String> assignmentDescriptions) {
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
        this.imageServingUrlList = imageServingUrlList;
        this.imageDescriptions = imageDescriptions;
        this.assignmentBlobKeysList = assignmentBlobKeysList;
        this.assignmentDescriptions = assignmentDescriptions;
    }

    /* getters */
    public long getLessonId() {
        return lessonId;
    }
    public String getCourseId() {
        return courseId;
    }
    public Date getDateCreated() {
        return dateCreated;
    }
    public String getLessonTitle() {
        return lessonTitle;
    }
    public String getLessonBody() {
        return lessonBody;
    }
    public String getPPTLink() {
        return pptLink;
    }
    public String getPPTDescription() {
        return pptDescription;
    }
    public List<String> getVideoLinks() {
        return videoLinks;
    }
    public List<String> getVideoBlobKeysList() {
        return videoBlobKeysList;
    }
    public List<String> getVideoDescriptions() {return videoDescriptions;}
    public List<String> getImageServingUrlList() {
        return imageServingUrlList;
    }
    public List<String> getImageDescriptions() {
        return imageDescriptions;
    }
    public List<String> getAssignmentBlobKeysList() {
        return assignmentBlobKeysList;
    }
    public List<String> getAssignmentDescriptions() {
        return assignmentDescriptions;
    }

    /* setters */
    public void setLessonId(long lessonId) {
        this.lessonId = lessonId;
    }
    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }
    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }
    public void setLessonTitle(String lessonTitle) {
        this.lessonTitle = lessonTitle;
    }
    public void setLessonBody(String lessonBody) {
        this.lessonBody = lessonBody;
    }
    public void setPPTLink(String pptLink) {
        this.pptLink = pptLink;
    }
    public void setPPTDescription(String pptDescription) {
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
    public void setImageServingUrlList(List<String> imageServingUrlList) {this.imageServingUrlList = imageServingUrlList;}
    public void setImageDescriptions(List<String> imageDescriptions) {
        this.imageDescriptions = imageDescriptions;
    }
    public void setAssignmentBlobKeysList(List<String> assignmentBlobKeysList) { this.assignmentBlobKeysList = assignmentBlobKeysList;}
    public void setAssignmentDescriptions(List<String> assignmentDescriptions) { this.assignmentDescriptions = assignmentDescriptions;}

}
