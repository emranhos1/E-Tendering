/**
 *
 * @author Md. Emran Hossain
 */
package userBean;

import Dao.AuctionDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateSupplierProSpceBean extends HttpServlet {
    private String ppsId;
    private String newUnitPrice;
    private String newPrice;
    private boolean updateAuction;
    private String setColumnAuction;
    private String WhereClauseAuction;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            ppsId = request.getParameter("ppsId");
            newUnitPrice = request.getParameter("newUPrice");
            newPrice = request.getParameter("newPrice");
            
            setColumnAuction = " unit_price = '"+newUnitPrice+"' , price= '"+newPrice+"'";
            WhereClauseAuction = " pps_id = '"+ppsId+"'";
            updateAuction = AuctionDao.updateAuction(setColumnAuction, WhereClauseAuction);
            
            if (updateAuction) {
                    String updateAuctionSuccess = "<p class='alert-info'>Auction Update Successful</p>";
                    request.getSession().setAttribute("updateAuctionInfo", updateAuctionSuccess);
                    response.sendRedirect("supplier/auctionOrder.jsp");
                } else {
                    String updateAuctionError = "<p class='alert-danger'>Error To Update Auction</p>";
                    request.getSession().setAttribute("updateAuctionInfo", updateAuctionError);
                    response.sendRedirect("supplier/auctionOrder.jsp");
                }
            
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateSupplierProSpceBean</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateSupplierProSpceBean at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } catch (SQLException ex) {
            Logger.getLogger(UpdateSupplierProSpceBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
