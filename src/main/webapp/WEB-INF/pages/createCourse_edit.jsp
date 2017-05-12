<%--
  Created by IntelliJ IDEA.
  User: GangdiHuang, YANDA WU
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
    <link href="../../bootstrap/css/cover.css" rel="stylesheet">
    <link href="../../stylesheets/main.css" rel="stylesheet">

    <!-- Latest compiled JavaScript -->
    <script src="../../bootstrap/js/bootstrap.min.js"></script>

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
                            <a href="#" onclick="editLessonToHome()">I-Programming</a>
                            <form id="editLessonToHome"><input type="hidden"></form>
                        </h3>
                        <nav>
                            <ul class="nav masthead-nav">
                                <li>
                                    <div id="my-signin2" style="display: none;"></div>
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
                    <div class="row" id="statusRow">
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
                <%--<div class="row">
                    <div class="col-md-5"></div>
                    <div class="col-md-2">
                        <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="editLessonConfirm();">Save</button>
                        <form id="lessonInfo" action="${uploadUrl}" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="userEmail" value="${userEmail}">
                            <input type="hidden" name="courseId" value="${courseId}">
                            <input type="hidden" name="numEnrolled" value="${numEnrolled}">
                            <input type="hidden" name="courseTitle" value="${courseTitle}">
                            <input type="hidden" name="instructor" value="${instructor}">
                            <input type="hidden" name="description" value="${description}">
                            <input type="hidden" name="status" value="${status}">
                            <c:if test="${status == 'private'}">
                                <input type="hidden" name="accessCode" value="${accessCode}">
                            </c:if>
                        </form>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="col-md-2">
                        &lt;%&ndash;<button class="btn btn-lg btn-primary btn-block" type="submit" onclick="editLessonToEditCourseCancel();">Cancel</button>&ndash;%&gt;
                        <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="goBack()">Cancel</button>
                        <form id="editLessonToEditCourseCancel"><input type="hidden"></form>
                    </div>
                </div>--%>
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/iprogrammingScript.js"></script>
    <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
