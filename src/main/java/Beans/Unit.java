package Beans;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

/**
 * Created by JIAQI ZHANG on 4/18/2017.
 */
@Entity
public class Unit {
    @Id long id;
    public String name;

}
