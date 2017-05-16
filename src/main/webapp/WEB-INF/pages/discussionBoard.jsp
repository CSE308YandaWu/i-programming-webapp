<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: JIAQI ZHANG
  Date: 5/13/2017
  Time: 12:28 AM
  To change this template use File | Settings | File Templates.
--%>

<%--This is the discussion board page --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%--this is needed for the signin-out function so every page should have this --%>
<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">

<head>
    <title>Discussion Board</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../../stylesheets/main.css">
    <!-- Bootstrap core CSS -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../../stylesheets/discussionBoard.css" rel="stylesheet">
</head>
<body>
<div class="site-wrapper">
    <div class="masthead clearfix">
        <div class="inner">
            <h3 class="masthead-brand">
                <a href="#" onclick="searchCourseToHome()">I-Programming</a>
            </h3>
            <form id="backToHome"><input type="hidden"></form>
            <nav>
                <ul class="nav masthead-nav">
                    <li>
                        <div id="my-signin2" style="display: none;"></div>
                        <a id="userEmail">${userObject.userEmail}</a>
                    </li>
                    <li>
                        <a href="#" onclick="signOut();">Sign out</a>
                        <form id="signOutToHome"><input type="hidden"></form>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
    <div class="site-wrapper-inner">
        <div class="text-heading">
            <h2>${course.title} Discussion Board</h2>
        </div>
        <div class="discussion-board">
            <div class="post-comment">
                <ul>
                    <li>
                        <h4>${userObject.userEmail}:</h4>
                    </li>
                    <li>
                        <textarea rows="7" placeholder="write a comment..." form="postComment"
                                  name="comment"></textarea>
                    </li>
                    <li>
                        <input type="submit" form="postComment" value="Post" class="btn btn-primary post-btn">
                    </li>
                    <form action="/discussionBoard" method="post" id="postComment">
                        <input type="hidden" name="userEmail" value="${userObject.userEmail}">
                        <input type="hidden" name="courseId" value="${course.id}">
                    </form>
                </ul>
            </div>
            <div class="comment-list">
                <div class="sort-select">
                    <form id="sortForm" action="/sortComment">
                        <input type="hidden" name="courseId" value="${course.id}">
                        <select name="sortMethod" id="sortSelect" onchange="this.form.submit()">
                            <option value="" disabled selected>Sort Comment..</option>
                            <option value="newest">Newest Comment</option>
                            <option value="top">Top Comment</option>
                        </select>
                    </form>
                </div>
                <h3>Comments(${fn:length(commentList)})</h3>
                <hr>
                <c:if test="${!empty commentList}">
                    <c:forEach var="x" items="${commentList}" varStatus="loop">
                        <div class="comment-item">
                                <%--<span style="float: right">${x.likes} likes</span>--%>
                            <h4>${x.author} <span class="date">${x.dateCreated}</span></h4>
                            <p>${x.comment}</p>
                            <a href="#reply${loop.index}" data-toggle="collapse">Reply</a>&nbsp;&nbsp;
                            <a href="#" onclick="likeComment(${loop.index})">Like</a>&nbsp;&nbsp;
                            <a href="#" onclick="dislikeComment(${loop.index})">Dislike</a>&nbsp;&nbsp;${x.likes}&nbsp;&nbsp;
                                    <c:if test="${x.author eq userObject.userEmail}">
                                        <a href="#" onclick="deleteComment(${loop.index})">Delete</a>
                                        <form id="deleteComment${loop.index}" action="/deleteComment">
                                            <input type="hidden" name="courseId" value="${course.id}">
                                            <input type="hidden" name="commentId" value="${x.id}">
                                        </form>
                                    </c:if>
                            <form id="likeForm${loop.index}">
                                <input type="hidden" name="courseId" value="${course.id}">
                                <input type="hidden" name="commentId" value="${x.id}">
                            </form>
                            <div class="reply collapse" id="reply${loop.index}">
                                <form action="/discussionBoard" method="post">
                                    <span>${userObject.userEmail}: </span><br>
                                    <input type="hidden" name="userEmail" value="${userObject.userEmail}">
                                    <input type="hidden" name="courseId" value="${course.id}">
                                    <input type="hidden" name="commentId" value="${x.id}">
                                    <input type="text" class="reply-box" name="comment" placeholder="write a reply...">
                                    <input type="submit" value="Post" class="btn btn-primary post-btn">
                                </form>
                            </div>
                            <div class="reply-list">
                                <c:if test="${!empty replyMap[x.id]}">
                                    <c:forEach var="reply" items="${replyMap[x.id]}">
                                        <div class="reply-item">
                                                <%--<span style="float: right">${reply.likes} likes</span>--%>
                                            <h4>${reply.author} <span class="date">${reply.dateCreated}</span></h4>
                                            <p>${reply.comment}</p>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
        <form action="/enterCourse">
            <input type="submit" class="btn btn-primary back-btn" value="Back">
            <input type="hidden" name="courseId" value="${course.id}">
        </form>
    </div>
    <div class="mastfoot">
        <div class="inner">
            <p>Developed by Dark Blue Team.</p>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="/bootstrap/js/bootstrap.js/bootstrap.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/discussionBoard.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/googleSignInFunctions.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/homePageNavigation.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/iprogrammingScript.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/courseContentPageFunctions.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
