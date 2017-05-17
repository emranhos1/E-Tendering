package userBean;

import Dao.CompanyDao;
import Dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EditPurchaserBean extends HttpServlet {

    private DateFormat dateFormat;
    private Date date;
    private String companyName, companyType, companyCategory, companyWebsite;
    private String userName, userEmail, userPass, userType, updateDate;
    private String Id;
    private int userId;

    ResultSet rs;
    private String neededColumnUsers;
    private String whereClauseUsers;
    private int companyId;
    private boolean updateUser;
    private String whereClauseCompany;
    private boolean updateCompany;
    private String whereClauseUsersUpdate;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
            date = new Date();

            companyName = request.getParameter("cName");
            companyType = request.getParameter("cType");
            companyCategory = request.getParameter("category");
            companyWebsite = request.getParameter("website");

            userName = request.getParameter("uName");
            userEmail = request.getParameter("email");
            userPass = request.getParameter("password1");
            userType = request.getParameter("type");
            updateDate = dateFormat.format(date);

            HttpSession session = request.getSession();
            Id = session.getAttribute("idUser").toString();
            userId = Integer.parseInt(Id);

            neededColumnUsers = "company_id";
            whereClauseUsers = "user_id = '" + userId + "'";
            rs = UserDao.allUserWithWhereClause(neededColumnUsers, whereClauseUsers);
            while (rs.next()) {
                companyId = rs.getInt("company_id");
            }

            whereClauseUsersUpdate = "user_id = '" + userId + "'";
            updateUser = UserDao.updateUser(userName, userEmail, userPass, updateDate, whereClauseUsersUpdate);

            whereClauseCompany = "company_id = '" + companyId + "'";
            updateCompany = CompanyDao.updateCompany(companyName, companyType, companyCategory, companyWebsite, whereClauseCompany);
            
            if (updateUser) {
                if (updateCompany) {
                    String updateUserInfoSuccess = "<p class='alert-info'>User Information updated Successfully</p>";
                    request.getSession().setAttribute("updateUserInfo", updateUserInfoSuccess);
                    response.sendRedirect("purchaser/editPurchaser.jsp");
                } else {
                    String updateUserInfoError = "<p class='alert-danger'>User Information Not Updated</p>";
                    request.getSession().setAttribute("updateUserInfo", updateUserInfoError);
                    response.sendRedirect("purchaser/editPurchaser.jsp");
                }
            } else {
                String updateUserInfoError = "<p class='alert-danger'>User Information Not Updated</p>";
                request.getSession().setAttribute("updateUserInfo", updateUserInfoError);
                response.sendRedirect("purchaser/editPurchaser.jsp");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(EditPurchaserBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
