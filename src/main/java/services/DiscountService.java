package services;

import dao.DiscountDAO;
import dao.UserVoucherDAO;
import model.Cart;
import model.Discount;
import model.UserVoucher;

import java.util.ArrayList;
import java.util.List;

public class DiscountService {
    private DiscountDAO discountDAO = new DiscountDAO();
    private UserVoucherDAO userVoucherDAO = new UserVoucherDAO();

    public List<Discount> getUserVouchers(int userId) {
        List<UserVoucher> userVouchers = userVoucherDAO.findByUserId(userId);
        List<Discount> discounts = new ArrayList<>();
        for (UserVoucher uv : userVouchers) {
            Discount d = new Discount();
            d.setId(uv.getDiscountId());
            Discount found = discountDAO.findById(d);
            if (found != null && found.isActive() && found.getQuantity() > 0) {
                discounts.add(found);
            }
        }
        return discounts;
    }

    public double calculateWholesaleDiscountRate(int totalQuantity) {
        if (totalQuantity >= 12)
            return 0.10;
        if (totalQuantity >= 6)
            return 0.06;
        if (totalQuantity >= 3)
            return 0.05;
        return 0.0;
    }

    public List<Discount> getAvailableShippingDiscounts() {
        List<Discount> all = discountDAO.findShippingDiscounts();
        List<Discount> available = new ArrayList<>();
        for (Discount d : all) {
            if (d.getQuantity() > 0) {
                available.add(d);
            }
        }
        return available;
    }

    public double calculateWholesaleAmount(Cart cart) {
        double subtotal = cart.getSubtotal();
        int totalQuantity = cart.getTotalQuantity();
        double wholesaleRate = calculateWholesaleDiscountRate(totalQuantity);
        return subtotal * wholesaleRate;
    }

    public boolean decrementQuantity(int discountId) {
        return discountDAO.decrementQuantity(discountId);
    }

    public List<Discount> getCollectableVouchers(int userId) {
        return discountDAO.findCollectableDiscounts(userId);
    }

    public List<Discount> getPublicDiscounts() {
        return discountDAO.findPublicDiscounts();
    }

    public boolean collectVoucher(int userId, int discountId) {
        // Check if already collected (double check)
        List<UserVoucher> existing = userVoucherDAO.findByUserId(userId);
        for (UserVoucher uv : existing) {
            if (uv.getDiscountId() == discountId) {
                return false; // Already collected
            }
        }

        // Decrement quantity
        boolean decremented = discountDAO.decrementQuantity(discountId);
        if (decremented) {
            // Create UserVoucher
            UserVoucher uv = new UserVoucher(userId, discountId);
            return userVoucherDAO.create(uv);
        }
        return false;
    }
}
