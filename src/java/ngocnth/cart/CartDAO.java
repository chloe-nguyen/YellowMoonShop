package ngocnth.cart;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import ngocnth.cartDetail.CartDetailDAO;
import ngocnth.product.ProductDAO;
import ngocnth.util.DBHelper;

public class CartDAO implements Serializable {

    public int saveCart(String username, String fullname, String phone,
            String address, Date date, int total, List<Item> list)
            throws SQLException, NamingException {

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                con.setAutoCommit(false);
                String sql = "INSERT cart(username, fullname, phone, address, date, total) "
                        + "VALUES(?, ?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

                stm.setString(1, username);
                if (username.equals("")) {
                    stm.setNull(1, Types.VARCHAR);
                }
                stm.setString(2, fullname);
                stm.setString(3, phone);
                stm.setString(4, address);
                java.sql.Date sqlDate = new java.sql.Date(date.getTime());
                stm.setDate(5, sqlDate);
                stm.setInt(6, total);

                stm.executeUpdate();
                rs = stm.getGeneratedKeys();
                if (rs.next()) {
                    int id = rs.getInt(1);

                    CartDetailDAO cdDao = new CartDetailDAO();
                    boolean result = cdDao.saveCartDetail(list, id, con);
                    if (result) {
                        ProductDAO pDao = new ProductDAO();
                        boolean updateSuccess = pDao.updateProductQuantity(list, con);
                        if (updateSuccess) {
                            con.commit();
                            con.setAutoCommit(true);
                            return id;
                        }
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
        return -1;
    }

    public CartDTO getCart(int id) throws NamingException, SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT id, cartId, username, fullname, phone, address, date, total "
                        + "FROM cart "
                        + "WHERE id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String cartId = rs.getString("cartId");
                    String username = rs.getString("username");
                    String fullname = rs.getString("fullname");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    Date date = rs.getDate("date");
                    int total = rs.getInt("total");
                    
                    CartDTO dto = new CartDTO(id, cartId, username, fullname, phone, address, date, total);
                    return dto;
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
        return null;
    }
}
