<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: JIAQI ZHANG, YANDA WU
  Date: 4/6/2017
  Time: 3:29 AM
  To change this template use File | Settings | File Templates.
  This file generates the non-owner user's view of a course
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

    <title>Course Page - Owner</title>

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
                        <a href="#" onclick="courseInfoToHome()">I-Programming</a>
                        <form id="backToHome"><input type="hidden"></form>
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
            <h2 class="cover-heading">
                ${course.title} Course Page</h2>
            <div class="inner cover">
                <h3 class="text">Course Description</h3>
                <br>
                <div class="course-info">
                    <table class="table1">
                        <tr>
                            <td>Instructor:</td>
                            <td>${course.instructor}</td>
                        </tr>
                        <tr>
                            <td>Description:</td>
                            <td>${course.description}</td>
                        </tr>
                        <tr>
                            <td>Date Created:</td>
                            <td>${course.dateCreated}</td>
                        </tr>
                    </table>
                </div>
                <div class="outlinelist">
                    <h3 class="lessonHeading">Lessons</h3>
                    <c:choose>
                        <c:when test="${empty lessons}">
                            There is no lessons.
                        </c:when>
                        <c:otherwise>
                            <ol>
                                <c:forEach var="lesson" items="${lessons}" varStatus="loop">
                                    <li style="padding-bottom: 5px">
                                        <a href="#" onclick="viewLesson('${loop.index}')"
                                           class="list-group-item list-group-item-action">${lesson.lessonTitle}
                                        </a>
                                        <form id="viewLesson${loop.index}">
                                            <input type="hidden" name="lessonId" value="${lesson.lessonId}">
                                            <%--tell courseContent page where is the viewLesson action from--%>
                                            <input type="hidden" name="originalPlace" value="courseInfoPage">
                                            <input type="hidden" name="courseId" value="${course.id}">
                                        </form>
                                    </li>
                                </c:forEach>
                            </ol>
                        </c:otherwise>
                    </c:choose>
                </div>
                <form action="/main">
                    <input type="submit" class="btn btn-primary add-btns-group" value="Back">
                </form>
                <div class="row">
                    <%-- used to create padding at bottom --%>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="/bootstrap/js/bootstrap.js/bootstrap.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/googleSignInFunctions.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/homePageNavigation.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/iprogrammingScript.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

