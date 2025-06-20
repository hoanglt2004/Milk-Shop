package dao;

import entity.Discount;
import entity.Product;
import context.DBContext;

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

            System.out.println("Executing query: " + query);
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
                
                // Debug logging
                System.out.println("Found discount: " + discount.getDiscountID() + 
                                 " - Product: " + product.getName() + 
                                 " - Percent: " + discount.getPercentOff() + "%" +
                                 " - Active: " + discount.isActive() + 
                                 " - getActive(): " + discount.getActive());
            }
            System.out.println("Total discounts found: " + list.size());
        } catch (Exception e) {
            System.err.println("Error in getAllDiscounts: " + e.getMessage());
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
        } catch (Exception e) {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteDiscount(int discountID) {
        String query = "DELETE FROM Discount WHERE discountID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, discountID);
            ps.executeUpdate();
        } catch (Exception e) {
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
        } catch (Exception e) {
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

            System.out.println("Executing query: " + query);
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                System.out.println("Found product: " + product.getId() + " - " + product.getName());
                list.add(product);
            }
            System.out.println("Total products found: " + list.size());
        } catch (Exception e) {
            System.err.println("Error in getAllProducts: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // Test connection method
    public boolean testConnection() {
        try (Connection conn = getConnection()) {
            if (conn != null) {
                System.out.println("Database connection successful!");
                
                // Test if Discount table exists
                String checkTableQuery = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Discount'";
                try (PreparedStatement ps = conn.prepareStatement(checkTableQuery);
                     ResultSet rs = ps.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        System.out.println("Discount table exists!");
                        
                        // Check how many records in Discount table
                        String countQuery = "SELECT COUNT(*) FROM Discount";
                        try (PreparedStatement ps2 = conn.prepareStatement(countQuery);
                             ResultSet rs2 = ps2.executeQuery()) {
                            if (rs2.next()) {
                                int count = rs2.getInt(1);
                                System.out.println("Discount table has " + count + " records");
                            }
                        }
                    } else {
                        System.out.println("Discount table does not exist!");
                        return false;
                    }
                }
                return true;
            } else {
                System.out.println("Failed to get database connection!");
                return false;
            }
        } catch (Exception e) {
            System.err.println("Error testing connection: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        // Test the connection and data
        DiscountDAO dao = new DiscountDAO();
        
        System.out.println("=== Testing Database Connection ===");
        dao.testConnection();
        
        System.out.println("\n=== Testing getAllProducts ===");
        List<Product> products = dao.getAllProducts();
        
        System.out.println("\n=== Testing getAllDiscounts ===");
        List<Discount> discounts = dao.getAllDiscounts();
        
        // Add test discount if no discounts exist
        if (discounts.isEmpty() && !products.isEmpty()) {
            System.out.println("\n=== Adding Test Discount ===");
            try {
                Discount testDiscount = new Discount();
                testDiscount.setProductID(products.get(0).getId()); // First product
                testDiscount.setPercentOff(10);
                testDiscount.setStartDate(new java.util.Date());
                testDiscount.setEndDate(new java.util.Date(System.currentTimeMillis() + 86400000L * 30)); // 30 days later
                testDiscount.setActive(true);
                
                dao.addDiscount(testDiscount);
                System.out.println("Test discount added successfully!");
                
                // Test again
                discounts = dao.getAllDiscounts();
            } catch (Exception e) {
                System.err.println("Error adding test discount: " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        System.out.println("\n=== Summary ===");
        System.out.println("Products found: " + products.size());
        System.out.println("Discounts found: " + discounts.size());
    }
}
