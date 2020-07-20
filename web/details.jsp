<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wyj.DAO.TravelImageDao" %>
<%@ page import="com.wyj.Model.TravelImage" %>
<%@ page import="com.wyj.DAO.TravelUserDao" %><%--
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
    <link href="static/css/homepage.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<body>
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
                <li class="active"><a href="homepage.jsp">Home</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="myBookmarks.jsp"><i class="fa fa-heart"></i>&nbsp;Bookmarks</a>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown<strong
                            class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="#">Action</a>
                        </li>
                        <li>
                            <a href="#">Another action</a>
                        </li>
                        <li class="divider">
                        </li>
                        <li>
                            <a href="#">Separated link</a>
                        </li>
                    </ul>
                </li>
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

        <div class="row"><!-- Left colunm -->
            <div class="column col-xs-12 col-sm-3" id="left_column"><!-- block category -->
                <div class="list-group">
                    <a href="#" class="list-group-item active" style="background-color: #669933">
                        Cras justo odio
                    </a>
                    <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
                    <a href="#" class="list-group-item">Morbi leo risus</a>
                    <a href="#" class="list-group-item">Porta ac consectetur ac</a>
                    <a href="#" class="list-group-item">Vestibulum at eros</a>
                </div>
            </div><!-- ./left colunm --><!-- Center colunm-->

            <%
                // 这一行最后需要删掉，username应该在login或register的时候就存在session中
                session.setAttribute("username", "SpongeBob");
                session.setAttribute("uid", 12);
                ///
                String username = (String) session.getAttribute("username");
                int uid = (int) session.getAttribute("uid");

                String imageURL = request.getParameter("imageURL");
                String photographer = "Sponge";
                String title = null;
                String topic = null;
                String description = null;
                int favorAmount = 0;
                String country = null;
                String city = null;
                Date releaseDate = new Date();

                TravelUserDao travelUserDao = new TravelUserDao();
                List<String> bookmarkList = travelUserDao.getMyBookmarkedImagePaths(uid);
                if (bookmarkList == null) {
                    bookmarkList = new ArrayList<>();
                }
                boolean alreadyBookmarked = bookmarkList.contains(imageURL);
                String bookmarkButton = alreadyBookmarked ? "Cancel This Bookmark" : "Add to Bookmarks";
            %>
            <%--            商品详情！就是这个div了--%>
            <div class="center_column col-xs-12 col-sm-9" id="center_column"><!-- Product -->
                <div id="product">
                    <div class="primary-box row">
                        <div class="pb-left-column col-xs-12 col-sm-6"><!-- product-imge-->
                            <div class="product-image">
                                <%--这里放的就是详情的大图片--%><%--这里放的就是详情的大图片--%>
                                <%--这里放的就是详情的大图片--%><%--这里放的就是详情的大图片--%>
                                <%--这里放的就是详情的大图片--%><%--这里放的就是详情的大图片--%>
                                <%--这里放的就是详情的大图片--%><%--这里放的就是详情的大图片--%>
                                <img src="static/image/travel-images/large/<%= imageURL %>" style="width: 100%;height: auto">
                            </div><!-- product-imge-->
                        </div>
                        <%
                            // 确定要被删除的cookie
                            // >=5?
                            Cookie[] cookies = request.getCookies();
                            // 将来会要第一个cookie，因此放进List（所有LEO_IMAGE_开头的cookie）
                            List<Cookie> imageCookieList = new ArrayList<>();

                            // 用来保存和details.jsp传入的imageURL匹配的cookie
                            Cookie tempCookie = null;
                            if (cookies != null && cookies.length > 0) {
                                for (Cookie c : cookies) {
                                    String cName = c.getName();
                                    if (cName.startsWith("LEO_IMAGE_")) {
                                        imageCookieList.add(c);

                                        // 与新加的imageURL相同的，且在原来cookieList中的cookie
                                        // 这是要删掉的第一个候选人
                                        // 不管长度是否>=5，如果有重复的cookie，都是要删除的
                                        if (c.getValue().equals(imageURL)) {
                                            tempCookie = c;
                                        }
                                    }
                                }
                                // 以上已经将所有imageCookie都找出来了，如果>=5；且第一个候选人不存在
                                if (imageCookieList.size() >= 5 && tempCookie == null) {
                                    // 唯一候选人就是最前面的cookie
                                    tempCookie = imageCookieList.get(0);
                                }
                                // 如果新cookie既不在原来的bookCookieList中，bookCookieList又长度小于5，tempCookie==null
                                if (tempCookie != null) {
                                    // 0表示删除cookie
                                    tempCookie.setMaxAge(0);
                                    response.addCookie(tempCookie);
                                }
                            }
                            // 把传入的image作为一个新的cookie传回
                            Cookie cookie = new Cookie("LEO_IMAGE_" + imageURL, imageURL);
                            response.addCookie(cookie);
                        %>

                        <%
                            TravelImageDao travelImageDao = new TravelImageDao();
                            TravelImage currentImage = travelImageDao.getImage(imageURL);
                            int currentImageID = currentImage.getImageID();
                            description = currentImage.getDescription();
                            country = currentImage.getCountry_regionCode();
                            city = currentImage.getCityCode();
                        %>
                        <div class="pb-right-column col-xs-12 col-sm-6">
