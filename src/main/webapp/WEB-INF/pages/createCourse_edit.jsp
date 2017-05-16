<%--
  Created by IntelliJ IDEA.
  User: GangdiHuang, YANDA WU
  Date: 4/6/17
  Time: 3:41 AM
  To change this template use File | Settings | File Templates.
--%>

<%--This is the page for creating course --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    <%--<link rel="icon" href="../../favicon.ico">--%>

    <title>Edit Lesson</title>

    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../stylesheets/layout.css" rel="stylesheet">
    <link href="../../stylesheets/navigation.css" rel="stylesheet">
    <link href="../../stylesheets/createCourse.css" rel="stylesheet">

    <!-- Latest compiled JavaScript -->
    <script src="../../bootstrap/js/bootstrap.min.js"></script>

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
                <a class="navbar-brand" href="#" onclick="createCourseToHome()">I-Programming</a>
                <form id="backToHome"><input type="hidden"></form>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
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
                <div class="inner editLesson">
                    <h2>Create Course</h2>
                    <h5>*denotes a required field</h5>
                    <br>
                    <div class="row">
                        <div class="col-md-3" ><h4>Course Title*:</h4></div>
                        <div class="col-md-6">
                            <input type="text" class="form-control" name="courseTitle" required autofocus form="courseinfo">
                        </div>
                    </div>
                    <div class="help-block"></div>
                    <div class="row">
                        <div class="col-md-3" ><h4>Instructor:</h4></div>
                        <div class="col-md-6">
                            <input type="text" class="form-control" name="instructor" form="courseinfo">
                        </div>
                    </div>
                    <div class="help-block"></div>
                    <div class="row">
                        <div class="col-md-3"><h4>Description:</h4></div>
                        <div class="col-md-6">
                            <textarea class="form-control" name="description" rows="7" form="courseinfo"></textarea>
                        </div>
                    </div>
                    <div class="help-block"></div>
                    <div class="row">
                        <div class="col-md-3"><h4>Status:</h4></div>
                        <div class="col-md-6">
                            <select name="status" form="courseinfo" id="status" onchange="courseStatus()">
                                <option value="public">Public</option>
                                <option value="private">Private</option>
                            </select>
                        </div>
                    </div>
                    <div class="row" id="statusRow" hidden>
                        <div class="col-md-3"><h4>Access Code:</h4></div>
                        <div class="col-md-6">
                            <input type="text" class="form-control" name="accessCode" form="courseinfo">
                        </div>
                    </div>
                </div>
                <div class="create-course-btns">
                    <form action="/createCourse1" id="courseinfo">
                        <input name="userEmail" id="formUser" type="hidden" value="${user}">
                        <input name="confirm" type="submit" value="Confirm" class="btn btn-primary">
                    </form>
                    <form id="createCourseToMainCancel">
                        <input type="hidden">
                        <input name="cancel" type="submit" value="Cancel" class="btn btn-primary" onclick="createCourseToMainCancel();">
                    </form>
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
