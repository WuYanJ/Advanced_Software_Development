<%@ page import="com.wyj.DAO.TravelImageDao" %>
<%@ page import="com.wyj.DAO.TravelUserDao" %>
<%@ page import="com.wyj.Model.TravelImage" %>
<%@ page import="com.wyj.Model.TravelUser" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wyj.Model.Comment" %>
<%@ page import="com.wyj.DAO.CommentDAO" %><%--
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
</head>

<body>
<%
    session.removeAttribute("lastPage");
    session.setAttribute("lastPage", "details.jsp?imageURL="+request.getParameter("imageURL"));
    TravelUser myself = (TravelUser) session.getAttribute("travelUser");
    String username = null;
    int uid = 0;
    if (myself != null) {
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
            <img src="siteLogo.png" style="height: 50px">
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
            <span class="navigation-pipe"></span>
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

                String imageURL = request.getParameter("imageURL");
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
                        <div class="box pb-left-column col-xs-12 col-sm-6"><!-- product-imge-->
                            <div class="product-image">
                                <img src="static/image/travel-images/large/<%= imageURL %>" style="width: 100%;height: auto">
                                <div class="mask"></div>
                                <%--这里放的就是详情的大图片--%><%--这里放的就是详情的大图片--%>
                                <%--这里放的就是详情的大图片--%><%--这里放的就是详情的大图片--%>
                                <%--这里放的就是详情的大图片--%><%--这里放的就是详情的大图片--%>
                                <%--这里放的就是详情的大图片--%><%--这里放的就是详情的大图片--%>
                            </div><!-- product-imge-->
                            <div class="big-image">
                                <img src="static/image/travel-images/large/<%= imageURL %>" alt=""/>
                            </div>
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
                            TravelImage image = travelImageDao.getImage(imageURL);
                            String photographer = image.getPhotographer();
                            String topic = image.getContent();
                            String title = image.getTitle();
                            String description = image.getDescription();
                            int imageID = image.getImageID();
                            long favorAmount = image.getFavor();
                            String country = image.getCountry_regionCode();
                            String city = image.getCityCode();
                            Date releaseDate = new Date();
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
                                        <a href="#" class="a-block"><i class="fa fa-pencil"></i>&nbsp;Write a review</a>
                                    </div>
                                </div>
                                <div>
                                    <p>Photographer: <%= photographer %>
                                    </p>
                                    <p>Topic: <%= topic %>
                                    </p>
                                    <p>Description: <%= description %>
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
                                    <%
                                        if (myself != null) {
                                    %>
                                    <a href="<%= request.getContextPath() %>/processBookmark?imageID=<%= imageID %>&bookmarked=<%= alreadyBookmarked %>"
                                       class="btn btn-lg btn-success">
                                        <i class="<%= alreadyBookmarked? "fa fa-heart":"fa fa-heart-o" %>"></i>
                                        <%= bookmarkButton %>
                                    </a>
                                    <%
                                        }
                                    %>

                                </div>
                            </form>
                        </div>
                    </div><!-- tab product -->

                    <div class="tabbable" id="tabs-80803">
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a href="#panel-284036" data-toggle="tab">Send Comments</a>
                            </li>
                            <li>
                                <a href="#panel-704287" data-toggle="tab">View Comments</a>
                            </li>
                            <li>
                                <a href="#panel-704288" data-toggle="tab">Order By Favor</a>
                            </li>
                            <li>
                                <a href="#panel-704289" data-toggle="tab">Order By Date</a>
                            </li>
                        </ul>
                        <div class="tab-content">

                            <div class="tab-pane fade in active" id="panel-284036">
                                <div class="row" style="padding: 20px 0"></div>
                                <%
                                    if(myself != null){
                                %>
                                <form action="comment.do?imageURL=<%=imageURL%>&username=<%=username%>" method="post">
                                    <div class="row form-group">
                                        <label class="control-label col-lg-1" for="commentText">Comment</label>
                                        <div class="col-lg-5 col-md-12">
                                        <textarea class="form-control" name="comment" id="commentText"
                                                  rows="5"></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-sm btn-success" id="sendButton"><i
                                                class="fa fa-paper-plane-o"></i>&nbsp;Send</button>
                                    </div>
                                </form>
                                <%
                                } else {
                                %>
                                <p>Login in First.</p>
                                <%
                                    }
                                %>
                            </div>


                        <div class="tab-pane" id="panel-704287">
                            <%
                                CommentDAO commentDAO = new CommentDAO();
                                List<Comment> comments = commentDAO.getComments(imageURL);
                                for(Comment comment:comments){
                            %>
                            <h3>
                                <%=comment.getUsername()%>
                            </h3>
                            <p style="float: right">
                                <%=comment.getFavorAmount()%>
                            </p>
                            <a href="commentLike.do?id=<%=comment.getId()%>&imageURL=<%=comment.getImageURL()%>" style="float: right">
                                <i class="fa fa-heart"></i>
                            </a>
                            <p>
                                <%=comment.getComment()%>
                            </p>
                            <p>
                                <%=comment.getDateCreated()%>
                            </p>
                            <hr>
                            <%
                                }
                            %>
                        </div>
                        <div class="tab-pane" id="panel-704289">
                            <%
                                List<Comment> commentsOrderByDate = commentDAO.getCommentsOrderByDate(imageURL);
                                for(Comment comment:commentsOrderByDate){
                            %>
                            <h3>
                                <%=comment.getUsername()%>
                            </h3>
                            <p style="float: right">
                                <%=comment.getFavorAmount()%>
                            </p>
                            <p>
                                <%=comment.getComment()%>
                            </p>
                            <p>
                                <%=comment.getDateCreated()%>
                            </p>
                            <hr>
                            <%
                                }
                            %>
                        </div>
                        <div class="tab-pane" id="panel-704288">
                            <%
                                List<Comment> commentsOrderByFavor = commentDAO.getCommentsOrderByFavor(imageURL);
                                for(Comment comment:commentsOrderByFavor){
                            %>
                            <h3>
                                <%=comment.getUsername()%>
                            </h3>
                            <p style="float: right">
                                <%=comment.getFavorAmount()%>
                            </p>
                            <p>
                                <%=comment.getComment()%>
                            </p>
                            <p>
                                <%=comment.getDateCreated()%>
                            </p>

                            <hr>
                            <%
                                }
                            %>
                        </div>
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
<script src="static/js/detailsTool.js"></script>
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
    $("#sendButton").eq(0).on('click', function () {
        var txt = $('#commentText').val();
        <%--$.post("${basePath}/JavaWeb/message.jsp?txt=0",{txt : txt},function(data){--%>
        $.post("http://localhost:8089/JavaWeb/message.jsp", {txt: txt}, function (data) {
            data = data.trim();
            if (data == '-1') {
                alert('请先登录！');
            }
        });
    });

    window.onload = function () {
        //需求：鼠标放到小盒子上，让大盒子里面的图片和我们同步等比例移动。
        //技术点：οnmοuseenter==onmouseover 第一个不冒泡
        //技术点：οnmοuseleave==onmouseout  第一个不冒泡
        //步骤：
        //1.鼠标放上去显示盒子，移开隐藏盒子。
        //2.老三步和新五步（黄盒子跟随移动）
        //3.右侧的大图片，等比例移动。

        //0.获取相关元素
        var box = document.getElementsByClassName("box")[0];
        var small = box.firstElementChild || box.firstChild;
        var big = box.children[1];
        var mask = small.children[1];
        var bigImg = big.children[0];

        //1.鼠标放上去显示盒子，移开隐藏盒子。(为小盒子绑定事件)
        small.onmouseenter = function () {
            //封装好方法调用：显示元素
            show(mask);
            show(big);
        };
        small.onmouseleave = function () {
            //封装好方法调用：隐藏元素
            hide(mask);
            hide(big);
        };

        //2.老三步和新五步（黄盒子跟随移动）
        //绑定的事件是onmousemove，而事件源是small(只要在小盒子上移动1像素，黄盒子也要跟随)
        small.onmousemove = function (event) {
            //新五步
            event = event || window.event;

            //想要移动黄盒子，必须要知道鼠标在small小图中的位置。
            var pagex = event.pageX || scroll().left + event.clientX;
            var pagey = event.pageY || scroll().top + event.clientY;

            //x：mask的left值，y：mask的top值。
            var x = pagex - 448 - mask.offsetWidth / 2; //除以2，可以保证鼠标mask的中间
            var y = pagey - 138 - mask.offsetHeight / 2;

            console.log("x.before->"+x)

            //限制换盒子的范围
            //left取值为大于0，小盒子的宽-mask的宽。
            if (x < 0) {
                x = 0;
            }
            if (x > small.offsetWidth - mask.offsetWidth) {
                x = small.offsetWidth - mask.offsetWidth;
            }
            //top同理。
            if (y < 0) {
                y = 0;
            }
            if (y > small.offsetHeight - mask.offsetHeight) {
                y = small.offsetHeight - mask.offsetHeight;
            }
            //移动黄盒子
            // console.log(small.offsetHeight);
            mask.style.left = x + "px";
            mask.style.top = y + "px";

            //3.右侧的大图片，等比例移动。
            //如何移动大图片？等比例移动。
            //    大图片/大盒子 = 小图片/mask盒子
            //    大图片走的距离/mask走的距离 = （大图片-大盒子）/（小图片-黄盒子）
//                var bili = (bigImg.offsetWidth-big.offsetWidth)/(small.offsetWidth-mask.offsetWidth);

            //大图片走的距离/mask盒子都的距离 = 大图片/小图片
            var bili = bigImg.offsetWidth / small.offsetWidth;

            var xx = bili * x;  //知道比例，就可以移动大图片了
            var yy = bili * y;

            bigImg.style.marginTop = -yy + "px";
            bigImg.style.marginLeft = -xx + "px";
        }
    }
</script>
<style>

.box {
    position: relative;
}

.big-image {
    width: 400px;
    height: 400px;
    position: absolute;
    top: 0;
    left: 450px;
    overflow: hidden;
    display: none;
    z-index: 999;
    border-radius: 10px;
}

.mask {
    width: 175px;
    height: 175px;
    background: rgba(255, 255, 0, 0.4);
    position: absolute;
    top: 0;
    left: 0;
    cursor: move;
    display: none;
}

.product-image {
    position: relative;
}

img {
    vertical-align: top;
}
</style>
