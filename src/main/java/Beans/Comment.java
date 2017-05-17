package Beans;

import com.googlecode.objectify.ObjectifyFactory;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

import java.util.*;

/**
 * Created by JIAQI ZHANG on 5/2/2017.
 */
/*
 * A Bean class representing a comment in the discussion board.
 */
@Entity
public class Comment {
    @Id
    private String id;
    @Index
    private String courseId;
    private String author;
    private String comment;
    @Index
    private int likes;
    @Index
    private Date dateCreated;
    Map<String, Integer> likeStatus;


    //Constructors
    public Comment(){
        id = new ObjectifyFactory().allocateId(Comment.class).getString();
        dateCreated = new Date();
        likes = 0;
        likeStatus = new HashMap<String, Integer>();
    }

    public Comment(String courseId, String author, String comment){
        this();
        this.courseId = courseId;
        this.author = author;
        this.comment = comment;
    }



    //Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLesson() {
        return courseId;
    }

    public void setLesson(String courseId) {
        this.courseId = courseId;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Map<String, Integer> getLikeStatus() {
        return likeStatus;
    }

    public void setLikeStatus(Map<String, Integer> likeStatus) {
        this.likeStatus = likeStatus;
    }
}
