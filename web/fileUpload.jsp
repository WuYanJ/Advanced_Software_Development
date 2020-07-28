<%@ page import="com.wyj.DAO.TravelImageDao" %>
<%@ page import="com.wyj.Model.TravelImage" %>
<%@ page import="com.wyj.Model.TravelUser" %>
<%@ page import="java.io.File" %><%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 17-5-11
  Time: 下午3:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="static/image/favicon.ico">

    <title>Share Your Story...</title>


    <%--  Font Awesome  --%>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="static/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="static/css/personalInfo.css" rel="stylesheet">


    <script src="static/js/jquery-3.5.1.js"></script>
    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]>
    <script src="static/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="static/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="static/js/holder.min.js"></script>
</head>

<body>
<%
    session.removeAttribute("lastPage");
    session.setAttribute("lastPage", "fileUpload.jsp");
    TravelImageDao travelImageDao = new TravelImageDao();
    TravelUser myself = (TravelUser) session.getAttribute("travelUser");
    String username = myself.getUsername();
    int uid = myself.getUID();
    TravelImage image = new TravelImage();
    String imageURL = "";
    String title = "";
    String photographer = "";
    String topic = "";
    String description = "";
    File file = null;
    boolean modify = false;
    if (request.getParameter("imageURL") != null) {
        modify = true;
        imageURL = request.getParameter("imageURL");
        image = travelImageDao.getImage(imageURL);
        title = image.getTitle();
        photographer = image.getPhotographer();
        topic = image.getContent();
        description = image.getDescription();
    }
%>
<nav class="navbar navbar-fixed-top navbar-inverse">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="homepage.jsp">Daddy Travel Agency</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="#">Home</a></li>
                <li><a href="searchResults.jsp">Search</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i
                            class="fa fa-user-circle-o"></i> <%=username%><strong
                            class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="fileUpload.jsp"><i class="fa fa-plus"></i>&nbsp;Share</a>
                        </li>
                        <li>
                            <a href="pageMyBookmarks.page"><i class="fa fa-heart"></i>&nbsp;Bookmarks</a>
                        </li>
                        <li>
                            <a href="pageMyImages.page"><i class="fa fa-plus"></i>&nbsp;My Page</a>
                        </li>
                        <li>
                            <a href="friends.jsp"><i class="fa fa-heart"></i>&nbsp;Friends</a>
                        </li>
                        <li class="divider">
                        </li>
                        <li>
                            <a href="logout.do">Logout</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.nav-collapse -->
    </div><!-- /.container -->
</nav><!-- /.navbar -->

<div class="container">
    <ul class="breadcrumb">
        <li>
            <a href="#">Home</a>
        </li>
        <li>
            <a href="#">Library</a>
        </li>
        <li class="active">
            Data
        </li>
    </ul>
    <div class="row row-offcanvas row-offcanvas-right">

        <div class="col-xs-12 col-sm-9">
            <p class="pull-right visible-xs">
                <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button>
            </p>
            <div class="jumbotron">
                <h1 style="color:#006633;">Share something with the world.</h1>

                <p>This is photo upload page.</p>
            </div>


            <hr class="featurette-divider">
            <blockquote>
                <p>
                    Better Late Than Never.
                </p> <small>Someone famous <cite>Source Title</cite></small>
            </blockquote>
            <div class="col-xs-12 col-sm-9">
                <div class="container">
                    <form class="form-horizontal" action="uploadServlet" method="post" enctype="multipart/form-data">

                        <%--@declare id="name"--%>
                        <div class="row" style="padding: 20px 0">
                            <h3>Upload Form</h3>
                        </div>
                        <div class="row form-group">
                            <label class="control-label col-lg-1" for="title">Title</label>
                            <div class="col-lg-5 col-md-6">
                                <input class="form-control" name="title" id="title" type="text" value="<%=title%>" required>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="control-label col-lg-1">Photographer</label>
                            <div class="col-lg-5 col-md-6">
                                <input class="form-control" name="photographer" rows="5" value="<%=photographer%>" required/>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="control-label col-lg-1">Topic</label>
                            <div class="col-lg-5 col-md-6">
                                <input class="form-control" name="content" rows="5" value="<%=topic%>" required/>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="control-label col-lg-1">Description</label>
                            <div class="col-lg-5 col-md-6">
                                <textarea class="form-control" name="description" rows="5"
                                          required><%=description%></textarea>
                            </div>
                        </div>
                        <div class="row form-group">
                            <label class="control-label col-lg-1">File </label>
                            <div class="col-lg-5 col-md-6">
                                <input type="file" name="file" id="file0" accept=".jpg,.jpeg,.png" required>
                                <br>
                                <p><%=imageURL == null? "" : imageURL%></p>
                                <br>
                                <img src="" id="img0" style="width: 500px;height: auto;"><br/>
                                <img src="static/image/travel-images/large/<%=imageURL%>" style="width: 500px;height: auto;" id="imagePrevious">
                            </div>
                        </div>

                        <div class="row form-group">
                            <%--@declare id="country"--%><label for="country">Country</label>
                            <select class="form-control col-lg-4">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                        <div class="row form-group">
                            <%--@declare id="city"--%><label for="city">City</label>
                            <select class="form-control col-lg-4">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <button type="submit"><%=modify ? "Confirm" : "Upload"%></button>
                            <input id ="ifModify" type="hidden" name="ifModify" value="aaa"></input>
                        </div>

                    </form>
                </div>
            </div>
        </div><!--/.col-xs-12.col-sm-9-->

        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
            <div class="list-group">
                <a href="#" class="list-group-item active">Link</a>
                <a href="#" class="list-group-item">Link</a>
                <a href="#" class="list-group-item">Link</a>
                <a href="#" class="list-group-item">Link</a>
                <a href="#" class="list-group-item">Link</a>
            </div>
        </div><!--/.sidebar-offcanvas-->
    </div><!--/row-->
    <hr>
    <footer>
        <p>&copy; 2020 Company, Inc.</p>
    </footer>
</div><!--/.container-->
<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="static/js/jquery.min.js"><\/script>')</script>
<script src="static/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="static/js/ie10-viewport-bug-workaround.js"></script>
<script src="static/js/personalInfo.js"></script>
</body>
</html>
<script type="text/javascript">
    function pressSearch(event) {
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if (e && e.keyCode === 13) { // enter 键
            alert("此处回车触发搜索事件");
        }
    }
</script>
<script>
    $("#file0").change(function () {
        var objUrl = getObjectURL(this.files[0]);
        console.log("objUrl = " + objUrl);
        if (objUrl) {
            $("#img0").attr("src", objUrl);
            $("#imagePrevious").attr("src", null);
        }

    });
    $("#file1").change(function () {
        var objUrl = getObjectURL(this.files[0]);
        console.log("objUrl = " + objUrl);
        if (objUrl) {
            $("#img1").attr("src", objUrl);
        }
    });

    //建立一個可存取到該file的url
    function getObjectURL(file) {
        var url = null;
        if (window.createObjectURL != undefined) { // basic
            url = window.createObjectURL(file);
        } else if (window.URL != undefined) { // mozilla(firefox)
            url = window.URL.createObjectURL(file);
        } else if (window.webkitURL != undefined) { // webkit or chrome
            url = window.webkitURL.createObjectURL(file);
        }
        return url;
    }
</script>
<style>
    .breadcrumb {
        background: none;
        padding: 0;
        margin: 0;
        padding-bottom: 17px;
        line-height: normal;
    }
</style>
