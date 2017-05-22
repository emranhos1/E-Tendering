/**
 *
 * @author Md. Emran Hossain
 */
package userBean;

import Dao.SupplierProSpceDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateSupplierProSpceBean extends HttpServlet {
    private String ppsId;
    private String newUnitPrice;
    private String newPrice;
    private String Id;
    private int supplierId;
    private boolean updateSupplierProSpce;
    private String neededColumnSupplierProSpce;
    private String whereClauseSupplierProSpce;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession session = request.getSession();
            Id = session.getAttribute("idUser").toString();
            supplierId = Integer.parseInt(Id);
            
            ppsId = request.getParameter("ppsId");
            newUnitPrice = request.getParameter("newUPrice");
            newPrice = request.getParameter("newPrice");
            
            neededColumnSupplierProSpce = " unit_price = '"+newUnitPrice+"' , price= '"+newPrice+"'";
            whereClauseSupplierProSpce = " pps_id = '"+ppsId+"' and user_id = '"+supplierId+"'";
            updateSupplierProSpce = SupplierProSpceDao.updateSupplierProSpceWithWhereClause(neededColumnSupplierProSpce, whereClauseSupplierProSpce);
            
            if (updateSupplierProSpce) {
                    String updateAuctionSuccess = "<p class='alert-info'>Your Price Update Successful</p>";
                    request.getSession().setAttribute("updateAuctionInfo", updateAuctionSuccess);
                    response.sendRedirect("supplier/auctionOrder.jsp");
                } else {
                    String updateAuctionError = "<p class='alert-danger'>Error To Update New Price</p>";
                    request.getSession().setAttribute("updateAuctionInfo", updateAuctionError);
                    response.sendRedirect("supplier/auctionOrder.jsp");
                }
        } catch (SQLException ex) {
            Logger.getLogger(UpdateSupplierProSpceBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
