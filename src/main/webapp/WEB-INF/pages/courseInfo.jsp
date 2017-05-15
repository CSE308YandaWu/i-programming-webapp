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
    <link href="../../stylesheets/layout.css" rel="stylesheet">
    <link href="../../stylesheets/navigation.css" rel="stylesheet">
    <link href="../../stylesheets/courseInfo.css" rel="stylesheet">

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
                <a class="navbar-brand" href="#" onclick="courseInfoToHome()">I-Programming</a>
                <form id="backToHome"><input type="hidden"></form>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="nav navbar-nav navbar-right">
                    <li id="welcome-user">
                        Welcome, <span id="my-signin2" style="display: none;"></span>
                        <p id="userEmail" style="display:inline"></p>
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
                <div class="inner course-info">
                    <h2 class="cover-heading">${course.title} Course Page</h2>
                    <h3>Instructor: ${course.instructor}</h3>
                    <h4>${course.description}</h4>
                </div>
                <div class="inner cover">
                    <div class="outlinelist">
                        <h3 class="lessonHeading subheading">Lessons</h3>
                        <c:choose>
                            <c:when test="${empty lessons}">
                                There are no lessons.
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
                    <form action="/discussionBoard">
                        <input type="submit" class="btn btn-primary" value="Discussion Board">
                        <input type="hidden" name="courseId" value="${course.id}">
                    </form>
                    <form action="/main">
                        <input type="submit" class="btn btn-primary add-btns-group" value="Back">
                    </form>
                    <div class="row">
                        <%-- used to create padding at bottom --%>
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
    <script src="../../jQuery/jquery-3.2.1.js"></script>
</body>
</html>

