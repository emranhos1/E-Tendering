
package userBean;

import Dao.ConfirmSupplierDao;
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

public class ConfirmSupplier extends HttpServlet {
    
    private boolean addConfirmSupplier;
    private int supplierId;
    private int ppsId;
    private String massege;
    private double finalUPrice;
    private double finalPrice;
    private String setColumnPurchaseProSpec;
    private String WhereClausePurchaseProSpec;
    private boolean updatePurchaserProSpec;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            supplierId = Integer.parseInt(request.getParameter("sId"));
            ppsId = Integer.parseInt(request.getParameter("ppsId"));
            massege = request.getParameter("massege");
            finalUPrice = Double.parseDouble(request.getParameter("uPrice"));
            finalPrice = Double.parseDouble(request.getParameter("price"));
            
            addConfirmSupplier = ConfirmSupplierDao.addConfirmSupplier(supplierId, ppsId, massege, finalUPrice, finalPrice);
            
            setColumnPurchaseProSpec =" flag = 'Closed'";
            WhereClausePurchaseProSpec = " pps_id = "+ppsId;
            updatePurchaserProSpec = PurchaserProSpceDao.updatePurchaseProSpceWithWhereClasuse(setColumnPurchaseProSpec, WhereClausePurchaseProSpec);
            
            if (addConfirmSupplier) {
                if (updatePurchaserProSpec) {
                    String confirmSupplierSuccess = "<p class='alert-info'>Supplier are Selected For This Project</p>";
                    request.getSession().setAttribute("confirmSupplierInfo", confirmSupplierSuccess);
                    response.sendRedirect("purchaser/supplierSpce.jsp");
                } else {
                    String confirmSupplierError = "<p class='alert-danger'>Supplier are not Selected For This Project</p>";
                    request.getSession().setAttribute("confirmSupplierInfo", confirmSupplierError);
                    response.sendRedirect("purchaser/supplierSpce.jsp.jsp");
                }
            } else {
                String confirmSupplierError = "<p class='alert-danger'>Supplier are not Selected For This Project</p>";
                request.getSession().setAttribute("confirmSupplierInfo", confirmSupplierError);
                response.sendRedirect("purchaser/supplierSpce.jsp.jsp");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConfirmSupplier.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
