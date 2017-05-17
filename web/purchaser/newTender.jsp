<%-- 
    Document   : newTender
    Created on : Apr 16, 2017, 3:53:17 PM
    Author     : Md. Emran Hossain
--%>


<%@page import="Dao.ProjectDao"%>
<%@page import="Dao.TenderDocComDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html lang="en-US">
    <head>
        <title>E-Tender: New Tender</title>
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
                                <li><a href="#">New Tender</a></li>
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
                <div class="col-md-12">
                    <center><p>${createProjectInfo}</p></center>
                    <center><p>${addPurchaserProSpce}</p></center>
                    <form action="../PurchaserProSpceBean" class="form-horizontal" method="post" accept-charset="utf-8" enctype="multipart/form-data">
                        <h2 class="form-heading">Add Purchaser Info</h2>
                        <div id="purchaser">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label for="project_name" class="col-sm-5 control-label">Select Project</label>
                                        <div class="col-sm-5">
                                            <select name="project_id" class="form-control" required>
                                                <option value="">Select One</option>
                                                <%
                                                    int projectId = 0;
                                                    ResultSet rs;
                                                    int userId = Integer.parseInt(session.getAttribute("idUser").toString());

                                                    String neededColumn = "*";
                                                    String whereClauseProject = " user_id = '" + userId + "'";
                                                    rs = ProjectDao.allProjectWithWhereClause(neededColumn, whereClauseProject);
                                                    while (rs.next()) {
                                                %>
                                                <option value="<%=rs.getString("project_id")%>"><%=rs.getString("project_name")%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                        <div class="col-sm-1">
                                            <button name="button" type="button"  class="btn btn-large btn-primary" id="add_project" data-toggle="modal" data-target="#addProject">+</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="sDate" class="col-sm-4 control-label">Start Date</label>
                                        <div class="col-sm-8">
                                            <input type="date" name="sDate" value="" id="sDate" class="form-control" required/>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label for="eDate" class="col-sm-4 control-label">End Date</label>
                                        <div class="col-sm-8">
                                            <input type="date" name="eDate" value="" id="eDate" class="form-control" required/>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <label for="status" class="col-sm-4 control-label">Status</label>
                                        <div class="col-sm-8">
                                            <input type="text" name="status" value="Publish" id="status" class="form-control" readonly/>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <table id="purchaser-table" class="table table-bordered">
                                            <tr id="header-input">
                                            </tr>
                                            <tr id="body-input">
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <div class="div-left">
                                    <button name="button" type="button"  class="btn btn-large btn-primary" id="add_more_btn">Add more</button>
                                </div>

                                <div class="div-center">
                                    <input type="reset" name="reset" value="Reset"  class="btn btn-large btn-danger" />
                                    <input type="submit" name="submit" value="Save"  class="btn btn-large btn-primary" />
                                </div>
                            </div>
                    </form>     

                    <input type="hidden" class="users" name="selected_id[]" value="0">
                    <!--  <input type="hidden" class="users" name="selected_id[]" value="2"> -->
                </div>
                <!-- <p><a class="btn btn-primary btn-lg" href="#" role="button">Sign in</a></p> -->
            </div>
        </div>

        <div class="container">
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

        <!-- Project Modal -->
        <div class="modal fade" id="addProject" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">Add Project</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" method="post" action="../ProjectBean">
                            <div class="form-group">
                                <label for="cName" class="col-sm-4 control-label">Project Title</label>
                                <div class="col-sm-8">
                                    <input  type="text" id="cName" name="pName" class="form-control" placeholder="Project Title" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="pDesc" class="col-sm-4 control-label">Project Description</label>
                                <div class="col-sm-8">
                                    <textarea id="pDesc" name="pDesc" class="form-control" placeholder="Project Description" required></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="reset" class="btn btn-danger" name="submitProject" value="Reset" />
                                <input type="submit" class="btn btn-primary" name="submitProject" value="Save" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--window load time dialog box-->
        <div id="boxes">
            <div id="dialog" class="window">
                <%
                    int i = 0;

                    String neededColumnCompany = "*";
                    String whereClauseForTenderDocCom = " user_id = '" + userId + "'";
                    rs = TenderDocComDao.allTenderDocComWithWhereClause(neededColumnCompany, whereClauseForTenderDocCom);
                    rs.last();
                    int tenderDocComRow = rs.getRow();
                    String[] tdcId = new String[tenderDocComRow];
                    String[] columnName = new String[tenderDocComRow];
                    String[] columnType = new String[tenderDocComRow];
                    String[] columnSize = new String[tenderDocComRow];
                    rs.beforeFirst();
                    while (rs.next()) {
                        tdcId[i] = rs.getString("tdc_id");
                        columnName[i] = rs.getString("component_name");
                        columnType[i] = rs.getString("type");
                        columnSize[i] = rs.getString("size");
                        i++;
                    }

                    for (i = 0; i < tenderDocComRow; i++) {
                %>
                <div id="check-box" class="left-align col-md-6">
                    <input type="checkbox" data-type="<%=columnType[i]%>" data-size="<%=columnSize[i]%>" name="<%=columnName[i]%>" value="<%=tdcId[i]%>"> Name: <%=columnName[i]%> Type: <%=columnType[i]%>(<%=columnSize[i]%>)<br/>
                </div>
                <%}%>
                <div id="popupfoot"> 
                    <a href="#" class="agree btn btn-default">I agree</a>
                    <a href="#" class="not-agree btn btn-default">I do not agree</a>
                </div>
                <div id="mask"></div>
            </div>
        </div>
        <%}%>
        <script type="text/javascript">

            // AJAX call for autocomplete 
            $(document).ready(function () {
                var id = '#dialog';

                //Get the screen height and width
                var maskHeight = $(document).height();
                var maskWidth = $(window).width();
                //Set heigth and width to mask to fill up the whole screen
                //$('#mask').css({'width':maskWidth,'height':maskHeight});
                //transition effect
                $('#mask').fadeIn(500);
                $('#mask').fadeTo("slow", 0.9);

                //Get the window height and width
                var winH = $(window).height();
                var winW = $(window).width();

                //Set the popup window to center
                $(id).css('top', winH / 2 - $(id).height() / 2);
                $(id).css('left', winW / 2 - $(id).width() / 2);
                $(id).css('position', 'fixed');
                //transition effect
                $(id).fadeIn(2000);

                //if I agree button is clicked
                $('.window .agree').click(function (e) {

                    //Cancel the link behavior
                    e.preventDefault();
                    updateTextArea();
                    $('#mask').hide();
                    $('.window').hide();
                });

                $('#mask').click(function () {
                    $(this).hide();
                    $('.window').hide();
                });

                function updateTextArea() {
                    var allVals = [];
                    var allNams = [];
                    var allTyps = [];
                    var allSize = [];
                    $('#check-box :checked').each(function () {
                        allVals.push($(this).val());
                        allNams.push($(this).attr("name"));
                        allTyps.push($(this).attr("data-type"));
                        allSize.push($(this).attr("data-size"));
                    });

                    $.each(allVals, function (index, value) {

                        $('#header-input').append('<td>' + allNams[index] + '</td>');
                        if (allTyps[index] != 'textarea') {
                            $('#body-input').append('<td><input type="hidden" id="tdc_id_' + allTyps[index] + '" name="tdc_' + allTyps[index] + '_1" value="' + value + '"><input id="purc_' + allTyps[index] + '" type="' + allTyps[index] + '" name="purc_' + allTyps[index] + '_1"></td>');
                        } else {
                            //console.log("textarea");
                            $('#body-input').append('<td><input type="hidden" id="tdc_' + allTyps[index] + '" name="tdc_' + allTyps[index] + '_1" value="' + value + '"><textarea id="purc_' + allTyps[index] + '" name="purc_' + allTyps[index] + '_1"></textarea></td>');
                        }
                    });
                    var group = '<input type="hidden" id="table_row" name="table_row[]" value="1"/><input type="text" id="group-search-box" placeholder="Select Group" autocomplete="off" required/><div id="group-suggesstion-box"></div><div class="" id="all_group"></div>';

                    var supplier = '<input type="text" id="search-box" placeholder="Select Supplier" autocomplete="off"/><div id="suggesstion-box"></div><div class="" id="all_supplier" required><input type="hidden" id="users" name="selected_id_1[]" value="0"></div>';

                    $('#purchaser-table tr#header-input').append('<td>Group</td><td>Supplier</td>');
                    $('#purchaser-table tr#body-input').append('<td onClick="searchGroup(this)" class="groupTD">' + group + '</td><td onClick="searchSupplier(this)">' + supplier + '</td>');
                }
            });
            function searchSupplier(elam) {
                $(elam).on("keyup", "#search-box", function () {
                    var row_index = $(elam).parent().index();
                    //console.log(row_index);
                    var users = [];
                    $(elam).find('input[name^="selected_id_' + row_index + '"]').each(function () {
                        users.push($(this).val());
                    });
                    var search = $(this).val();
                    if (users) {
                        //var users_data = JSON.stringify(users);
                        var users_data = users;
                        console.log(users_data);
                    }

                    $.ajax({
                        type: "POST",
                        url: "../FindSupplier",
                        data: 'search=' + search + '&users=' + users_data,
                        beforeSend: function () {
                            $(elam).find("#search-box").css("background", "#FFF");
                        },
                        success: function (data) {
                            $(elam).find("#suggesstion-box").show();
                            $(elam).find("#suggesstion-box").html(data);
                            $(elam).find("#search-box").css("background", "#FFF");
                        }
                    });
                });
            }

            function searchGroup(elam) {
                $(elam).on("keyup", "#group-search-box", function () {
                    var search = $(this).val();
                    $.ajax({
                        type: "POST",
                        url: "../FindGroups",
                        data: 'keyword=' + search,
                        beforeSend: function () {
                            $(elam).find("#group-search-box").css("background", "#FFF");
                        },
                        success: function (data) {
                            $(elam).find("#group-suggesstion-box").show();
                            $(elam).find("#group-suggesstion-box").html(data);
                            $(elam).find("#group-search-box").css("background", "#FFF");
                        }
                    });
                });
            }

            function selectSupplier(elem) {
                var id = $(elem).attr("search");
                var val = $(elem).attr("data-val");
//                var trCount = $('#purchaser-table tr').length;
//                var ar = trCount - 2;
                //console.log(val);
                var row_index = $(elem).parent().parent().parent().index();
                console.log(row_index);
                $(elem).parent().parent().parent().find("#search-box").val('');
                $(elem).parent().parent().parent().find("#all_supplier").append("<div id='user_list_selected'><div id='selected_user'>" + val + "</div><div onClick='removeSupplier(this)' id='closeit'>×</div><input type='hidden' class='users' name='selected_id_" + row_index + "[]' value='" + id + "'</div>");
                $(elem).parent().parent().parent().find("#suggesstion-box").hide();
            }

            function selectGroup(elem) {
                var id = $(elem).attr("id");
                var val = $(elem).attr("data-val");
                //console.log(val);
                var row_index = $(elem).parent().parent().parent().index();
                $(elem).parent().parent().parent().find("#group-search-box").val(val);
                $(elem).parent().parent().parent().find("#all_group").html("<input type='hidden' class='users' name='group_id_" + row_index + "' value='" + id + "'</div>");
                $(elem).parent().parent().parent().find("#group-suggesstion-box").hide();
            }

            function removeSupplier(elem) {
                $(elem).parent().remove();
            }

            $("#add_more_btn").click(function () {
                var tableRow = $("#body-input").html();
                console.log(tableRow);
                var trCount = $('#purchaser-table tr').length;
                var ro = trCount;
                //console.log(rowCount);
                var $currentHtml = $('<div>').append(tableRow);

                $currentHtml.find('#user_list_selected').remove();
                $currentHtml.find("#table_row").attr("value", ro);
                $currentHtml.find("#tdc_file").attr("name", "tdc_file_" + ro);
                $currentHtml.find("#tdc_text").attr("name", "tdc_text_" + ro);
                $currentHtml.find("#tdc_number").attr("name", "tdc_number_" + ro);
                $currentHtml.find("#tdc_textarea").attr("name", "tdc_textarea_" + ro);
                $currentHtml.find("#purc_file").attr("name", "purc_file_" + ro);
                $currentHtml.find("#purc_text").attr("name", "purc_text_" + ro);
                $currentHtml.find("#purc_number").attr("name", "purc_number_" + ro);
                $currentHtml.find("#purc_textarea").attr("name", "purc_textarea_" + ro);
                $currentHtml.find("#users").attr("name", "selected_id_" + ro + "[]");
                var newRow = $currentHtml.html();
                $("#purchaser-table").append("<tr id='body-input'>" + newRow + "</tr>");
            });
        </script>
        <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>