package dao;

import entity.Warehouse;
import entity.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class WarehouseDAO extends DBContext {

    public List<Warehouse> getAllWarehouseEntries() {
        List<Warehouse> list = new ArrayList<>();
        String query = "SELECT w.*, p.name AS productName FROM Warehouse w JOIN Product p ON w.productID = p.id ORDER BY w.importDate DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Warehouse entry = new Warehouse();
                entry.setWarehouseID(rs.getInt("warehouseID"));
                entry.setProductID(rs.getInt("productID"));
                entry.setQuantity(rs.getInt("quantity"));
                entry.setImportDate(rs.getTimestamp("importDate"));
                entry.setRemainingQuantity(rs.getInt("remainingQuantity"));

                Product product = new Product();
                product.setId(rs.getInt("productID"));
                product.setName(rs.getString("productName"));

                entry.setProduct(product);
                list.add(entry);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addWarehouseEntry(Warehouse entry) {
        String query = "INSERT INTO Warehouse (productID, quantity, importDate, remainingQuantity) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, entry.getProductID());
            ps.setInt(2, entry.getQuantity());
            ps.setTimestamp(3, new java.sql.Timestamp(entry.getImportDate().getTime()));
            ps.setInt(4, entry.getQuantity()); // Initially remainingQuantity is the same as quantity

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateWarehouseEntry(Warehouse entry) {
        // Note: Updating quantity might require careful consideration of remainingQuantity and linked invoices.
        // For simplicity, this basic update only allows modifying quantity and importDate.
        // A more robust implementation might restrict updates or adjust remainingQuantity based on existing sales.
        String query = "UPDATE Warehouse SET productID = ?, quantity = ?, importDate = ?, remainingQuantity = ? WHERE warehouseID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, entry.getProductID());
            ps.setInt(2, entry.getQuantity());
            ps.setTimestamp(3, new java.sql.Timestamp(entry.getImportDate().getTime()));
             ps.setInt(4, entry.getRemainingQuantity()); // Allow updating remaining quantity, but be cautious
            ps.setInt(5, entry.getWarehouseID());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteWarehouseEntry(int warehouseID) {
        String query = "DELETE FROM Warehouse WHERE warehouseID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, warehouseID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Warehouse getWarehouseEntryByID(int warehouseID) {
        String query = "SELECT w.*, p.name AS productName FROM Warehouse w JOIN Product p ON w.productID = p.id WHERE w.warehouseID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, warehouseID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Warehouse entry = new Warehouse();
                    entry.setWarehouseID(rs.getInt("warehouseID"));
                    entry.setProductID(rs.getInt("productID"));
                    entry.setQuantity(rs.getInt("quantity"));
                    entry.setImportDate(rs.getTimestamp("importDate"));
                    entry.setRemainingQuantity(rs.getInt("remainingQuantity"));

                    Product product = new Product();
                    product.setId(rs.getInt("productID"));
                    product.setName(rs.getString("productName"));

                    entry.setProduct(product);
                    return entry;
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

    // Method to get total remaining quantity per product (Optional but helpful for overview)
    public List<ProductStock> getTotalStockPerProduct() {
        List<ProductStock> list = new ArrayList<>();
        String query = "SELECT p.id, p.name, SUM(w.remainingQuantity) AS totalRemaining FROM Product p LEFT JOIN Warehouse w ON p.id = w.productID GROUP BY p.id, p.name";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ProductStock(rs.getInt("id"), rs.getString("name"), rs.getInt("totalRemaining")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
     // Helper class for total stock (create a new file entity/ProductStock.java)
    public static class ProductStock {
        private int productID;
        private String productName;
        private int totalRemaining;

        public ProductStock(int productID, String productName, int totalRemaining) {
            this.productID = productID;
            this.productName = productName;
            this.totalRemaining = totalRemaining;
        }

        public int getProductID() {
            return productID;
        }

        public String getProductName() {
            return productName;
        }

        public int getTotalRemaining() {
            return totalRemaining;
        }
    }

    public static void main(String[] args) {
        // Example Usage (for testing)
        WarehouseDAO dao = new WarehouseDAO();
        List<Warehouse> entries = dao.getAllWarehouseEntries();
        for (Warehouse entry : entries) {
            System.out.println(entry.getWarehouseID() + " - " + entry.getProduct().getName() + " - " + entry.getQuantity() + " - " + entry.getRemainingQuantity());
        }
         List<ProductStock> productStocks = dao.getTotalStockPerProduct();
        for (ProductStock ps : productStocks) {
            System.out.println("Product: " + ps.getProductName() + ", Total Stock: " + ps.getTotalRemaining());
        }
    }
}
