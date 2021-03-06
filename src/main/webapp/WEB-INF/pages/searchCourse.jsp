<%--
  Created by IntelliJ IDEA.
  User: GangdiHuang, YANDA WU
  Date: 4/5/17
  Time: 6:39 PM
  To change this template use File | Settings | File Templates.
  This page is used to display the search results returned when the user is looking for a new course to add
--%>


<%--This is the serarch course page --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<%--this is needed for the signin-out function so every page should have this --%>
<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">

<head>
    <title>Course Search</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../../stylesheets/mainPage.css">
    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../stylesheets/layout.css" rel="stylesheet">
    <link href="../../stylesheets/navigation.css" rel="stylesheet">
    <link href="../../stylesheets/searchCourse.css" rel="stylesheet">
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
                <a class="navbar-brand" href="#" onclick="searchCourseToHome()">I-Programming</a>
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
                <div class="inner">
                    <div class="searchContainer">
                        <form action="#" type="hidden" id="searchClass">
                            <div class="row">
                                <div class="col-md-1" ><h4>Search:</h4></div>
                                <div class="col-md-7" >
                                    <input type="text" class="form-control" name="UserIn" id="UserIn" type="text"  placeholder="Enter course to search for..." required autofocus>
                                </div>
                                <div class="col-md-3" >
                                    <select name="MySelect" id="MySelect" style="color:black">
                                        <option name="Search_by_title" value="title">Search by title</option>
                                        <option name="Search_by_instructor" value="instructor">Search by instructor</option>
                                    </select>
                                </div>
                                <div class="col-md-1" >
                                    <button id="search_btn" class="btn btn-block btn-primary btn-block" type="submit" onclick="do_search()">Go!</button>
                                </div>
                                <input type = hidden name="Select_method" id="select_method" >
                            </div>
                        </form>
                        <br><br><br>
                        <div class="resultlist">
                            <h2>Search Results</h2>
                            <ul class="list-group">
                                <c:choose>
                                    <c:when test="${empty result}">
                                        No courses found!
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="x" items="${result}" varStatus="loop">
                                            <li class="list-group-item">
                                                <div class="panel panel-default panel1">
                                                    <div class="panel-heading">
                                                        <a data-toggle="collapse" href="#${x.id}">${x.title}</a>
                                                    </div>
                                                    <div id="${x.id}" class="panel-collapse collapse">
                                                        <div class="panel-body panelbody">
                                                            <p>Instructors: ${x.instructor}</p>
                                                            <p>Status: ${x.status}</p>
                                                            <form action="/enrollCourse" id="enrollForm" onsubmit="return checkCode(${x.accessCode},${loop.index})">
                                                                <input name="courseId" type="hidden" value="${x.id}">
                                                                <input name="userEmail" type="hidden" value="${user}">
                                                                <c:if test="${x.status == 'private'}">
                                                                    <p>Access Code: <input type="text" id="accessCode${loop.index}" name="accessCode"></p>
                                                                </c:if>
                                                                <input type="submit" value="Enroll">
                                                            </form>
                                                            <p class="errorMsg" id="errorMsg${loop.index}">Access Code is invalid. Fail to enroll.</p>
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/SearchCourse.js"></script>
    <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
