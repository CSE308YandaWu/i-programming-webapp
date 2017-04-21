package Beans;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Serialize;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by YandaWu on 4/15/2017.
 * Edited by Shanshan Chen on 4/20/17
 */
/* we might need to use beans later */
@Entity
public class User implements Serializable {
    @Id
    private String userEmail;
    @Index
    private String userId;
    private List<Course> createdCourse;
    private List<Course> joinedCourse;

    //Access data
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public List<Course> getCreatedCourse() { return createdCourse; }
    public void setCreatedCourse(List<Course> createdCourse) { this.createdCourse = createdCourse; }
    public void addCreatedCourse(Course course) { this.createdCourse.add(course); }

    public List<Course> getJoinedCourse() { return joinedCourse; }
    public void setJoinedCourse(List<Course> joinedCourse) { this.joinedCourse = joinedCourse; }
    public void addJoinedCourse(Course course) { this.joinedCourse.add(course); }

    //Constructors
    public User(){}

    public User(String userEmail){
        this.userEmail = userEmail;
        this.userId = userEmail;
    }

    public User(String email, List<Course> createdCourse, List<Course> joinedCourse){
        this.userEmail = email;
        this.userId = email;
        this.createdCourse = createdCourse;
        this.joinedCourse = joinedCourse;

    }
}