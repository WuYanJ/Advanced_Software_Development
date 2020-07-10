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
    <!--[if lt IE 9]>
    <script src="static/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="static/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
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
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </div><!-- /.nav-collapse -->
    </div><!-- /.container -->
</nav><!-- /.navbar -->

<div class="container">

    <div class="primary-box row">
        <div class="pb-left-column col-xs-12 col-sm-6"><!-- product-imge-->
            <div class="product-image">
                <div class="product-full"><img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
                </div>
                <div class="product-img-thumb" id="gallery_01">
                    <ul class="owl-carousel owl-theme owl-loaded" data-items="3" data-nav="true" data-dots="false"
                        data-margin="20" data-loop="false">
                        <div class="owl-stage-outer">
                            <div class="owl-stage"
                                 style="transform: translate3d(0px, 0px, 0px); transition: all 0s ease 0s; width: 720px;">
                                <div class="owl-item active" style="width: 100px; margin-right: 20px;">
                                    <li>
                                        <a href="#" data-image="assets/data/product-s3-420x512.jpg"
                                           data-zoom-image="assets/data/product-s3-850x1036.jpg">
                                        <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
                                    </a>
                                    </li>
                                </div>
                                <div class="owl-item active" style="width: 100px; margin-right: 20px;">
                                    <li><a href="#" data-image="assets/data/product-s2-420x512.jpg"
                                           data-zoom-image="assets/data/product-s2-850x1036.jpg">
                                        <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
                                    </a>
                                    </li>
                                </div>
                                <div class="owl-item active" style="width: 100px; margin-right: 20px;">
                                    <li>
                                        <a href="#" data-image="assets/data/product-420x512.jpg"
                                           data-zoom-image="assets/data/product-850x1036.jpg">
                                            <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
                                    </a>
                                    </li>
                                </div>
                                <div class="owl-item" style="width: 100px; margin-right: 20px;">
                                    <li>
                                        <a href="#" data-image="assets/data/product-s4-420x512.jpg"
                                           data-zoom-image="assets/data/product-s4-850x1036.jpg">
                                            <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
                                    </a>
                                    </li>
                                </div>
                                <div class="owl-item" style="width: 100px; margin-right: 20px;">
                                    <li>
                                        <a href="#" data-image="assets/data/product-s5-420x512.jpg"
                                           data-zoom-image="assets/data/product-s5-850x1036.jpg">
                                            <img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
                                    </a>
                                    </li>
                                </div>
                                <div class="owl-item" style="width: 100px; margin-right: 20px;">
                                    <li><a href="#" data-image="assets/data/product-s6-420x512.jpg"
                                           data-zoom-image="assets/data/product-s6-850x1036.jpg"><img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">
                                    </a>
                                    </li>
                                </div>
                            </div>
                        </div>
                        <div class="owl-controls">
                            <div class="owl-nav">
                                <div class="owl-prev" style=""><i class="fa fa-angle-left"></i></div>
                                <div class="owl-next" style=""><i class="fa fa-angle-right"></i></div>
                            </div>
                            <div class="owl-dots" style="display: none;"></div>
                        </div>
                    </ul>
                </div>
            </div><!-- product-imge--></div>
        <div class="pb-right-column col-xs-12 col-sm-6"><h1 class="product-name">Maecenas consequat mauris</h1>
            <div class="product-comments">
                <div class="product-star"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i
                        class="fa fa-star"></i><i class="fa fa-star-half-o"></i></div>
                <div class="comments-advices"><a href="#">Based on 3 ratings</a><a href="#"><i class="fa fa-pencil"></i>write
                    a review</a></div>
            </div>
            <div class="product-price-group"><span class="price">$38.95</span><span class="old-price">$52.00</span><span
                    class="discount">-30%</span></div>
            <div class="info-orther"><p>Item Code: #453217907</p>
                <p>Availability: <span class="in-stock">In stock</span></p>
                <p>Condition: New</p></div>
            <div class="product-desc"> Vestibulum eu odio. Suspendisse potenti. Morbi mollis tellus ac sapien. Praesent
                egestas tristique nibh. Nullam dictum felis eu pede mollis pretium.Fusce egestas elit eget lorem.
            </div>
                <div class="attributes">
                    <div class="attribute-label">Qty:</div>
                    <div class="attribute-list product-qty">
                        <div class="qty"><input id="option-product-qty" type="text" value="1"></div>
                        <div class="btn-plus"><a href="#" class="btn-plus-up"><i class="fa fa-caret-up"></i></a><a
                                href="#" class="btn-plus-down"><i class="fa fa-caret-down"></i></a></div>
                    </div>
                </div>
                <div class="attributes">
                    <div class="attribute-label">Size:</div>
                    <div class="attribute-list"><select>
                        <option value="1">X</option>
                        <option value="2">XL</option>
                        <option value="3">XXL</option>
                    </select><a id="size_chart" class="fancybox" href="static/image/favicon.ico">Size Chart</a></div>
                </div>
            </div>
            <div class="form-action">
                <div class="button-group"><a class="btn-add-cart" href="#">Add to cart</a></div>
                <div class="button-group"><a class="wishlist" href="#"><i class="fa fa-heart-o"></i><br>Wishlist</a><a
                        class="compare" href="#"><i class="fa fa-signal"></i><br>Compare</a></div>
            </div>
            <div class="form-share">
                <div class="sendtofriend-print"><a href="javascript:print();"><i class="fa fa-print"></i>Print</a><a
                        href="#"><i class="fa fa-envelope-o fa-fw"></i>Send to a friend</a></div>
                <div class="network-share"></div>
            </div>
        </div>
    </div>


    <footer>
        <p>&copy; 2020 Company, Inc.</p>
    </footer>
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
