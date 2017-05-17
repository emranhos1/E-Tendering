<%-- 
    Document   : orders
    Created on : Apr 9, 2017, 1:50:20 PM
    Author     : Softcell-4
--%>

<%@page import="Dao.SupplierProSpceDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Dao.SupplierDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                                <li><a href="#">Publish Order</a></li>
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

        <!--For Publish Project only-->
        <div class="jumbotron">
            <div></div>
            <div class="container">
                <div class="col-md-12">
                    <center>
                        <h3>Publish Project</h3>
                        <p>${message}</p>
                        <div>
                            <table class="table table-hover table-bordered text-center">
                                <thead class="table table-responsive">
                                    <tr>
                                        <th>Company</th><th>projects</th><th>Details</th><th>Groups</th><th>Flag</th><th>Start Date</th><th>End Date</th><th>Specification</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int i = 0;
                                        ResultSet rs;
                                        int user_Id = Integer.parseInt(session.getAttribute("idUser").toString());
                                        String neededColumnSupplier = "*";
                                        String whereClauseSupplier = " ppsTsupplier_id like '%\"" + user_Id + "\"%' and flag = 'Publish'";
                                        rs = SupplierDao.allDataForSupplierWithWhereClause(neededColumnSupplier, whereClauseSupplier);
                                        rs.last();
                                        int purchaserProRow = rs.getRow();
                                        String[] purchaserProId = new String[purchaserProRow];
                                        String[] shortDesc = new String[purchaserProRow];
                                        String[] purchaserSpec = new String[purchaserProRow];
                                        String[] companyName = new String[purchaserProRow];
                                        String[] companyType = new String[purchaserProRow];
                                        String[] category = new String[purchaserProRow];
                                        String[] projectName = new String[purchaserProRow];
                                        String[] details = new String[purchaserProRow];
                                        String[] groupName = new String[purchaserProRow];
                                        String[] flag = new String[purchaserProRow];
                                        String[] startDate = new String[purchaserProRow];
                                        String[] endDate = new String[purchaserProRow];
                                        String[] type = new String[purchaserProRow];
                                        String[] auctionSDate = new String[purchaserProRow];
                                        String[] auctionEDate = new String[purchaserProRow];

                                        rs.beforeFirst();

                                        while (rs.next()) {
                                            purchaserProId[i] = rs.getString("ppsTpps_id");
                                            shortDesc[i] = rs.getString("short_desc");
                                            purchaserSpec[i] = rs.getString("purchase_spec");
                                            companyName[i] = rs.getString("company_name");
                                            companyType[i] = rs.getString("company_type");
                                            category[i] = rs.getString("category");
                                            projectName[i] = rs.getString("project_name");
                                            details[i] = rs.getString("project_desc");
                                            groupName[i] = rs.getString("group_name");
                                            flag[i] = rs.getString("flag");
                                            startDate[i] = rs.getString("start_date");
                                            endDate[i] = rs.getString("end_date");
                                            type[i] = rs.getString("type");
                                            auctionSDate[i] = rs.getString("auction_s_date");
                                            auctionEDate[i] = rs.getString("auction_e_date");
                                            i++;
                                        }
                                        for (i = 0; i < purchaserProRow; i++) {
                                    %>
                                    <tr>
                                        <td><%=companyName[i]%></td>
                                        <td><%=projectName[i]%></td>
                                        <td>
                                            Project Details : <%=details[i]%><br/>
                                            <%if (type[i].equals("file")) {%>
                                            File : <img src="../allUpload/<%=shortDesc[i]%>" alt="" height="40px" width="40px"/><br/> 
                                            <%} else {%>
                                            Purchaser Description : <%=shortDesc[i]%> <br/>
                                            <%}%>
                                            Purchaser Spec : <%=purchaserSpec[i]%><br/>
                                        </td>
                                        <td><%=groupName[i]%></td>
                                        <td><%=flag[i]%></td>
                                        <td><%=startDate[i]%></td>
                                        <td><%=endDate[i]%></td>
                                        <td>
                                            <button class="btn btn-success">
                                                <a data-toggle="modal" data-id="<%=purchaserProId[i]%>" data-cname="<%=companyName[i]%>" data-pname="<%=projectName[i]%>" data-gname="<%=groupName[i]%>" data-pdesc="<%=shortDesc[i]%>" class="open-spceDialog" href="#addSpec" >Submit A Proposal</a>
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

        <!--Specification Dialog-->
        <div class="modal fade" id="addSpec" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">Add Specification</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" method="post" action="../SupplierProSpceBean">
                            <div class="form-group">
                                <label for="ppsId" class="col-sm-4 control-label">Purchaser spce ID</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="ppsId" name="ppsId" class="form-control" value="" readonly/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cName" class="col-sm-4 control-label">Company Name</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="cName" name="cName" class="form-control" value="" readonly/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="pName" class="col-sm-4 control-label">Project Name</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="pName" name="pName" class="form-control" value="" readonly/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="gName" class="col-sm-4 control-label">Group Name</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="gName" name="gName" class="form-control" value="" readonly/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="uPrice" class="col-sm-4 control-label">Unit Price</label>
                                <div class="col-sm-8">
                                    <input  type="number" id="uPrice" name="uPrice" class="form-control" value="" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="price" class="col-sm-4 control-label">Price</label>
                                <div class="col-sm-8">
                                    <input  type="number" id="price" name="price" class="form-control" value="" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="spce" class="col-sm-4 control-label">Give Specification</label>
                                <div class="col-sm-8">
                                    <textarea id="spce" name="spce" class="form-control" required></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary" name="submitSpce" value="Save" />
                            </div>
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
            $(document).on("click", ".open-spceDialog", function () {

                var ppsId = $(this).data('id');
                var cName = $(this).data('cname');
                var pName = $(this).data('pname');
                var gName = $(this).data('gname');
                //console.log(pName);

                $(".modal-body #ppsId").val(ppsId);
                $(".modal-body #cName").val(cName);
                $(".modal-body #pName").val(pName);
                $(".modal-body #gName").val(gName);
            });

        </script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
