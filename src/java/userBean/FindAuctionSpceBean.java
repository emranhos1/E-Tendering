package userBean;

import Dao.SupplierProSpceDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FindAuctionSpceBean extends HttpServlet {

    private int j;
    private ResultSet rs1;
    private String neededColumnSpsPpsProjectUsersCompanyAuction;
    private String Id;
    private int userId;
    private String ppsId;
    private String whereClauseSpsPpsProjectUsersCompanyAuction;
    private String[] pName;
    private String[] cName;
    private String[] website;
    private String[] supplierSpce;
    private String[] unitPrice;
    private String[] price;
    private String[] auctionUPrice;
    private String[] auctionPrice;
    private String[] supplierId;
    private String[] pps_Id;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            j = 0;
            ppsId = request.getParameter("ppsId");
            HttpSession session = request.getSession();
            Id = session.getAttribute("idUser").toString();
            userId = Integer.parseInt(Id);

            neededColumnSpsPpsProjectUsersCompanyAuction = "*";
            whereClauseSpsPpsProjectUsersCompanyAuction = " ppsTuser_id = " + userId + " and flag = 'Auction' and pps_id = " + ppsId + " and supplier_spec != 'null'";
            rs1 = SupplierProSpceDao.allDataForSpsPpsProjectUsersCompanyAuctionWithWhereClause(neededColumnSpsPpsProjectUsersCompanyAuction, whereClauseSpsPpsProjectUsersCompanyAuction);

            rs1.last();
            int spsppspucaRow = rs1.getRow();
            pName = new String[spsppspucaRow];
            cName = new String[spsppspucaRow];
            website = new String[spsppspucaRow];
            supplierSpce = new String[spsppspucaRow];
            unitPrice = new String[spsppspucaRow];
            price = new String[spsppspucaRow];
            auctionUPrice = new String[spsppspucaRow];
            auctionPrice = new String[spsppspucaRow];
            supplierId = new String[spsppspucaRow];
            pps_Id = new String[spsppspucaRow];
            rs1.beforeFirst();
            while (rs1.next()) {
                pName[j] = rs1.getString("project_name");
                cName[j] = rs1.getString("company_name");
                website[j] = rs1.getString("website");
                supplierSpce[j] = rs1.getString("supplier_spec");
                unitPrice[j] = rs1.getString("unit_price");
                price[j] = rs1.getString("price");
                auctionUPrice[j] = rs1.getString("aTuprice");
                auctionPrice[j] = rs1.getString("aTprice");
                supplierId[j] = rs1.getString("spsTuser_id");
                pps_Id[j] = rs1.getString("pps_id");
                j++;
            }
            for (j = 0; j < spsppspucaRow; j++) {
                response.setContentType("text/plain");
                response.getWriter().write("<table class='table table-hover table-bordered text-center'>"
                        + "<thead class='table table-responsive'>"
                        + "<tr>"
                        + "<td>SL</td><td>Project</td><td>Supplier Company Details</td><td>Supplier Specification</td><td>Your Given Prices</td><td></td>"
                        + "</tr>"
                        + "</thead>"
                        + "<tbody>"
                        + "<tr>"
                        + "<td>"+(j +1)+"</td><td>"+pName[j]+"</td><td>Company : "+cName[j]+"<br/>Website"+website[j]+"</td><td>Spce : "+supplierSpce[j]+"<br/>Unit Price : "+unitPrice[j]+"<br>Price : "+price[j]+"</td><td>Unit Price : "+auctionUPrice[j]+"<br/>Price : "+auctionPrice[j]+"</td>"
                        + "<td>"
                        + "<button class='btn btn-success'>"
                        + "<a data-toggle='modal' data-ppsid='"+pps_Id[j]+"' data-sid='"+supplierId[j]+"' data-pname='"+pName[j]+"' data-cname='"+cName[j]+"' data-uprice='"+unitPrice[j]+"' data-price='"+price[j]+"' class='open-confirmSupplier' onclick='auctionDialogHide()' href='#confirmSupplier' >Confirm This Supplier</a>"
                        + "</button>"
                        + "<br/>"
                        + "OR"
                        + "<br/>"
                        + "<button class='btn btn-danger'>"
                        + "<a data-toggle='modal' data-ppsid='<%=ppsId[j]%>' class='delete-pruchaserProSpce' href='#deletePPS'>Close Project</a>"
                        + "</button>"
                        + "</td>"
                        + "</tr>"
                        + "</tbody>"
                        + "</table>");
                  
            }
        } catch (SQLException ex) {
            Logger.getLogger(FindAuctionSpceBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
