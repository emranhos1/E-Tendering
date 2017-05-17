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

public class SupplierProSpceBean extends HttpServlet {

    private String supplierSpec;
    private double unitPrice;
    private double price;
    private int purchaserProSpceId;
    private String Id;
    private int supplierId;
    boolean addSupplierProSpec;
    private ResultSet rs;
    private String neededColumnSupplier;
    private String whereClauseSupplier;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            purchaserProSpceId = Integer.parseInt(request.getParameter("ppsId"));
            supplierSpec = request.getParameter("spce");
            unitPrice = Double.parseDouble(request.getParameter("uPrice"));
            price = Double.parseDouble(request.getParameter("price"));

            HttpSession session = request.getSession();
            Id = session.getAttribute("idUser").toString();
            supplierId = Integer.parseInt(Id);

            neededColumnSupplier = "*";
            whereClauseSupplier = " pps_id = " + purchaserProSpceId + " and user_id = " + supplierId;
            rs = SupplierProSpceDao.allDataForSupplierProSpceWithWhereClause(neededColumnSupplier, whereClauseSupplier);
            if (!rs.next()) {
                addSupplierProSpec = SupplierProSpceDao.addSupplierProSpce(purchaserProSpceId, supplierSpec, unitPrice, price, supplierId);
                if (addSupplierProSpec) {
                    String success = "<p class='alert-info'>Specification Inserted</p>";
                    request.getSession().setAttribute("message", success);
                    response.sendRedirect("supplier/publishOrder.jsp");
                } else {
                    String error = "<p class='alert-danger'>Error to Specification Insert</p>";
                    request.getSession().setAttribute("message", error);
                    response.sendRedirect("supplier/publishOrder.jsp");
                }
            } else{
                    String error = "<p class='alert-danger'>Specification Already Have Been Inserted Try Another</p>";
                    request.getSession().setAttribute("message", error);
                    response.sendRedirect("supplier/publishOrder.jsp");
            }

        } catch (SQLException ex) {
            Logger.getLogger(SupplierProSpceBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
