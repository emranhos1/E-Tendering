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
                                <li><a href="publishOrder.jsp">Publish Order</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Auction Order</a></li>
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
                        <h3>Auction Project</h3>
                        <p>${updateAuctionInfo}</p>
                        <div>
                            <table class="table table-hover table-bordered text-center">
                                <thead class="table table-responsive">
                                    <tr>
                                        <th>Company</th><th>projects</th><th>Groups</th><th>Flag</th><th>Auction Start Date</th><th>Auction End Date</th><th>New Specification</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int j = 0;
                                        ResultSet resultset;
                                        int userId = Integer.parseInt(session.getAttribute("idUser").toString());

                                        String neededColumnAllDataSupplierProSpce = "*";
                                        String whereClauseAllDataSupplierProSpce = " supplier_spec !='null' and user_id = '" + userId + "' and flag = 'Auction'";
                                        resultset = SupplierProSpceDao.allDataForAllDataSupplierProSpceWithWhereClause(neededColumnAllDataSupplierProSpce, whereClauseAllDataSupplierProSpce);
                                        resultset.last();
                                        int supplierProRow = resultset.getRow();
                                        String[] ppsId = new String[supplierProRow];
                                        String[] beforeUnitPrice = new String[supplierProRow];
                                        String[] beforePrice = new String[supplierProRow];
                                        String[] cName = new String[supplierProRow];
                                        String[] pName = new String[supplierProRow];
                                        String[] gName = new String[supplierProRow];
                                        String[] flag = new String[supplierProRow];
                                        String[] aSDate = new String[supplierProRow];
                                        String[] aEDate = new String[supplierProRow];
                                        resultset.beforeFirst();

                                        while (resultset.next()) {
                                            ppsId[j] = resultset.getString("pps_id");
                                            beforeUnitPrice[j] = resultset.getString("unit_price");
                                            beforePrice[j] = resultset.getString("price");
                                            cName[j] = resultset.getString("company_name");
                                            pName[j] = resultset.getString("project_name");
                                            gName[j] = resultset.getString("group_name");
                                            flag[j] = resultset.getString("flag");
                                            aSDate[j] = resultset.getString("auction_s_date");
                                            aEDate[j] = resultset.getString("auction_e_date");
                                            j++;
                                        }
                                        for (j = 0; j < supplierProRow; j++) {
                                    %>
                                    <tr>
                                        <td><%=cName[j]%></td>
                                        <td><%=pName[j]%></td>
                                        <td><%=gName[j]%></td>
                                        <td><%=flag[j]%></td>
                                        <td><%=aSDate[j]%></td>
                                        <td><%=aEDate[j]%></td>
                                        <td>
                                            <button class="btn btn-success">
                                                <a data-toggle="modal" data-ppsid="<%=ppsId[j]%>" data-buprice="<%=beforeUnitPrice[j]%>" data-bprice="<%=beforePrice[j]%>" data-cname="<%=cName[j]%>" data-pname="<%=pName[j]%>" data-gname="<%=gName[j]%>" data-flag="<%=flag[j]%>" data-asdate="<%=aSDate[j]%>" data-aedate="<%=aEDate[j]%>" class="open-newSpceDialog" href="#newSpec" ><b>Submit New Proposal</b></a>
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
        <div class="modal fade" id="newSpec" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">Add New Specification</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" method="post" action="../UpdateSupplierProSpceBean">
                            <div id="supplierAuctionOrder">
                                <div class="row">

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="aEDate" class="col-sm-10 control-label">Auction Start Date</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="aEDate" value="" id="aEDate" class="form-control" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="aEDate" class="col-sm-10 control-label">Auction End Date</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="aEDate" value="" id="aEDate" class="form-control" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="flag" class="col-sm-10 control-label">Status</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="flag" value="" id="flag" class="form-control" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="cName" class="col-sm-10 control-label">Company Name</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="cName" value="" id="cName" class="form-control" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="pName" class="col-sm-10 control-label">Project Name</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="pName" value="" id="pName" class="form-control" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="gName" class="col-sm-10 control-label">Group Name</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="gName" value="" id="gName" class="form-control" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="bUPrice" class="col-sm-10 control-label">Unit Price</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="bUPrice" value="" id="bUPrice" class="form-control" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="bPrice" class="col-sm-10 control-label">Price</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="bPrice" value="" id="bPrice" class="form-control" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="newUPrice" class="col-sm-10 control-label">New Unit Price</label>
                                            <div class="col-sm-10">
                                                <input type="number" name="newUPrice" value="" id="newUPrice" class="form-control" required/>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="ppsId" class="col-sm-10 control-label">Purchaser Pro ID</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="ppsId" name="ppsId" value="" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="newPrice" class="col-sm-10 control-label">New Price</label>
                                            <div class="col-sm-10">
                                                <input type="number" name="newPrice" value="" id="newPrice" class="form-control" required/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-10">
                                        <div class="form-group">
                                            <div class="div-center">
                                                <input type="reset" name="reset" value="Reset"  class="btn btn-large btn-danger" />
                                                <input type="submit" name="submit" value="Bit New"  class="btn btn-large btn-primary" />
                                            </div>
                                        </div>
                                    </div>
                                </div>    
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
            $(document).on("click", ".open-newSpceDialog", function () {

                var ppsId = $(this).data('ppsid');
                var beforeUnitPrice = $(this).data('buprice');
                var beforePrice = $(this).data('bprice');
                var cName = $(this).data('cname');
                var pName = $(this).data('pname');
                var gName = $(this).data('gname');
                var flag = $(this).data('flag');
                var aSDate = $(this).data('asdate');
                var aEDate = $(this).data('aedate');
                //console.log(pName);

                $(".modal-body #ppsId").val(ppsId);
                $(".modal-body #bUPrice").val(beforeUnitPrice);
                $(".modal-body #bPrice").val(beforePrice);
                $(".modal-body #cName").val(cName);
                $(".modal-body #pName").val(pName);
                $(".modal-body #gName").val(gName);
                $(".modal-body #flag").val(flag);
                $(".modal-body #aSDate").val(aSDate);
                $(".modal-body #aEDate").val(aEDate);
            });
        </script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>

