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

public class AuctionDao {
    
    static DBConnection db = new DBConnection();
    static Connection con;
    static ResultSet rs;
    static PreparedStatement pstm;
    
    public static boolean addAuction(double unit_price, double price, int sps_id, int pps_id) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("insert into auction(unit_price, price, sps_id, pps_id) values(?,?,?,?)");
        pstm.setDouble(1, unit_price);
        pstm.setDouble(2, price);
        pstm.setInt(3, sps_id);
        pstm.setInt(4, pps_id);
        pstm.execute();
        pstm.close();
        return true;
    }
}
