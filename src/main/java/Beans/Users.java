package Beans;

/**
 * Created by YandaWu on 4/15/2017.
 */

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Ignore;

@Entity
public class Users {
    @Id
    public Long id;
    public String userEmail;

    @Ignore
    int irrelevant;

    public Users() {}

    public Users(String userEmail) {
        this();
        this.userEmail = userEmail;
    }
}