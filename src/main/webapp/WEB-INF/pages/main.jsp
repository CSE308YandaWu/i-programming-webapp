<%@ page import="Beans.Course" %>
<%@ page import="Beans.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.googlecode.objectify.Key" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="static com.googlecode.objectify.ObjectifyService.ofy" %>
<%--
  Created by IntelliJ IDEA.
  User: JIAQI ZHANG, YANDA WU
  Date: 4/5/2017
  Time: 7:28 PM
  To change this template use File | Settings | File Templates.
--%>

<%--This is the main page --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<%--this is needed for the signin-out function so every page should have this --%>
<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Main Page</title>

    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../stylesheets/layout.css" rel="stylesheet">
    <link href="../../stylesheets/navigation.css" rel="stylesheet">
    <link href="../../stylesheets/mainPage.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top top-nav-collapse" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#" onclick="mainToHome()">I-Programming</a>
                <form id="backToHome"><input type="hidden"></form>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="coursefunctions nav navbar-nav">
                    <li><a href="#" class="createCourse" onclick="toCreateCourse()">Create Course</a>
                        <form id="createCourse"><input type="hidden"></form>
                    </li>
                    <li><a href="#" class="addCourse" onclick="toSearchCourse()">Add Course</a>
                        <form id="searchCourse"><input type="hidden"></form>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li id="welcome-user">
                        Welcome, <span id="my-signin2"></span>
                        <p id="userEmail"></p>
                    </li>
                    <li>
                        <button class="btn navbar-btn" onclick="signOut()">Sign Out
                            <form id="signOutToHome"><input type="hidden"></form></button>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <div class="site-wrapper">
        <div class="site-wrapper-inner">
            <div class="cover-container">
                <div class="inner toplist">
                    <h2>Top 5 Popular Courses</h2>
                    <c:choose>
                        <c:when test="${empty topCourses}">
                            Empty!
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="x" items="${topCourses}" varStatus="loop">
                                <li class="list-group-item">
                                    <div class="panel panel-default panel1">
                                        <div class="panel-heading">
                                            <a data-toggle="collapse" href="#${x.id}">${x.title}</a>
                                        </div>
                                        <div id="${x.id}" class="panel-collapse collapse">
                                            <div class="panel-body panelbody">
                                                <p>Instructors: ${x.instructor}</p>
                                                <p>Status: ${x.status}</p>
                                                <form action="/enrollCourse" id="enrollForm" onsubmit="return checkCode(${x.accessCode},${loop.index})">
                                                    <input name="courseId" type="hidden" value="${x.id}">
                                                    <input name="userEmail" type="hidden" value="${user}">
                                                    <c:if test="${x.status == 'private'}">
                                                        <p>Access Code: <input type="text" id="accessCode${loop.index}" name="accessCode"></p>
                                                    </c:if>
                                                    <input type="submit" value="Enroll">
                                                </form>
                                                <p class="errorMsg" id="errorMsg${loop.index}">Access Code is invalid. Fail to enroll.</p>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="inner createdlist">
                    <h2>My Created Courses</h2>
                    <div class="list-group">
                        <c:choose>
                            <c:when test="${empty createdCourses}">
                                You have not created any courses yet.
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="x" items="${createdCourses}" varStatus="loop">
                                    <div class="list-group-item list-group-item-action">
                                        <a href="#" style="color: black" onclick="toEditCourse(${loop.index})" class="list-group-item-action enrolledlink">
                                            ${x.title}
                                        </a>
                                        <form action="/deleteCourse" class="deletebutton">
                                            <input type="hidden" value="${x.id}" name="courseId" id="editCourseId${loop.index}">
                                            <input type="submit" value="Delete" onclick="return confirmDelete()" class="btn btn-primary">
                                        </form>
                                        <br>
                                        <span>Instructor: ${x.instructor}; ${x.numEnrolled} enrolled</span>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        <form id="toEditCourse"><input type="hidden" name="courseId" id="editId"></form>
                    </div>
                </div>
                <div class="inner enrolledlist">
                    <h2>My Enrolled Courses</h2>
                    <div class="list-group">
                        <c:choose>
                            <c:when test="${empty joinedCourses}">
                                You have not joined any courses yet.
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="x" items="${joinedCourses}" varStatus="loop">
                                    <div class="list-group-item enrolledlink">
                                        <a href="#" style="color: black" onclick="toCoursePage(${loop.index})" class="list-group-item-action enrolledlink">
                                            ${x.title}
                                        </a>
                                        <form action="/dropCourse" class="dropbutton">
                                            <input type="hidden" value="${x.id}" name="courseId" id="courseId${loop.index}">
                                            <input type="hidden" value="${user}" name="userEmail">
                                            <input type="submit" value="Drop" onclick="return confirmDrop()" class="btn btn-primary">
                                        </form>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        <form id="toCoursePage"><input type="hidden" name="courseId" id="cId"></form>
                    </div>
                </div>
                <div>
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
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/googleSignInFunctions.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/homePageNavigation.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/iprogrammingScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/confirmEvent.js"></script>
    <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
    <script src="../../jQuery/jquery-3.2.1.js"></script>
    <script src="../../bootstrap/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
