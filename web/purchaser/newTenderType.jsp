<%-- 
    Document   : newTenderType
    Created on : Apr 16, 2017, 5:44:58 PM
    Author     : Md. Emran Hossain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Tender: New Tender Type</title>
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
                            <a href="purchaser.jsp">Home</a>
                        </li>
                        <li>
                            <a href="editPurchaser.jsp">Purchaser Info</a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tender<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="newTender.jsp">New Tender</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="allTender.jsp">All My Tender</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Before Make A Tender <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="newTenderType.jsp">Insert Tender Document Type</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="newGroups.jsp">Insert Groups</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="supplierSpce.jsp">Supplier Specification</a>
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
            <div class="container">
                <div class="col-md-offset-3 col-md-6">
                    <form action="../TenderDocComBean" class="form-horizontal" method="post" accept-charset="utf-8">
                        <center><p>${tenderTypeInfo}</p></center>
                        <h2 class="form-heading">Create an Tender Document Type</h2>
                        <div id="tdc">
                            <div class="form-group">
                                <label for="cName" class="col-sm-4 control-label">Column Name</label>
                                <div class="col-sm-8">
                                    <input type="text" id="cName" name="cName" value="" placeholder="Column Name" class="form-control" required /><label class="registrationFormAlert" id="checkCName"></label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="cType" class="col-sm-4 control-label">Column Type</label>
                                <div class="col-sm-8">
                                    <select name="cType" id="cType" class="form-control" onchange="checkColumnType();" required>
                                        <option value="" selected>Select One</option>
                                        <option value="number">Number</option>
                                        <option value="text">Text</option>
                                        <option value="textarea">Textarea</option>
                                        <option value="file">File</option>
                                    </select>
                                    <label class="registrationFormAlert" id="checkUType"></label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="lSize" class="col-sm-4 control-label">Length Size</label>
                                <div class="col-sm-8">
                                    <input type="number" id="lSize" name="lSize" value=""  placeholder="Length Size" class="form-control" required/><label class="registrationFormAlert" id="checkCCategory"></label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="siType" class="col-sm-4 control-label">Supplier Input Type</label>
                                <div class="col-sm-8">
                                    <select name="siType" id="siType" class="form-control" onchange="checkColumnType();" required>
                                        <option value="" selected>Select One</option>
                                        <option value="number">Number</option>
                                        <option value="text">Text</option>
                                        <option value="textarea">Textarea</option>
                                        <option value="file">File</option>
                                    </select>
                                    <label class="registrationFormAlert" id="checksiType"></label>
                                </div>
                            </div>

                            <div class="div-center">
                                <input type="reset" name="reset" value="Reset"  class="btn btn-large btn-danger" />
                                <input type="submit" name="submit" value="Create"  class="btn btn-large btn-primary" />
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
        <%}%>
        <script>
            function checkColumnType() {
                var userType = $("#cType").val();
                if (userType === '' || userType === null) {
                    $("#checkUType").html("<font color='red'>Insert User Type!</font>");
                } else {
                    $("#checkUType").html("<font color='green'>Done!</font>");
                }
            }
            $(document).ready(function () {
                $("#checkUType").keyup(checkUserType);
            });

            function checkSupplierColumnType() {
                var userType = $("#siType").val();
                if (userType === '' || userType === null) {
                    $("#checksiType").html("<font color='red'>Insert User Type!</font>");
                } else {
                    $("#checksiType").html("<font color='green'>Done!</font>");
                }
            }
            $(document).ready(function () {
                $("#checksiType").keyup(checkUserType);
            });
        </script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
