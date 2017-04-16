<%--
  Created by IntelliJ IDEA.
  User: GangdiHuang
  Date: 4/5/17
  Time: 6:39 PM
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
</head>
<body>

<ul class="navUl">

    <li>
        <a href="#" onclick="searchCourseToHome()">I-Programming</a>
        <form id="searchCourseToHome"><input type="hidden"></form>
    </li>
    <li style="float:right">
        <div id="my-signin2" style="display: none;"></div>
        <div id="userEmail"></div>
        <a href="#" onclick="signOut()">Sign out</a>
        <form id="signOutToHome"><input type="hidden"></form>
    </li>

</ul>

<h1>--------------------Search Course--------------------</h1>

<div class="container1">
    <table class="table1">
        <tr>
            <td>
                <span ><strong>Course Title:</strong></span>
            </td>
            <td>
                <input name="CourseId" type="text" size="40" value="CSE220">
            </td>
        </tr>

    </table>

    <div class="search_result">
        <span class="input_label">CSE 220: Systems Fundamentals I  01/09/2017

                    Instructors: Kevin McDonnell · 217 Enrolled</span>
    </div>


    <div class="join_course">
        <lable>Course Access Code:</lable>
        <input name="AccessCode" type="text" size="10" value="">
        <input id="join_btn" type="submit" value="Add" onclick="searchCourseToMain();">
        <form id="searchCourseToMain"><input type="hidden"></form>
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
