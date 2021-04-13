package ngocnth.cartDetail;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import ngocnth.cart.Item;
import org.apache.log4j.Logger;

public class CartDetailDAO implements Serializable {
    
    private static final Logger LOGGER = Logger.getLogger(CartDetailDAO.class);

    public boolean saveCartDetail(List<Item> list, int cartId, Connection con)
            throws NamingException, SQLException {

        PreparedStatement stm = null;

        try {
            String sql = "INSERT cartDetail(cartId, productId, quantity, price) "
                    + "VALUES(?, ?, ?, ?)";
            stm = con.prepareStatement(sql);

            for (Item item : list) {
                int productId = item.getProduct().getId();
                int quantity = item.getQuantity();
                int price = item.getProduct().getPrice() * quantity;
                
                stm.setInt(1, cartId);
                stm.setInt(2, productId);
                stm.setInt(3, quantity);
                stm.setInt(4, price);
                
                stm.executeUpdate();
            }
            return true;
        } catch (Exception ex) {
            LOGGER.info("Exception: " + ex.getMessage());
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
        return false;
    }
    
}
