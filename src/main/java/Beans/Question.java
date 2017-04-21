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
public class Question {
    @Id long id;
    @Parent public Key<Quiz> parentQuiz;

    public String question;
    public String correctAns;
    public List<String> options;

    //Access data
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }
    public String getAnswer() { return correctAns; }
    public void setAnswer(String correctAns) { this.correctAns = correctAns; }
    public List<String> getAnswerOptions() { return options; }
    public void setAnswerOptions(List<String> options) { this.options = options; }

    //constructors
    public Question() { }

    public Question(long id, String question, String correctAns, List<String> options) {
        this.id = id;
        this.question = question;
        this.correctAns = correctAns;
        this.options = options;
        this.parentQuiz = Key.create(Quiz.class, id);
    }

}
