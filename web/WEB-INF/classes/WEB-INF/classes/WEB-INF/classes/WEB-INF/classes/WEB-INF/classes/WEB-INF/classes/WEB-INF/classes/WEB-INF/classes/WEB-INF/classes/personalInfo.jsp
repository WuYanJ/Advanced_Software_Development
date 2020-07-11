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

    <title>Personal Info</title>

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
  <nav class="navbar navbar-fixed-top navbar-inverse">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">Daddy Travel Agency</a>
      </div>
      <div id="navbar" class="collapse navbar-collapse">
        <ul class="nav navbar-nav">
          <li class="active"><a href="#">Home</a></li>
          <li><a href="#about">About</a></li>
          <li><a href="#contact">Contact</a></li>
        </ul>
        <form class="navbar-form navbar-left" role="search">
          <div class="form-group">
            <input type="text" class="form-control" />
          </div> <button type="submit" class="btn btn-default">Submit</button>
        </form>
        <ul class="nav navbar-nav navbar-right">
          <li>
            <a href="#">Link</a>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown<strong class="caret"></strong></a>
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
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
          %>
          <div class="jumbotron">
            <h1>Hello, <%= username %>!</h1>
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><%= username %>'s Personal Information</h3>
              </div>
              <div class="panel-body">
                <ul class="list-group">
                  <li class="list-group-item">Username: <%= username %></li>
                  <li class="list-group-item">Email: <%= email %></li>
                </ul>
              </div>
            </div>
            <p>This is personal information page. This page contains basic information and User's photo collection.</p>
          </div>


          <hr class="featurette-divider">
            <blockquote>
              <p>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.
              </p> <small>Someone famous <cite>Source Title</cite></small>
            </blockquote>
          <div class="row featurette">
            <div class="col-md-7">
              <h2 class="featurette-heading" style="color: #3c763d">First featurette heading. <span style="color: #99CC00">It'll blow your mind.</span></h2>
              <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
            </div>
            <div class="col-md-5">
              <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
            </div>
          </div>

          <hr class="featurette-divider">

          <div class="row featurette">
            <div class="col-md-7 col-md-push-5">
              <h2 class="featurette-heading" style="color: #3c763d">Oh yeah, it's that good. <span style="color: #99CC00">See for yourself.</span></h2>
              <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
            </div>
            <div class="col-md-5 col-md-pull-7">
              <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
            </div>
          </div>

          <hr class="featurette-divider">

          <div class="row featurette">
            <div class="col-md-7">
              <h2 class="featurette-heading" style="color: #3c763d">And lastly, this one. <span style="color: #99CC00">Checkmate.</span></h2>
              <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
            </div>
            <div class="col-md-5">
              <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
            </div>
          </div>
          <br>
          <hr class="featurette-divider">
          <br>
          <!-- /END THE FEATURETTES -->

          <h1>My Collection</h1>
          <div class="row">
            <div class="col-md-4">
              <div class="thumbnail">
                <img alt="300x200" src="static/image/travel-images/large/222222.jpg" />
                <div class="caption">
                  <h3>
                    Thumbnail label
                  </h3>
                  <p>
                    Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
                  </p>
                  <p>
                    <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
                  </p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="thumbnail">
                <img alt="300x200" src="static/image/travel-images/large/222223.jpg" />
                <div class="caption">
                  <h3>
                    Thumbnail label
                  </h3>
                  <p>
                    Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
                  </p>
                  <p>
                    <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
                  </p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="thumbnail">
                <img alt="300x200" src="static/image/travel-images/large/222222.jpg" />
                <div class="caption">
                  <h3>
                    Thumbnail label
                  </h3>
                  <p>
                    Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
                  </p>
                  <p>
                    <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
                  </p>
                </div>
              </div>
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
