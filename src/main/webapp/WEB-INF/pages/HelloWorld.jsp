<%@ page import="com.google.appengine.api.blobstore.BlobKey" %><%--
  Created by IntelliJ IDEA.
  User: YandaWu
  Date: 4/5/2017
  Time: 10:11 PM
  To change this template use File | Settings | File Templates.
--%>

<%--this page is used with index.jsp to test the Blobstore--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="/javascripts/script.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">

<head>
    <title>Hello World!</title>
</head>

<body>
<title>Hello World!</title>

<img src=${model.url}>
<p>THE KEY is: ${model.blobKey}</p>

<div id="my-signin2"></div>
<%--<div id="my-signin2" style="display: none;"></div>--%>
<div id="userEmail"></div>
<a href="#" onclick="signOut();">Sign out</a>

<a href="#" onclick="ff10();">GET ME BACK</a>
<form id="myForm2"></form>
<a href="#" onclick="ff30();">Serve!</a>

<%--https://drive.google.com/file/d/0Bxvj3nOK7Tf-NzI0NmJpU3BNXzg/view?usp=sharing--%>
<%--<a href="https://docs.google.com/uc?export=download&id=0Bxvj3nOK7Tf-NzI0NmJpU3BNXzg"> Edit Google Drive share link to DownloadLink!!! </a>--%>
<form id="serve"><input type="hidden" name="key" value="${model.blobKey}"></form>
<div id="ppt"><iframe src="https://docs.google.com/presentation/d/1cuyhAboik9tKx446da2ULyyQfyJGhjrlz983fUmrGgw/embed?start=false&loop=false&delayms=3000"
                      frameborder="0" width="960" height="569" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe></div>
<div id="doc"><iframe src="https://docs.google.com/document/d/1GL_KRk1lLJEg3aiTbnKyzCY-8VP-SH33YryiwkSfUA0/pub?embedded=true"
                      frameborder="0" width="960" height="569" allowfullscreen="true"  mozallowfullscreen="true" webkitallowfullscreen="true"></iframe></div>
</body>
</html>
