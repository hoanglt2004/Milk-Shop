package dao;

import context.DBContext;
import entity.Warehouse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public List<Warehouse> getAllWarehouses() {
        List<Warehouse> list = new ArrayList<>();
        String query = "SELECT * FROM Warehouse";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Warehouse(
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getInt(3),
                    rs.getDate(4),
                    rs.getInt(5)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Warehouse getWarehouseByID(int warehouseID) {
        String query = "SELECT * FROM Warehouse WHERE warehouseID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, warehouseID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Warehouse(
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getInt(3),
                    rs.getDate(4),
                    rs.getInt(5)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addWarehouse(Warehouse warehouse) {
        String query = "INSERT INTO Warehouse (productID, quantity, importDate, remainingQuantity) VALUES (?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, warehouse.getProductID());
            ps.setInt(2, warehouse.getQuantity());
            ps.setDate(3, new java.sql.Date(warehouse.getImportDate().getTime()));
            ps.setInt(4, warehouse.getRemainingQuantity());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateWarehouse(Warehouse warehouse) {
        String query = "UPDATE Warehouse SET productID = ?, quantity = ?, importDate = ?, remainingQuantity = ? WHERE warehouseID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, warehouse.getProductID());
            ps.setInt(2, warehouse.getQuantity());
            ps.setDate(3, new java.sql.Date(warehouse.getImportDate().getTime()));
            ps.setInt(4, warehouse.getRemainingQuantity());
            ps.setInt(5, warehouse.getWarehouseID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteWarehouse(int warehouseID) {
        String query = "DELETE FROM Warehouse WHERE warehouseID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, warehouseID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Warehouse> getWarehousesByProductID(int productID) {
        List<Warehouse> list = new ArrayList<>();
        String query = "SELECT * FROM Warehouse WHERE productID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Warehouse(
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getInt(3),
                    rs.getDate(4),
                    rs.getInt(5)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalQuantityByProductID(int productID) {
        String query = "SELECT SUM(remainingQuantity) FROM Warehouse WHERE productID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
} 