<%@ page import="java.util.Date" %><%--
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
    <!--[if lt IE 9]>
    <script src="static/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="static/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

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
            <a class="navbar-brand" href="#">Daddy Travel Agency</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="homepage.jsp">Home</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </div><!-- /.nav-collapse -->
    </div><!-- /.container -->
</nav><!-- /.navbar -->

<div class="container">
    <div class="container" id="columns"><!-- breadcrumb -->
        <ul class="breadcrumb">
            <a href="homepage.jsp" title="Return to Homepage">Home</a>
            <span class="navigation-pipe"> > </span>
            <a href="personalInfo.jsp" title="Return to Homepage">Personal</a>
            <span class="navigation-pipe"> > </span>
            <span class="navigation_page">Maecenas consequat mauris</span>
        </ul><!-- ./breadcrumb --><!-- row -->

        <div class="row"><!-- Left colunm -->
            <div class="column col-xs-12 col-sm-3" id="left_column"><!-- block category -->
                <div class="list-group">
                    <a href="#" class="list-group-item active">
                        Cras justo odio
                    </a>
                    <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
                    <a href="#" class="list-group-item">Morbi leo risus</a>
                    <a href="#" class="list-group-item">Porta ac consectetur ac</a>
                    <a href="#" class="list-group-item">Vestibulum at eros</a>
                </div>
            </div><!-- ./left colunm --><!-- Center colunm-->


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
                                <img src="static/image/travel-images/large/222222.jpg" style="width: 100%;height: auto">
                            </div><!-- product-imge-->
                        </div>

                        <%
//                            String imageUrl = request.getParameter("imageUrl");
                            String photographer = "wuyanjie";
                            String title = "Maecenas consequat mauris";
                            String topic = "Ocean";
                            String description = "So Beautiful. Hope you can enjoy.";
                            int favorAmount = 15;
                            String country = "Japan";
                            String city = "Tokyo";
                            Date releaseDate = new Date();
                        %>

                        <div class="pb-right-column col-xs-12 col-sm-6">
                            <h1 class="product-name"><%= title %></h1>
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
                                <p>Photographer: <%= photographer %></p>
                                <p>Topic: <%= topic %></p>
                                <p>Description: <%= description %></p>
                                <p>Favor: <%= favorAmount %></p>
                                <p>Country: <%= country %></p>
                                <p>City: <%= city %></p>
                                <p>Date: <%= releaseDate %></p>
                            </div>
                            <div class="form-share">
                                <div class="sendtofriend-print">
                                    <a class="a-block" href="javascript:print();"><i class="fa fa-print"></i>Print This Page</a>
                                    <a class="a-block" href="#"><i class="fa fa-envelope-o fa-fw"></i>Send to a friend</a>
                                </div>
                                <button type="button" class="btn btn-lg btn-success"><i class="fa fa-heart-o"></i>Add to Collection</button>
                            </div>
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
                                <p>
                                    City Information. Beautiful City.City Information. Beautiful City.City Information.
                                    Beautiful City.
                                    City Information. Beautiful City.City Information. Beautiful City.City Information.
                                    Beautiful City.
                                </p>
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