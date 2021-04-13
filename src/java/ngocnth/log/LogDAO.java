
package ngocnth.log;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import javax.naming.NamingException;
import ngocnth.util.DBHelper;

public class LogDAO implements Serializable {
    
    public boolean addLog(Date date, String username, int productId) throws NamingException, SQLException {
        
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT log(date, username, productId) "
                            + "VALUES(?, ?, ?)";
                stm = con.prepareStatement(sql);
                java.sql.Date sqlDate = new java.sql.Date(date.getTime());
                stm.setDate(1, sqlDate);
                stm.setString(2, username);
                stm.setInt(3, productId);
                
                int row = stm.executeUpdate();
                if (row > 0)
                    return true;
            }
        } finally {
            if (stm != null)
                stm.close();
            
            if (con != null)
                con.close();
        }
        
        return false;
    }
}
