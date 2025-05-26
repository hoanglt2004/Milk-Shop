package dao;

import entity.Discount;
import entity.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class DiscountDAO extends DBContext {

    public List<Discount> getAllDiscounts() {
        List<Discount> list = new ArrayList<>();
        String query = "SELECT d.*, p.name AS productName FROM Discount d JOIN Product p ON d.productID = p.id";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Discount discount = new Discount();
                discount.setDiscountID(rs.getInt("discountID"));
                discount.setProductID(rs.getInt("productID"));
                discount.setPercentOff(rs.getInt("percentOff"));
                discount.setStartDate(rs.getDate("startDate"));
                discount.setEndDate(rs.getDate("endDate"));
                discount.setActive(rs.getBoolean("isActive"));

                Product product = new Product();
                product.setId(rs.getInt("productID"));
                product.setName(rs.getString("productName"));

                discount.setProduct(product);
                list.add(discount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addDiscount(Discount discount) {
        String query = "INSERT INTO Discount (productID, percentOff, startDate, endDate, isActive) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, discount.getProductID());
            ps.setInt(2, discount.getPercentOff());
            ps.setDate(3, new java.sql.Date(discount.getStartDate().getTime()));
            ps.setDate(4, new java.sql.Date(discount.getEndDate().getTime()));
            ps.setBoolean(5, discount.isActive());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateDiscount(Discount discount) {
        String query = "UPDATE Discount SET productID = ?, percentOff = ?, startDate = ?, endDate = ?, isActive = ? WHERE discountID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, discount.getProductID());
            ps.setInt(2, discount.getPercentOff());
            ps.setDate(3, new java.sql.Date(discount.getStartDate().getTime()));
            ps.setDate(4, new java.sql.Date(discount.getEndDate().getTime()));
            ps.setBoolean(5, discount.isActive());
            ps.setInt(6, discount.getDiscountID());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteDiscount(int discountID) {
        String query = "DELETE FROM Discount WHERE discountID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, discountID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Discount getDiscountByID(int discountID) {
        String query = "SELECT d.*, p.name AS productName FROM Discount d JOIN Product p ON d.productID = p.id WHERE d.discountID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, discountID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Discount discount = new Discount();
                    discount.setDiscountID(rs.getInt("discountID"));
                    discount.setProductID(rs.getInt("productID"));
                    discount.setPercentOff(rs.getInt("percentOff"));
                    discount.setStartDate(rs.getDate("startDate"));
                    discount.setEndDate(rs.getDate("endDate"));
                    discount.setActive(rs.getBoolean("isActive"));

                    Product product = new Product();
                    product.setId(rs.getInt("productID"));
                    product.setName(rs.getString("productName"));

                    discount.setProduct(product);
                    return discount;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Product";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                // You can set other product properties if needed
                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        // Example Usage (for testing)
        DiscountDAO dao = new DiscountDAO();
        List<Discount> discounts = dao.getAllDiscounts();
        for (Discount discount : discounts) {
            System.out.println(discount.getDiscountID() + " - " + discount.getProduct().getName() + " - " + discount.getPercentOff() + "%");
        }
    }
}
