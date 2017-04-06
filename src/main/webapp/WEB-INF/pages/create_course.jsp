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
<head>
    <title>Search Course</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="stylesheets/main.css">
</head>
<body>

<ul class="navUl">
    <li><a href="#">I-programming</a></li>
    <li style="float:right"><a class="active" href="#">Back to Home</a></li>

    <%--<li class="active"><a href="#" onclick="mainToHome();">Home</a>--%>
    <%--<form id="mainToHome"><input type="hidden"></form>--%>
    <%--</li>--%>
</ul>

<h1>--------------------Create Course--------------------</h1>
<td class="container1">

    <table class="table1">
        <tr>
            <td>
                <span ><strong>Course ID:</strong></span>
            </td>

            <td>
                <input name="courseId" type="text" size="40" value="">
            </td>
        </tr>

        <tr>
            <td>
                <span ><strong>Course Title:</strong></span>
            </td>
            <td>
                <input name="courseTitle" type="text" size="40" value="">
            </td>
        </tr>

        <tr>
            <td>
                <span ><strong>Instructor:</strong></span>
            </td>
            <td>
                <input name="instructor" type="text" size="40" value="">
            </td>
        </tr>

        <tr>
            <td>
                <span ><strong> <br>Description:</br> </strong></span>


            </td>
            <td>
                <textarea rows="7" cols="38" ></textarea>
            </td>

        </tr>

        <tr>
            <td>
                <span><strong>Status:</strong></span>
            </td>
            <td>
                <select>
                    <option value="public">Public</option>
                    <option value="private">Private</option>
                </select>
            </td>
        </tr>




        <tr>
            <td>
                <input name="confirm" type="submit"  value="Confirm">
            </td>
            <td>
                <input name="cancel" type="submit" value="Cancel">
            </td>
        </tr>


    </table>

</div>


</body>
</html>
