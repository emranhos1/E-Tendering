<%-- 
    Document   : allTender
    Created on : Mar 20, 2017, 3:53:59 PM
    Author     : Md. Emran Hossain
--%>

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
                            <table border="1" class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Project Name</th><th>Group Name</th><th>Flag</th><th>Start Date</th><th>End Date</th><th>Auction Start Date</th><th>Auction End Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int i = 0;

                                        PurchaserProSpceDao ppsd = new PurchaserProSpceDao();
                                        ResultSet rs;
                                        int user_Id = Integer.parseInt(session.getAttribute("idUser").toString());
                                        String neededColumnPurchaseProSpec = "*";
                                        String WhereClausePurchaseProSpec = " ppsTuser_id = '" + user_Id + "'";
                                        rs = ppsd.allPurchaseProSpecWithWhereClause(neededColumnPurchaseProSpec, WhereClausePurchaseProSpec);

                                        rs.last();
                                        int companyRow = rs.getRow();
                                        String[] projectName = new String[companyRow];
                                        String[] groupName = new String[companyRow];
                                        String[] flag = new String[companyRow];
                                        String[] startDate = new String[companyRow];
                                        String[] endDate = new String[companyRow];
                                        String[] auctionSDate = new String[companyRow];
                                        String[] auctionEDate = new String[companyRow];
                                        rs.beforeFirst();

                //                        SimpleDateFormat dt = new SimpleDateFormat("yyyyy-mm-dd");
                                        //                        Date date = dt.parse(date_s);
                                        while (rs.next()) {
                                            projectName[i] = rs.getString("project_name");
                                            groupName[i] = rs.getString("group_name");
                                            flag[i] = rs.getString("flag");
                                            startDate[i] = rs.getString("start_date");
                                            endDate[i] = rs.getString("end_date");
                                            auctionSDate[i] = rs.getString("auction_s_date");
                                            auctionEDate[i] = rs.getString("auction_e_date");
                                            i++;
                                        }
                                        for (i = 0; i < companyRow; i++) {
                                    %>
                                    <tr>
                                        <td><%=projectName[i]%></td></td><td><%=groupName[i]%></td><td><%=flag[i]%></td><td><%=startDate[i]%></td><td><%=endDate[i]%></td><td><%=auctionSDate[i]%></td><td><%=auctionEDate[i]%></td>
                                        <%}%>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </center>
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
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
