<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: JIAQI ZHANG
  Date: 4/5/2017
  Time: 11:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    <title>Edit Course</title>

    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../bootstrap/css/cover.css" rel="stylesheet">
    <link rel="stylesheet" href="../../stylesheets/sortlist.css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

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
                            <a href="#" onclick="editCourseToHome()">I-Programming</a>
                            <form id="editCourseToHome"><input type="hidden"></form>
                        </h3>
                        <nav>
                            <ul class="nav masthead-nav">
                                <li>
                                    <div id="my-signin2" style="display: none;"></div>
                                    <a id="userEmail"></a>
                                </li>
                                <li>
                                    <a href="#" onclick="signOut();">Sign out</a>
                                    <form id="signOutToHome"><input type="hidden"></form>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <div class="inner editcourse">
                    <h2>Edit Course</h2>
                    <div class="add-btns-group">
                        <button type="button" class="btn btn-primary" onclick="toEditUnit();">Edit Course Details
                            <form id="toEditCourseDetails"><input type="hidden"></form>
                        </button>
                    </div>
                    <h3 class="subheading">Course Details:</h3>
                    <div class="course-info">
                        <table class="table1">
                            <tr><td>User:</td><td>${model.email}</td></tr>
                            <tr><td>Course Id:</td><td>${model.id}</td></tr>
                            <tr><td>Course Title:</td><td>${model.title}</td></tr>
                            <tr><td>Instructor:</td><td>${model.instructor}</td></tr>
                            <tr><td>Status:</td><td>${model.status}</td></tr>
                            <tr><td>Description:</td><td>${model.description}</td></tr>
                            <tr><td>Date Created: </td><td>${model.dateCreated}</td></tr>
                        </table>
                    </div>
                    <div class="outlinelist">
                        <h3 class="subheading">Lessons</h3>
                            <ul id="sortable" class="lesson-list">
                                <%--<li><a href="#">Introduction</a>(<a href="#">Edit</a>)</li>--%>
                                <li class="ui-state-default">
                                    <div class="lesson-info">
                                        <span class="ui-icon ui-icon-triangle-2-n-s"></span> Introduction
                                    </div>
                                    <div class="lesson-edit">
                                        <a href="#" onclick="toCourseContent()"><span class="ui-icon ui-icon-document"></span></a>
                                        <a href="#" onclick="<%--editCourseContent()--%>"><span class="ui-icon ui-icon-pencil"></span></a>
                                        <a href="#" onclick="<%--deleteCourse()--%>"><span class="ui-icon ui-icon-trash"></span></a>
                                        <form id="toCourseContent"><input type="hidden"></form>
                                    </div>
                                </li>
                                <li class="ui-state-default">
                                    <div class="lesson-info">
                                        <span class="ui-icon ui-icon-triangle-2-n-s"></span> Basics
                                    </div>
                                    <div class="lesson-edit">
                                        <a href="#" onclick="toCourseContent()"><span class="ui-icon ui-icon-document"></span></a>
                                        <a href="#" onclick="<%--editCourseContent()--%>"><span class="ui-icon ui-icon-pencil"></span></a>
                                        <a href="#" onclick="<%--deleteCourse()--%>"><span class="ui-icon ui-icon-trash"></span></a>
                                    </div>
                                </li>
                                <li class="ui-state-default">
                                    <div class="lesson-info">
                                        <span class="ui-icon ui-icon-triangle-2-n-s"></span> Intermediate
                                    </div>
                                    <div class="lesson-edit">
                                        <a href="#" onclick="toCourseContent()"><span class="ui-icon ui-icon-document"></span></a>
                                        <a href="#" onclick="<%--editCourseContent()--%>"><span class="ui-icon ui-icon-pencil"></span></a>
                                        <a href="#" onclick="<%--deleteCourse()--%>"><span class="ui-icon ui-icon-trash"></span></a>
                                    </div>
                                </li>
                                <li class="ui-state-default">
                                    <div class="lesson-info">
                                        <span class="ui-icon ui-icon-triangle-2-n-s"></span> Advanced
                                    </div>
                                    <div class="lesson-edit">
                                        <a href="#" onclick="toCourseContent()"><span class="ui-icon ui-icon-document"></span></a>
                                        <a href="#" onclick="<%--editCourseContent()--%>"><span class="ui-icon ui-icon-pencil"></span></a>
                                        <a href="#" onclick="<%--deleteCourse()--%>"><span class="ui-icon ui-icon-trash"></span></a>
                                    </div>
                                </li>
                            </ul>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="toEditLesson();" style="float: left">Add Lesson
                        <form id="toEditLesson">
                            <input type="hidden" name="userEmail" value="${course.email}">
                            <input type="hidden" name="courseId" value="${course.id}">
                            <input type="hidden" name="numEnrolled" value="${course.numEnrolled}">
                            <input type="hidden" name="courseTitle" id="titleEditLesson" value="${course.title}">
                            <input type="hidden" name="instructor" id="instructorEditLesson"
                                   value="${course.instructor}">
                            <input type="hidden" name="description" id="descriptionEditLesson"
                                   value="${course.description}">
                            <input type="hidden" name="status" id="statusEditLesson" value="${course.status}">
                            <input type="hidden" id="accessCodeEditLesson" name="accessCode"
                                   value="${course.accessCode}">
                        </form>
                    </button>
                </div>
                <br>
                <br>
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/iprogrammingScript.js"></script>
    <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
    <script src="../javascripts/jquery-sortable.js"></script>

    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../javascripts/sortableList.js"></script>
</body>
</html>
