<%--
  Created by IntelliJ IDEA.
  User: YandaWu
  Date: 4/5/2017
  Time: 12:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/script.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <%--<link rel="icon" href="../../favicon.ico">--%>

    <title>Home Page</title>

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
                    <h3 class="masthead-brand">I-Programming</h3>
                    <nav>
                        <ul class="nav masthead-nav">
                            <li class="active"><a href="#">Home</a></li>
                            <li><a href="#">Help</a></li>
                            <%--<li><a href="#">Sign in</a></li>--%>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="inner cover">
                <h1 class="cover-heading">Welcome to I-Programming!</h1>
                <p class="lead">I-Programing is an online informal education web app that uses an innovative approach to develop an interactive student progress verification
                    system to help users learn a programing language in an easy and fast
                    way.</p>
                <%--<p class="lead">--%>
                    <%--<a href="#" class="btn btn-lg btn-default">Learn more</a>--%>
                    <%--<div class="btn btn-lg btn-default" data-onsuccess="onSignIn"></div>--%>
                    <div id="my-signin2" class="btn"></div>

                <%--</p>--%>
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
<script src="../../dist/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
