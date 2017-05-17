package Dao;

import dbConnection.DBConnection;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PurchaserProSpceDao {

    private static final DBConnection db = new DBConnection();
    private static Connection con;
    private static PreparedStatement pstm;
    private static ResultSet rs;
    private static String type;
    private static String user_id;

    public static boolean addPurchaseProSpec(String projectId, int tdcId, String shortDesc, String purSpec, String supplierId, String flag, String startDate, String endDate, int groupId, int userId) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("Insert into purchase_pro_spec(project_id, tdc_id, short_desc, purchase_spec, supplier_id, flag, start_date, end_date, group_id, user_id) values(?,?,?,?,?,?,?,?,?,?)");
        pstm.setString(1, projectId);
        pstm.setInt(2, tdcId);
        pstm.setString(3, shortDesc);
        pstm.setString(4, purSpec);
        pstm.setString(5, supplierId);
        pstm.setString(6, flag);
        pstm.setString(7, startDate);
        pstm.setString(8, endDate);
        pstm.setInt(9, groupId);
        pstm.setInt(10, userId);

        pstm.execute();
        pstm.close();

        return true;
    }

    public static ResultSet allPurchaseProSpecWithoutWhereClause(String neededColumnPurchaseProSpec) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("Select " + neededColumnPurchaseProSpec + " from purchase_pro_spec");
        rs = pstm.executeQuery();

        return rs;
    }

    public static ResultSet allPurchaseProSpecWithWhereClause(String neededColumnPurchaseProSpec, String WhereClausePurchaseProSpec) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("Select " + neededColumnPurchaseProSpec + " from all_data where" + WhereClausePurchaseProSpec);
        rs = pstm.executeQuery();

        return rs;
    }

    public static boolean updatePurchaseProSpceWithWhereClasuse(String setColumnPurchaseProSpec, String WhereClausePurchaseProSpec) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("Update purchase_pro_spec set " + setColumnPurchaseProSpec + " where " + WhereClausePurchaseProSpec);
        pstm.executeUpdate();
        return true;
    }

    public static boolean deletePurchaseProSpceWithWhereClause(String whereClausePurchaseProSpec) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("Delete from purchase_pro_spec where " + whereClausePurchaseProSpec);
        pstm.executeUpdate();
        return true;
    }
}
