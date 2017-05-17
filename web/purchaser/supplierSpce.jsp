<%-- 
    Document   : supplierSpce
    Created on : Mar 20, 2017, 3:53:59 PM
    Author     : Md. Emran Hossain
--%>

<%@page import="Dao.PurchaserProSpceDao"%>
<%@page import="Dao.SupplierProSpceDao"%>
<%@page import="Dao.SupplierDao"%>
<%@page import="Dao.UserDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en-US">
    <head>
        <title>E-Tender: Supplier Spce</title>
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
                            <a href="#">Supplier Specification</a>
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
                    <center>

                        <p>${message}</p>
                        <p>${auctionInfo}</p>
                        <p>${deleteInfo}</p>

                        <div>
                            <table class="table table-hover table-bordered text-center">
                                <thead class="table table-responsive">
                                    <tr>
                                        <td>SL</td><td>Project</td><td>Supplier Specification</td><td>Supplier Company Details</td><td></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int i = 0;
                                        int sl = 0;
                                        ResultSet rs;
                                        int user_Id = Integer.parseInt(session.getAttribute("idUser").toString());
                                        String neededColumnSupplier = "*";
                                        String whereClauseSupplier = " ppsTuser_id = " + user_Id + " and flag = 'Publish' and supplier_spec != 'null'";
                                        rs = SupplierProSpceDao.allDataForSpsPpsProjectUsersCompanyWithWhereClause(neededColumnSupplier, whereClauseSupplier);

                                        rs.last();
                                        int companyRow = rs.getRow();
                                        String[] projectName = new String[companyRow];
                                        String[] supplierSpce = new String[companyRow];
                                        String[] unitPrice = new String[companyRow];
                                        String[] price = new String[companyRow];
                                        String[] companyName = new String[companyRow];
                                        String[] website = new String[companyRow];
                                        String[] supplierId = new String[companyRow];
                                        String[] ppsId = new String[companyRow];
                                        rs.beforeFirst();
                                        while (rs.next()) {
                                            projectName[i] = rs.getString("project_name");
                                            supplierSpce[i] = rs.getString("supplier_spec");
                                            unitPrice[i] = rs.getString("unit_price");
                                            price[i] = rs.getString("price");
                                            companyName[i] = rs.getString("company_name");
                                            website[i] = rs.getString("website");
                                            supplierId[i] = rs.getString("spsTuser_id");
                                            ppsId[i] = rs.getString("pps_id");
                                            i++;
                                        }
                                        for (i = 0; i < companyRow; i++) {
                                    %>
                                    <tr>
                                        <td><%=i + 1%></td><td><%=projectName[i]%></td><td>Spce : <%=supplierSpce[i]%><br/>Unit Price : <%=unitPrice[i]%><br><%=price[i]%></td><td>Company : <%=companyName[i]%><br/><%=website[i]%></td>
                                        <td>
                                            <button class="btn btn-success">
                                                <a data-toggle="modal" data-pname="<%=projectName[i]%>" data-cname="<%=companyName[i]%>" data-sid="<%=supplierId[i]%>" data-ppsid="<%=ppsId[i]%>" data-uprice="<%=unitPrice[i]%>" data-price="<%=price[i]%>" class="open-auction" href="#auction" >Auction</a>
                                            </button>
                                            <br/>
                                            OR
                                            <br/>
                                            <button class="btn btn-danger">
                                                <a data-toggle="modal" data-ppsid="<%=ppsId[i]%>" class="delete-pruchaserProSpce" href="#deletePPS">Close Project</a>
                                            </button>
                                        </td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                    </center>
                </div>
            </div>
        </div>

        <!--delete Project-->
        <div class="modal fade" id="deletePPS" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <center><h4 class="modal-title" id="myModalLabel">Auction This Project ?</h4></center>
                    </div>
                    <div class="modal-body">
                        <form action="../DeletePurchaserProSpce" class="form-horizontal" method="post" accept-charset="utf-8">
                            <p>Are You Sure To Delete Project</p>
                            <input type="hidden" id="ppsId" name="ppsId" class="form-control" value="" />

                            <center>
                                <input type="submit" name="submit" value="Delete Project" class="btn btn-success"/>
                                <button type="button" class="btn btn-danger" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">Cancel</span>
                                </button>
                            </center>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--Going project to Auction-->
        <div class="modal fade" id="auction" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <center><h4 class="modal-title" id="myModalLabel">Auction This Project ?</h4></center>
                    </div>
                    <div class="modal-body">
                        <form action="../AuctionBean" class="form-horizontal" method="post" accept-charset="utf-8">
                            <div class="form-group">
                                <label for="pName" class="col-sm-4 control-label">Project Name</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="pName" name="pName" class="form-control" value="" readonly/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cName" class="col-sm-4 control-label">Company Name</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="cName" name="cName" class="form-control" value="" readonly/>
                                </div>
                            </div>

                            <input type="hidden" id="sId" name="sId" class="form-control" value="" />
                            <input type="hidden" id="ppsId" name="ppsId" class="form-control" value="" />

                            <div class="form-group">
                                <label for="uPrice" class="col-sm-4 control-label">Unit Price</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="uPrice" name="uPrice" class="form-control" value="" readonly/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="price" class="col-sm-4 control-label">Price</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="price" name="price" class="form-control" value="" readonly/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="AuctionSDate" class="col-sm-4 control-label">Auction Start Date</label>
                                <div class="col-sm-8">
                                    <input  type="date" id="AuctionSDate" name="AuctionSDate" class="form-control" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="AuctionEDate" class="col-sm-4 control-label">Auction End Date</label>
                                <div class="col-sm-8">
                                    <input  type="date" id="AuctionEDate" name="AuctionEDate" class="form-control" required/>
                                </div>
                            </div>
                            <center>
                                <input type="submit" name="submit" value="Confirm" class="btn btn-success"/>
                                <button type="button" class="btn btn-danger" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">Cancel</span>
                                </button>
                            </center>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--        confirm box
                <div class="modal fade" id="confirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h4 class="modal-title" id="myModalLabel">Confirmation</h4>
                            </div>
                            <div class="alert">
                                <form method="post" action="">
                                    <p>If You Confirm This Supplier You Can't Hire Another Supplier</p>
                                    <input type="submit" class="btn btn-primary" name="submitSpce" value="Confirm" /><button class="close btn-danger" data-dismiss="modal" aria-label="Close" >Cancel</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>-->

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
            $(document).on("click", ".open-auction", function () {

                var supplierId = $(this).data('sid');
                var ppsId = $(this).data('ppsid');
                var unitPrice = $(this).data('uprice');
                var price = $(this).data('price');
                var projectName = $(this).data('pname');
                var companyName = $(this).data('cname');
                console.log(supplierId);
                console.log(ppsId);
                console.log(unitPrice);
                console.log(price);
                console.log(projectName);
                console.log(companyName);

                $(".modal-body #sId").val(supplierId);
                $(".modal-body #ppsId").val(ppsId);
                $(".modal-body #uPrice").val(unitPrice);
                $(".modal-body #price").val(price);
                $(".modal-body #pName").val(projectName);
                $(".modal-body #cName").val(companyName);
            });
            
            $(document).on("click", ".delete-pruchaserProSpce", function () {

                var ppsId = $(this).data('ppsid');
                
                $(".modal-body #ppsId").val(ppsId);
                console.log(ppsId);
            });
        </script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
