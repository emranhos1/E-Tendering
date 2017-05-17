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

public class CompanyDao {

    static DBConnection db = new DBConnection();
    static Connection con;
    static ResultSet rs;
    static PreparedStatement pstm;

    public static boolean addCompany(String companyName, String companyType, String companyCategory, String companyWebsite) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("insert into company(company_name, company_type, category, website) values(?,?,?,?)");
        pstm.setString(1, companyName);
        pstm.setString(2, companyType);
        pstm.setString(3, companyCategory);
        pstm.setString(4, companyWebsite);
        pstm.execute();
        pstm.close();
        return true;
    }

    public static ResultSet allCompanyWithWhereClause(String neededColumnCompany, String whereClauseCompany) throws SQLException {
        //neededColumn :: company_id & whereClause :: company_id = (Select Max(company_id) from company)
        con = db.myConn();
        pstm = con.prepareStatement("Select "+neededColumnCompany+" from company where "+whereClauseCompany);
        rs = pstm.executeQuery();

        return rs;
    }
    
    public static ResultSet allCompanyWithOutWhereClause(String neededColumnCompany) throws SQLException {
        //neededColumn :: company_id & whereClause :: company_id = (Select Max(company_id) from company)
        con = db.myConn();
        pstm = con.prepareStatement("Select "+neededColumnCompany+" from company");
        rs = pstm.executeQuery();

        return rs;
    }
    
    public static boolean updateCompany(String companyName, String companyType, String companyCategory, String companyWebsite, String whereClauseCompany) throws SQLException {
        
        con = db.myConn();
        pstm = con.prepareStatement("Update company set company_name = ?, company_type = ?, category = ?, website = ? where "+whereClauseCompany);
        pstm.setString(1, companyName);
        pstm.setString(2, companyType);
        pstm.setString(3, companyCategory);
        pstm.setString(4, companyWebsite);
        pstm.executeUpdate();
        return true;
    }
}
