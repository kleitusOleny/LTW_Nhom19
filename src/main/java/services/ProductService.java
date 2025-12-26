package services;

import dao.ProductDAO;
import model.Product;

import java.util.List;

public class ProductService {
    List<Product> lst = new ProductDAO().getProducts();
    public Product getProduct(String productId) {
        for (Product product:lst){
            if (product.getId().equals(productId)) return product;
        }
        return null;
    }
}
