<%--
  Created by IntelliJ IDEA.
  User: Shanshan Chen
  Date: 4/5/2017
  Time: 12:50 PM
  The home page of this application.
  TODO: determine if other sections needed
--%>

<%--This is the home page --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/googleSignInFunctions.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/iprogrammingScript.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
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

    <title>Home Page</title>

    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <%--<link href="../../stylesheets/layout.css" rel="stylesheet">--%>
    <link href="../../stylesheets/navigation.css" rel="stylesheet">
    <link href="../../stylesheets/home.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top top-nav-collapse" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <%--<span class="sr-only">Toggle navigation</span>--%>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand page-scroll" href="#page-top">I-Programming</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="nav navbar-nav">
                    <!-- Hidden li included to remove the "back-to-top" option -->
                    <li class="hidden active">
                        <a class="page-scroll" href="#page-top"></a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#about">About</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#contact">Contact</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Intro Section -->
    <section id="intro" class="intro-section intro-shadow">
        <div class="section container">
            <div class="row">
                <div class="col-lg-12">
                    <h2>Welcome to</h2>
                    <h1 class="name">I-Programming</h1>
                    <h4>Start learning with us today:</h4>
                    <%--google SignIn Button--%>
                    <div id="my-signin2" class="btn" data-onsuccess="onSignIn"></div>
                    <form id="formToMain"><input type="hidden" id="userEmail" name="userEmail"></form>
                    <p></p><p>-or-</p>
                    <a class="btn btn-default page-scroll" href="#about">Learn More</a>
                </div>
            </div>
            <video autoplay loop muted poster="../../media/matrix-frame.jpg" id="video-background">
                <source src="../../media/matrix-10s.mp4" type="video/mp4">Your browser does not support the video tag. I suggest you upgrade your browser.
            </video>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="about-section shadow">
        <div class="section container">
            <div class="row">
                <div class="col-lg-12">
                    <h1>About I-Programming</h1>
                    <p>
                        I-Programing is an online web application that allows you to create, share,
                        and access courses on a variety of subjects. Each of the courses can be made
                        by anyone anywhere in the world who wishes to share their knowledge with the
                        rest of the world. By providing this platform, we hope to cultivate a
                        worldwide community of intellectuals.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact-section shadow">
        <div class="section container">
            <div class="row">
                <div class="col-lg-12">
                    <h1>Contact Us</h1>
                    <p>We are the Dark Blue Development Team.</p>
                    <p>Contact us at cse308.darkblue@gmail.com for more information.</p>
                    <br>
                    <img src="../../media/logo-cropped.png">
                </div>
            </div>
        </div>
    </section>

    <!-- Button to go back to top -->
    <a id="back-to-top" href="#page-top" class="btn btn-primary btn-lg back-to-top page-scroll" role="button" title="Click to return on the top page" data-toggle="tooltip" data-placement="left">
        <span class="glyphicon glyphicon-chevron-up"></span>
    </a>


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="../../bootstrap/js/bootstrap.min.js"></script>

    <script src="../../jQuery/jquery-3.2.1.js"></script>
    <script src="../../jQuery/jquery-ui.js"></script>
    <script src="../../jQueryScripts/jQueryEasing.min.js"></script>
    <script src="../../javascripts/scrollingNavbar.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
