<%--
  Created by IntelliJ IDEA.
  User: JIAQI ZHANG
  Date: 4/5/2017
  Time: 11:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    <title>Edit Course</title>

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
                        <a href="#" onclick="editCourseToHome()">I-Programming</a>
                        <form id="editCourseToHome"><input type="hidden"></form>
                    </h3>
                    <nav>
                        <ul class="nav masthead-nav">
                            <li class="active">
                                <div id="my-signin2" style="display: none;"></div>
                                <div id="userEmail"></div>
                            </li>
                            <li>
                                <a href="#" onclick="signOut();">Sign out</a>
                                <form id="signOutToHome"><input type="hidden"></form>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="inner editcourse">
                <h3 class="editlabel">--------Edit Course--------</h3>
                <div class="add-btns-group">
                    <button type="button" class="btn btn-primary" onclick="toEditUnit();">Add Unit
                        <form id="toEditUnit"><input type="hidden" ></form>
                    </button>
                    <button type="button" class="btn btn-primary" onclick="toEditLesson();">Add Lesson
                        <form id="toEditLesson"><input type="hidden" ></form>
                    </button>
                </div>
                <div class="outlinelist">
                    <h3 class="outlinelabel">Course Outline</h3>
                    <ul>
                        <li><a href="#">Unit 1 - Introduction</a>(<a href="#">Edit</a>)</li>
                        <ol>
                            <li><a href="#">Introduction</a>(<a href="#">Edit</a>)</li>
                            <li><a href="#">Filter image</a>(<a href="#">Edit</a>)</li>
                            <li><a href="#">How search works</a>(<a href="#">Edit</a>)</li>
                        </ol>
                        <li><a href="#">Unit 2 - Interpreting Result</a>(<a href="#">Edit</a>)</li>
                        <ol>
                            <li><a href="#">Lesson 1....</a>(<a href="#">Edit</a>)</li>
                            <li><a href="#">Lesson 2...</a>(<a href="#">Edit</a>)</li>
                        </ol>
                    </ul>
                </div>
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
