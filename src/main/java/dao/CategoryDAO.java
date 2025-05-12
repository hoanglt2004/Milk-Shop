package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.DBContext;

public class CategoryDAO extends DBContext {

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM category";
        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCid(rs.getInt("cid"));
                category.setCname(rs.getString("cname"));
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    public Category getCategoryById(int cid) {
        String sql = "SELECT * FROM category WHERE cid = ?";
        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Category category = new Category();
                category.setCid(rs.getInt("cid"));
                category.setCname(rs.getString("cname"));
                return category;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addCategory(Category category) {
        String getMaxIdSql = "SELECT ISNULL(MAX(cid), 0) FROM category";
        String insertSql = "INSERT INTO category (cid, cname) VALUES (?, ?)";
        try {
            Connection conn = getConnection();
            // Lấy cid lớn nhất
            PreparedStatement psMax = conn.prepareStatement(getMaxIdSql);
            ResultSet rs = psMax.executeQuery();
            int newCid = 1;
            if (rs.next()) {
                newCid = rs.getInt(1) + 1;
            }
            rs.close();
            psMax.close();

            // Thêm mới với cid mới
            PreparedStatement ps = conn.prepareStatement(insertSql);
            ps.setInt(1, newCid);
            ps.setString(2, category.getCname());
            ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi thêm danh mục: " + e.getMessage());
        }
    }

    public void updateCategory(Category category) {
        String sql = "UPDATE category SET cname = ? WHERE cid = ?";
        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, category.getCname());
            ps.setInt(2, category.getCid());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCategory(int cid) {
        String sql = "DELETE FROM category WHERE cid = ?";
        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
} 