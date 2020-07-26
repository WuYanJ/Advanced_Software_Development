<%@ page import="com.wyj.Model.TravelUser" %>
<%@ page import="java.util.List" %>
<%@ page import="com.wyj.DAO.InvitationDAO" %>
<%@ page import="com.wyj.DAO.TravelUserDao" %>
<%@ page import="com.wyj.DAO.DAO" %><%--
  Created by IntelliJ IDEA.
  User: wuyanjie
  Date: 2020/7/22
  Time: 2:47 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="favicon.ico">

    <title>Off Canvas Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet">

    <%--  Font Awesome  --%>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
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
            <a class="navbar-brand" href="#">Daddy Trvel Agency</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="#">Home</a></li>
                <li><a href="searchResults.jsp">Search</a></li>
                <li><a href="">Contact</a></li>
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
                            <a href="bookmarks.jsp?username=<%=username%>"><i class="fa fa-heart"></i>&nbsp;Bookmarks</a>
                        </li>
                        <li>
                            <a href="fileUpload.jsp"><i class="fa fa-plus"></i>&nbsp;My Page</a>
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

    <div class="row row-offcanvas row-offcanvas-right">

<%
    DAO dao = new DAO();
    String sql = "SELECT ifVisibleToFriend FROM travels.traveluser WHERE username=?";
    long ifVisibleToFriend = dao.getForValue(sql, username);
    System.out.println(ifVisibleToFriend);
    String ifVisibleMessage = ifVisibleToFriend == 1 ? "VISIBLE":"NOT VISIBLE";
%>
        <div class="col-xs-12 col-sm-9">
            <p class="pull-right visible-xs">
                <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button>
            </p>
            <div class="jumbotron">
                <h1>Friends</h1>
                <form action="ifVisible.do" method="post">
                <button type="submit" class="visible"><b><%=ifVisibleMessage%></b> to friends</button>
                </form>
            </div>

            <div class="row">
                <%
                    TravelUserDao travelUserDao = new TravelUserDao();
                    List<TravelUser> friends = travelUserDao.getFriends(username);
                    if(friends != null && friends.size() > 0){
                        for (TravelUser friend: friends){
                %>
                <div class="col-xs-6 col-lg-4">
                    <h2><%=friend.getUsername()%></h2>
                    <p><%=friend.getEmail()%>></p>
                    <p><%=friend.getDateJoined()%>></p>
                    <p><a class="addFriend btn btn-default" href="bookmarks.jsp?username=<%=friend.getUsername()%>" role="button">Bookmark &raquo;</a></p>
                </div><!--/.col-xs-6.col-lg-4-->
                <%
                        }
                    }
                %>
            </div><!--/row-->

            <hr>
            <div class="row">
                <div class="col-xs-8 col-sm-8" style="margin-top: 10px">
                    <form action="fuzzyQueryUsers.do" method="post"
                          class="form-inline" style="border: none" role="search">
                        <input type="search" name="friendUsername" class="form-control" placeholder="Search For Users..." style="width: 60%">
                        <button type="submit" class="btn btn-success"><i class="fa fa-search"></i></button>
                    </form>
                </div>
            </div>
            <div class="row">
            <%
                List<TravelUser> userResultSet = (List<TravelUser>) request.getAttribute("userResultSet");
                if(userResultSet != null && userResultSet.size() > 0){
                    for (TravelUser friendCandidate: userResultSet){
            %>
                <div class="col-xs-6 col-lg-4">
                    <h2><%=friendCandidate.getUsername()%></h2>
                    <p><%=friendCandidate.getEmail()%>></p>
                    <p><%=friendCandidate.getDateJoined()%>></p>
                    <p><a class="addFriend btn btn-default" href="addFriend.do?friend=<%=friendCandidate.getUsername()%>" role="button">Reach out &raquo;</a></p>
                </div><!--/.col-xs-6.col-lg-4-->
            <%
                    }
                }
            %>
            </div><!--/row-->
        </div><!--/.col-xs-12.col-sm-9-->

        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
            <div class="list-group">
                <h3>Invitation Received</h3>
        <%
            InvitationDAO invitationDAO = new InvitationDAO();
            List<TravelUser> invitationSenders = invitationDAO.getInvitationSenders(username);
            for (TravelUser sender : invitationSenders){
        %>
                <a href="agree.do?friend=<%=sender.getUsername()%>" class="agree list-group-item"><b><%=sender.getUsername()%></b>&nbsp;(&nbsp;<%=sender.getEmail()%>&nbsp;)</a>
        <%
            }
        %>
            </div>
        </div><!--/.sidebar-offcanvas-->
    </div><!--/row-->

    <hr>

    <footer>
        <p>&copy; 2016 Company, Inc.</p>
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
    $(function () {
        $(".addFriend").click(function () {
            var content = $(this).parent().find("h2");
            var flag = confirm("Confirm?");
            return flag;
        })
    })
    $(function () {
        $(".agree").click(function () {
            var flag = confirm("Confirm Add?");
            return flag;
        })
    })
</script>
