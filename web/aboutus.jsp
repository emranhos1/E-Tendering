<%-- 
    Document   : login
    Created on : Mar 20, 2017, 3:53:59 PM
    Author     : Md. Emran Hossain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en-US">
    <head>
        <title> E-Tender</title>
        <meta charset="utf-8">
        <link href="css/global.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-3.2.0.min.js" type="text/javascript"></script>
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.jsp">E-Tendering System</a>
                </div>

                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li >
                            <a href="index.jsp">Home</a>
                        </li>
                        <li >
                            <a href="#">About us</a>
                        </li>
                        <li class="active">
                            <a href="registration.jsp">Sign up</a>
                        </li>
                    </ul>
                    <form action="LoginBean" class="navbar-form navbar-right" method="post" accept-charset="utf-8">
                        <div class="form-group">
                            <input name="email" type="email" placeholder="email" placeholder="Username" class="form-control" required/>
                        </div>
                        <div class="form-group">
                            <input name="password" type="password" placeholder="password" placeholder="Password" class="form-control" required/>
                        </div>
                        <input type="submit" name="submit" value="Login"  class="btn btn-large btn-primary" />
                    </form>          
                </div><!--/.navbar-collapse -->
            </div>
        </nav>	
        <div class="jumbotron">
            <div class="container">
                <center>
                    <h2><b>Under Construction</b></h2><br/>
                </center>
            </div>
        </div>

        <div class="container">
            <!-- Example row of columns -->
            <div class="row">
                <div class="col-md-4">
                    <h2>Heading</h2>
                    <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
                    <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
                </div>
                <div class="col-md-4">
                    <h2>Heading</h2>
                    <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
                    <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
                </div>
                <div class="col-md-4">
                    <h2>Heading</h2>
                    <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
                    <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
                </div>
            </div>

            <hr>
        </div>

        <script src="js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
