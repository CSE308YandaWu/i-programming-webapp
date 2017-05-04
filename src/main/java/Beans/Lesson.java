package Beans;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

import java.util.Date;

/**
 * Created by JIAQI ZHANG on 5/1/2017.
 */
@Entity
public class Lesson {
    @Id
    private long lessonId;
    private String courseId;
    private String title;
    @Index
    private Date dateCreated;


    //Constructors
    public Lesson(){
        dateCreated = new Date();
    }

    public Lesson(String title){
        this();
        this.title = title;
    }

    //Accessors and Mutators
    public long getLessonId() {
        return lessonId;
    }

    public void setLessonId(long lessonId) {
        this.lessonId = lessonId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }
}
