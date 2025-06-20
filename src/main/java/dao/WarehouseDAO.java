package dao;

import entity.Warehouse;
import entity.Product;
import context.DBContext;

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
        } catch (Exception e) {
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
        } catch (Exception e) {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteWarehouseEntry(int warehouseID) {
        String query = "DELETE FROM Warehouse WHERE warehouseID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, warehouseID);
            ps.executeUpdate();
        } catch (Exception e) {
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

    // Method to get total remaining quantity per product (Optional but helpful for overview)
    public List<entity.ProductStock> getTotalStockPerProduct() {
        List<entity.ProductStock> list = new ArrayList<>();
        String query = "SELECT p.id, p.name, COALESCE(SUM(w.remainingQuantity), 0) AS totalRemaining FROM Product p LEFT JOIN Warehouse w ON p.id = w.productID GROUP BY p.id, p.name ORDER BY p.name";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new entity.ProductStock(rs.getInt("id"), rs.getString("name"), rs.getInt("totalRemaining")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        // Example Usage (for testing)
        WarehouseDAO dao = new WarehouseDAO();
        List<Warehouse> entries = dao.getAllWarehouseEntries();
        for (Warehouse entry : entries) {
            System.out.println(entry.getWarehouseID() + " - " + entry.getProduct().getName() + " - " + entry.getQuantity() + " - " + entry.getRemainingQuantity());
        }
         List<entity.ProductStock> productStocks = dao.getTotalStockPerProduct();
        for (entity.ProductStock ps : productStocks) {
            System.out.println("Product: " + ps.getProductName() + ", Total Stock: " + ps.getTotalRemaining());
        }
    }

    /**
     * Check if there's enough stock for a product
     * @param productID The product ID to check
     * @param requestedQuantity The quantity requested
     * @return true if there's enough stock, false otherwise
     */
    public boolean hasEnoughStock(int productID, int requestedQuantity) {
        String query = "SELECT COALESCE(SUM(remainingQuantity), 0) AS totalStock FROM Warehouse WHERE productID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, productID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int totalStock = rs.getInt("totalStock");
                    return totalStock >= requestedQuantity;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Get total remaining stock for a specific product
     * @param productID The product ID
     * @return Total remaining quantity
     */
    public int getTotalRemainingStock(int productID) {
        String query = "SELECT COALESCE(SUM(remainingQuantity), 0) AS totalStock FROM Warehouse WHERE productID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, productID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("totalStock");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Reduce stock quantity when products are sold
     * Uses FIFO (First In, First Out) approach - reduces from oldest stock first
     * @param productID The product ID
     * @param quantityToReduce The quantity to reduce from stock
     * @return true if successful, false if not enough stock
     */
    public boolean reduceStock(int productID, int quantityToReduce) {
        // First check if we have enough stock
        if (!hasEnoughStock(productID, quantityToReduce)) {
            return false;
        }

        // Get warehouse entries for this product ordered by import date (FIFO)
        String selectQuery = "SELECT warehouseID, remainingQuantity FROM Warehouse WHERE productID = ? AND remainingQuantity > 0 ORDER BY importDate ASC";
        
        try (Connection conn = getConnection();
             PreparedStatement selectPs = conn.prepareStatement(selectQuery)) {
            
            selectPs.setInt(1, productID);
            try (ResultSet rs = selectPs.executeQuery()) {
                int remainingToReduce = quantityToReduce;
                
                while (rs.next() && remainingToReduce > 0) {
                    int warehouseID = rs.getInt("warehouseID");
                    int currentRemaining = rs.getInt("remainingQuantity");
                    
                    int reduceFromThis = Math.min(remainingToReduce, currentRemaining);
                    int newRemaining = currentRemaining - reduceFromThis;
                    
                    // Update this warehouse entry
                    String updateQuery = "UPDATE Warehouse SET remainingQuantity = ? WHERE warehouseID = ?";
                    try (PreparedStatement updatePs = conn.prepareStatement(updateQuery)) {
                        updatePs.setInt(1, newRemaining);
                        updatePs.setInt(2, warehouseID);
                        updatePs.executeUpdate();
                    }
                    
                    remainingToReduce -= reduceFromThis;
                }
                
                return remainingToReduce == 0; // Should be 0 if all quantity was reduced successfully
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Validate order before processing - check if all items have enough stock
     * @param cartItems List of cart items with productID and amount
     * @return true if all items have sufficient stock, false otherwise
     */
    public boolean validateOrderStock(List<entity.Cart> cartItems) {
        try {
            for (entity.Cart cart : cartItems) {
                if (!hasEnoughStock(cart.getProductID(), cart.getAmount())) {
                    return false;
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Process order - reduce stock for all items in the order
     * This method should be called within a transaction to ensure data consistency
     * @param cartItems List of cart items with productID and amount
     * @return true if all stock reductions were successful, false otherwise
     */
    public boolean processOrderStock(List<entity.Cart> cartItems) {
        try {
            // First validate that all items have enough stock
            if (!validateOrderStock(cartItems)) {
                return false;
            }
            
            // Then reduce stock for each item
            for (entity.Cart cart : cartItems) {
                if (!reduceStock(cart.getProductID(), cart.getAmount())) {
                    // If any reduction fails, we have a problem
                    // In a real application, this should be within a database transaction
                    // that can be rolled back
                    return false;
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
