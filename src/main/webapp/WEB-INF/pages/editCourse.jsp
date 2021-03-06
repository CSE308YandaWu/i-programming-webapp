<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: JIAQI ZHANG, YANDA WU
  Date: 4/5/2017
  Time: 11:32 PM
  To change this template use File | Settings | File Templates.
--%>

<%--This is the edit course page --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    <title>Edit Course</title>

    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../stylesheets/layout.css" rel="stylesheet">
    <link href="../../stylesheets/navigation.css" rel="stylesheet">
    <link rel="stylesheet" href="../../stylesheets/editCourse.css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<%--if user click the back button from this page, the editLesson page will need to be refreshed to generate a new blobstore uploadUrl--%>
<body onload="showAccessCode();refreshBackFromEditCoursePage();" id="page-top">
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
                <div class="inner editcourse">
                    <br><br><br>
                    <h2>Edit Course</h2>
                    <h3 class="subheading">Course Details:</h3>
                    <div class="course-info">
                        <table class="table1">
                            <%-- STATIC FIELDS --%>
                            <tr><td>Owner:</td><td>${course.email}</td></tr>
                            <tr><td>Course Id:</td><td>${course.id}</td></tr>
                            <tr><td>Date Created: </td><td>${course.dateCreated}</td></tr>
                            <tr><td>Number Enrolled: </td><td>${course.numEnrolled}</td></tr>
                            <%-- EDITABLE FIELDS --%>
                            <tr>
                                <td>Course Title:</td>
                                <td><input type="text" class="form-control" name="courseTitle" value="${course.title}" oninput="setCourseTitle(this)"></td>
                            </tr>
                            <tr>
                                <td>Instructor:</td>
                                <td><input type="text" class="form-control" name="instructor" value="${course.instructor}" oninput="setInstructor(this)"></td>
                            </tr>
                            <tr>
                                <td>Status:</td>
                                <td><select name="status" id="status" onchange="setStatus(this)">
                                    <c:choose>
                                        <c:when test="${course.status == 'private'}">
                                            <option value="public">Public</option>
                                            <option value="private" selected>Private</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="public" selected>Public</option>
                                            <option value="private">Private</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select></td>
                            </tr>
                            <%--<c:if test="${course.status == 'private'}">--%>
                            <tr id="statusRow">
                                <td>Access Code:</td>
                                <td><input type="text" class="form-control" name="accessCode" value="${course.accessCode}" oninput="setAccessCode(this)"></td>
                            </tr>
                            <%--</c:if>--%>
                            <tr>
                                <td>Description:</td>
                                <td> <textarea class="form-control" rows="5" name="description" oninput="setDescription(this)">${course.description}</textarea></td>
                            </tr>
                        </table>
                    </div>
                    <hr>
                    <div class="outlinelist">
                        <h3 class="subheading">Lessons</h3>
                        <c:choose>
                            <c:when test="${empty lessonList}">
                                There are no lessons. <br><br>
                            </c:when>
                            <c:otherwise>
                            <ul id="sortable" class="lesson-list">
                                <c:forEach var="lesson" items="${lessonList}" varStatus="loop">
                                    <%--loop.index is lesson order index--%>
                                    <li class="ui-state-default" id="${loop.index}">
                                        <div class="lesson-info">
                                            <span class="ui-icon ui-icon-triangle-2-n-s"></span><p class="lesson-name">${lesson.lessonTitle}</p>
                                        </div>
                                        <div class="lesson-edit">
                                            <a href="#" onclick="viewLesson(${loop.index});"><span class="ui-icon ui-icon-document"></span></a>
                                            <a href="#" onclick="editLesson(${loop.index});"><span class="ui-icon ui-icon-pencil"></span></a>
                                            <a href="#" onclick="deleteLesson(${loop.index});"><span class="ui-icon ui-icon-trash"></span></a>
                                            <form id="viewLesson${loop.index}">
                                                <%--lessonId is used to determine if the action is editing/adding lesson--%>
                                                <input type="hidden" name="lessonId" value="${lesson.lessonId}">
                                                <%--needed for the go back button, to indicate where is the viewLesson action come from --%>
                                                <input type="hidden" name="originalPlace" value="editCoursePage">

                                                <input type="hidden" name="userEmail" value="${course.email}">
                                                <input type="hidden" name="courseId" value="${course.id}">
                                                <input type="hidden" name="numEnrolled" value="${course.numEnrolled}">
                                                <input type="hidden" name="courseTitle" id="titleDeleteLesson" value="${course.title}">
                                                <input type="hidden" name="instructor" id="instructorDeleteLesson" value="${course.instructor}">
                                                <input type="hidden" name="description" id="descriptionDeleteLesson" value="${course.description}">
                                                <input type="hidden" name="status" id="statusDeleteLesson" value="${course.status}">
                                                <input type="hidden" name="accessCode" id="accessCodeDeleteLesson" value="${course.accessCode}">
                                            </form>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                            </c:otherwise>
                        </c:choose>
                        <ul><li id="addLesson">
                            <div class="add-lesson">
                                <a href="#" onclick="toEditLesson();" class="list-group-item list-group-item-action">(Click here to add a lesson)</a>
                                <form id="toEditLesson">
                                    <input type="hidden" name="userEmail" value="${course.email}">
                                    <input type="hidden" name="courseId" value="${course.id}">
                                    <input type="hidden" name="numEnrolled" value="${course.numEnrolled}">
                                    <input type="hidden" name="courseTitle" id="titleEditLesson" value="${course.title}">
                                    <input type="hidden" name="instructor" id="instructorEditLesson"
                                           value="${course.instructor}">
                                    <input type="hidden" name="description" id="descriptionEditLesson"
                                           value="${course.description}">
                                    <input type="hidden" name="status" id="statusEditLesson" value="${course.status}">
                                    <input type="hidden" id="accessCodeEditLesson" name="accessCode"
                                           value="${course.accessCode}">
                                </form>
                            </div>
                        </li></ul>
                    </div>
                    <br>
                    <div class="add-btns-group">
                        <form action="/saveCourse">
                            <input type="submit" class="btn btn-primary" onclick="editCourseToMain()" value="Save">
                            <input type="hidden" name="userEmail" value="${course.email}">
                            <input type="hidden" name="courseId" value="${course.id}">
                            <input type="hidden" name="numEnrolled" value="${course.numEnrolled}">
                            <input type="hidden" name="courseTitle" id="title2Save" value="${course.title}">
                            <input type="hidden" name="instructor" id="instructor2Save" value="${course.instructor}">
                            <input type="hidden" name="description" id="description2Save" value="${course.description}">
                            <input type="hidden" name="status" id="status2Save" value="${course.status}">
                            <input type="hidden" name="accessCode" id="accessCode2Save" value="${course.accessCode}">
                            <%--lesson order--%>
                            <input type="hidden" name="lessonOrder" id="lessonOrderID">
                        </form>
                        <form action="/main">
                            <input type="submit" class="btn btn-primary" value="Cancel">
                        </form>
                    </div>
                </div>
                <br>
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
    <script src="../../bootstrap/js/bootstrap.min.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/googleSignInFunctions.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/homePageNavigation.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/iprogrammingScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/refreshEditLesson.js"></script>
    <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

    <script src="../../jQuery/jquery-sortable.js"></script>
    <script src="../../jQuery/jquery-3.2.1.js"></script>
    <script src="../../jQuery/jquery-ui.js"></script>
    <script src="../../javascripts/sortableList.js"></script>
</body>
</html>
