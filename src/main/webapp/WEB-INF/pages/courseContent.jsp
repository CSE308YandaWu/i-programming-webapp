<%--
  Created by IntelliJ IDEA.
  User: YandaWu
  Date: 4/20/2017
  Time: 5:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

    <title>Lesson Content</title>

    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../stylesheets/layout.css" rel="stylesheet">
    <link href="../../stylesheets/navigation.css" rel="stylesheet">
    <link href="../../stylesheets/lessonContent.css" rel="stylesheet">

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
            <a class="navbar-brand" href="#" onclick="courseContentToHome()">I-Programming</a>
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
            <br><br><br><br>
            <h1 class="cover-heading">Lesson: ${lesson.lessonTitle}</h1>
            <h3 class="cover-heading">${lesson.lessonBody}</h3>

            <div class="inner cover">
                <h3 class = "text" >
                    <br>
                    <c:choose>
                        <c:when test="${lesson.pptLink!=''}">
                            <p class="text">
                            <%--<p style="font-size:36px;">Slide Show Section</p>--%>
                            <%--<br><br>--%>
                            <div id="doc">
                                <iframe src="${lesson.pptLink}" frameborder="0" width="800" height="500" allowfullscreen="true"  mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>
                            </div>
                            </p>
                        </c:when>
                        <c:otherwise>
                            <%--<p style="font-size:36px;">no pptlink</p>--%>
                            <%--<br />--%>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${lesson.pptDescription!=null}">
                            <p class="text">
                                <p class="item-descp">${lesson.pptDescription}</p>
                            </p>
                        </c:when>
                        <c:otherwise>
                            <%--<p style="font-size:36px;">no pptDescription</p>--%>
                            <%--<br />--%>
                        </c:otherwise>
                    </c:choose>
                    <br>
                    <c:choose>
                        <c:when test="${lesson.videoTypes!=null}">
                            <%--<p class="text">--%>
                            <%--<p style="font-size:36px;">Video Lecture Section</p>--%>
                            <%--<br>--%>
                            <br><br>
                            <div id="doc">
                                <c:set var="videoLinkIndex" value="0" scope="page" />
                                <c:set var="videoFileIndex" value="0" scope="page" />
                                <ul>
                                    <c:forEach var="listValue" items="${lesson.videoTypes}" varStatus="loop">
                                        <c:choose>
                                            <c:when test="${listValue == '1'}">
                                                <iframe src="${lesson.videoLinks[videoLinkIndex]}" frameborder="0" width="800" height="500" allowfullscreen="true"  mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>
                                                <p class="text">
                                                    <p class="item-descp">${lesson.videoDescriptions[loop.index]}</p>
                                                </p>
                                                <c:set var="videoLinkIndex" value="${videoLinkIndex + 1}" scope="page"/>
                                            </c:when>
                                            <c:otherwise>
                                                <video width="800" height="500" controls>
                                                    <source src="http://localhost:8080/serve?key=${lesson.videoBlobKeysList[videoFileIndex]}" type="video/mp4">
                                                    <%--<source src="http://i-programming.appspot.com/serve?key=${lesson.videoBlobKeysList[videoFileIndex]}" type="video/mp4">--%>
                                                </video>
                                                <p class="text">
                                                    <p class="item-descp">${lesson.videoDescriptions[loop.index]}</p>
                                                </p>
                                                <c:set var="videoFileIndex" value="${videoFileIndex + 1}" scope="page"/>
                                                <br />
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </ul>
                            </div>
                            </p>
                        </c:when>
                        <c:otherwise>
                            <%--<p style="font-size:36px;">no video </p>--%>
                            <%--<br />--%>
                        </c:otherwise>
                    </c:choose>
                    <br>
                    <c:choose>
                        <c:when test="${lesson.imageServingUrlList!=null}">
                            <%--<p class="text">--%>
                            <%--<p style="font-size:36px;">Image Section</p>--%>
                            <%--<br>--%>
                            <%--Resized Image:--%>
                            <%--<br>--%>
                            <img src=${model.url}>
                            <ul>
                                <c:forEach var="listValue" items="${lesson.imageServingUrlList}" varStatus="loop">
                                    <img src=${listValue}><br>
                                    <p class="text">
                                        <p class="item-descp">${lesson.imageDescriptions[loop.index]}</p>
                                    </p>
                                </c:forEach>
                            </ul>
                            <br>
                            <%--<a href="#" onclick="serveImage();"><p style="color:deepskyblue;">View Original Image</p></a>--%>
                            <%--<form id="serveImage" target="_blank"><input type="hidden" name="key" value="${model.blobKeyI}" ></form>--%>
                            </p>
                        </c:when>
                        <c:otherwise>
                            <%--<p style="font-size:36px;">no uploaded image file</p>--%>
                            <%--<br />--%>
                        </c:otherwise>
                    </c:choose>
                    <br>
                    <c:choose>
                        <c:when test="${lesson.assignmentBlobKeysList!=null}">
                            <%--<p class="text">--%>
                            <%--<p style="font-size:36px;">Assignment Section</p>--%>
                            <%--<br>--%>
                            <ul>
                                <c:forEach var="listValue" items="${lesson.assignmentBlobKeysList}" varStatus="loop">
                                    <a href="#" onclick="serveAssignment(${loop.index}); return false;"><p style="color:deepskyblue;">${lesson.assignmentFileNameList[loop.index]}</p></a>
                                    <form id="serveAssignment${loop.index}" target="_blank"><input type="hidden" name="key" value="${listValue}"></form>
                                    <p class="text">
                                        <p class="item-descp">${lesson.assignmentDescriptions[loop.index]}</p>
                                    </p>
                                </c:forEach>
                            </ul>
                            </p>
                        </c:when>
                        <c:otherwise>
                            <%--<p style="font-size:36px;">no uploaded assignment file</p>--%>
                            <%--<br />--%>
                        </c:otherwise>
                    </c:choose>
                    <br>
                </h3>
                <div class="col-md-2">
                    <%--choose where to go back--%>
                    <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="goBackSelector('${originalPlace}')">Back</button>
                    <form id="backToEditCourse">
                        <input type="hidden" name="userEmail" value="${course.email}">
                        <input type="hidden" name="courseId" value="${course.id}">
                        <input type="hidden" name="numEnrolled" value="${course.numEnrolled}">
                        <input type="hidden" name="courseTitle" value="${course.title}">
                        <input type="hidden" name="instructor" value="${course.instructor}">
                        <input type="hidden" name="description" value="${course.description}">
                        <input type="hidden" name="status" value="${course.status}">
                        <input type="hidden" name="accessCode" value="${course.accessCode}">
                    </form>
                    <form id="backToCourseInfo">
                        <input type="hidden" name="courseId" value="${course.id}">
                    </form>
                </div>
                <br><br><br><br><br><br><br><br><br>
                    <%--End of all sections--%>
                <%--</p>--%>
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
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/googleSignInFunctions.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/homePageNavigation.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/iprogrammingScript.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/courseContentPageFunctions.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="../../jQuery/jquery-3.2.1.js"></script>
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

