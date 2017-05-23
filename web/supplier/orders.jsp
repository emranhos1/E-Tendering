<%-- 
    Document   : supplier
    Created on : Mar 20, 2017, 3:53:59 PM
    Author     : Md. Emran Hossain
--%>

<%@page import="Dao.ConfirmSupplierDao"%>
<%@page import="Dao.UserDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en-US">
    <head>
        <title>E-Tender: Supplier</title>
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
                            <a href="editSupplier.jsp">Supplier Info</a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Orders<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="publishOrder.jsp">Publish Order</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="auctionOrder.jsp">Auction Order</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Orders</a></li>
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

        <!--jumbotron-->
        <div class="jumbotron">
            <div></div>
            <div class="container">
                <div class="col-md-12">
                    <center>
                        <p>${message}</p>
                        <div>
                            <table class="table table-hover table-bordered text-center">
                                <thead class="table table-responsive">
                                    <tr>
                                        <th><center><h3>Job Confirmation</h3></center></th>
                                </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int i = 0;
                                        ResultSet rs;
                                        int user_Id = Integer.parseInt(session.getAttribute("idUser").toString());
                                        String neededColumnConfirmSupplier = "*";
                                        String whereClauseConfirmSupplier = " user_id = '" + user_Id + "'";
                                        rs = ConfirmSupplierDao.selectConfirmSupplierWithWhereClause(neededColumnConfirmSupplier, whereClauseConfirmSupplier);
                                        rs.last();
                                        int purchaserProRow = rs.getRow();
                                        String[] purchaserProId = new String[purchaserProRow];
                                        String[] massage = new String[purchaserProRow];
                                        String[] finalUnitPrice = new String[purchaserProRow];
                                        String[] finalPrice = new String[purchaserProRow];
                                        rs.beforeFirst();

                                        while (rs.next()) {
                                            purchaserProId[i] = rs.getString("pps_id");
                                            massage[i] = rs.getString("massage");
                                            finalUnitPrice[i] = rs.getString("final_u_price");
                                            finalPrice[i] = rs.getString("final_price");
                                            i++;
                                        }
                                        for (i = 0; i < purchaserProRow; i++) {
                                            if (purchaserProRow > 0) {
                                    %>
                                    <tr data-toggle="modal" data-ppsid="<%=purchaserProId[i]%>" data-massage="<%=massage[i]%>" data-fuprice="<%=finalUnitPrice[i]%>" data-fprice="<%=finalPrice[i]%>" class="open-massege" href="#massage" onclick="getMassage(this)">
                                        <td>
                                            <h3>You have a new Massage </h3><br/>
                                            <h4>You are selected for a new job</h4><br/>
                                            Massage : <%=massage[i]%><br/>
                                            Final Unit Price : <%=finalUnitPrice[i]%><br/>
                                            Final Price : <%=finalPrice[i]%>
                                        </td>
                                    </tr>
                                    <%} else {%>
                                <h3>You have No new Job </h3><br/>  
                                <%}
                                    }%>
                                </tbody>
                            </table>
                        </div>
                    </center>
                </div>
            </div>
        </div>
                                
        <!--massage dialog box-->
        <div class="modal fade" id="massage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <center><h4 class="modal-title" id="myModalLabel">New Job</h4></center>
                    </div>
                    <div class="modal-body">
                        <form action="" class="form-horizontal" method="post" accept-charset="utf-8">

                            <input type="hidden" id="ppsId" name="ppsId" class="form-control" value="" />
                            <div class="form-group">
                                <label for="pName" class="col-sm-4 control-label">Massage</label>
                                <div class="col-sm-8">
                                    <textarea id="massage" name="massage" class="form-control" readonly></textarea>
                                </div>
                            </div>

                            <div id="all-info-box"></div>
                            <center>
                                <input id="btn-confirm" type="button" name="auction" value="FFF" data-toggle="modal" href="#" onclick="" class="btn btn-success"/>
                                <button type="button" class="btn btn-danger" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">Cancel</span>
                                </button>
                            </center>
                        </form>
                    </div>
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
            $(document).on("click", ".open-massege", function () {
                var ppsId = $(this).data('ppsid');
                var massage = $(this).data('massage');
                var finalUnitPrice = $(this).data('fuprice');
                var finalPrice = $(this).data('fprice');
                $(".modal-body #ppsId").val(ppsId);
                $(".modal-body #massage").val(massage);
                $(".modal-body #fUPrice").val(finalUnitPrice);
                $(".modal-body #fPrice").val(finalPrice);
            });


        </script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
