<%@ page import="Beans.Course" %>
<%@ page import="Beans.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.googlecode.objectify.Key" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %><%--
  Created by IntelliJ IDEA.
  User: JIAQI ZHANG
  Date: 4/5/2017
  Time: 7:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <%--<link rel="icon" href="../../favicon.ico">--%>

    <title>Main Page</title>

    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../bootstrap/css/cover.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="site-wrapper">
    <div class="site-wrapper-inner">
        <div class="cover-container">
            <div class="masthead clearfix">
                <div class="inner">
                    <h3 class="masthead-brand">
                        <a href="#" onclick="mainToHome()">I-Programming</a>
                        <form id="mainToHome"><input type="hidden"></form>
                    </h3>
                    <nav>
                        <ul class="nav masthead-nav">
                            <%--<li><a>--%>
                            <%--<%--%>
                            <%--if(session.getAttribute("user") == null){--%>
                            <%--String user = request.getParameter("userEmail");--%>
                            <%--session.setAttribute("user", user);--%>
                            <%--}--%>
                            <%--out.println(session.getAttribute("user"));--%>
                            <%--%>--%>
                            <%--</a>--%>
                            <%--</li>--%>
                            <li>
                                <div id="my-signin2" style="display: none;"></div>
                                <a id="userEmail"></a>

                                <%--<form id="mainToHome"><input type="hidden"></form>--%>
                            </li>
                            <li>
                                <a href="#" onclick="signOut();">Sign out</a>
                                <form id="signOutToHome"><input type="hidden"></form>
                            </li>
                        </ul>
                    </nav>
                    <nav>
                        <ul class="coursefunctions nav masthead-nav">
                            <li><a href="#" class="createCourse" onclick="toCreateCourse()">Create Course</a>
                                <form id="createCourse"><input type="hidden"></form>
                            </li>
                            <li><a href="#" class="addCourse" onclick="toSearchCourse()">Add Course</a>
                                <form id="searchCourse"><input type="hidden"></form>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="inner toplist">
                <h2>Top 5 Popular Courses</h2>
                <ul class="list-group">
                    <li class="list-group-item">
                        <div class="panel panel-default panel1">
                            <div class="panel-heading">
                                <a data-toggle="collapse" href="#collapse1">CSE 308</a>
                            </div>
                            <div id="collapse1" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <p>Instructor: Richard McKenna</p>
                                    <span>Access Code: <input type="text" name="AccessCode" value="Code"></span>
                                    <button type="button" class="btn btn-primary">Add</button>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="list-group-item">
                        <div class="panel panel-default panel1">
                            <div class="panel-heading">
                                <a data-toggle="collapse" href="#collapse2">CSE 219</a>
                            </div>
                            <div id="collapse2" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <p>Instructor: Richard McKenna</p>
                                    <span>Access Code: <input type="text" name="AccessCode" value="Code"></span>
                                    <button type="button" class="btn btn-primary">Add</button>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="list-group-item">
                        <div class="panel panel-default panel1">
                            <div class="panel-heading">
                                <a data-toggle="collapse" href="#collapse3">CSE 320</a>
                            </div>
                            <div id="collapse3" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <p>Instructor: Jennifer Wong-Ma</p>
                                    <span>Access Code: <input type="text" name="AccessCode" value="Code"></span>
                                    <button type="button" class="btn btn-primary">Add</button>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="list-group-item">
                        <div class="panel panel-default panel1">
                            <div class="panel-heading">
                                <a data-toggle="collapse" href="#collapse4">CSE 220</a>
                            </div>
                            <div id="collapse4" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <p>Instructor: Jennifer Wong-Ma</p>
                                    <span>Access Code: <input type="text" name="AccessCode" value="Code"><button
                                            type="button" class="btn btn-primary">Add</button></span>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="list-group-item">
                        <div class="panel panel-default panel1">
                            <div class="panel-heading">
                                <a data-toggle="collapse" href="#collapse5">CSE 114</a>
                            </div>
                            <div id="collapse5" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <p>Instructor: Paul Fodor</p>
                                    <span>Access Code: <input type="text" name="AccessCode" value="Code"><button
                                            type="button" class="btn btn-primary">Add</button></span>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="inner createdlist">
                <h2>My Created Courses</h2>
                <div class="list-group">
                    <%
                        if (session.getAttribute("user") == null) {
                            session.setAttribute("user", request.getParameter("userEmail"));
                        }
                        String user = (String) session.getAttribute("user");
                        List<Course> courses;

                        courses = ObjectifyService.ofy()
                                .load()
                                .type(Course.class)
                                .filter("email", user)
                                .order("-dateCreated")
                                .list();
                        pageContext.setAttribute("courses", courses);
                    %>
                    <c:choose>
                        <c:when test="${empty courses}">
                            You have not create any courses yet.
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="x" items="${courses}">
                                <a href="#" onclick="toEditCourse(this)" class="list-group-item list-group-item-action">${x.title}
                                    <form action="/deleteCourse" class="deletebutton">
                                        <input type="hidden" value="${x.id}" id="cId">
                                        <input type="submit" value="Delete" class="btn btn-primary">
                                    </form><br>
                                    <span>Instructor: ${x.instructor}; ${x.numEnrolled} enrolled</span>
                                </a>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <form id="toEditCourse"><input type="hidden" id="courseId" name="courseId"></form>
                    <%--<a href="#" class="list-group-item list-group-item-action">CSE 111--%>
                        <%--<button type="button" class="btn btn-primary" onclick="toEditCourse()">Edit</button>--%>
                        <%--<form id="toEditCourse"><input type="hidden"></form>--%>
                    <%--</a>--%>
                    <%--<a href="#" class="list-group-item list-group-item-action">CSE 123</a>--%>
                    <%--<a href="#" class="list-group-item list-group-item-action">CSE 235</a>--%>
                    <%--<a href="#" class="list-group-item list-group-item-action">CSE 456</a>--%>
                    <%--<a href="#" class="list-group-item list-group-item-action">CSE 222</a>--%>
                </div>
            </div>
            <div class="inner enrolledlist">
                <h2>My Enrolled Courses</h2>
                <div class="list-group">
                    <form id="entercourse" action="/course_page">
                        <a href="#" onclick="toCoursePage()" id="coursename"
                           class="list-group-item list-group-item-action">CSE 308</a>
                        <input type="hidden" id="nameinput" name="coursename">
                    </form>
                    <a href="#" class="list-group-item list-group-item-action">CSE 336</a>
                    <a href="#" class="list-group-item list-group-item-action">CSE 320</a>
                </div>
            </div>
            <div class="mastfoot">
                <div class="inner">
                    <p>Developed by Dark Blue Team.</p>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="/bootstrap/js/bootstrap.js/bootstrap.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/script.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
