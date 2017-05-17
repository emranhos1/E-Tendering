/**
 *
 * @author Md. Emran Hossain
 */
package userBean;

import Dao.GroupsDao;
import java.io.IOException;
import java.io.PrintWriter;
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

public class GroupsBean extends HttpServlet {

    private String groupName;
    private String Id;
    private int userId;

    DateFormat dateFormat;
    Date date;
    private String createDate;
    private boolean addGroups;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            groupName = request.getParameter("gName");

            HttpSession session = request.getSession();
            Id = session.getAttribute("idUser").toString();
            userId = Integer.parseInt(Id);

            dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
            date = new Date();
            createDate = dateFormat.format(date);

            addGroups = GroupsDao.addGroup(groupName, userId, createDate);

            if (addGroups) {
                String createGroupInfoSuccess = "<p class='alert-info'>One Group Created Successfully</p>";
                request.getSession().setAttribute("createGroupInfo", createGroupInfoSuccess);
                response.sendRedirect("purchaser/newGroups.jsp");
            } else {
                String createGroupInfoError = "<p class='alert-danger'>Error To Create Group</p>";
                request.getSession().setAttribute("createGroupInfo", createGroupInfoError);
                response.sendRedirect("purchaser/newGroups.jsp");
            }

        } catch (SQLException ex) {
            Logger.getLogger(GroupsBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
