<%--&lt;%&ndash;
  Created by IntelliJ IDEA.
  User: wuyanjie
  Date: 2020/7/7
  Time: 1:28 下午
  To change this template use File | Settings | File Templates.
--%>
<%-- session="false"因为如果创建了session对象用的也是cookie --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<html>
<head>
    <title>Cookie</title>
</head>
<body>
<%
//    1. 创建一个cookie对象
// 需要一个键值对
    Cookie cookie = new Cookie("name", "myCookie");
    //    2. 调用response的一个方法把cookie传给客户端
    response.addCookie(cookie);
    // 获取cookie
    Cookie[]cookies = request.getCookies();
    if(cookies != null && cookies.length > 1) {
        for(Cookie cookie1 : cookies) {
            out.print(cookie1.getName()+":"+cookie1.getValue());
        }
    }
%>
</body>
</html>
