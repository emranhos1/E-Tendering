/**
 *
 * @author Md. Emran Hossain
 */
package userBean;

import Dao.JoinQueryDao;
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

public class FindSupplier extends HttpServlet {


    ResultSet rs;
    private String search;
    private String supplierId;
    private int userId;
    private String needColumnCompanyUsers;
    private String whereClauseCompanyUsers;
    private String companyName;
    private String userName;
    private int userIds;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            search = request.getParameter("search");
            supplierId = request.getParameter("users");

            HttpSession session = request.getSession();
            userId = Integer.parseInt(session.getAttribute("idUser").toString());

            needColumnCompanyUsers = "*";
            whereClauseCompanyUsers = " c.company_name like '%" + search + "%' and u.type!= 'Purchaser' and u.user_id not in (" + supplierId + ")";
            rs = JoinQueryDao.innerJoinsCompanyUsers(needColumnCompanyUsers, whereClauseCompanyUsers);
            while (rs.next()) {
                companyName = rs.getString("company_name");
                userName = rs.getString("user_name");
                userIds = rs.getInt("user_id");

                response.setContentType("text/plain");
                response.getWriter().write("<p onClick='selectSupplier(this)' search='" + userIds + "' data-val='" + companyName + "'>" + companyName + " : " + userName + "</p>");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(FindSupplier.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}