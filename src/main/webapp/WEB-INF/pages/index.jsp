<%--
  Created by IntelliJ IDEA.
  User: YandaWu
  Date: 4/19/2017
  Time: 12:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.UploadOptions" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%
    //create uploadUrl for upload form
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    UploadOptions uploadOptions = UploadOptions.Builder.withGoogleStorageBucketName("i-programming.appspot.com");
    String uploadUrl = blobstoreService.createUploadUrl("/upload", uploadOptions);
%>

<html>
<head>
    <title>Upload Test</title>
</head>
<body>
<form action="<%= uploadUrl %>" method="post" enctype="multipart/form-data">
    <input type="file" name="myFile">
    <input type="submit" value="Submit">
</form>
</body>
</html>