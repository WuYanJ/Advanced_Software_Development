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

    <title>Signin Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="static/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="static/css/login.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]>
    <script src="static/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="static/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="container">
    <form action="LoginServlet" method="post" class="form-signin">
        <h2 class="form-signin-heading">Please sign in</h2>
        <p style="color: red"><%=request.getAttribute("message") == null ? "" : request.getAttribute("message")%></p>
        <input type="text" id="username" name="usernameORemail" class="form-control"
               placeholder="Username/Email" value="<%=request.getParameter("usernameORemail") == null ? "":request.getParameter("usernameORemail")%>" required autofocus>
        <br>
        <input type="password" id="password" name="password" id="inputPassword" class="form-control"
               placeholder="Password" value="<%=request.getParameter("password") == null ? "":request.getParameter("password")%>" required>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> Remember me
            </label>
        </div>
        <br>
        <input type="text"  style="width: 120px" name="captcha">&nbsp;
        <img id="captcha_img" src="http://localhost:8089/JavaWeb/kaptcha.jpg" style="width: 100px;height:30px">
<%--        <img id="captcha_img" src="http://139.224.72.202/JavaWeb2020Summer_war_exploded/kaptcha.jpg" style="width: 100px;height:30px">--%>
        <br><br>
<%--        <button class="btn btn-lg btn-primary btn-block" onclick="sendRequest()">Sign in</button>--%>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
        <br>
        <p class="pull-right"><a href="homepage.jsp">Back to HOMEPAGE</a></p>
    </form>
</div> <!-- /container -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="static/js/jquery.min.js"><\/script>')</script>
<script src="static/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="static/js/ie10-viewport-bug-workaround.js"></script>
<script src="static/js/personalInfo.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="static/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
<script>
    function sendRequest() {
        $.ajax({
            url: "LoginServlet",
            type: "POST",
            dataType: "txt",
            data: {
                username: $("#username").val(),
                password: $("#password").val()
            },
            complete: function (result) {
                console.log(result)
                if (result.responseText === 'success') {
                    alert("success")
                } else {

                }
            }
        });
    }
    $(function () {
        $("#captcha_img").click(function () {
            this.src = "${basePath}kaptcha.jpg";
        })
    })

</script>
