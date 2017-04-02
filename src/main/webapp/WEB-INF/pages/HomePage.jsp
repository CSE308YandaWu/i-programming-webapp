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
<script type="text/javascript" src="${pageContext.request.contextPath}/javascripts/script.js"></script>
<meta name="google-signin-client_id" content="340280548361-isjppofa0fvoflvbgdhjjkacvmi4lhms.apps.googleusercontent.com">
<head>
    <title>Iprogramming</title>
</head>
<body>
Welcome, dark blue. let's start coding.
<div class="g-signin2" data-onsuccess="onSignIn"></div>
<a href="#" onclick="signOut();">Sign out</a>
</body>
</html>
