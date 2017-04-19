<%--
  Created by IntelliJ IDEA.
  User: Epic_Miracle_
  Date: 4/5/2017
  Time: 10:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="Beans.Course"%>
<%@ page import="java.util.List" %>
<%@ page import="Beans.User" %>
<%@ page import="com.googlecode.objectify.Key" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="/javascripts/script.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">

<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.googlecode.objectify.Key" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="Beans.Users" %>
<%@ page import="com.googlecode.objectify.Result" %>
<%@ page import="com.googlecode.objectify.cmd.Query" %>
<%@ page import="com.google.appengine.api.datastore.QueryResultIterator" %>


<head>
    <title>Hello World!</title>
</head>

<body>
Hello World!
<div id="my-signin2"></div>
<%--<div id="my-signin2" style="display: none;"></div>--%>
<div id="userEmail"></div>
<a href="#" onclick="signOut();">Sign out</a>

<%--<a href="#" onclick="signOut();">GET ME OUT</a>--%>
<a href="#" onclick="ff10();">GET ME BACK</a>
<%
    Query<Users> all = ObjectifyService.ofy().load().type(Users.class);
    QueryResultIterator<Users> iterator = all.iterator();
    while (iterator.hasNext()) {
        Users u1 = iterator.next();
        System.out.println(u1.userEmail);
    }
    String userEmail = all.first().now().userEmail;
%>
userEmail is: <%=userEmail%>

<form id="myForm2"><input type="hidden" id="input1" name="email"></form>
<div>
    <form action="/test">
        Email: <input name="email"><br>
        Course Title: <input name="title"><br>
        <input type="submit" value="Add">
    </form>
    <form action="/test">
        Key: <input name="key" id="key"><input type="submit" value="search">
    </form>

    <%
        String key = request.getParameter("key");
        List<Course> courses;
        if (key != null){
            Key<Beans.User> theUser = Key.create(Beans.User.class, key);

            courses = ObjectifyService.ofy()
                    .load()
                    .type(Course.class)
                    .ancestor(theUser)
                    .list();
        }
        else{
            courses = ObjectifyService.ofy()
                    .load()
                    .type(Course.class)
                    .list();
        }




        if (courses.isEmpty()) {
    %>
    <p>Course List has no courses.</p>
    <%
    } else {
    %>
    <p>Courses:</p><br>
    <%
        // Look at all of our greetings
        for (Course c : courses) {
            pageContext.setAttribute("course_title", c.title);
            String author;
            if (c.email == null) {
                author = "An anonymous person";
            } else {
                author = c.email;
            }
            pageContext.setAttribute("course_email", author);
    %>
    <p><b>${fn:escapeXml(course_email)}</b> adds:</p>
    <blockquote>${fn:escapeXml(course_title)}</blockquote>
    <%
            }
        }
    %>


</div>
</body>
</html>
