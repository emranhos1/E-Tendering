package userBean;

import Dao.UserDao;
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

public class LoginBean extends HttpServlet {

    private String userEmail, userPass;

    ResultSet rs;
    private String neededColumnUsers;
    private String whereClauseUsers;
    private String userType;
    private int userId;
    private String email;
    private String password;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            userEmail = request.getParameter("email");
            userPass = request.getParameter("password");

            neededColumnUsers = "*";
            whereClauseUsers = "email = '" + userEmail + "' and password = '" + userPass + "' ";
            rs = UserDao.allUserWithWhereClause(neededColumnUsers, whereClauseUsers);
            if (rs.next()) {
                userType = rs.getString("type");
                userId = rs.getInt("user_id");
                email = rs.getString("email");
                password = rs.getString("password");

                switch (userType) {
                    case "Purchaser": {
                        String loginSuccess = "<p><h3 class='alert-info'>Login Successful</h3></p>";
                        request.getSession().setAttribute("loginSuccess", loginSuccess);
                        response.sendRedirect("purchaser/purchaser.jsp");
                        break;
                    }
                    case "Supplier": {
                        String loginSuccess = "<p><h3 class='alert-info'>Login Successful</h3></p>";
                        request.getSession().setAttribute("loginSuccess", loginSuccess);
                        response.sendRedirect("supplier/supplier.jsp");
                        break;
                    }
                }
            } else {
                String loginError = "<p class='alert-danger'>User Email or Password Incorrect</p>";
                request.getSession().setAttribute("loginError", loginError);
                response.sendRedirect("index.jsp");
            }
            
            HttpSession session = request.getSession();
            session.setAttribute("idUser", userId);
            
        } catch (SQLException ex) {
            Logger.getLogger(LoginBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
