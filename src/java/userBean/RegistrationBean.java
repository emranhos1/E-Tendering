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

public class RegistrationBean extends HttpServlet {

    private String cName, cType, category, website;
    private String uName, email, pass, type, cDate, uDate;

    ResultSet rs;

    boolean addCompany;
    boolean addUser;

    private int company_id;
    private String neededColumnCompany;
    private String whereClauseCompany;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
            Date date = new Date();

            cName = request.getParameter("cName");
            cType = request.getParameter("cType");
            category = request.getParameter("category");
            website = request.getParameter("website");

            uName = request.getParameter("uName");
            email = request.getParameter("email");
            pass = request.getParameter("password1");
            type = request.getParameter("type");
            cDate = df.format(date);
            uDate = df.format(date);

            addCompany = CompanyDao.addCompany(cName, cType, category, website);
            System.out.println(addCompany);
            neededColumnCompany = "company_id";
            whereClauseCompany = "company_id = (Select Max(company_id) from company)";
            rs = CompanyDao.allCompanyWithWhereClause(neededColumnCompany, whereClauseCompany);
            while (rs.next()) {
                company_id = rs.getInt("company_id");
            }
            System.out.println(company_id);

            addUser = UserDao.addUser(uName, email, pass, type, cDate, uDate, company_id);
            System.out.println(addUser);
            if (addCompany) {
                if (addUser) {
                    String registrationSuccess = "<p class='alert-info'>Registration Successful</p>";
                    request.getSession().setAttribute("registrationInfo", registrationSuccess);
                    response.sendRedirect("registration.jsp");
                } else {
                    String registrationSuccess = "<p class='alert-danger'>Error To Registration</p>";
                    request.getSession().setAttribute("registrationInfo", registrationSuccess);
                    response.sendRedirect("registration.jsp");
                }

            } else {
                response.sendRedirect("registration.jsp");
                out.println("<h1>" + "Please Give Valid Company Details" + "</h1>");
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegistrationBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
