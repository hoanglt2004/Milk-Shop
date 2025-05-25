package dao;

import context.DBContext;
import entity.Discount;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DiscountDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public List<Discount> getAllDiscounts() {
        List<Discount> list = new ArrayList<>();
        String query = "SELECT * FROM Discount";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Discount(
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getInt(3),
                    rs.getDate(4),
                    rs.getDate(5),
                    rs.getBoolean(6)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Discount getDiscountByID(int discountID) {
        String query = "SELECT * FROM Discount WHERE discountID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, discountID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Discount(
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getInt(3),
                    rs.getDate(4),
                    rs.getDate(5),
                    rs.getBoolean(6)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addDiscount(Discount discount) {
        String query = "INSERT INTO Discount (productID, percentOff, startDate, endDate, isActive) VALUES (?, ?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
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
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
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
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, discountID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Discount> getActiveDiscounts() {
        List<Discount> list = new ArrayList<>();
        String query = "SELECT * FROM Discount WHERE isActive = 1 AND startDate <= GETDATE() AND endDate >= GETDATE()";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Discount(
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getInt(3),
                    rs.getDate(4),
                    rs.getDate(5),
                    rs.getBoolean(6)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Discount getActiveDiscountByProductID(int productID) {
        String query = "SELECT * FROM Discount WHERE productID = ? AND isActive = 1 AND startDate <= GETDATE() AND endDate >= GETDATE()";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Discount(
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getInt(3),
                    rs.getDate(4),
                    rs.getDate(5),
                    rs.getBoolean(6)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
} 