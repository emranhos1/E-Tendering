/**
 *
 * @author Md. Emran Hossain
 */
package userBean;

import Dao.ProjectDao;
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

public class ProjectBean extends HttpServlet {
    
    DateFormat dateFormat;
    Date date;
    
    private String projectName;
    private String projectDesc;
    private String createDate;
    private String Id;
    private int userId;
    private boolean addProject;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            projectName = request.getParameter("pName");
            projectDesc = request.getParameter("pDesc");
            
            dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
            date = new Date();
            createDate = dateFormat.format(date);
            
            HttpSession session = request.getSession();
            Id =session.getAttribute("idUser").toString();
            userId = Integer.parseInt(Id);
            
            addProject = ProjectDao.addProject(projectName, projectDesc, createDate, userId);
            
            if(addProject){
                String createProjectInfoSuccess = "<p class='alert-info'>One Project Created Successfully</p>";
                request.getSession().setAttribute("createProjectInfo", createProjectInfoSuccess);
                response.sendRedirect("purchaser/newTender.jsp");
            }else {
                String createProjectInfoError = "<p class='alert-info'>Error To Create Project</p>";
                request.getSession().setAttribute("createProjectInfo", createProjectInfoError);
                response.sendRedirect("purchaser/newTender.jsp");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ProjectBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
