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

public class SupplierDao {
    
    private static final DBConnection db = new DBConnection();
    private static Connection con;
    private static PreparedStatement pstm;
    private static ResultSet rs;
    String query;
    
    public static ResultSet allDataForSupplierWithWhereClause(String neededColumnSupplier, String whereClauseSupplier) throws SQLException{
        con = db.myConn();
        pstm = con.prepareStatement("SELECT "+neededColumnSupplier+" FROM all_data where"+whereClauseSupplier);
        rs = pstm.executeQuery();
    return rs;
    }
    
    public static ResultSet allDataForSupplierWithOutWhereClause(String neededColumnSupplier) throws SQLException{
        con = db.myConn();
        pstm = con.prepareStatement("SELECT "+neededColumnSupplier+" FROM all_data");
        rs = pstm.executeQuery();
    return rs;
    }
}
