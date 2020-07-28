<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 17-5-11
  Time: 下午3:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contact</title>
</head>
<body>
<h1>Contact</h1>
<form action="RegisterServlet" method="post">
    <input type="text" name="password" id="password"/>
    <button type="submit" id="btnSubmit">Submit</button>
</form>
<script type="text/javascript">
    window.onload = function () {
        var submitButton = document.getElementById("btnSubmit");
        submitButton.onclick = function (event) {
            alert("alert")
            return false;
        }
    };
</script>
</body>
</html>
