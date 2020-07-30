<%@ page import="com.wyj.Model.TravelImage" %>
<%@ page import="java.util.List" %>
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
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <!-- Bootstrap core CSS -->
        <link href="static/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="static/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="static/css/personalInfo.css" rel="stylesheet">
    <link href="static/css/style.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]>
    <script src="static/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="static/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<%--    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>--%>
<%--    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
</head>

<body>
<%
    session.removeAttribute("lastPage");
    session.setAttribute("lastPage", "searchResults.jsp");
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
                <li><a href="homepage.jsp">Home</a></li>
                <li><a href="searchResults.jsp">Search</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <% if (myself != null) {
                %>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user-circle-o"></i> <%=username%><strong
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
                <%
                } else {
                %>
                <li>
                    <a href="login.jsp">Sign In</a>
                </li>
                <li>
                    <a href="register.jsp">Sign Up</a>
                </li>
                <%
                    }
                %>
            </ul>
        </div><!-- /.nav-collapse -->
    </div><!-- /.container -->
</nav><!-- /.navbar -->


<div class="container">
    <div class="container" id="columns"><!-- breadcrumb -->
        <ul class="breadcrumb">
            <a href="homepage.jsp" title="Return to Homepage">Home</a>
            <span class="navigation-pipe"> </span>
            <a href="personalInfo.jsp" title="Return to Homepage">Personal</a>
            <span class="navigation-pipe"> </span>
            <span class="navigation_page">Maecenas consequat mauris</span>
        </ul><!-- ./breadcrumb --><!-- row -->

        <div class="row">
            <div class="col-xs-12 col-sm-3 logo">
                <img src="siteLogo.png" style="width: 100%">
<%--                <img src="logo.png" style="width: 100%">--%>
            </div>
            <div class="col-xs-8 col-sm-8" style="margin-top: 10px">
<%--                <form action="fuzzyQueryImages.do" method="post"--%>
<%--                        class="form-inline" style="border: none" role="search">--%>
    <form method="post" class="form-inline" style="border: none" role="search">
                    <select name="select" id="select" style="border-radius: 10px;height: 30px">
                        <option value="topic">Topic</option>
                        <option value="title" selected>Title</option>
                    </select>
                    <select name="order" id="order" style="border-radius: 10px;height: 30px">
                        <option value="favor">Favor</option>
                        <option value="date" selected>Date</option>
                    </select>
                    <input type="search" id="searchWith" name="searchWith" class="form-control" placeholder="Search by Topic/Title..." style="width: 60%">
<%--                    <button type="submit" onclick="searchForImages(1)" class="btn btn-success"><i class="fa fa-search"></i></button>--%>
                <input type="button" onclick="searchForImages(1)" value="search">
    </form>
            </div>
        </div>

        <hr class="container">
        <div class="category-featured">
            <nav class="navbar nav-menu nav-menu-green show-brand">
                <div class="container">
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse">
                        <ul class="nav navbar-nav">
                        </ul>
                    </div><!-- /.navbar-collapse -->
                </div><!-- /.container-fluid -->
            </nav>
        </div>
        <div class="row"><!-- Left colunm -->

<%--        <%--%>
<%--            List<TravelImage> imageResultSet = (List<TravelImage>) request.getAttribute("imageResultSet");--%>
<%--            if(imageResultSet != null && imageResultSet.size() > 0){--%>
<%--                for (TravelImage image: imageResultSet){--%>
<%--        %>--%>
<%--            <div class="col-md-4">--%>
<%--                <div class="thumbnail">--%>
<%--                <img alt="300x200" src="<%=getServletConfig().getServletContext().getRealPath("/travel-images")%>>/large/<%=image.getPath()%>"/>--%>
<%--                    <div class="caption">--%>
<%--                        <h3>--%>
<%--                            <%=image.getTitle()%>--%>
<%--                        </h3>--%>
<%--                        <p>--%>
<%--                            <%=image.getDescription()%>--%>
<%--                        </p>--%>
<%--                        <p>--%>
<%--                            <a class="btn btn-primary" href="details.jsp?imageURL=<%=image.getPath()%>">Learn More</a>--%>
<%--                        </p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        <%--%>
<%--                }--%>
<%--            }--%>
<%--        %>--%>
            <div id="showResultsDiv"></div>
            <div id="hidden" hidden><%=getServletConfig().getServletContext().getRealPath("/")%></div>
        </div>


