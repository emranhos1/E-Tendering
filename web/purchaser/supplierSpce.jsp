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
        <!--menu bar-->
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

        <!--jumbotron-->
        <div class="jumbotron">
            <div></div>
            <div class="container">
                <div class="col-md-12">
                    <center>
                        <div>
                            <h2>All Bits Projects</h2>
                            <p>${confirmSupplierInfo}</p>
                            <table border="1" class="table table-hover text-center">
                                <thead class="table table-responsive">
                                    <tr>
                                        <th>SL</th><th>Project Name</th><th>Flag</th><th>Start Date</th><th>End Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int i = 0;

                                        PurchaserProSpceDao ppsd = new PurchaserProSpceDao();
                                        ResultSet rs;
                                        int user_Id = Integer.parseInt(session.getAttribute("idUser").toString());
                                        String neededColumnSpsPpsProjectUsersCompany = "*";
                                        String WhereClauseSpsPpsProjectUsersCompany = " ppsTuser_id = '" + user_Id + "' and flag = 'Auction' and supplier_spec != 'null'";
                                        rs = ppsd.allSpsPpsProjectUsersCompanyWithWhereClause(neededColumnSpsPpsProjectUsersCompany, WhereClauseSpsPpsProjectUsersCompany);

                                        rs.last();
                                        int dataRow = rs.getRow();
                                        String[] ppsTppsId = new String[dataRow];
                                        String[] spsTsps_id = new String[dataRow];
                                        String[] projectName = new String[dataRow];
                                        String[] projectId = new String[dataRow];
                                        String[] flag = new String[dataRow];
                                        String[] startDate = new String[dataRow];
                                        String[] endDate = new String[dataRow];
                                        rs.beforeFirst();
                                        while (rs.next()) {
                                            ppsTppsId[i] = rs.getString("pps_id");
                                            spsTsps_id[i] = rs.getString("spsTsps_id");
                                            projectName[i] = rs.getString("project_name");
                                            projectId[i] = rs.getString("project_id");
                                            flag[i] = rs.getString("flag");
                                            startDate[i] = rs.getString("start_date");
                                            endDate[i] = rs.getString("end_date");
                                            i++;
                                        }
                                        for (i = 0; i < dataRow; i++) {
                                    %>

                                    <tr data-toggle="modal" data-ppsid="<%=ppsTppsId[i]%>" class="open-auction" href="#specDetails" onclick="getAuctionSpce(this)">
                                        <td><%=i + 1%></td><td><%=projectName[i]%></td><td><%=flag[i]%></td><td><%=startDate[i]%></td><td><%=endDate[i]%></td>

                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                    </center>
                </div>
            </div>
        </div>

        <!--specDetails dialog box-->
        <div class="modal fade" id="specDetails" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <center><h4 class="modal-title" id="myModalLabel">All Supplier Specification</h4></center>
                    </div>
                    <div id="all-info-box"></div>
                </div>
            </div>
        </div>

        <!--Confirm Supplier-->
        <div class="modal fade" id="confirmSupplier" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <center><h4 class="modal-title" id="myModalLabel">Confirm This Supplier?</h4></center>
                    </div>
                    <div class="modal-body">
                        <form action="../ConfirmSupplier" class="form-horizontal" method="post" accept-charset="utf-8">
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
                                <label for="uPrice" class="col-sm-4 control-label">Supplier Unit Price</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="uPrice" name="uPrice" class="form-control" value="" readonly/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="price" class="col-sm-4 control-label">Supplier Price</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="price" name="price" class="form-control" value="" readonly/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="massege" class="col-sm-4 control-label">Contact Info</label>
                                <div class="col-sm-8">
                                    <textarea id="massege" name="massege" class="form-control" placeholder="exp: Email or Phone No or Any other contuct info" maxlength="255" required></textarea>
                                </div>
                            </div>
                            <center>
                                <input type="submit" name="submit" value="Confirm Supplier" class="btn btn-success"/>
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
            $(document).on("click", ".open-confirmSupplier", function () {
                var projectName = $(this).data('pname');
                var companyName = $(this).data('cname');
                var unitPrice = $(this).data('uprice');
                var price = $(this).data('price');
                var ppsId = $(this).data('ppsid');
                var sId = $(this).data('sid');
                $(".modal-body #pName").val(projectName);
                $(".modal-body #cName").val(companyName);
                $(".modal-body #uPrice").val(unitPrice);
                $(".modal-body #price").val(price);
                $(".modal-body #ppsId").val(ppsId);
                $(".modal-body #sId").val(sId);
            });
            function getAuctionSpce(el) {

                var ppsId = $(el).data('ppsid');
                $.ajax({
                    type: "POST",
                    url: "../FindAuctionSpceBean",
                    data: 'ppsId=' + ppsId,
                    success: function (data) {
                        $("#all-info-box").show();
                        $("#all-info-box").html(data);
                        console.log(data)
                    }
                });
            }

            function auctionDialogHide() {
                $(".close").click();
            }
        </script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
