package Dao;

import dbConnection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JoinQueryDao {

    private static final DBConnection db = new DBConnection();
    private static Connection con;
    private static PreparedStatement pstm;
    private static ResultSet rs;

    public static ResultSet innerJoinsCompanyUsers(String needColumnCompanyUsers, String whereClauseCompanyUsers) throws SQLException {

        con = db.myConn();
        pstm = con.prepareStatement("SELECT "+needColumnCompanyUsers+" FROM company c inner join users u on c.company_id = u.company_id where " + whereClauseCompanyUsers);
        rs = pstm.executeQuery();

        return rs;
    }
}
