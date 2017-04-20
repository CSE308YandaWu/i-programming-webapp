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
public class Quiz {
    @Id long id;
    @Parent public Key<Unit> parentUnit;
    public List<Question> questions;

    //Access data
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public List<Question> getQuestion() { return questions; }
    public void setQuestion(List<Question> questions) { this.questions = questions; }
    public void addQuestion(Question question) { this.questions.add(question); }

    //constructors
    public Quiz() { }

    public Quiz(long id, List<Question> questions) {
        this.id = id;
        this.questions = questions;
        this.parentUnit = Key.create(Unit.class, id);
    }

}
