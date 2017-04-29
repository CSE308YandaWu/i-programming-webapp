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

<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <%--<link rel="icon" href="../../favicon.ico">--%>

    <title>Course Content Page</title>

    <!-- Bootstrap core CSS -->
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
                        <a href="#" onclick="courseContentToHome()">I-Programming</a>
                        <form id="courseContentToHome"><input type="hidden"></form>
                    </h3>
                    <nav>
                        <ul class="nav masthead-nav">
                            <li>
                                <div id="my-signin2" style="display: none;"></div>
                                <a id="userEmail"></a>
                            </li>
                            <li>
                                <a href="#" onclick="signOut();">Sign out</a>
                                <form id="signOutToHome"><input type="hidden"></form>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            <h1 class="cover-heading">Course Content Page</h1>
            <br><br>
            <div class="inner cover">
                <h3 class = "text" >
                    <br><br>
                    <c:choose>
                        <c:when test="${model.pptLink!=null}">
                            <p class="text">
                            <p style="font-size:36px;">Slide Show Section</p>
                            <br>
                            <br><br>
                            <div id="doc">
                                <iframe src="${model.pptLink}" frameborder="0" width="800" height="500" allowfullscreen="true"  mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>
                            </div>
                            </p>
                        </c:when>
                        <c:otherwise>
                            <p style="font-size:36px;">nothing</p>
                            <br />
                        </c:otherwise>
                    </c:choose>

                    <br><br>
                    <c:choose>
                        <c:when test="${model.videoLink!=null}">
                            <p class="text">
                            <p style="font-size:36px;">Video Lecture Section</p>
                            <br>
                            <br><br>
                            <div id="doc">
                                <iframe src="${model.videoLink}" frameborder="0" width="800" height="500" allowfullscreen="true"  mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>
                            </div>
                            </p>
                        </c:when>
                        <c:otherwise>
                            <p style="font-size:36px;">nothing</p>
                            <br />
                        </c:otherwise>
                    </c:choose>
                    <br><br>
                    <%--<p class="text">--%>
                    <%--<p style="font-size:36px;">Video Section</p>--%>
                    <%--<br>--%>
                    <%--<a href="#" onclick="serveVideo();"><p style="color:deepskyblue;">View Video</p></a>--%>
                    <%--<form id="serveVideo" target="_blank"><input type="hidden" name="key" value="${model.blobKeyV}" ></form>--%>
                    <%--</p>--%>
                    <br><br>
                    <p class="text">
                        <p style="font-size:36px;">Image Section</p>
                        <br>
                        Resized Image:
                        <br>
                        <img src=${model.url}>
                        <br>
                        <a href="#" onclick="serveImage();"><p style="color:deepskyblue;">View Original Image</p></a>
                        <form id="serveImage" target="_blank"><input type="hidden" name="key" value="${model.blobKeyI}" ></form>
                    </p>
                    <br><br>
                    <p class="text">
                    <p style="font-size:36px;">Assignment Section</p>
                    <br>
                    <a href="#" onclick="serveAssignment();"><p style="color:deepskyblue;">View Assignment</p></a>
                    <form id="serveAssignment" target="_blank"><input type="hidden" name="key" value="${model.blobKeyA}"></form>

                    <a href="#" onclick="serveAssignment1();"><p style="color:deepskyblue;">View Assignment1</p></a>
                    <form id="serveAssignment1" target="_blank"><input type="hidden" name="key" value="${model.blobKeyA1}"></form>
                    </p>
                    <br><br>
                </h3>
                <p class="text">
                    End of all sections
                </p>
            </div>
            <div class="mastfoot">
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

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

