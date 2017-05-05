<%--
  Created by IntelliJ IDEA.
  User: GangdiHuang
  Date: 4/5/17
  Time: 6:39 PM
  To change this template use File | Settings | File Templates.
  This page is used to display the search results returned when the user is looking for a new course to add
--%>
<%@ page import="Beans.Course" %>
<%@ page import="Beans.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.googlecode.objectify.Key" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">

<head>
    <title>Course Search</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../../stylesheets/main.css">
    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../bootstrap/css/cover.css" rel="stylesheet">
</head>
<body>


    <ul class="navUl">

        <li>
            <a href="#" onclick="searchCourseToHome()">I-Programming</a>
            <form id="searchCourseToHome"><input type="hidden"></form>
        </li>
        <li style="float:right">
            <a href="#" onclick="signOut()">Sign out</a>
            <form id="signOutToHome"><input type="hidden"></form>
        </li>

        <li style="float:right">
            <a id="my-signin2" style="display: none;"></a>
            <a id="userEmail"></a>
        </li>

    </ul>

    <h1>Course Search</h1>
    <br>
    <div class="container1">
        <form action="#" type="hidden" id="searchClass">
            <div class="row">
                <div class="col-md-2" ></div>
                <div class="col-md-5" >
                    <input type="text" class="form-control" name="UserIn" id="UserIn" type="text"  placeholder="Enter course to search for..." required autofocus>
                </div>
                <div class="col-md-2" >
                    <select name="MySelect" id="MySelect" style="color:black">
                        <option name="Search_by_title" value="title">Search by title</option>
                        <option name="Search_by_instructor" value="instructor">Search by instructor</option>
                    </select>
                </div>
                <div class="col-md-1" >
                    <button id="seach_btn" class="btn btn-primary btn-block" type="submit" onclick="do_search()">Search</button>
                    <%--<input id="search_btn" type="submit" value="Search" style="color:black" >--%>
                </div>
                <input type = hidden name="Select_method" id="select_method" >
            </div>
        </form>
        <br>
        <div class="resultlist">
            <h2>Search Result</h2>
            <ul class="list-group">
                <c:choose>
                    <c:when test="${empty result}">
                        No course found!
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="x" items="${result}">
                            <li class="list-group-item">
                                <div class="panel panel-default panel1">
                                    <div class="panel-heading">
                                        <a data-toggle="collapse" href="#${x.id}">${x.title}</a>
                                    </div>
                                    <div id="${x.id}" class="panel-collapse collapse">
                                        <div class="panel-body panelbody">
                                            <p>Instructors: ${x.instructor}</p>
                                            <p>Status: ${x.status}</p>
                                            <form action="/enrollCourse" id="enrollForm">
                                                <input name="courseId" type="hidden" value="${x.id}">
                                                <input name="userEmail" type="hidden" value="${user}">
                                                <c:choose>
                                                    <c:when test="${x.status == 'private'}">
                                                        <p>Access Code: <input type="text" name="accessCode" onkeypress="checkCodeEnter(event,${x.accessCode},this)">
                                                        <input name="confirm" type="button" value="Enroll" onclick="checkCode(${x.accessCode},this)"></p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input name="confirm" type="submit" value="Enroll" >
                                                    </c:otherwise>
                                                </c:choose>
                                            </form>
                                            <p style="display: none; color: red;">Access Code is invalid. Fail to enroll.</p>
                                        </div>
                                    </div>
                                </div>
                            </li>

                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="/bootstrap/js/bootstrap.js/bootstrap.min.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/iprogrammingScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/SearchCourse.js"></script>
    <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
