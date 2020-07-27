<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 17-5-11
  Time: 下午3:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="static/image/favicon.ico">

    <title>Sign up Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="static/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="static/css/login.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="static/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="static/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="static/js/holder.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="container">
<form action="RegisterServlet" method="post" class="form-signin" id="form_reg">
    <h2 class="form-signin-heading">Please sign up</h2>
    <p style="color: red"><%=request.getAttribute("message") == null ? "" : request.getAttribute("message")%></p>
    <input type="text" name="username" id="username" class="form-control" onblur="validateUsername()" onfocus="validateUsername()"
           placeholder="Username" value="<%=request.getParameter("username") == null ? "":request.getParameter("username")%>" required autofocus>
    <div id="usernameDiv" style="color: red"></div>
    <br>
    <input type="email" name="email" id="inputEmail" class="form-control"
           placeholder="Email address" value="<%=request.getParameter("email") == null ? "":request.getParameter("email")%>" required autofocus>
    <br>
    <input type="password" name="password" id="inputPassword" class="form-control" onblur="validatePassword()" onfocus="validatePassword()"
           placeholder="Password" value="<%=request.getParameter("password") == null ? "":request.getParameter("password")%>" required autofocus>
    <div id="passwordDiv" style="color: red"></div>
    <br>
    <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" onblur="validateConfirmPassword()" onfocus="validateConfirmPassword()"
           placeholder="Confirm Password" value="<%=request.getParameter("confirmPassword") == null ? "":request.getParameter("confirmPassword")%>" required>
    <div id="confirmPasswordDiv" style="color: red"></div>
    <br>
    <div class="checkbox">
        <label>
            <input type="checkbox" value="remember-me"> Remember me
        </label>
    </div>
    <br>
    <input type="text" style="width: 120px" name="captcha" id="captcha">&nbsp;
    <img id="captcha_img" src="http://localhost:8089/JavaWeb/kaptcha.jpg" style="width: 100px;height:30px">
    <br><br>
    <button class="btn btn-lg btn-primary btn-block" type="submit" id="btnSubmit">Sign up</button><br>
    <p class="pull-right"><a href="homepage.jsp">Back to HOMEPAGE</a></p>
</form>
</div> <!-- /container -->
<%
//    request.getParameter("");
%>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="static/js/jquery.min.js"><\/script>')</script>
<script src="static/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="static/js/ie10-viewport-bug-workaround.js"></script>
<script src="static/js/personalInfo.js"></script>
<script src="static/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
<script type="text/javascript">
    $(function () {
        $("#captcha_img").click(function () {
            this.src = "${basePath}kaptcha.jpg?randomParam="+new Math.random();

        })
    })
    function validateUsername(){
        // 获取用户名
        var username = document.getElementById("username").value;
        var usernameDiv = document.getElementById("usernameDiv");
        if(username.length < 4){
            usernameDiv.innerHTML="Username must be longer than 4 characters";
            return false;
        } else if (username.length > 15){
            usernameDiv.innerHTML="Username must be shorter than 15 characters";
            return false;
        } else if (username.indexOf("@") != -1){
            usernameDiv.innerHTML="Username cannot contain '@'";
            return false;
        } else{
            usernameDiv.innerHTML="";
            return true;
        }
    }
    function validatePassword(){
        var password = document.getElementById("inputPassword").value;
        var passwordDiv = document.getElementById("passwordDiv");
        if(password.length < 6){
            passwordDiv.innerHTML="Password must be longer than 6 characters";
            return false;
        } else if (password.length > 12){
            passwordDiv.innerHTML="Password must be shorter than 12 characters";
            return false;
        } else {
            passwordDiv.innerHTML="";
            return true;
        }
    }
    function validateConfirmPassword(){
        var password = document.getElementById("inputPassword").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var confirmPasswordDiv = document.getElementById("confirmPasswordDiv");
        if(password !== confirmPassword){
            confirmPasswordDiv.innerHTML="Passwords are not identical";
            return false;
        } else {
            confirmPasswordDiv.innerHTML="";
            return true;
        }
    }


</script>
