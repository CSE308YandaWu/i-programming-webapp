<%--
  Created by IntelliJ IDEA.
  User: GangdiHuang
  Date: 4/5/17
  Time: 6:39 PM
  To change this template use File | Settings | File Templates.
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
    <title>Search Course</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="stylesheets/main.css">
    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../bootstrap/css/cover.css" rel="stylesheet">
</head>
<body>

<script>
    function do_search(){
        var title = document.getElementById()
    }
</script>

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

<h1>--------------------Search Course--------------------</h1>

<div class="container1">
    <table class="table1">
        <tr>
            <td>
                <span ><strong>Course Title:</strong></span>
            </td>
            <td>
                <input style="color:black" name="CourseTitle" id="CourseTitle" type="text" size="40" form="searchClass">
            </td>
            <td>
                <input id="search_btn" type="submit" value="Search" style="color:black" form="searchClass">
            </td>
            <form action="#" type="hidden" id="searchClass"></form>
        </tr>

    </table>

    <div class="resultlist">
        <h2>Search Result</h2>
        <ul class="list-group">
            <%
                String title = request.getParameter("CourseTitle");
                List<Course> courses;
                courses = ObjectifyService.ofy()
                        .load()
                        .type(Course.class)
                        .filter("title =",title)
                        .list();
                pageContext.setAttribute("courses", courses);
            %>
            <c:choose>
                <c:when test="${empty courses}">
                    No course found!
                </c:when>
                <c:otherwise>
                    <c:forEach var="x" items="${courses}">
                        <li class="list-group-item">
                            <div class="panel panel-default panel1">
                                <div class="panel-heading">
                                    <a data-toggle="collapse" href="#${x.id}">${x.title}</a>
                                </div>
                                <div id="${x.id}" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <p style="color:black">Instructors: ${x.instructor}</p>
                                        <span>Access Code: <input style="color:black" type="text" name="AccessCode" value="Code"></span>
                                        <form action="/enrollCourse">
                                            <input name="courseId" type="hidden" value="${x.id}">
                                            <input name="userEmail" type="hidden" value="${user}">
                                            <input name="confirm" type="submit" value="Enroll">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </li>

                        <%--<li name=x.title >${x.title}</li>--%>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <%--<a href="#" class="list-group-item list-group-item-action">CSE 111--%>
            <%--<button type="button" class="btn btn-primary" onclick="toEditCourse()">Edit</button>--%>
            <%--<form id="toEditCourse"><input type="hidden"></form>--%>
            <%--</a>--%>
            <%--<a href="#" class="list-group-item list-group-item-action">CSE 123</a>--%>
            <%--<a href="#" class="list-group-item list-group-item-action">CSE 235</a>--%>
            <%--<a href="#" class="list-group-item list-group-item-action">CSE 456</a>--%>
            <%--<a href="#" class="list-group-item list-group-item-action">CSE 222</a>--%>
        </ul>
    </div>


    <%--<div class="join_course">--%>
        <%--<lable>Course Access Code:</lable>--%>
        <%--<input name="AccessCode" type="text" size="10" value="">--%>
        <%--<input id="join_btn" type="submit" value="Add" onclick="searchCourseToMain();">--%>
        <%--<form id="searchCourseToMain"><input type="hidden"></form>--%>
    <%--</div>--%>


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

</body>
</html>
