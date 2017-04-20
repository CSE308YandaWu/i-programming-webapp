package Beans;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;
import com.googlecode.objectify.Key;

import java.util.List;

/**
 * Created by Shanshan Chen on 4/19/2017.
 */
@Entity
public class Unit {
    @Id long id;
    @Parent public Key<Course> parentCourse;
    public Key<Quiz> quiz;

    @Index public String title;
    public String content;

    //Access data
    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public Key<Quiz> getQuiz() {
        return quiz;
    }
    public void setQuiz(Key<Quiz> quiz) {
        this.quiz = quiz;
    }

    //Constructors
    public Unit() { }

    public Unit(long id, String title, String content, Key<Quiz> quiz) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.quiz = quiz;
        this.parentCourse = Key.create(Course.class, id);
    }
}
