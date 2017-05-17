<%--
  Created by IntelliJ IDEA.
  User: Shanshan Chen, Yanda Wu
  Date: 5/2/2017
  Time: 11:56 PM
  To change this template use File | Settings | File Templates.
--%>

<%--This is the edit lesson page --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

    <title>Edit Lesson</title>

    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../stylesheets/layout.css" rel="stylesheet">
    <link href="../../stylesheets/navigation.css" rel="stylesheet">
    <link href="../../stylesheets/editLesson.css" rel="stylesheet">

    <!-- Latest compiled JavaScript -->
    <script src="../../bootstrap/js/bootstrap.min.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<%--if user click the back button from editCourse, s/he will be redirected to this page and it needs to be refreshed to generate a new blobstore uploadUrl--%>
<body onload="refreshEditLesson();">
    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top top-nav-collapse" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#" onclick="editLessonToHome()">I-Programming</a>
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
                <div class="inner editLesson">
                    <h2>Edit Lesson</h2>
                    <h5>*denotes a required field</h5>
                    <br>
                    <div class="help-block"></div>
                    <div class="row">
                        <div class="col-md-4" ><h4>Lesson Title*</h4></div>
                        <div class="col-md-7">
                            <input type="text" id="inputEditLessonID" class="form-control" name="lessonTitle"  placeholder="eg. 1234" required autofocus form="lessonInfo">
                        </div>
                    </div>
                    <div class="help-block"></div>
                    <div class="row">
                        <div class="col-md-4"><h4>Lesson Body</h4></div>
                        <div class="col-md-7">
                            <textarea id="lessonBody" class="form-control" name="lessonBody" rows="3" form="lessonInfo"></textarea>
                        </div>
                    </div>
                    <div class="help-block"></div>
                    <div class="row">
                        <div class="col-md-4"><h4>Google SlideShow Link</h4></div>
                        <div class="col-md-7">
                            <input type="text" id="slideShowLink" class="form-control" name="pptLink" placeholder="Insert the Google Slideshow embed URL here" form="lessonInfo">
                            <textarea id="slideShowDescription" class="form-control" rows="3" wrap="soft" name="pptDescription" placeholder="Add slideshow description here" form="lessonInfo"></textarea>
                        </div>
                    </div>
                    <div class="help-block"></div>
                    <div class="row">
                        <div class="col-md-4"><h4>Videos</h4></div>
                        <div id="videoAdding" class="col-md-7">
                            <div id="dynamicInputVideo">

                            </div>
                            <%--video Upload Option dropdown box--%>
                            <select id="videoUploadOption" class="btn btn-primary btn-block" onchange="enableOptionButton()">
                                <option value="" disabled="disabled" selected="selected">Select an upload option to add a video</option>
                                <option value="1">Paste Link</option>
                                <option value="2">Upload File</option>
                            </select>
                            <%--add more video button--%>
                            <div id="optionButtonVideo">
                                <input id="addOptionButtonVideo" class="add-delete-btn btn btn-primary" type="button" value="Add Video" disabled="disabled" onClick="addVideoOptions('dynamicInputVideo');">
                                <input id="deleteOptionButtonVideo" class="add-delete-btn btn btn-primary" type="button" value="Delete Video" disabled="disabled" onClick="deleteVideoOptions();">
                            </div>
                        </div>
                    </div>
                    <div class="help-block"></div>
                    <div class="row">
                        <div class="col-md-4"><h4>Images</h4></div>
                        <div id="imageAdding" class="col-md-7">
                            <div id="dynamicInputImage">

                            </div>
                            <%--add more image button--%>
                            <div id="optionButtonImage">
                                <input id="addOptionButtonImage" class="add-delete-btn btn btn-primary" type="button" value="Add Image" onClick="addImageButton('dynamicInputImage');">
                                <input id="deleteOptionButtonImage" class="add-delete-btn btn btn-primary" type="button" value="Delete Image" disabled="disabled" onClick="deleteImageButton();">
                            </div>
                        </div>
                    </div>
                    <div class="help-block"></div>

                    <div class="help-block"></div>
                    <div class="row">
                        <div class="col-md-4"><h4>Attachments</h4></div>
                        <div id="assignmentAdding" class="col-md-7">
                            <div id="dynamicInputAssignment">

                            </div>
                            <%--add more assignment button--%>
                            <div id="optionButtonAssignment">
                                <input id="addOptionButtonAssignment" class="add-delete-btn btn btn-primary"  type="button" value="Add Assignment" onClick="addAssignmentButton('dynamicInputAssignment');">
                                <input id="deleteOptionButtonAssignment" class="add-delete-btn btn btn-primary" type="button" value="Delete Assignment" disabled="disabled" onClick="deleteAssignmentButton();">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4"></div>
                    <div class="col-md-2">
                        <button class="btn btn-primary btn-block" type="submit" onclick="editLessonConfirm();">Save</button>
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
                            <%--lessonId is used to determine if the action is editing/adding lesson--%>
                            <input type="hidden" name="lessonId" value="${lessonId}">
                        </form>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="col-md-2">
                        <%--<button class="btn btn-primary btn-block" type="submit" onclick="editLessonToEditCourseCancel();">Cancel</button>--%>
                        <button class="btn btn-primary btn-block" type="submit" onclick="goBack()">Cancel</button>
                        <form id="editLessonToEditCourseCancel"><input type="hidden"></form>
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/editLessonFunctions.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/refreshEditLesson.js"></script>
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