<%--
  Created by IntelliJ IDEA.
  User: JIAQI ZHANG
  Date: 4/6/2017
  Time: 3:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.lang.String" %>
<html>
<head>
    <title>Course Page</title>
</head>
<body>
<h1>Hello, still testing on this page</h1>
<%
    String name = (String)request.getAttribute("coursecode");
    System.out.println(name);
    pageContext.setAttribute("name", name);
%>

</body>
</html>
