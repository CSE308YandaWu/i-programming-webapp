<%--
  Created by IntelliJ IDEA.
  User: Shanshan Chen
  Date: 4/6/2017
  Time: 2:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.UploadOptions" %>
<!DOCTYPE html>
<html lang="en">

<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">

<%
    //create uploadUrl for upload form
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    UploadOptions uploadOptions = UploadOptions.Builder.withGoogleStorageBucketName("i-programming.appspot.com");
    String uploadUrl = blobstoreService.createUploadUrl("/editLessonConfirm", uploadOptions);
//    String uploadUrlImage = blobstoreService.createUploadUrl("/uploadImage", uploadOptions);
//    String uploadUrlVideo = blobstoreService.createUploadUrl("/uploadVideo", uploadOptions);
%>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <%--<link rel="icon" href="../../favicon.ico">--%>

    <title>Main Page</title>

    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../bootstrap/css/cover.css" rel="stylesheet">

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
                <h2>Edit Lesson</h2>
                <h5>*denotes a required field</h5>
                <br>
                <div class="help-block"></div>
                <div class="row">
                    <div class="col-md-4" ><h4>Lesson Name*</h4></div>
                    <div class="col-md-7">
                        <input type="text" id="inputEditLessonID" class="form-control" name="Lesson ID"  placeholder="eg. 1234" required autofocus>
                    </div>
                </div>
                <div class="help-block"></div>
                <div class="help-block"></div>
                <div class="row">
                    <div class="col-md-4"><h4>Google SlideShow Link</h4></div>
                    <div class="col-md-7">
                        <input type="text" id="slideShowLink" class="form-control" name="pptLink" placeholder="Insert URL here" form="lessonInfo">
                    </div>
                </div>
                <div class="help-block"></div>
                <div class="row">
                    <div class="col-md-4"><h4>Video</h4></div>
                    <div class="col-md-7">
                        <input type="file" multiple name="myFileVideo" form="lessonInfo">
                    </div>
                    <div class="col-md-7">
                        <input type="text" id="videoLink" class="form-control" name="videoLink" placeholder="Insert URL here" form="lessonInfo">
                    </div>
                </div>
                <div class="help-block"></div>
                <div class="row">
                    <div class="col-md-4"><h4>Image</h4></div>
                    <div class="col-md-7">
                        <%--<form class="btn btn-lg btn-primary btn-block" action="<%= uploadUrlImage %>" method="post" enctype="multipart/form-data">--%>
                            <input type="file" multiple name="myFileImage" form="lessonInfo">
                            <%--<input class="btn btn-lg btn-primary btn-block" type="submit" value="Upload Image">--%>
                        <%--</form>--%>
                    </div>
                </div>
                <div class="help-block"></div>
                <div class="row">
                    <div class="col-md-4"><h4>Lesson Body</h4></div>
                    <div class="col-md-7">
                        <!--label for="lessonBody">Lesson Body:</label-->
                        <textarea class="form-control" rows="3" id="lessonBody"></textarea>
                    </div>
                </div>
                <div class="help-block"></div>
                <div class="help-block"></div>
                <div class="row">
                    <div class="col-md-4"><h4>Attachment</h4></div>
                    <div class="col-md-7">
                        <input type="file" multiple name="myFileAssignment" form="lessonInfo">
                        <%--<input class="btn btn-lg btn-primary btn-block" type="submit" value="Upload Assignment">--%>
                    </div>
                </div>
                <div class="help-block"></div>
                <div class="row">
                    <div class="col-md-5"></div>
                    <div class="col-md-2">
                        <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="editLessonConfirm();">Save</button>
                        <form id="lessonInfo" action="<%= uploadUrl %>" method="post" enctype="multipart/form-data"><input type="hidden"></form>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="col-md-2">
                        <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="editLessonToEditCourseCancel();">Cancel</button>
                        <form id="editLessonToEditCourseCancel"><input type="hidden"></form>
                    </div>
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
<script>
    function dropdown(val){
        var y = document.getElementsByClassName('btn btn-default dropdown-toggle');
        var aNode = y[0].innerHTML = val + ' <span class="caret"></span>';
    }
</script>
</body>
</html>