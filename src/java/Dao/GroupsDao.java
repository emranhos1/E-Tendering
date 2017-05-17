/**
 *
 * @author Md. Emran Hossain
 */

package Dao;

import dbConnection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GroupsDao {
    
    static DBConnection db = new DBConnection();
    static Connection con;
    static ResultSet rs;
    static PreparedStatement pstm;
    
    public static boolean addGroup(String groupName, int userId, String createDate) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("Insert into groups(name, user_id, date) values(?,?,?)");
        pstm.setString(1, groupName);
        pstm.setInt(2, userId);
        pstm.setString(3, createDate);
        pstm.execute();
        pstm.close();
        return true;
    }
    
    public static ResultSet allGroupWithWhereClause(String needColumnGroups, String whereClauseGroups) throws SQLException {
        
        con = db.myConn();
        pstm = con.prepareStatement("Select "+needColumnGroups+" from groups where "+whereClauseGroups);
        rs = pstm.executeQuery();

        return rs;
    }
}
