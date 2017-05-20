/**
 *
 * @author Md. Emran Hossain
 */
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

public class FindSupplierSpceBean extends HttpServlet {

    ResultSet rs1;
    private int j;
    private String Id;
    private int userId;
    private String ppsId;
    private String pId;
    private String[] supplierSpce;
    private String[] unitPrice;
    private String[] companyName;
    private String[] price;
    private String[] website;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            j = 0;
            ppsId = request.getParameter("ppsId");
            pId = request.getParameter("pId");
            HttpSession session = request.getSession();
            Id = session.getAttribute("idUser").toString();
            userId = Integer.parseInt(Id);

            String neededColumnSupplier = "*";
            String whereClauseSupplier = " ppsTuser_id = " + userId + " and flag = 'Publish' and supplier_spec != 'null' and pps_id =" + ppsId;
            rs1 = SupplierProSpceDao.allDataForSpsPpsProjectUsersCompanyWithWhereClause(neededColumnSupplier, whereClauseSupplier);
            rs1.last();
            int supplierRow = rs1.getRow();
            supplierSpce = new String[supplierRow];
            unitPrice = new String[supplierRow];
            price = new String[supplierRow];
            companyName = new String[supplierRow];
            website = new String[supplierRow];
            rs1.beforeFirst();
            while (rs1.next()) {
                supplierSpce[j] = rs1.getString("supplier_spec");
                unitPrice[j] = rs1.getString("unit_price");
                price[j] = rs1.getString("price");
                companyName[j] = rs1.getString("company_name");
                website[j] = rs1.getString("website");
                j++;
            }
            if(supplierRow == 0){
            response.getWriter().write("<center><h2 id='data-none' data-none='0'>No Bit Yet</h2></center>");
            } else{
            for (j = 0; j < supplierRow; j++) {
                response.setContentType("text/plain");
                response.getWriter().write("<table class='table table-hover table-bordered text-center'>"
                        + "<thead class='table table-responsive'>"
                        + "<tr>"
                        + "<td>SL</td><td>Company Details</td><td>Specification</td><td>Unit Price</td><td>Price</td>"
                        + "</tr>"
                        + "</thead>"
                        + "<tbody >"
                        + "<tr>"
                        + "<td>" + (j + 1) + "</td><td>" + companyName[j] + "<br/>" + website[j] + "</td><td>" + supplierSpce[j] + "</td><td>" + unitPrice[j] + "</td><td>" + price[j] + "</td>"
                        + "</tr>"
                        + "</tbody>"
                        + "</table>");
            }
            }
        } catch (SQLException ex) {
            Logger.getLogger(FindSupplierSpceBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
