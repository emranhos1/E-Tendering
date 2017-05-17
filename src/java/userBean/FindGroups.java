/**
 *
 * @author Md. Emran Hossain
 */
package userBean;

import Dao.GroupsDao;
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

public class FindGroups extends HttpServlet {

    ResultSet rs;
    private String keyword;
    private int userId;
    private String needColumnGroups;
    private String whereClauseGroups;
    private String groupsId;
    private String groupsName;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            keyword = request.getParameter("keyword");
            HttpSession session = request.getSession();
            userId = Integer.parseInt(session.getAttribute("idUser").toString());
            
            needColumnGroups = "*";
            whereClauseGroups = " user_id = '"+userId+"' and name like '%"+keyword+"%'";
            rs = GroupsDao.allGroupWithWhereClause(needColumnGroups, whereClauseGroups);
            while(rs.next()){
                groupsId = rs.getString("group_id");
                groupsName = rs.getString("name");
                response.setContentType("text/plain");
                response.getWriter().write("<p onClick='selectGroup(this)' id='"+groupsId+"' data-val='"+ groupsName +"'>" + groupsName + "</p>");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(FindGroups.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}