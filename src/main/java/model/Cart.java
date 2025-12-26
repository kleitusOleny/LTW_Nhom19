package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

public class Cart implements Serializable {
    private Map<String,CartItem> data;
    private User user;
    
    public Cart(){
        data = new HashMap<>();
    }
    
    public void addItem(Product product,int quantity){
        if (quantity <= 0) {quantity = 1;}
        if (data.get(product.getId()) != null){
            data.get(product.getId()).upQuantity(quantity);
        }else{
            data.put(product.getId(),new CartItem(quantity,product.getPrice(),product));
        }
    }
    
    public boolean updateItem(String idProduct, int quantity){
        if (get(idProduct) == null) return false;
        if (quantity <= 0) quantity = 1;
        data.get(idProduct).setQuantity(quantity);
        return true;
    }
    
    public CartItem removeItem(String idProduct){
        if (get(idProduct) == null) return null;
        return data.remove(idProduct);
    }
    
    public List<CartItem> removeAll(String idProduct){
        List<CartItem> cartItems = new ArrayList<>(data.values());
        data.clear();
        return cartItems;
    }
    
    public List<CartItem> getItems(){
        return new ArrayList<>(data.values());
    }
    
    public CartItem get(String id){
        return data.get(id);
    }
    
    public int getTotalQuantity(){
        AtomicInteger total = new AtomicInteger();
        getItems().forEach(item -> total.addAndGet(item.getQuantity()));
        return total.get();
    }
    
    public BigDecimal getTotal() {
        BigDecimal total = BigDecimal.ZERO;
        
        for (var item : getItems()) {
            BigDecimal subTotal = item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
            total = total.add(subTotal);
        }
        
        return total;
    }
    
    public void updateCustomerInfo(User user){
        this.user = user;
    }
}
