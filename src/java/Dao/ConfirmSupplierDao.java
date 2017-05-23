package Dao;

import dbConnection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConfirmSupplierDao {
    static DBConnection db = new DBConnection();
    static Connection con;
    static ResultSet rs;
    static PreparedStatement pstm;
    
    public static boolean addConfirmSupplier(int user_id, int pps_id, String massege, double final_u_price, double final_price) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("insert into confirm_supplier(user_id, pps_id, massage, final_u_price, final_price) values(?,?,?,?,?)");
        pstm.setInt(1, user_id);
        pstm.setInt(2, pps_id);
        pstm.setString(3, massege);
        pstm.setDouble(4, final_u_price);
        pstm.setDouble(5, final_price);
        pstm.execute();
        pstm.close();
        return true;
    }
    
    public static ResultSet selectConfirmSupplierWithWhereClause(String neededColumnConfirmSupplier, String whereClauseConfirmSupplier) throws SQLException {
        
        con = db.myConn();
        pstm = con.prepareStatement("Select "+neededColumnConfirmSupplier+" from confirm_supplier where "+whereClauseConfirmSupplier);
        rs = pstm.executeQuery();

        return rs;
    }
}
