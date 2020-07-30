<%@ page import="com.wyj.DAO.TravelImageDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.wyj.Model.TravelImage" %>
<%@ page import="java.util.Map" %>
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

    <link href="static/css/style.css" rel="stylesheet">
    <title>Carousel Template for Bootstrap</title>

    <%--  Font Awesome  --%>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">


    <!-- Custom styles for this template -->
    <link href="static/css/homepage.css" rel="stylesheet">
</head>
<!-- NAVBAR
================================================== -->
<body>
<%
    session.removeAttribute("lastPage");
    session.setAttribute("lastPage", "homepage.jsp");
    if(request.getAttribute("message") != null){
    if((request.getAttribute("message")).equals("register")){
%>
<script>
    alert("Successfully Registered")
</script>
<%
    } else if((request.getAttribute("message")).equals("login")){
%>
<script>
    alert("Successfully Logged in")
</script>
<%
    }
    }
%>
<%
    TravelUser myself = (TravelUser) session.getAttribute("travelUser");
    String username = "";
    int uid = 0;
    if(myself != null){
        username = myself.getUsername();
        uid = myself.getUID();
    }
%>
<div class="navbar-wrapper">
    <div class="container">
        <nav class="navbar navbar-fixed-top navbar-inverse">
            <div class="container">

                <div class="navbar-header">
                    <img src="siteLogo.png" style="height: 50px">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                            aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Daddy Travel Agency</a>
                </div>
                <div id="navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="#">Home</a></li>
                        <li><a href="searchResults.jsp">Search</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                        <li><a href="login.jsp">登陆</a></li>
                        <li><a href="register.jsp">注册</a></li>
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
    </div>
</div>


<!-- Carousel
================================================== -->

<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner" role="listbox">
        <div class="item active">
<%--            <img src="static/image/travel-images/large/222223.jpg" style="width: 100%;height: auto">--%>
            <div class="container" style="background-color: #99CC66">
                <div class="carousel-caption">
                    <h1>Here are those HOTTEST images.</h1>
                    <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida
                        at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                </div>
            </div>
        </div>
            <%
                TravelImageDao travelImageDao = new TravelImageDao();
                int hottestImageAmount = 3;
                Map<String, Integer> hottestImageFavorMap = travelImageDao.getHottestImage(hottestImageAmount);
                for(Map.Entry<String, Integer> entry: hottestImageFavorMap.entrySet()) {
                    TravelImage image = travelImageDao.getImage(entry.getKey());
                    %>
        <div class="item">
            <img src="static/image/travel-images/large/<%= entry.getKey() %>" style="width: 100%;height: auto">

<%--            <img src="static/image/travel-images/large/<%= entry.getKey() %>" style="width: 100%;height: auto">--%>

            <div class="container">
                <div class="carousel-caption">
                    <h1><%= image.getTitle() %></h1>
                    <p><%= image.getDescription() %></p>
                    <p><a class="btn btn-lg btn-primary" href="details.jsp?imageURL=<%= entry.getKey() %>" role="button">Favor: <%= entry.getValue() %></a></p>
                </div>
            </div>
        </div>
            <%
                }
            %>
    </div>

<%--        <div class="item">--%>
<%--            <img src="static/image/travel-images/large/5855191275.jpg" style="width: 100%;height: auto">--%>

<%--            &lt;%&ndash;          <img class="third-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Third slide">&ndash;%&gt;--%>
<%--            <div class="container">--%>
<%--                <div class="carousel-caption">--%>
<%--                    <h1>One more for good measure.</h1>--%>
<%--                    <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida--%>
<%--                        at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>--%>
<%--                    <p><a class="btn btn-lg btn-primary" href="#" role="button">Browse gallery</a></p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div><!-- /.carousel -->


<!-- Marketing messaging and featurettes
================================================== -->
<!-- Wrap the rest of the page in another container to center all the content. -->

<div class="container marketing">

    <!-- Three columns of text below the carousel -->
    <div class="row">
        <%
            int latestImageAmount = 3;
            List<TravelImage> latestImages = travelImageDao.getLatestImage(latestImageAmount);
            for(TravelImage image : latestImages){
        %>
        <div class="col-lg-4">
<%--            <img class="img-circle" src="static/image/travel-images/large/<%=image.getPath()%>" alt="Generic placeholder image" width="140" height="140">--%>
            <img class="img-circle" src="static/image/travel-images/large/<%=image.getPath()%>" alt="<%=image.getTitle()%>" width="140" height="140">
            <h2 style="color: #666633"><%=image.getTitle()%></h2>
            <p style="color: #99CC33"><%=image.getDescription()%></p>
            <p style="color: #99CC99"><%=image.getUpdatedDate()%></p>
            <p><a class="btn btn-default" href="details.jsp?imageURL=<%=image.getPath()%>" role="button">View details &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <%
            }
        %>
    <!-- START THE FEATURETTES -->

        <%
            for(TravelImage image : latestImages){
        %>
    <hr class="featurette-divider">

    <div class="row featurette">
        <div class="col-md-7">
            <h2 class="featurette-heading" style="color: #3c763d"><%=image.getTitle()%><span
                    style="color: #99CC00">It'll blow your mind.</span></h2>
            <p class="lead"><%=image.getDescription()%></p>
        </div>
        <div class="col-md-5">
<%--            <img class="featurette-image img-responsive center-block" src="static/image/travel-images/large/<%=image.getPath()%>" alt="Generic placeholder image">--%>
            <img class="featurette-image img-responsive center-block" src="static/image/travel-images/large/<%=image.getPath()%>" alt="Generic placeholder image">
        </div>
    </div>

        <%
            }
        %>

    <!-- FOOTER -->
    <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2020 Company, Inc. &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a></p>
    </footer>

</div><!-- /.container -->


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="static/js/jquery.min.js"><\/script>')</script>
<script src="static/js/bootstrap.min.js"></script>
<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
<script src="static/js/holder.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="static/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
