
package Dao;

import dbConnection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProjectDao {
    
    static DBConnection db = new DBConnection();
    static Connection con;
    static ResultSet rs;
    static PreparedStatement pstm;
    
    public static boolean addProject(String projectName, String projectDesc, String createDate, int userId) throws SQLException {
        con = db.myConn();
        pstm = con.prepareStatement("Insert into project(project_name, project_desc, date, user_id) values(?,?,?,?)");
        pstm.setString(1, projectName);
        pstm.setString(2, projectDesc);
        pstm.setString(3, createDate);
        pstm.setInt(4, userId);
        pstm.execute();
        pstm.close();
        return true;
    }
    
    public static ResultSet allProjectWithWhereClause(String neededColumn, String whereClauseProject) throws SQLException {

         con = db.myConn();
        pstm = con.prepareStatement("Select "+neededColumn+" from project where "+whereClauseProject);
        rs = pstm.executeQuery();

        return rs;
    }
}
