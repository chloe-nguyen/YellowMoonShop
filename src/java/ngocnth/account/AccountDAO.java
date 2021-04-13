
package ngocnth.account;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import ngocnth.util.DBHelper;

public class AccountDAO implements Serializable {
    
    public AccountDTO getAccount(String username, String password) 
            throws SQLException, NamingException {
        
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT username, password, fullname, phone, address, role, status "
                           + "FROM account "
                           + "WHERE username = ? AND password = ? AND status = 2"; //2 is active status
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String fullname = rs.getString("fullname");                    
                    String phone = rs.getString("phone");                    
                    String address = rs.getString("address");
                    int role = rs.getInt("role");
                    int status = rs.getInt("status");
                    
                    AccountDTO dto = new AccountDTO(username, password, fullname, phone, address, role, status);
                    return dto;
                }
            }
        } finally {
            if (rs != null)
                rs.close();
            
            if (stm != null)
                stm.close();
            
            if (con != null)
                con.close();
        }
        return null;
    }
}
