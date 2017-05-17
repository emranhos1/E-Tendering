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

public class UserDao {

    static DBConnection db = new DBConnection();
    static Connection con;
    static ResultSet rs;
    static PreparedStatement pstm;

    public static boolean addUser(String userName, String userEmail, String userPass, String userType, String signUpDate, String updateDate, int companyId) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("insert into users(user_name, email, password, type, create_date, update_date, company_id) values(?,?,?,?,?,?,?)");
        pstm.setString(1, userName);
        pstm.setString(2, userEmail);
        pstm.setString(3, userPass);
        pstm.setString(4, userType);
        pstm.setString(5, signUpDate);
        pstm.setString(6, updateDate);
        pstm.setInt(7, companyId);
        pstm.execute();
        pstm.close();
        return true;
    }
    
    public static ResultSet allUserWithWhereClause(String neededColumnUsers, String whereClauseUsers) throws SQLException {
        
        con = db.myConn();
        pstm = con.prepareStatement("Select "+neededColumnUsers+" from users where "+whereClauseUsers);
        rs = pstm.executeQuery();

        return rs;
    }
    
    public static ResultSet allUserWithoutWhereClause(String neededColumnUsers) throws SQLException {
        
        con = db.myConn();
        pstm = con.prepareStatement("Select "+neededColumnUsers+" from users");
        rs = pstm.executeQuery();

        return rs;
    }
    
    public static boolean updateUser(String userName, String userEmail, String userPass, String updateDate, String whereClauseUsersUpdate) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("Update users set user_name = ?, email = ?, password = ?, update_date = ? where "+whereClauseUsersUpdate);
        pstm.setString(1, userName);
        pstm.setString(2, userEmail);
        pstm.setString(3, userPass);
        pstm.setString(4, updateDate);
        pstm.executeUpdate();
        return true;
    }
}
