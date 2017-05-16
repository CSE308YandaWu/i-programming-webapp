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
/* This is a bean for each user */
@Entity
public class User implements Serializable {
    @Id
    private String userEmail;
    private List<String> joinedCourse;

    //Constructors
    public User(){
        joinedCourse = new ArrayList<String>();
    }

    public User(String userEmail){
        this();
        this.userEmail = userEmail;
    }

    public User(String email, List<String> joinedCourse){
        this.userEmail = email;
        this.joinedCourse = joinedCourse;
    }

    //Access data
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public List<String> getJoinedCourse() { return joinedCourse; }
    public void setJoinedCourse(List<String> joinedCourse) { this.joinedCourse = joinedCourse; }
    
    public void addJoinedCourse(Course course) { this.joinedCourse.add(course.getId()); }
    public void dropJoinedCourse(Course course){
        joinedCourse.remove(course.getId());
    }
}