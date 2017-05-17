package userBean;

import Dao.PurchaserProSpceDao;
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

public class DeletePurchaserProSpce extends HttpServlet {

    private String ppsId;
    private String whereClausePurchaseProSpec;
    private boolean deletePurchaserProSpce;
    private String whereClauseSupplierProSpec;
    private boolean deleteSupplierProSpce;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            ppsId = request.getParameter("ppsId");
            whereClauseSupplierProSpec = " pps_id = " + ppsId;
            deleteSupplierProSpce = SupplierProSpceDao.deleteSupplierProSpceWithWhereClause(whereClauseSupplierProSpec);

            whereClausePurchaseProSpec = " pps_id = " + ppsId;
            deletePurchaserProSpce = PurchaserProSpceDao.deletePurchaseProSpceWithWhereClause(whereClausePurchaseProSpec);
            if (deletePurchaserProSpce) {
                if (deleteSupplierProSpce) {
                    String deleteSuccess = "<p class='alert-info'>Project Delete Successfully</p>";
                    request.getSession().setAttribute("deleteInfo", deleteSuccess);
                    response.sendRedirect("purchaser/supplierSpce.jsp");
                } else {
                    String deleteError = "<p class='alert-danger'>Project are not Deleted</p>";
                    request.getSession().setAttribute("deleteInfo", deleteError);
                    response.sendRedirect("purchaser/supplierSpce.jsp.jsp");
                }
            } else {
                String deleteError = "<p class='alert-danger'>Project are not Deleted</p>";
                request.getSession().setAttribute("deleteInfo", deleteError);
                response.sendRedirect("purchaser/supplierSpce.jsp.jsp");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DeletePurchaserProSpce.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
