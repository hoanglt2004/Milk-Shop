package dao;

import entity.Invoice;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

public class InvoiceDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public void insertInvoice(int accountID, Date ngayXuat, double tongGia) {
        String query = "INSERT INTO Invoice (accountID, ngayXuat, tongGia, status) VALUES (?, ?, ?, N'Chờ xác nhận')";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.setDate(2, ngayXuat);
            ps.setDouble(3, tongGia);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateInvoice(int maHD, int accountID, Date ngayXuat, double tongGia) {
        String query = "UPDATE Invoice SET accountID = ?, ngayXuat = ?, tongGia = ? WHERE maHD = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.setDate(2, ngayXuat);
            ps.setDouble(3, tongGia);
            ps.setInt(4, maHD);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteInvoice(int maHD) {
        String query = "DELETE FROM [dbo].[Invoice] WHERE [maHD] = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, maHD);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Deleted " + rowsAffected + " invoice(s) with maHD: " + maHD);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public List<Invoice> getAllInvoices() {
        List<Invoice> list = new ArrayList<>();
        String query = "SELECT * FROM Invoice";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Invoice(
                    rs.getInt("maHD"),
                    rs.getInt("accountID"),
                    rs.getDouble("tongGia"),
                    rs.getDate("ngayXuat"),
                    rs.getString("status"),
                    rs.getDate("deliveryDate")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Invoice getInvoiceById(int maHD) {
        String query = "SELECT * FROM Invoice WHERE maHD = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, maHD);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Invoice(
                    rs.getInt("maHD"),
                    rs.getInt("accountID"),
                    rs.getDouble("tongGia"),
                    rs.getDate("ngayXuat"),
                    rs.getString("status"),
                    rs.getDate("deliveryDate")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Invoice> getInvoicesByAccountId(int accountID) {
        List<Invoice> list = new ArrayList<>();
        String query = "SELECT * FROM Invoice WHERE accountID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Invoice(
                    rs.getInt("maHD"),
                    rs.getInt("accountID"),
                    rs.getDouble("tongGia"),
                    rs.getDate("ngayXuat"),
                    rs.getString("status"),
                    rs.getDate("deliveryDate")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateInvoiceStatus(int maHD, String status) {
        String query = "UPDATE Invoice SET status = ? WHERE maHD = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, maHD);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
} 