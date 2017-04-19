package Beans;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

import java.util.List;

/**
 * Created by YandaWu on 4/15/2017.
 */
/* we might need to use beans later */
@Entity
public class User {
    @Id public String userEmail;
    List<Course> createdCourse;
    List<Course> joinedCourse;

    public User(){}

    public User(String email){
        userEmail = email;
    }
}