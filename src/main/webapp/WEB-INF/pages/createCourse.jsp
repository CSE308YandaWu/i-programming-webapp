<%--
  Created by IntelliJ IDEA.
  User: GangdiHuang
  Date: 4/6/17
  Time: 3:41 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">

<head>
    <title>Search Course</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="stylesheets/main.css">
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
                        <a href="#" onclick="createCourseToHome()">I-Programming</a>
                        <form id="createCourseToHome"><input type="hidden"></form>
                    </h3>
                    <nav>
                        <ul class="nav masthead-nav">
                            <li class="active">
                                <a id="my-signin2" style="display: none;"></a>
                                <a id="userEmail"></a>
                            </li>
                            <li>
                                <a href="#" onclick="signOut()">Sign out</a>
                                <form id="signOutToHome"><input type="hidden"></form>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="inner editDetails">
                <h2>Course Details</h2>
                <h5>*denotes a required field</h5>
                <div class="help-block"></div>
                <div class="help-block"></div>
                <div class="row">
                    <div class="col-md-4"><h4>Lesson ID:*</h4></div>
                    <div class="col-md-7">
                        <input type="text" id="inputEditLessonID" class="form-control" name="Lesson ID"  placeholder="eg. 1234" required autofocus>
                    </div>
                </div>
                <div class="help-block"></div>
                <div class="row">
                    <div class="col-md-4"><h4>Status:*</h4></div>
                    <div class="col-md-7">
                        <label class="radio-inline"><input type="radio" name="statusradio">Public</label>
                        <label class="radio-inline"><input type="radio" name="statusradio">Private</label>
                    </div>
                </div>
                <div class="help-block"></div>
                <div class="row">
                    <div class="col-md-4"><h4>Password:</h4></div>
                    <div class="col-md-7">
                        <input type="text" id="inputEditTitle" class="form-control" name="Lesson Title" placeholder="Required if private">
                    </div>
                </div>
                <div class="help-block"></div>
                <div class="row">
                   <div class="col-md-5"></div>
                    <div class="col-md-2">
                        <button class="btn btn-lg btn-primary btn-block" type="submit">Save</button>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="col-md-2">
                        <button class="btn btn-lg btn-primary btn-block" type="submit">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>









<%--<ul class="navUl">--%>

    <%--<li>--%>
        <%--<a href="#" onclick="createCourseToHome()">I-Programming</a>--%>
        <%--<form id="createCourseToHome"><input type="hidden"></form>--%>
    <%--</li>--%>
    <%--<li style="float:right">--%>
        <%--<a href="#" onclick="signOut()">Sign out</a>--%>
        <%--<form id="signOutToHome"><input type="hidden"></form>--%>
    <%--</li>--%>
    <%--<li style="float:right">--%>
        <%--<a id="my-signin2" style="display: none;"></a>--%>
        <%--<a id="userEmail"></a>--%>
    <%--</li>--%>

<%--</ul>--%>

<%--<h1>--------------------Create Course--------------------</h1>--%>
<%--<div class="container1">--%>

    <%--<table class="table1">--%>
        <%--<tr>--%>
            <%--<td>--%>
                <%--<span ><strong>Course ID:</strong></span>--%>
            <%--</td>--%>

            <%--<td>--%>
                <%--<input name="courseId" type="text" size="40" value="">--%>
            <%--</td>--%>
        <%--</tr>--%>

        <%--<tr>--%>
            <%--<td>--%>
                <%--<span ><strong>Course Title:</strong></span>--%>
            <%--</td>--%>
            <%--<td>--%>
                <%--<input name="courseTitle" type="text" size="40" value="">--%>
            <%--</td>--%>
        <%--</tr>--%>

        <%--<tr>--%>
            <%--<td>--%>
                <%--<span ><strong>Instructor:</strong></span>--%>
            <%--</td>--%>
            <%--<td>--%>
                <%--<input name="instructor" type="text" size="40" value="">--%>
            <%--</td>--%>
        <%--</tr>--%>

        <%--<tr>--%>
            <%--<td>--%>
                <%--<span ><strong> <br>Description:</br> </strong></span>--%>


            <%--</td>--%>
            <%--<td>--%>
                <%--<textarea rows="7" cols="38" ></textarea>--%>
            <%--</td>--%>

        <%--</tr>--%>

        <%--<tr>--%>
            <%--<td>--%>
                <%--<span><strong>Status:</strong></span>--%>
            <%--</td>--%>
            <%--<td>--%>
                <%--<select>--%>
                    <%--<option value="public">Public</option>--%>
                    <%--<option value="private">Private</option>--%>
                <%--</select>--%>
            <%--</td>--%>
        <%--</tr>--%>




        <%--<tr>--%>
            <%--<td>--%>
                <%--<input name="confirm" type="submit"  value="Confirm" onclick="createCourseToMainConfirm();">--%>
                <%--<form id="createCourseToMainConfirm"><input type="hidden"></form>--%>
            <%--</td>--%>
            <%--<td>--%>
                <%--<input name="cancel" type="submit" value="Cancel" onclick="createCourseToMainCancel();">--%>
                <%--<form id="createCourseToMainCancel"><input type="hidden"></form>--%>
            <%--</td>--%>
        <%--</tr>--%>


    <%--</table>--%>

<%--</div>--%>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="/bootstrap/js/bootstrap.js/bootstrap.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/googleSignInFunctions.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/iprogrammingScript.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