<%--        <ul class="pagination">--%>
<%--            <li><a href="#" class="active">&laquo;</a></li>--%>
<%--            <li><a href="#">1</a></li>--%>
<%--            <li><a href="#">2</a></li>--%>
<%--            <li><a href="#">3</a></li>--%>
<%--            <li><a href="#">4</a></li>--%>
<%--            <li><a href="#">5</a></li>--%>
<%--            <li><a href="#">&raquo;</a></li>--%>
<%--        </ul>--%>


        <ul class="pagination">
            <li><a href="#">First</a></li>
            <li id="previous"><a id="previousPageNo">&laquo;&nbsp;Previous</a></li>

            <li class="active" id="current"><a href="#" id="currentPageNo">1</a></li>

            <li id="next"><a id="nextPageNo">Next&nbsp;&raquo;</a></li>

            <li><a id="totalNo">Last Page</a></li>
        </ul>
        <footer>
            <p>&copy; 2020 Company, Inc.</p>
        </footer>
    </div>
</div>
<style>
    .form-inline {
        border: 1px solid #eaeaea;
        position: relative;
    }

    select {
        border-color: #99CC00;
        background-color: #99CC66;
    }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="static/js/jquery.min.js"><\/script>')</script>
<script src="static/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="static/js/ie10-viewport-bug-workaround.js"></script>
<script src="static/js/personalInfo.js"></script>
</body>
</html>
<script type="text/javascript">
    var searchResults;
    function searchForImages(pageNo) {
        console.log(">>"+pageNo);
        var select = document.getElementById("select");　　//获取select对象
        var index1 = select.selectedIndex;　　　　　　　　　//获取被选中的索引
        var selectBy = select.options[index1].value;　　　　　　//获取被选中的值

        var order = document.getElementById("order");　　//获取select对象
        var index2 = order.selectedIndex;　　　　　　　　　//获取被选中的索引
        var orderBy = order.options[index2].value;　　　　　　//获取被选中的值

        $.ajax({
            url : "fuzzyQueryImagesWithPage.do",  //显示数据的处理页面
            data: {
                searchWith : document.getElementById("searchWith").value,
                select : selectBy,
                order : orderBy,
                pageNo : pageNo
            }, //页数和查询都要传值
            type : "POST",
            dataType : "JSON", //这里我们用JSON的数据格式
            success: function(pageResult){
                console.log(pageResult.items);
                var imageResultSet = pageResult.items;
                var htmlString = "";
                var image;
                for(image in imageResultSet){
                    htmlString += "<div class=\"col-md-4\"><div class=\"thumbnail\"><img alt=\"300x200\" src=\"static/image/travel-images/large/"+imageResultSet[image].path+"\"/><div class=\"caption\"><h3>"+imageResultSet[image].title+"</h3><p>"+imageResultSet[image].description+"</p><p><a class=\"btn btn-primary\" href=\"details.jsp?imageURL="+imageResultSet[image].path+"\">Learn More</a></p></div></div></div>"
                }
                console.log(htmlString)
                $("#showResultsDiv").html(htmlString)
                document.getElementById("totalNo").innerHTML = "Last Page --> " + pageResult.pageTotal;
                document.getElementById("totalNo").setAttribute("onclick", "searchForImages("+pageResult.pageTotal+")")
                document.getElementById("currentPageNo").innerHTML = pageNo;
                var nextPageNo = pageNo+1;
                var previousPageNo = pageNo-1;
                if(pageNo===1){
                    document.getElementById('previous').className="disabled"
                }
                if(pageNo===pageResult.pageTotal){
                    document.getElementById('next').className="disabled"
                }
                document.getElementById('nextPageNo').setAttribute("onclick","searchForImages("+nextPageNo+")");
                document.getElementById('previousPageNo').setAttribute("onclick","searchForImages("+previousPageNo+")");
            }
        });
    }
</script>
