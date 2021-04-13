
package ngocnth.cart;

import java.io.Serializable;
import ngocnth.product.ProductDTO;

public class Item implements Serializable {
    
    private ProductDTO product;
    private int quantity;

    public Item() {
    }

    public Item(ProductDTO product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public ProductDTO getProduct() {
        return product;
    }

    public void setProduct(ProductDTO product) {
        this.product = product;
    }
    
    
}
