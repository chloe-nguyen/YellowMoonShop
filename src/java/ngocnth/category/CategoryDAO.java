package ngocnth.category;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import ngocnth.util.DBHelper;

public class CategoryDAO implements Serializable {

    public List<CategoryDTO> getCategories() throws NamingException, SQLException {

        List<CategoryDTO> list = null;

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT categoryId, categoryName "
                            + "FROM category";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("categoryId");
                    String name = rs.getString("categoryName");
                    
                    CategoryDTO dto = new CategoryDTO(id, name);
                    if (list != null)
                        list.add(dto);
                    else {
                        list = new ArrayList<>();
                        list.add(dto);
                    }
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }

            if (stm != null) {
                stm.close();
            }

            if (con != null) {
                con.close();
            }
        }
        return list;
    }
    
    public int getCategoryId(String categoryName) throws NamingException, SQLException {
        
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT categoryId "
                            + "FROM category "
                            + "WHERE categoryName = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, categoryName);
                rs = stm.executeQuery();
                if (rs.next()) {
                    return rs.getInt("categoryId");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }

            if (stm != null) {
                stm.close();
            }

            if (con != null) {
                con.close();
            }
        }
        return -1;
    }
}
