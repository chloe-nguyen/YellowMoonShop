
package ngocnth.cart;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import ngocnth.product.ProductDTO;

public class Cart implements Serializable {
    
    List<Item> cart;
    int totalQuantity;
    int totalPrice;

    public List<Item> getCart() {
        return cart;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalQuantity() {
        totalQuantity = 0;
        if (cart == null)
            return;
        
        for (Item item : cart) {
            totalQuantity += item.getQuantity();
        }
    }
    
    public void setTotalPrice() {
        totalPrice = 0;
        if (cart == null)
            return;
        
        for (Item item : cart) {
            totalPrice += item.getQuantity() * item.getProduct().getPrice();
        }
    }
    
    public void addItemToCart(ProductDTO product) {
        if (cart == null)
            cart = new ArrayList<>();
        
        int quantity = 1;
        for (Item item : cart) {
            if (item.getProduct().getId() == product.getId()) {
                quantity = item.getQuantity();
                item.setQuantity(quantity + 1);
                setTotalQuantity();
                setTotalPrice();
                return;
            }
        }
        
        Item newItem = new Item(product, quantity);
        cart.add(newItem);
    }
    
    public boolean updateItemQuantity(int id, int quantity) {
        for (Item item : cart) {
            if (item.getProduct().getId() == id) {
                if (item.getProduct().getQuantity() >= quantity) {
                    item.setQuantity(quantity);
                    setTotalQuantity();
                    setTotalPrice();
                    return true;
                }
            }
        }
        return false;
    }
    
    public void removeItemFromCart(int id) {
        for (Item item : cart) {
            if (item.getProduct().getId() == id) {
                cart.remove(item);
                setTotalQuantity();
                setTotalPrice();
                
                if (cart.isEmpty())
                    cart = null;
                return;
            }
        }
    }
}
