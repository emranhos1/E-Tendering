/**
 *
 * @author Md. Emran Hossain
 */
package userBean;

import Dao.AuctionDao;
import Dao.PurchaserProSpceDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AuctionBean extends HttpServlet {
    
    private int ppsId;
    private double unitPrice;
    private double price;
    private String auctionSDate;
    private String auctionEDate;
    private String setColumnPurchaseProSpec;
    private String WhereClausePurchaseProSpec;
    private boolean updatePurchaserProSpce;
    private boolean addAuction;
    private int spsTsps_id;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            spsTsps_id = Integer.parseInt(request.getParameter("spsTspsId"));
            ppsId = Integer.parseInt(request.getParameter("ppsId"));
            unitPrice = Double.parseDouble(request.getParameter("uPrice"));
            price = Double.parseDouble(request.getParameter("price"));
            auctionSDate = request.getParameter("AuctionSDate");
            auctionEDate = request.getParameter("AuctionEDate");
            setColumnPurchaseProSpec = "flag = 'Auction', auction_s_date = '"+auctionSDate+"', auction_e_date = '"+auctionEDate+"'";
            WhereClausePurchaseProSpec = " pps_id = " + ppsId;
            updatePurchaserProSpce = PurchaserProSpceDao.updatePurchaseProSpceWithWhereClasuse(setColumnPurchaseProSpec, WhereClausePurchaseProSpec);
            
            addAuction = AuctionDao.addAuction(unitPrice, price, spsTsps_id, ppsId);
            if (addAuction) {
                if (updatePurchaserProSpce) {
                    String auctionSuccess = "<p class='alert-info'>Project are going to Auction</p>";
                    request.getSession().setAttribute("auctionInfo", auctionSuccess);
                    response.sendRedirect("purchaser/allTender.jsp");
                } else {
                    String auctionError = "<p class='alert-danger'>Project are not going to Auction</p>";
                    request.getSession().setAttribute("auctionInfo", auctionError);
                    response.sendRedirect("purchaser/allTender.jsp");
                }
            } else {
                String auctionError = "<p class='alert-danger'>Project are not going to Auction</p>";
                request.getSession().setAttribute("auctionInfo", auctionError);
                response.sendRedirect("purchaser/allTender.jsp.jsp");
            }

        } catch (SQLException ex) {
            Logger.getLogger(AuctionBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
