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

<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.googlecode.objectify.Key" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="Beans.Users" %>
<%@ page import="com.googlecode.objectify.Result" %>
<%@ page import="com.googlecode.objectify.cmd.Query" %>
<%@ page import="com.google.appengine.api.datastore.QueryResultIterator" %>


<head>
    <title>Hello World!</title>
</head>

<body>
Hello World!
<div id="my-signin2"></div>
<%--<div id="my-signin2" style="display: none;"></div>--%>
<div id="userEmail"></div>
<a href="#" onclick="signOut();">Sign out</a>

<%--<a href="#" onclick="signOut();">GET ME OUT</a>--%>
<a href="#" onclick="ff10();">GET ME BACK</a>
<%
    Query<Users> all = ObjectifyService.ofy().load().type(Users.class);
    QueryResultIterator<Users> iterator = all.iterator();
    while (iterator.hasNext()) {
        Users u1 = iterator.next();
        System.out.println(u1.userEmail);
    }
    String userEmail = all.first().now().userEmail;
%>
userEmail is: <%=userEmail%>

<form id="myForm2"><input type="hidden" id="input1" name="email"></form>
</body>
</html>
