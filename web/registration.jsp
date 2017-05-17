<%-- 
    Document   : registration
    Created on : Mar 20, 2017, 3:55:47 PM
    Author     : Md. Emran Hossain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/global.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
        <title>Registration</title>
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
                        <li>
                            <a href="index.jsp">Home</a>
                        </li>
                        <li >
                            <a href="aboutus.jsp">About us</a>
                        </li>
                        <li class="active">
                            <a href="#">Sign up</a>
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
                    <h2>::Registration::</h2>
                    <p>${registrationInfo}</p>
                    <label class="registrationFormAlert" id="message"></label>
                </center>
                
                <div class="col-md-offset-3 col-md-6">
                    <form action="RegistrationBean" class="form-horizontal" method="post" accept-charset="utf-8">
                        <h2 class="form-heading">Create an account</h2>
                        <div id="company">
                            <div class="form-group">
                                <label for="cName" class="col-sm-4 control-label">Company Name</label>
                                <div class="col-sm-8">
                                    <input type="text" id="cName" name="cName" value="" placeholder="Company Name" class="form-control" required /><label class="registrationFormAlert" id="checkCName"></label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="cType" class="col-sm-4 control-label">Company Type</label>
                                <div class="col-sm-8">
                                    <input type="text" id="cType" name="cType" value=""  placeholder="Company Type" class="form-control" required/><label class="registrationFormAlert" id="checkCType"></label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="category" class="col-sm-4 control-label">Company Category</label>
                                <div class="col-sm-8">
                                    <input type="text" id="catagory" name="category" value=""  placeholder="Company Category" class="form-control" required/><label class="registrationFormAlert" id="checkCCategory"></label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="website" class="col-sm-4 control-label">Company Website</label>
                                <div class="col-sm-8">
                                    <input type="text" id="website" name="website" value=""  placeholder="Ex : http://www.softcellbd.net" class="form-control" required/><label class="registrationFormAlert" id="checkCWebsite"></label>
                                </div>
                            </div>
                            <div class="div-center"><button name="button" type="button"  class="btn btn-large btn-primary" id="next_btn">Next</button>
                            </div>
                        </div>

                        <div id="user">
                            <div class="form-group">
                                <label for="uName" class="col-sm-4 control-label">User Full Name</label>
                                <div class="col-sm-8">
                                    <input type="text" id="uName" name="uName" value=""  placeholder="Full Name" class="form-control" onChange="checkUserName();" required /><label class="registrationFormAlert" id="checkUName"></label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="email" class="col-sm-4 control-label">Email Address</label>
                                <div class="col-sm-8">
                                    <input type="email" id="email" name="email" value=""  placeholder="Email" class="form-control" onchange="checkEmail();" required/><label class="registrationFormAlert" id="checkUEmail"></label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="type" class="col-sm-4 control-label">Account Type</label>
                                <div class="col-sm-8">
                                    <select name="type" id="type" class="form-control" onchange="checkUserType();" required>
                                        <option value="" selected="selected">Select One</option>
                                        <option value="Purchaser">Purchaser</option>
                                        <option value="Supplier">Supplier</option>
                                    </select>
                                    <label class="registrationFormAlert" id="checkUType"></label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="password1" class="col-sm-4 control-label">Password</label>
                                <div class="col-sm-8">
                                    <input type="password" id="password1" name="password1" value=""  placeholder="Password" class="form-control" maxlength="15" required/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="password2" class="col-sm-4 control-label">Confirm Password</label>
                                <div class="col-sm-8">
                                    <input type="password" id="password2" name="password2" value=""  placeholder="Password confirm" class="form-control" onChange="checkPasswordMatch();"  maxlength="15" required /><label class="registrationFormAlert" id="checkPassword"></label>
                                </div>
                            </div>
                            <div class="div-center">
                                <button name="button" type="button"  class="btn btn-large btn-primary" id="pre_btn">Back</button>
                                <input type="submit" name="submit" value="Register"  class="btn btn-large btn-primary" />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!--Footer Content--> 
        <div class="container">
            <hr>
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
        
        <script type="text/javascript">

            function checkUserName(){
                var userName = $("#uName").val();
                if (userName === '' || userName === null){
                    $("#checkUName").html("<font color='red'>Insert User Full Name!</font>");
                } else {
                    $("#checkUName").html("<font color='green'>Done!</font>");
                }
            }
            $(document).ready(function () {
                $("#checkUName").keyup(checkUserName);
            });
            
            function checkEmail(){
                var userEmail = $("#email").val();
                if (userEmail === '' || userEmail === null){
                    $("#checkUEmail").html("<font color='red'>Insert a valid Email!</font>");
                } else {
                    $("#checkUEmail").html("<font color='green'>Done!</font>");
                }
            }
            $(document).ready(function () {
                $("#checkUEmail").keyup(checkEmail);
            });
            
            function checkUserType(){
                var userType = $("#type").val();
                if (userType === '' || userType === null){
                    $("#checkUType").html("<font color='red'>Insert User Type!</font>");
                } else {
                    $("#checkUType").html("<font color='green'>Done!</font>");
                }
            }
            $(document).ready(function () {
                $("#checkUType").keyup(checkUserType);
            });
            
            function checkPasswordMatch() {
                var pass1 = $("#password1").val();
                var Pass2 = $("#password2").val();

                
                if (pass1 !== Pass2){
                    $("#checkPassword").html("<font color='red'>Passwords do not match!</font>");
                } else
                    $("#checkPassword").html("<font color='green'>Passwords match.</font>");
            }

            $(document).ready(function () {
                $("#password1, #password2").keyup(checkPasswordMatch);
            });


            $("#next_btn").click(function () {

                var name = $("#cName").val();
                var type = $("#cType").val();
                var cate = $("#category").val();
                var url = $("#website").val();
                var checkUrl = isValidURL(url);
                //console.log(url + checkUrl);

                if (name === '' || name === null || name === 'undefined') {
                    $("#checkCName").html("<font color='red'>Please Insert Company Name</font>");
                } else if (type === '' || type === null || type === 'undefined') {
                    $("#checkCType").html("<font color='red'>Please Insert Company Type</font>");
                } else if (cate === '' || cate === null || cate === 'undefined') {
                    $("#checkCCategory").html("<font color='red'>Please Insert Company Category</font>");
                } else if (url === '' || url === null || url === 'undefined') {
                    $("#checkCWebsite").html("<font color='red'>Please Insert WebSite</font>");
                } else if (checkUrl === false) {
                    $("#checkCWebsite").html("<font color='red'>Website is not valid</font>");
                } else {
                    $("#company").slideUp();
                    $("#user").show();
                }

            });

            $("#pre_btn").click(function () {
                $("#user").hide();
                $("#company").slideDown();
            });

            function isValidURL(url) {
                var RegExp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;

                if (RegExp.test(url)) {
                    return true;
                } else {
                    return false;
                }
            }

        </script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
