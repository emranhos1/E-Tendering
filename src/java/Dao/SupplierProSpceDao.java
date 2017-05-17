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

public class SupplierProSpceDao {
    
    private static final DBConnection db = new DBConnection();
    private static Connection con;
    private static PreparedStatement pstm;
    private static ResultSet rs;

    public static boolean addSupplierProSpce(int purchaserProSpceId, String supplierSpec, double unitPrice, double Price, int purchaserId) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("Insert into supplier_pro_spce(pps_id, supplier_spec, unit_price, price, user_id) values(?,?,?,?,?)");
        pstm.setInt(1, purchaserProSpceId);
        pstm.setString(2, supplierSpec);
        pstm.setDouble(3, unitPrice);
        pstm.setDouble(4, Price);
        pstm.setInt(5, purchaserId);
        pstm.execute();
        pstm.close();

        return true;
    }
    
    public static ResultSet allDataForSupplierProSpceWithWhereClause(String neededColumnSupplier, String whereClauseSupplier) throws SQLException{
        con = db.myConn();
        pstm = con.prepareStatement("SELECT "+neededColumnSupplier+" FROM supplier_pro_spce where"+whereClauseSupplier);
        rs = pstm.executeQuery();
    return rs;
    }
    
    public static ResultSet allDataForSupplierProSpceWithOutWhereClause(String neededColumnSupplier) throws SQLException{
        con = db.myConn();
        pstm = con.prepareStatement("SELECT "+neededColumnSupplier+" FROM supplier_pro_spce");
        rs = pstm.executeQuery();
    return rs;
    }
    
    public static boolean deleteSupplierProSpceWithWhereClause(String whereClauseSupplierProSpec) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("Delete from supplier_pro_spce where " + whereClauseSupplierProSpec);
        pstm.executeUpdate();
        return true;
    }
    
    public static ResultSet allDataForSpsPpsProjectUsersCompanyWithWhereClause(String neededColumnSupplier, String whereClauseSupplier) throws SQLException{
        con = db.myConn();
        pstm = con.prepareStatement("SELECT "+neededColumnSupplier+" FROM sps_pps_project_users_company where"+whereClauseSupplier);
        rs = pstm.executeQuery();
    return rs;
    }
    
    public static ResultSet allDataForAllDataSupplierProSpceWithWhereClause(String neededColumnAllDataSupplierProSpce, String whereClauseAllDataSupplierProSpce) throws SQLException{
        con = db.myConn();
        pstm = con.prepareStatement("SELECT "+neededColumnAllDataSupplierProSpce+" FROM all_data_supplier_pro_spce where"+whereClauseAllDataSupplierProSpce);
        rs = pstm.executeQuery();
    return rs;
    }
}
