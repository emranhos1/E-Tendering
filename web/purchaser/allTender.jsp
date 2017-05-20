<%-- 
    Document   : allTender
    Created on : Mar 20, 2017, 3:53:59 PM
    Author     : Md. Emran Hossain
--%>

<%@page import="Dao.SupplierProSpceDao"%>
<%@page import="Dao.PurchaserProSpceDao"%>
<%@page import="Dao.UserDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en-US">
    <head>
        <title>E-Tender: All Tenders</title>
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
                                <li><a href="#">All My Tender</a></li>
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
            <div></div>
            <div class="container">
                <div class="col-md-12">
                    <center>
                        <div>
                            <h2>All Projects</h2>
                            <p>${auctionInfo}</p>
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
                                        String WhereClauseSpsPpsProjectUsersCompany = " ppsTuser_id = '" + user_Id + "' and flag = 'Publish'";
                                        rs = ppsd.allSpsPpsProjectUsersCompanyWithWhereClause(neededColumnSpsPpsProjectUsersCompany, WhereClauseSpsPpsProjectUsersCompany);

                                        rs.last();
                                        int dataRow = rs.getRow();
                                        String[] ppsTppsId = new String[dataRow];
                                        String[] supplier_id = new String[dataRow];
                                        String[] projectName = new String[dataRow];
                                        String[] projectId = new String[dataRow];
                                        String[] flag = new String[dataRow];
                                        String[] startDate = new String[dataRow];
                                        String[] endDate = new String[dataRow];
                                        rs.beforeFirst();
                                        while (rs.next()) {
                                            ppsTppsId[i] = rs.getString("pps_id");
                                            supplier_id[i] = rs.getString("spsTuser_id");
                                            projectName[i] = rs.getString("project_name");
                                            projectId[i] = rs.getString("project_id");
                                            flag[i] = rs.getString("flag");
                                            startDate[i] = rs.getString("start_date");
                                            endDate[i] = rs.getString("end_date");
                                            i++;
                                        }
                                        for (i = 0; i < dataRow; i++) {
                                    %>

                                    <tr data-toggle="modal" data-ppsid="<%=ppsTppsId[i]%>" data-sid="<%=supplier_id[i]%>" data-pname="<%=projectName[i]%>" data-pid="<%=projectId[i]%>" data-flag="<%=flag[i]%>" class="open-auction" href="#specDetails" onclick="getProjectSpce(this)">
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

        <!--Confirm Auction Dialog box-->
        <div class="modal fade" id="confirmAuction" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <center><h4 class="modal-title" id="myModalLabel">Confirm Auction</h4></center>
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
                                <label for="uPrice" class="col-sm-4 control-label">Unit Price</label>
                                <div class="col-sm-8">
                                    <input type="number" id="uPrice" name="uPrice" class="form-control" value="" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="price" class="col-sm-4 control-label">Price</label>
                                <div class="col-sm-8">
                                    <input type="number" id="price" name="price" class="form-control" value="" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="AuctionSDate" class="col-sm-4 control-label">Auction Start Date</label>
                                <div class="col-sm-8">
                                    <input type="date" id="AuctionSDate" name="AuctionSDate" class="form-control" value="" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="AuctionEDate" class="col-sm-4 control-label">Auction End Date</label>
                                <div class="col-sm-8">
                                    <input type="date" id="AuctionEDate" name="AuctionEDate" class="form-control" value="" required/>
                                </div>
                            </div>
                            <input type="text" id="ppsId" name="ppsId" class="form-control" value="" />
                            <input type="text" id="pId" name="pId" class="form-control" value="" />
                            <input type="text" id="sId" name="sId" class="form-control" value="" />
                            <center>
                                <input id="btn-confirm" type="submit" name="submit" value="Confirm" class="btn btn-success"/>
                                <button type="button" class="btn btn-danger" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">Cancel</span>
                                </button>
                            </center>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        
        <!--Auction this project dialog box-->
        <div class="modal fade" id="specDetails" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <center><h4 class="modal-title" id="myModalLabel">Auction This Project ?</h4></center>
                    </div>
                    <div class="modal-body">
                        <form action="" class="form-horizontal" method="post" accept-charset="utf-8">

                            <input type="text" id="ppsId" name="ppsId" class="form-control" value="" />
                            <input type="text" id="pId" name="pId" class="form-control" value="" />
                            <input type="text" id="sId" name="sId" class="form-control" value="" />
                            <div class="form-group">
                                <label for="pName" class="col-sm-4 control-label">Project Name</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="pName" name="pName" class="form-control" value="" readonly/>
                                </div>
                            </div>

                            <div id="all-info-box"></div>
                            <center>
                                <input id="btn-confirm" type="button" name="auction" value="Auction" data-toggle="modal" href="#confirmAuction" onclick="auctionDialogHide()" class="btn btn-success"/>
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
            $(document).on("click", ".open-auction", function () {
                var ppsId = $(this).data('ppsid');
                var projectName = $(this).data('pname');
                var projectId = $(this).data('pid');
                var supplierId = $(this).data('sid');
                var flag = $(this).data('flag');
                $(".modal-body #ppsId").val(ppsId);
                $(".modal-body #pName").val(projectName);
                $(".modal-body #pId").val(projectId);
                $(".modal-body #sId").val(supplierId);
                $(".modal-body #flag").val(flag);
            });

            function getProjectSpce(el) {

                var ppsId = $(el).data('ppsid');
                var projectId = $(el).data('pid');
                var supplierId = $(el).data('sId');
                $.ajax({
                    type: "POST",
                    url: "../FindSupplierSpceBean",
                    data: 'ppsId=' + ppsId + '&pId=' + projectId,
                    success: function (data) {
                        $("#all-info-box").show();
                        $("#all-info-box").html(data);
                        var btnShow = $("#all-info-box").find("#data-none").data('none');
                        console.log(btnShow);
                        if (btnShow == 0) {
                            $("#all-info-box").parent().find("#btn-confirm").hide();
                        } else {
                            $("#all-info-box").parent().find("#btn-confirm").show();
                        }
                    }
                });
            }
            
            function auctionDialogHide(){
                $(".close").click();
            }
        </script>

        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
