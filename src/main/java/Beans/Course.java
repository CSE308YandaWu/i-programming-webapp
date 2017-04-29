package Beans;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;
import com.googlecode.objectify.Key;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by JIAQI ZHANG on 4/17/2017.
 */
@Entity
public class Course implements Serializable {
    @Id
    private String id;
    @Index
    private String email;
    @Index public String title;
    private String instructor;
    private String description;
    private String status;
    private String accessCode;
    @Index
    private Date dateCreated;
    @Index
    private int numEnrolled;

    //Constructors
    public Course() {
        dateCreated = new Date();
        numEnrolled = 0;
    }

    public Course(String userEmail, String id, String title, String instructor, String description, String status) {
        this();
        this.email = userEmail;
        this.id = id;
        this.title = title;
        this.instructor = instructor;
        this.description = description;
        this.status = status;
    }

    //Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getInstructor() {
        return instructor;
    }

    public void setInstructor(String instructor) {
        this.instructor = instructor;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public int getNumEnrolled() {
        return numEnrolled;
    }

    public void setNumEnrolled(int numEnrolled) {
        this.numEnrolled = numEnrolled;
    }

    public String getAccessCode() {
        return accessCode;
    }

    public void setAccessCode(String accessCode) {
        this.accessCode = accessCode;
    }

}
