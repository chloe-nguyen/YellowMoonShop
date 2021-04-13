
package ngocnth.cartDetail;

import java.io.Serializable;

public class CartDetailDTO implements Serializable {
    
    private int detailId;
    private int cartId;
    private int productId;
    private int quantity;
    private int price;

    public CartDetailDTO() {
    }

    public CartDetailDTO(int detailId, int cartId, int productId, int quantity, int price) {
        this.detailId = detailId;
        this.cartId = cartId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getDetailId() {
        return detailId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
}
