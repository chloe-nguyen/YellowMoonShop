
package ngocnth.cart;

import java.io.Serializable;
import java.util.Date;

public class CartDTO implements Serializable {
    
    private int id;
    private String cartId;
    private String username;
    private String fullname;
    private String phone;
    private String address;
    private Date date;
    private int total;

    public CartDTO() {
    }

    public CartDTO(int id, String cartId, String username, String fullname, 
            String phone, String address, Date date, int total) {
        this.id = id;
        this.cartId = cartId;
        this.username = username;
        this.fullname = fullname;
        this.phone = phone;
        this.address = address;
        this.date = date;
        this.total = total;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId = cartId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
    
    
}
