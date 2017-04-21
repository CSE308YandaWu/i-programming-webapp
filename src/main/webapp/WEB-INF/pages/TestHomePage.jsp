<%--
  Created by IntelliJ IDEA.
  User: KennyHuang
  Date: 3/31/17
  Time: 1:01 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="/javascripts/script.js"></script>

<head>
    <meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">
    <title>I-programming</title>
</head>
<body>
Welcome, dark blue. let's start coding.

<%--<div id="my-signin2" data-onsuccess="onSignIn" onclick="ff20();"></div>--%>
<%--<form id="myForm">--%>
<%--<input type="hidden" >--%>
<%--</form>--%>
<div id="my-signin2" data-onsuccess="onSignIn"></div>
<a href="#" onclick="signOut();">Sign out</a>

<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
</body>
</html>