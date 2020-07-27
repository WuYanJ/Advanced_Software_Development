<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wyj.Utils.DataBaseUtils" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.wyj.DAO.TravelImageDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.wyj.DAO.TravelUserDao" %>
<%@ page import="com.wyj.Model.TravelImage" %>
<%@ page import="com.wyj.DAO.DAO" %>
<%@ page import="com.wyj.Model.Page" %><%--
  Created by IntelliJ IDEA.
  User: wuyanjie
  Date: 2020/7/12
  Time: 7:55 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bookmarks</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="static/image/favicon.ico">

    <!-- Bootstrap core CSS -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="static/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="static/css/personalInfo.css" rel="stylesheet">

    <%--  Font Awesome  --%>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

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
    // 这一行最后需要删掉，username应该在login或register的时候就存在session中
    session.setAttribute("username", "SpongeBob");
    session.setAttribute("uid", 12);
    ///
    DAO dao = new DAO();
    String username = request.getParameter("username");
    String sql = "SELECT uid FROM travels.traveluser WHERE username=?";
    int uid = dao.getForValue(sql, username);

    TravelImageDao travelImageDao = new TravelImageDao();
    TravelUserDao travelUserDao = new TravelUserDao();

    Page<TravelImage> bookmarkPage = (Page<TravelImage>) request.getAttribute("page");
    List<String> bookmarkList = travelUserDao.getMyBookmarkedImagePaths(uid);
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
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user-circle-o"></i> <%=username%><strong
                            class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="fileUpload.jsp"><i class="fa fa-plus"></i>&nbsp;Share</a>
                        </li>
                        <li>
                            <a href="personalInfo.jsp"><i class="fa fa-plus"></i>&nbsp;My Page</a>
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
                <h1 style="color: #006633">WELCOME to </h1>
                <h1 style="color: #99CC00"><%= username %>'s Bookmark</h1>
                <p>This is bookmark page. This page contains User's photo bookmark.</p>
            </div>


            <hr class="featurette-divider">
            <blockquote>
                <p>
                    Better Late Than Never.
                </p> <small>Someone famous <cite>Source Title</cite></small>
            </blockquote>

            <h1>Bookmarks</h1>
            <%
                int currentImageID = 0;
//                if (!bookmarkList.isEmpty()) {
//                    for (String bookmark : bookmarkList) {
//                        try {
//                            currentImageID = travelImageDao.path2imageID(bookmark);
//                        } catch (Exception e) {
//                            e.printStackTrace();
//                        }
                if(bookmarkPage != null){
                    for(TravelImage image: bookmarkPage.getItems()){
            %>
            <div class="col-md-4" style="height: 34em">
                <div class="thumbnail">
                    <img alt="300x200" src="static/image/travel-images/medium/<%= image.getPath() %>"
                         style="height: 15em;width: 100%;overflow: hidden"/>
                    <div class="caption">
                        <%--                            <h3 style="color: #006633">--%>
                        <%--                                Thumbnail label</h3>--%>
                            <h3 style="color: #006633">Pic Title</h3>
                            <p>
                                Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta
                                gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
                            </p>
                            <p>
                                <a class="btn btn-success" href="details.jsp?imageURL=<%= image.getPath() %>">Learn More</a>
                                <a class="btn btn-warning" href="<%= request.getContextPath() %>/processBookmark?imageID=<%= currentImageID %>&bookmarked=true">Cancel</a>
                            </p>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div><!--/.col-xs-12.col-sm-9-->
        <h1></h1>

        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
            <h2>Footprint</h2>
            <div class="list-group">
        <%
            // 获取所有cookie
            Cookie[] cookies = request.getCookies();
            // 选择符合条件的显示
            if(cookies.length > 0){
                for(Cookie c : cookies){
                    String cName = c.getName();
                    // 符合条件的
                    if(cName.startsWith("LEO_IMAGE_")){
                        String cValue = c.getValue();
                        String cookieImageTitle = null;
                        String cookieImageContent = null;
                        sql = "SELECT title, content FROM travels.travelimage WHERE path='" + cValue + "'";
                        ResultSet resultSet = DataBaseUtils.getConn().createStatement().executeQuery(sql);
                        if(resultSet.next()) {
                            cookieImageTitle = resultSet.getString(1);
                            cookieImageContent = resultSet.getString(2);
                        }
                        %>
                <a href="details.jsp?imageURL=<%= cValue %>" class="list-group-item">
                    <%= cookieImageTitle %><span style="color: #99CC00">&nbsp;&nbsp;<%= cookieImageContent %></span>
                </a>
                <%
                    }
                }
            }
        %>
            </div>
        </div>
    </div>
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
<style>

    .breadcrumb {
        background: none;
        padding: 0;
        margin: 0;
        padding-bottom: 17px;
        line-height: normal;
    }
</style>
</body>
</html>
