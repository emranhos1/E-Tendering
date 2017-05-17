/**
 *
 * @author Md. Emran Hossain
 */

package userBean;

import Dao.TenderDocComDao;
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

public class TenderDocComBean extends HttpServlet {
    private String Id;
    private int userId;
    private String columnName;
    private String columnType;
    private String columnLengthSize;
    private boolean addTenderDocComponent;
    private String supplierInputType;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession session = request.getSession();
            Id = session.getAttribute("idUser").toString();
            userId = Integer.parseInt(Id);
            
            columnName = request.getParameter("cName");
            columnType = request.getParameter("cType");
            columnLengthSize = request.getParameter("lSize");
            supplierInputType = request.getParameter("siType");
            
            addTenderDocComponent = TenderDocComDao.addTenderDocCom(columnName, columnType, columnLengthSize, supplierInputType, userId);
            
            if(addTenderDocComponent){
                String tenderTypeSuccess = "<p class='alert-info'>One Tender Type Created Successfully</p>";
                request.getSession().setAttribute("tenderTypeInfo", tenderTypeSuccess);
                response.sendRedirect("purchaser/newTenderType.jsp");
            } else{
                String tenderTypeError = "<p class='alert-danger'>Error To Create Type</p>";
                request.getSession().setAttribute("tenderTypeInfo", tenderTypeError);
                response.sendRedirect("purchaser/newTenderType.jsp");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(TenderDocComBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
