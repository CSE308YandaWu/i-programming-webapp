package com.iprogramming.controller;

import Beans.Comment;
import Beans.Course;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.googlecode.objectify.ObjectifyService.ofy;

/**
 * Created by JIAQI ZHANG on 5/14/2017.
 */
@Controller
public class DiscussionBoardController {

    @RequestMapping("/discussionBoard")
    public ModelAndView toDiscussionBoard(@RequestParam(value = "courseId") String courseId,
                                          @RequestParam(value = "sortMethod", required = false) String sort) {
        //load the course
        Course course = ofy().load().type(Course.class).id(courseId).now();

        //load comments
        List<Comment> comments = ofy().load().type(Comment.class).filter("courseId", courseId).order("-dateCreated").list();
        ;
        if (sort != null)
            if (sort.equals("top"))
                comments = ofy().load().type(Comment.class).filter("courseId", courseId).order("-likes").list();

        //load replies
        Map<String, List<Comment>> replyMap = new HashMap<>();
        if (comments != null) {
            for (Comment c : comments) {
                List<Comment> replies = ofy().load().type(Comment.class).filter("courseId", c.getId()).list();
                replyMap.put(c.getId(), replies);
            }
        }


        ModelAndView mav = new ModelAndView("discussionBoard");
        mav.addObject("course", course);
        mav.addObject("commentList", comments);
        mav.addObject("replyMap", replyMap);
        return mav;
    }

    @RequestMapping(value = "/discussionBoard", method = RequestMethod.POST)
    public String postComment(@RequestParam(value = "userEmail") String user,
                              @RequestParam(value = "courseId") String courseId,
                              @RequestParam(value = "commentId", required = false) String commentId,
                              @RequestParam(value = "comment") String comment) {
        Comment newComment;
        if (commentId == null)
            newComment = new Comment(courseId, user, comment);
        else
            newComment = new Comment(commentId, user, comment);
        ofy().save().entity(newComment).now();
        return "redirect:/discussionBoard?courseId=" + courseId;
    }

    @RequestMapping(value = "/sortComment")
    public String sortComment(@RequestParam(value = "courseId") String courseId,
                              @RequestParam(value = "sortMethod") String sort) {
        return "redirect:/discussionBoard?courseId=" + courseId + "&sortMethod=" + sort;
    }

    @RequestMapping(value = "/likeComment")
    public String likeComment(@RequestParam(value = "courseId") String courseId,
                              @RequestParam(value = "commentId") String commentId,
                              @RequestParam(value = "userEmail") String userEmail) {
        Comment comment = ofy().load().type(Comment.class).id(commentId).now();

        Map<String, Integer> likeMap = comment.getLikeStatus();
        if (likeMap.get(userEmail) == null) {
            likeMap.put(userEmail, 0);
        }
        likeMap.put(userEmail, likeMap.get(userEmail) + 1);

        comment.setLikeStatus(likeMap);
        comment.setLikes(comment.getLikes() + 1);
        ofy().save().entity(comment).now();
        return "redirect:/discussionBoard?courseId=" + courseId;
    }

    @RequestMapping(value = "/dislikeComment")
    public String dislikeComment(@RequestParam(value = "courseId") String courseId,
                                 @RequestParam(value = "commentId") String commentId,
                                 @RequestParam(value = "userEmail") String userEmail) {
        Comment comment = ofy().load().type(Comment.class).id(commentId).now();

        Map<String, Integer> likeMap = comment.getLikeStatus();
        if (likeMap.get(userEmail) == null) {
            likeMap.put(userEmail, 0);
        }
        likeMap.put(userEmail, likeMap.get(userEmail) - 1);

        comment.setLikeStatus(likeMap);
        comment.setLikes(comment.getLikes() - 1);
        ofy().save().entity(comment).now();
        return "redirect:/discussionBoard?courseId=" + courseId;
    }

    @RequestMapping(value = "/deleteComment")
    public String deleteComment(@RequestParam(value = "courseId") String courseId,
                                @RequestParam(value = "commentId") String commentId) {
        //delete comment
        ofy().delete().type(Comment.class).id(commentId).now();
        //delete replies
        List<Comment> replies = ofy().load().type(Comment.class).filter("courseId", commentId).list();
        ofy().delete().entities(replies);
        return "redirect:/discussionBoard?courseId=" + courseId;
    }

}
