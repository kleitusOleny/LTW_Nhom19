package model;

import java.io.Serializable;

import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

public class Cart implements Serializable {
    private Map<String, CartItem> data;
    private User user;

    public Cart() {
        data = new HashMap<>();
    }

    public void addItem(Product product, int quantity) {
        if (quantity <= 0) {
            quantity = 1;
        }
        if (data.get(product.getId()) != null) {
            data.get(product.getId()).upQuantity(quantity);
        } else {
            data.put(product.getId(), new CartItem(quantity, product.getDiscountedPrice(), product));
        }
    }

    public void updateQuantity(String idProduct, int quantity) {
        CartItem cartItem = get(idProduct);
        if (cartItem == null || quantity == 0)
            return;
        int newQuantity = cartItem.getQuantity() + quantity;
        if (newQuantity <= 0) {
            removeItem(idProduct);
        }
        cartItem.setQuantity(newQuantity);
    }

    public boolean updateItem(String idProduct, int quantity) {
        if (get(idProduct) == null)
            return false;
        if (quantity <= 0)
            quantity = 1;
        data.get(idProduct).setQuantity(quantity);
        return true;
    }

    public CartItem removeItem(String idProduct) {
        return data.remove(idProduct);
    }

    public List<CartItem> removeAll(String idProduct) {
        List<CartItem> cartItems = new ArrayList<>(data.values());
        data.clear();
        return cartItems;
    }

    public List<CartItem> getItems() {
        return new ArrayList<>(data.values());
    }

    public CartItem get(String id) {
        return data.get(id);
    }

    public int getTotalQuantity() {
        AtomicInteger total = new AtomicInteger();
        getItems().forEach(item -> total.addAndGet(item.getQuantity()));
        return total.get();
    }

    private Discount shippingDiscount;
    private Discount voucherDiscount;
    private double loyaltyDiscountAmount = 0.0;

    public double getOriginalSubtotal() {
        double total = 0.0;
        for (var item : getItems()) {
            double subTotal = item.getPrice() * item.getQuantity();
            total += subTotal;
        }
        return total;
    }

    public double getSubtotal() {
        double total = 0.0;
        for (var item : getItems()) {
            total += item.getTotalPrice();
        }
        return total;
    }

    public double getTotal() {
        double subtotal = getSubtotal();
        double totalDeduction = loyaltyDiscountAmount;

        if (voucherDiscount != null) {
            String type = voucherDiscount.getDiscountType();
            if ("PERCENT".equalsIgnoreCase(type) || "percentage".equalsIgnoreCase(type)) {
                totalDeduction += subtotal * (voucherDiscount.getDiscountValue() / 100.0);
            } else {
                // FIXED, amount, etc.
                totalDeduction += voucherDiscount.getDiscountValue();
            }
        }

        if (shippingDiscount != null) {
            totalDeduction += shippingDiscount.getDiscountValue();
        }

        return Math.max(0, subtotal - totalDeduction);
    }

    public Discount getShippingDiscount() {
        return shippingDiscount;
    }

    public void setShippingDiscount(Discount shippingDiscount) {
        this.shippingDiscount = shippingDiscount;
    }

    public Discount getVoucherDiscount() {
        return voucherDiscount;
    }

    public void setVoucherDiscount(Discount voucherDiscount) {
        this.voucherDiscount = voucherDiscount;
    }

    public double getLoyaltyDiscountAmount() {
        return loyaltyDiscountAmount;
    }

    public void setLoyaltyDiscountAmount(double loyaltyDiscountAmount) {
        this.loyaltyDiscountAmount = loyaltyDiscountAmount;
    }

    public void updateCustomerInfo(User user) {
        this.user = user;
    }
}
