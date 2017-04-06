<%--
  Created by IntelliJ IDEA.
  User: Epic_Miracle_
  Date: 4/5/2017
  Time: 10:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="/javascripts/script.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<meta name="google-signin-client_id" content="340280548361-mli8u43jgqf6ijkkkffk6ilmke2hkphl.apps.googleusercontent.com">
<head>
    <title>Hello World!</title>
</head>

<body onload="userEmailDisplay()">
Hello World!

<div id="userEmail"></div>
<%--<a href="#" onclick="signOut();">GET ME OUT</a>--%>
<a href="#" onclick="ff10();">GET ME BACK</a>
<form id="myForm2"><input type="hidden" id="input1" name="email"></form>
</body>
</html>
