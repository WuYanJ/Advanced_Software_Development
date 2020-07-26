<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.wyj.Model.TravelImage" %>
<%@ page import="com.wyj.DAO.TravelImageDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.wyj.Model.TravelUser" %><%--
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

    <title>Personal Info</title>


    <%--  Font Awesome  --%>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="static/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="static/css/personalInfo.css" rel="stylesheet">


    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="static/js/ie8-responsive-file-warning.js"></script><![endif]-->
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
    TravelUser myself = (TravelUser) session.getAttribute("travelUser");
    String username = "";
    int uid = 0;
    if(myself != null){
      username = myself.getUsername();
      uid = myself.getUID();
    }
  %>
  <nav class="navbar navbar-fixed-top navbar-inverse">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
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
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user-circle-o"></i> <%=username%><strong class="caret"></strong></a>
            <ul class="dropdown-menu">
              <li>
                <a href="fileUpload.jsp"><i class="fa fa-plus"></i>&nbsp;Share</a>
              </li>
              <li>
                <a href="bookmarks.jsp?username=<%=username%>"><i class="fa fa-heart"></i>&nbsp;Bookmarks</a>
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
          <%
            List<TravelImage> uploadedImages = new ArrayList<>();

            // 用UID查询数据库,获取"我上传的图片"的imageURL的集合
            List<String> uploadedImageURLs = new ArrayList<>();
            TravelImageDao travelImageDao = new TravelImageDao();
            try {
              uploadedImages = travelImageDao.getMyImages(username);
            } catch (SQLException e) {
              e.printStackTrace();
            }
          %>
          <div class="jumbotron">
            <h1 style="color:#006633;">Hello, <span style="color:#99CC00;"><%= username %>!</span></h1>

            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= username %>'s Personal Information</h3>
              </div>
              <div class="panel-body">
                <ul class="list-group">
                  <li class="list-group-item">Username: <%= username %></li>
<%--                  <li class="list-group-item">Email: <%= email %></li>--%>
                </ul>
              </div>
            </div>
            <p>This is personal information page. This page contains basic information and User's Photo Uploads.</p>
          </div>


          <hr class="featurette-divider">
            <blockquote>
              <p>
                Better Late Than Never.
              </p> <small>Someone famous <cite>Source Title</cite></small>
            </blockquote>

          <%
            for(TravelImage travelImage : uploadedImages) {
              System.out.println(uploadedImages.indexOf(travelImage)%2);
              String class1 = uploadedImages.indexOf(travelImage)%2==0?"col-md-7":"col-md-7 col-md-push-5";
              String class2 = uploadedImages.indexOf(travelImage)%2==0?"col-md-5":"col-md-5 col-md-pull-7";
              %>
          <div class="row featurette">
            <div class=<%= class1 %>>
              <h2 class="featurette-heading" style="color: #3c763d"><%=travelImage.getTitle()%>.<span style="color: #99CC00">It'll blow your mind.</span></h2>
              <p class="lead"><%=travelImage.getDescription()%></p>
              <a href="fileUpload.jsp?imageURL=<%=travelImage.getPath()%>" class="btn btn-default">Modify</a>
              <a href="deleteMyUpload.do?imageURL=<%=travelImage.getPath()%>" class="delete btn btn-default">Delete</a>
            </div>
            <div class=<%= class2 %>>
              <img class="featurette-image img-responsive center-block" src="static/image/travel-images/large/<%= travelImage.getPath() %>" alt="<%= travelImage.getTitle() %>>">
            </div>
          </div>
          <hr class="featurette-divider">
          <%
            }
          %>
<%--          <hr class="featurette-divider">--%>
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
  $(function () {
    $(".delete").click(function () {
      var flag = confirm("Delete this photo？");
      return flag;
    })
  })

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