<%--                            post-> get --%>
                            <form>
                                <h1 class="product-name"><%= title %>
                                </h1>
                                <div class="product-comments">
                                    <div class="product-star">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star-half-o"></i>
                                    </div>
                                    <div class="comments-advices">
                                        <a href="#" class="a-block"><i class="fa fa-pencil"></i>write a review</a>
                                    </div>
                                </div>
                                <div>
                                    <p>Photographer: <%= photographer %>
                                    </p>
                                    <p>Topic: <%= topic %>
                                    </p>
                                    <p>Description:</p>
                                    <p><%= description %>
                                    </p>
                                    <p>Favor: <%= favorAmount %>
                                    </p>
                                    <p>Country: <%= country %>
                                    </p>
                                    <p>City: <%= city %>
                                    </p>
                                    <p>Date: <%= releaseDate %>
                                    </p>
                                </div>
                                <div class="form-share">
                                    <div class="sendtofriend-print">
                                        <a class="a-block" href="javascript:print();"><i class="fa fa-print"></i>
                                            Print This Page</a>
                                        <a class="a-block" href="#"><i class="fa fa-envelope-o fa-fw"></i>
                                            Send to a friend</a>
                                    </div>
                                    <a href="<%= request.getContextPath() %>/processBookmark?imageID=<%= currentImageID %>&bookmarked=<%= alreadyBookmarked %>" class="btn btn-lg btn-success">
                                        <i class="<%= alreadyBookmarked? "fa fa-heart":"fa fa-heart-o" %>"></i>
                                        <%= bookmarkButton %>
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div><!-- tab product -->

                    <div class="tabbable" id="tabs-80803">
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a href="#panel-284036" data-toggle="tab">City1</a>
                            </li>
                            <li>
                                <a href="#panel-704287" data-toggle="tab">Continent2</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="panel-284036">
                                    <%--@declare id="name"--%>
                                    <div class="row" style="padding: 20px 0">
                                    </div>
                                    <div class="row form-group">
                                        <label class="control-label col-lg-1" for="commentText">Comment</label>
                                        <div class="col-lg-5 col-md-12">
                                            <textarea class="form-control" name="comment" id="commentText" rows="5"></textarea>
                                        </div>
                                        <button class="btn btn-sm btn-success" id="sendButton"><i class="fa fa-paper-plane-o"></i>&nbsp;Send</button>
                                    </div>
                            </div>
<%--                                <p>--%>
<%--                                    City Information. Beautiful City.City Information. Beautiful City.City Information.--%>
<%--                                    Beautiful City.--%>
<%--                                    City Information. Beautiful City.City Information. Beautiful City.City Information.--%>
<%--                                    Beautiful City.--%>
<%--                                </p>--%>
                            </div>
                            <div class="tab-pane" id="panel-704287">
                                <p>
                                    Continent Information. Big Continent.Continent Information. Big Continent.Continent
                                    Information. Big Continent.
                                    Continent Information. Big Continent.Continent Information. Big Continent.Continent
                                    Information. Big Continent.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <footer>
                <p>&copy; 2020 Company, Inc.</p>
            </footer>
        </div>
    </div>
</div>


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
<style>
    a {
        TEXT-DECORATION: none;
        color: #009966;
    }

    a:hover {
        TEXT-DECORATION: #99CC00;
    }

    p, a.a-block {
        display: block;
        margin-block-start: 1em;
        margin-block-end: 1em;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
    }
</style>
<script>
    function processBookmark(imageURL) {
    }
    $("#sendButton").eq(0).on('click',function(){
        var txt = $('#commentText').val();
        <%--$.post("${basePath}/JavaWeb/message.jsp?txt=0",{txt : txt},function(data){--%>
        $.post("http://localhost:8089/JavaWeb/message.jsp",{txt : txt},function(data){
            data = data.trim();
            if(data == '-1'){
                alert('请先登录！');
            }
        });
    });
</script>
