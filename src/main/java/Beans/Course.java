package Beans;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;
import com.googlecode.objectify.Key;

import java.util.Date;
import java.util.List;

/**
 * Created by JIAQI ZHANG on 4/17/2017.
 */
@Entity
public class Course {
    @Id
    public String id;
    @Parent
    public Key<User> userEmail;

    public String email;
    public String title;
    public String instructor;
    public String description;
    public String status;
    public String accessCode;
    @Index
    public Date dateCreated;
    public int numEnrolled;
    public List<Unit> units;

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
        this.userEmail = Key.create(User.class, userEmail);
    }


//    For testing
    public Course(String user, String title) {
        this.email = user;
        this.title = title;
        userEmail = Key.create(User.class, user);
    }

//    public Course(String user, String title, String key){
//        this(user, title);
//        if( key != null ) {
//            userEmail = Key.create(User.class, key);  // Creating the Ancestor key
//        }
//    }
}
