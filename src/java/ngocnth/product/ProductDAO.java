package ngocnth.product;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import ngocnth.cart.Item;
import ngocnth.util.DBHelper;
import org.apache.log4j.Logger;

public class ProductDAO implements Serializable {
    
    private static final Logger LOGGER = Logger.getLogger(ProductDAO.class);

    public List<ProductDTO> getAvailableProducts() throws NamingException, SQLException {

        List<ProductDTO> list = null;

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT productId, productName, image, price, "
                        + "quantity, createDate, expirationDate, status, category "
                        + "FROM product "
                        + "WHERE status = 1 AND expirationDate > GETDATE() "
                        + "ORDER BY createDate DESC "
                        + "OFFSET 0 ROWS "
                        + "FETCH NEXT 21 ROWS ONLY";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("productId");
                    String name = rs.getString("productName");
                    String img = rs.getString("image");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    Date mfg = rs.getDate("createDate");
                    Date exp = rs.getDate("expirationDate");
                    int status = rs.getInt("status");
                    int category = rs.getInt("category");

                    ProductDTO dto = new ProductDTO(id, name, img, price, quantity, mfg, exp, status, category);

                    if (list != null) {
                        list.add(dto);
                    } else {
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
    
    public List<ProductDTO> getProducts() throws NamingException, SQLException {

        List<ProductDTO> list = null;

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT productId, productName, image, price, "
                        + "quantity, createDate, expirationDate, status, category "
                        + "FROM product "
                        + "ORDER BY createDate DESC "
                        + "OFFSET 0 ROWS "
                        + "FETCH NEXT 21 ROWS ONLY";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("productId");
                    String name = rs.getString("productName");
                    String img = rs.getString("image");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    Date mfg = rs.getDate("createDate");
                    Date exp = rs.getDate("expirationDate");
                    int status = rs.getInt("status");
                    int category = rs.getInt("category");

                    ProductDTO dto = new ProductDTO(id, name, img, price, quantity, mfg, exp, status, category);

                    if (list != null) {
                        list.add(dto);
                    } else {
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

    public List<ProductDTO> searchAvailableProducts(String searchValue, int minPrice,
            int maxPrice, String category, int skipRows, int nextRows)
            throws NamingException, SQLException {

        List<ProductDTO> list = null;

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT productId, productName, image, price, quantity, "
                        + "createDate, expirationDate, status, category, categoryName "
                        + "FROM product, category "
                        + "WHERE (product.category = category.categoryId) "
                        + "AND (status = 1) "
                        + "AND expirationDate > GETDATE() "
                        + "AND (productName LIKE ? ) "
                        + "AND (categoryName LIKE ? ) "
                        + "AND (price BETWEEN ? AND ?) "
                        + "ORDER BY createDate DESC "
                        + "OFFSET ? ROWS "
                        + "FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(sql);

                stm.setString(1, "%" + searchValue + "%");
                stm.setString(2, "%" + category + "%");
                stm.setInt(3, minPrice);
                stm.setInt(4, maxPrice);
                stm.setInt(5, skipRows);
                stm.setInt(6, nextRows);

                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("productId");
                    String name = rs.getString("productName");
                    String img = rs.getString("image");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    Date mfg = rs.getDate("createDate");
                    Date exp = rs.getDate("expirationDate");
                    int status = rs.getInt("status");
                    int categoryId = rs.getInt("category");

                    ProductDTO dto = new ProductDTO(id, name, img, price,
                            quantity, mfg, exp, status, categoryId);

                    if (list != null) {
                        list.add(dto);
                    } else {
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
    
    public List<ProductDTO> searchProducts(String searchValue, int minPrice,
            int maxPrice, String category, int skipRows, int nextRows)
            throws NamingException, SQLException {

        List<ProductDTO> list = null;

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT productId, productName, image, price, quantity, "
                        + "createDate, expirationDate, status, category, categoryName "
                        + "FROM product, category "
                        + "WHERE (product.category = category.categoryId) "
                        + "AND (productName LIKE ? ) "
                        + "AND (categoryName LIKE ? ) "
                        + "AND (price BETWEEN ? AND ?) "
                        + "ORDER BY createDate DESC "
                        + "OFFSET ? ROWS "
                        + "FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(sql);

                stm.setString(1, "%" + searchValue + "%");
                stm.setString(2, "%" + category + "%");
                stm.setInt(3, minPrice);
                stm.setInt(4, maxPrice);
                stm.setInt(5, skipRows);
                stm.setInt(6, nextRows);

                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("productId");
                    String name = rs.getString("productName");
                    String img = rs.getString("image");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    Date mfg = rs.getDate("createDate");
                    Date exp = rs.getDate("expirationDate");
                    int status = rs.getInt("status");
                    int categoryId = rs.getInt("category");

                    ProductDTO dto = new ProductDTO(id, name, img, price,
                            quantity, mfg, exp, status, categoryId);

                    if (list != null) {
                        list.add(dto);
                    } else {
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

    public boolean addProduct(String name, String img, int price, 
            int quantity, String mfg, String exp, int status, int category) 
            throws NamingException, SQLException, ParseException {

        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT product(productName, image, price, quantity, "
                                + "createDate, expirationDate, status, category) "
                            + "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, name);
                stm.setString(2, img);
                stm.setInt(3, price);
                stm.setInt(4, quantity);
                //convert MFG
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                Date utilMfg = formatter.parse(mfg);
                java.sql.Date sqlMfg = new java.sql.Date(utilMfg.getTime());
                stm.setDate(5, sqlMfg);
                //convert EXP
                Date utilExp = formatter.parse(exp);
                java.sql.Date sqlExp = new java.sql.Date(utilExp.getTime());
                stm.setDate(6, sqlExp);
                stm.setInt(7, status);
                stm.setInt(8, category);
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
    
    public boolean updateProduct(int id, String name, String img, int price, 
            int quantity, String mfg, String exp, int status, int category) 
            throws NamingException, SQLException, ParseException {

        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE product "
                            + "SET productName = ?, "
                                + "image = ?, "
                                + "price = ?, "
                                + "quantity = ?, "
                                + "createDate = ?, "
                                + "expirationDate = ?, "
                                + "status = ?, "
                                + "category = ? "
                            + "WHERE productId = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, name);
                stm.setString(2, img);
                stm.setInt(3, price);
                stm.setInt(4, quantity);
                //convert MFG
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                Date utilMfg = formatter.parse(mfg);
                java.sql.Date sqlMfg = new java.sql.Date(utilMfg.getTime());
                stm.setDate(5, sqlMfg);
                //convert EXP
                Date utilExp = formatter.parse(exp);
                java.sql.Date sqlExp = new java.sql.Date(utilExp.getTime());
                stm.setDate(6, sqlExp);
                stm.setInt(7, status);
                stm.setInt(8, category);
                stm.setInt(9, id);
                
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
    
    public int countAvailableProducts() throws NamingException, SQLException {

        int count = 0;

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(productId) AS Total "
                        + "FROM product "
                        + "WHERE status = 1 AND expirationDate > GETDATE() ";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    count = rs.getInt("Total");
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

        return count;
    }
    
    public int countTotalProducts() throws NamingException, SQLException {

        int count = 0;

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(productId) AS Total "
                        + "FROM product ";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    count = rs.getInt("Total");
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

        return count;
    }
    
    public int countSearchAvailableProducts(String searchValue, int minPrice,
            int maxPrice, String category, int skipRows, int nextRows)
            throws NamingException, SQLException {
        
        int count = 0;

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(productId) AS Total "
                        + "FROM product, category "
                        + "WHERE (product.category = category.categoryId) "
                        + "AND (status = 1) "
                        + "AND (expirationDate > GETDATE()) "
                        + "AND (productName LIKE ? ) "
                        + "AND (categoryName LIKE ? ) "
                        + "AND (price BETWEEN ? AND ?) ";
                stm = con.prepareStatement(sql);

                stm.setString(1, "%" + searchValue + "%");
                stm.setString(2, "%" + category + "%");
                stm.setInt(3, minPrice);
                stm.setInt(4, maxPrice);

                rs = stm.executeQuery();
                if (rs.next())
                    count = rs.getInt("Total");
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

        return count;
    }
    
    public int countSearchProducts(String searchValue, int minPrice,
            int maxPrice, String category, int skipRows, int nextRows)
            throws NamingException, SQLException {
        
        int count = 0;

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(productId) AS Total "
                        + "FROM product, category "
                        + "WHERE (product.category = category.categoryId) "
                        + "AND (productName LIKE ? ) "
                        + "AND (categoryName LIKE ? ) "
                        + "AND (price BETWEEN ? AND ?) ";
                stm = con.prepareStatement(sql);

                stm.setString(1, "%" + searchValue + "%");
                stm.setString(2, "%" + category + "%");
                stm.setInt(3, minPrice);
                stm.setInt(4, maxPrice);

                rs = stm.executeQuery();
                if (rs.next())
                    count = rs.getInt("Total");
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

        return count;
    }
    
    public boolean updateProductQuantity(List<Item> list, Connection con) throws SQLException {
        PreparedStatement stm = null;

        try {
            con.setAutoCommit(false);
            String sql = "UPDATE product "
                        + "SET quantity = quantity - ? "
                        + "WHERE productId = ?";
            stm = con.prepareStatement(sql);

            for (Item item : list) {
                int productId = item.getProduct().getId();
                int quantity = item.getQuantity();
                
                stm.setInt(1, quantity);
                stm.setInt(2, productId);
                
                stm.executeUpdate();
            }
            con.commit();
            con.setAutoCommit(true);
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
    
    public boolean updateProductStatus() throws NamingException, SQLException {
        
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE product "
                            + "SET status = 0 "
                            + "WHERE quantity <= 0";
                stm = con.prepareStatement(sql);
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
