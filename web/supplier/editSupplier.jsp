<%-- 
    Document   : login
    Created on : Mar 20, 2017, 3:53:59 PM
    Author     : Md. Emran Hossain
--%>

<%@page import="Dao.UserDao"%>
<%@page import="Dao.CompanyDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en-US">
    <head>
        <title> E-Tender</title>
        <meta charset="utf-8">
        <link href="../css/global.css" rel="stylesheet" type="text/css"/>
        <script src="../js/jquery-3.2.1.min.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            if ((session.getAttribute("idUser") == null) || (session.getAttribute("idUser") == "")) {
                response.sendRedirect("../login.jsp");
            } else {%>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">E-Tendering System</a>
                </div>

                <div id="navbar" class="navbar-collapse collapse ">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="supplier.jsp">Home</a>
                        </li>
                        <li>
                            <a href="#">Supplier Info</a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Orders<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="publishOrder.jsp">Publish Order</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="auctionOrder.jsp">Auction Order</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="../logout.jsp">Sign Out</a>
                        </li>
                    </ul> 
                </div>
                <!--/.navbar-collapse -->
            </div>
        </nav>	

        <div class="jumbotron">
            <div></div>
            <div class="container">
                <div class="col-md-12">
                    <nav>
                        <center><p>${updateUserInfo}</p></center>
                        <%
                            ResultSet rs;
                            String Id, companyName = "", companyType = "", companyCategory = "", companyWebsite = "", userName = "", userEmail = "", userType = "", createDate = "";
                            int user_Id;
                            int companyId = 0;

                            Id = session.getAttribute("idUser").toString();
                            user_Id = Integer.parseInt(Id);

                            String neededColumnUsers = "*";
                            String whereClauseUsers = "user_id = '" + user_Id + "'";
                            rs = UserDao.allUserWithWhereClause(neededColumnUsers, whereClauseUsers);
                            while (rs.next()) {
                                companyId = rs.getInt("company_id");
                                userName = rs.getString("user_name");
                                userEmail = rs.getString("email");
                                userType = rs.getString("type");
                                createDate = rs.getString("create_date");
                            }

                            String neededColumnCompany = "*";
                            String whereClauseCompany = "company_id = '" + companyId + "'";
                            rs = CompanyDao.allCompanyWithWhereClause(neededColumnCompany, whereClauseCompany);
                            while (rs.next()) {
                                companyName = rs.getString("company_name");
                                companyType = rs.getString("company_type");
                                companyCategory = rs.getString("category");
                                companyWebsite = rs.getString("website");
                            }
                        %>
                        <form action="../EditSupplierBean" class="form-horizontal" method="post" accept-charset="utf-8">
                            <h2 class="form-heading">Supplier Information</h2>
                            <div>
                                <div class="form-group col-md-6">
                                    <label for="createDate" class="col-sm-4 control-label">Create Date</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="type" name="type" value="<%=createDate%>" class="form-control" required readonly/><label class="registrationFormAlert" id="checkUType"></label>
                                    </div>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="uName" class="col-sm-4 control-label">User Full Name</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="uName" name="uName" value="<%=userName%>" class="form-control" onChange="checkUserName();" required /><label class="registrationFormAlert" id="checkUName"></label>
                                    </div>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="email" class="col-sm-4 control-label">Email Address</label>
                                    <div class="col-sm-8">
                                        <input type="email" id="email" name="email" value="<%=userEmail%>" class="form-control" required readonly/><label class="registrationFormAlert" id="checkUEmail"></label>
                                    </div>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="type" class="col-sm-4 control-label">Account Type</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="type" name="type" value="<%=userType%>" class="form-control" required readonly/><label class="registrationFormAlert" id="checkUType"></label>
                                    </div>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="password1" class="col-sm-4 control-label">Change Password</label>
                                    <div class="col-sm-8">
                                        <input type="password" id="password1" name="password1" value=""  placeholder="Password" class="form-control" maxlength="15" required/>
                                    </div>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="password2" class="col-sm-4 control-label">Confirm Password</label>
                                    <div class="col-sm-8">
                                        <input type="password" id="password2" name="password2" value=""  placeholder="Password confirm" class="form-control" onChange="checkPasswordMatch();"  maxlength="15" required /><label class="registrationFormAlert" id="checkPassword"></label>
                                    </div>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="cName" class="col-sm-4 control-label">Company Name</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="cName" name="cName" value="<%=companyName%>" class="form-control" required /><label class="registrationFormAlert" id="checkCName"></label>
                                    </div>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="cType" class="col-sm-4 control-label">Company Type</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="cType" name="cType" value="<%=companyType%>" class="form-control" required/><label class="registrationFormAlert" id="checkCType"></label>
                                    </div>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="category" class="col-sm-4 control-label">Company Category</label>
                                    <div class="col-sm-8">
                                        <input type="text" id="catagory" name="category" value="<%=companyCategory%>" class="form-control" required/><label class="registrationFormAlert" id="checkCCategory"></label>
                                    </div>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="website" class="col-sm-4 control-label">Company Website</label>
                                    <div class="col-sm-8">
                                        <input type="url" id="website" name="website" value="<%=companyWebsite%>"  placeholder="Ex : http://www.softcellbd.net" class="form-control" required/><label class="registrationFormAlert" id="checkCWebsite"></label>
                                    </div>
                                </div>

                                <div class="div-center">
                                    <input type="submit" name="submit" value="Update"  class="btn btn-large btn-primary" />
                                </div>
                            </div>
                        </form>
                    </nav>
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

        <%}%>
        <script>
            function checkUserName() {
                var userName = $("#uName").val();
                if (userName === '' || userName === null) {
                    $("#checkUName").html("<font color='red'>Insert User Full Name!</font>");
                } else {
                    $("#checkUName").html("<font color='green'>Done!</font>");
                }
            }
            $(document).ready(function () {
                $("#checkUName").keyup(checkUserName);
            });

            function checkPasswordMatch() {
                var pass1 = $("#password1").val();
                var Pass2 = $("#password2").val();


                if (pass1 !== Pass2) {
                    $("#checkPassword").html("<font color='red'>Passwords do not match!</font>");
                } else
                    $("#checkPassword").html("<font color='green'>Passwords match.</font>");
            }

            $(document).ready(function () {
                $("#password1, #password2").keyup(checkPasswordMatch);
            });

        </script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
