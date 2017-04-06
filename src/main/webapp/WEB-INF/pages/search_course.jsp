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
<head>
    <title>Search Course</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="stylesheets/main.css">
</head>
<body>

<ul class="navUl">
    <li><a href="#">I-programming</a></li>
    <li style="float:right"><a class="active" href="#" onclick="search_courseToHome();">Back to Home</a>
        <form id="search_courseToHome"><input type="hidden"></form>
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
        <input id="join_btn" type="submit" value="Add" >
    </div>


</div>


</body>
</html>
