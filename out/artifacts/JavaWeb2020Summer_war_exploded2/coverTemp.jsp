<%--&lt;%&ndash;
  Created by IntelliJ IDEA.
  User: wuyanjie
  Date: 2020/7/7
  Time: 1:28 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Tomcat测试</title>
  </head>
  <body>
  <h1>Tomcat测试1</h1>
  <%
    System.out.println(request.getServletContext().getRealPath("/"));
  %>
  </body>
</html>
