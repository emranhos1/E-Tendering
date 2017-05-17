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

public class TenderDocComDao {
    
    private static final DBConnection db = new DBConnection();
    private static Connection con;
    private static PreparedStatement pstm;
    private static ResultSet rs;

    public static boolean addTenderDocCom(String ColumnName, String columnType, String columnLengthSize, String supplierInputType, int userId) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("Insert into tender_doc_com(component_name, type, size, user_id, supplier_type) values(?,?,?,?,?)");
        pstm.setString(1, ColumnName);
        pstm.setString(2, columnType);
        pstm.setString(3, columnLengthSize);
        pstm.setInt(4, userId);
        pstm.setString(5, supplierInputType);
        pstm.execute();
        pstm.close();

        return true;
    }
    public static ResultSet allTenderDocComWithWhereClause(String neededColumnCompany, String whereClauseForTenderDocCom) throws SQLException {
        //neededColumn :: company_id & whereClause :: company_id = (Select Max(company_id) from company)
        con = db.myConn();
        pstm = con.prepareStatement("Select "+neededColumnCompany+" from tender_doc_com where "+whereClauseForTenderDocCom);
        rs = pstm.executeQuery();

        return rs;
    }
}
