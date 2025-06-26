/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import context.DBContext;
import entity.Account;
import entity.Cart;
import entity.Review;
import entity.SoLuongDaBan;
import entity.TongChiTieuBanHang;
import entity.Supplier;
import entity.Category;
import entity.Invoice;
import entity.Product;
import entity.Discount; // Import Discount
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.sql.SQLException;


public class DAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    private DiscountDAO discountDAO;
    
    public DAO() {
        try {
            // It's better to manage one connection per method, but we follow the existing pattern.
            // A single connection for the DAO's lifetime can be problematic.
            conn = new DBContext().getConnection(); 
            discountDAO = new DiscountDAO();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Applies active discount information to a single Product object.
     * @param p The Product object to process.
     */
    private void applyDiscountToProduct(Product p) {
        if (p == null || discountDAO == null) {
            return;
        }
        Discount activeDiscount = discountDAO.getActiveDiscountByProductId(p.getId());
        if (activeDiscount != null) {
            p.setDiscountPercent(activeDiscount.getPercentOff());
            double originalPrice = p.getPrice();
            double salePrice = originalPrice - (originalPrice * activeDiscount.getPercentOff() / 100.0);
            p.setSalePrice(salePrice);
        }
    }

    /**
     * Applies active discount information to a list of Product objects.
     * @param productList The list of Product objects to process.
     */
    private void applyDiscountToList(List<Product> productList) {
        if (productList == null || productList.isEmpty()) {
            return;
        }
        for (Product p : productList) {
            applyDiscountToProduct(p);
        }
    }

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getDouble("price"),
                    rs.getString("brand"),
                    rs.getString("description"),
                    rs.getInt("cateID"),
                    rs.getString("delivery"),
                    rs.getString("image2"),
                    rs.getString("image3")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list); // Correct
        return list;
    }
    
    public List<SoLuongDaBan> getTop10SanPhamBanChay() {
        List<SoLuongDaBan> list = new ArrayList<>();
        String query = "select top(10) * from SoLuongDaBan order by soLuongDaBan desc";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new SoLuongDaBan(rs.getInt(1), rs.getInt(2)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // DO NOT apply discount here. This list is not of Products.
        return list;
    }
    
    public List<Invoice> getAllInvoice() {
        List<Invoice> list = new ArrayList<>();
        String query = "select * from Invoice ORDER BY maHD DESC";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Invoice(rs.getInt(1),
                        rs.getInt(2),
                        rs.getDouble(3),
                        rs.getDate(4),
                        rs.getString(5),
                        rs.getDate(6)
                       ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public int countAllProductBySellID(int sell_ID) {
        String query = "select count(*) from Product where sell_ID=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, sell_ID);
            rs = ps.executeQuery();
            while (rs.next()) {
               return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    public int getSellIDByProductID(int productID) {
        String query = "select sell_ID\r\n"
        		+ "from Product\r\n"
        		+ "where [id]=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            while (rs.next()) {
               return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    public double totalMoneyDay(int day) {
        String query = "select \r\n"
        		+ "	SUM(tongGia) \r\n"
        		+ "from Invoice\r\n"
        		+ "where DATEPART(dw,[ngayXuat]) = ? AND status = N'Hoàn thành'\r\n"
        		+ "Group by ngayXuat ";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, day);
            rs = ps.executeQuery();
            while (rs.next()) {
               return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    public double totalMoneyMonth(int month) {
        String query = "select SUM(tongGia) from Invoice\r\n"
        		+ "where MONTH(ngayXuat)=? AND status = N'Hoàn thành'\r\n"
        		+ "Group by MONTH(ngayXuat)";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, month);
            rs = ps.executeQuery();
            while (rs.next()) {
               return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    public int countAllProduct() {
        String query = "select count(*) from Product";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
               return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    public double sumAllInvoice() {
        String query = "select SUM(tongGia) from Invoice WHERE status = N'Hoàn thành'";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
               return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    public int countAllReview() {
        String query = "select count(*) from Review";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
               return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    public int getCateIDByProductID(String id) {
        String query = "select [cateID] from Product\r\n"
        		+ "where [id] =?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
               return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    public List<Account> getAllAccount() {
        List<Account> list = new ArrayList<>();
        String query = "select * from Account";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Database structure: uID, user, pass, isAdmin, fullName, phone, address, province, email
                list.add(new Account(
                    rs.getInt("uID"),
                    rs.getString("user"),
                    rs.getString("pass"),
                    0,
                    rs.getInt("isAdmin"),
                    rs.getString("email"),
                    rs.getString("fullName"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getString("province")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Supplier> getAllSupplier() {
        List<Supplier> list = new ArrayList<>();
        String query = "select * from Supplier";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Supplier(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                		rs.getInt(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }
   
    public List<TongChiTieuBanHang> getTop5KhachHang() {
        List<TongChiTieuBanHang> list = new ArrayList<>();
        String query = "select top(5) *\r\n"
        		+ "from TongChiTieuBanHang\r\n"
        		+ "order by TongChiTieu desc";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new TongChiTieuBanHang(rs.getInt(1),
                        rs.getDouble(2),
                        rs.getDouble(3)
                       ));
            }
        } catch (Exception e) {
        }
        return list;
    }
    
    public List<Product> getTop3() {
        List<Product> list = new ArrayList<>();
        String query = "select top 3 * from Product";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Database structure: id, name, image, price, brand, description, cateID, delivery, image2, image3
                list.add(new Product(rs.getInt(1),      // id
                        rs.getString(2),                // name  
                        rs.getString(3),                // image
                        rs.getDouble(4),                // price
                        rs.getString(5),                // brand (was title)
                        rs.getString(6),                // description
                        "",                             // model (removed from DB)
                        "",                             // color (removed from DB)
                        rs.getString(8),                // delivery
                        rs.getString(9),                // image2
                        rs.getString(10),               // image3
                        ""));                           // image4 (removed from DB)
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }

    public List<Product> getNext3Product(int amount) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Product ORDER BY id OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, amount);
            rs = ps.executeQuery();
            while (rs.next()) {
                 list.add(new Product(
                    rs.getInt("id"), rs.getString("name"), rs.getString("image"), rs.getDouble("price"),
                    rs.getString("brand"), rs.getString("description"), rs.getInt("cateID"),
                    rs.getString("delivery"), rs.getString("image2"), rs.getString("image3")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> getNext4NikeProduct(int amount) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product\r\n"
        		+ "where cateID=2\r\n"
        		+ "order by id desc\r\n"
        		+ "offset ? rows\r\n"
        		+ "fetch next 4 rows only";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, amount);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                         rs.getInt(7), // cateID
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> getNext4AdidasProduct(int amount) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product\r\n"
        		+ "where cateID=1\r\n"
        		+ "order by id desc\r\n"
        		+ "offset ? rows\r\n"
        		+ "fetch next 4 rows only";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, amount);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                         rs.getInt(7), // cateID
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> getProductByCID(String cid) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product where cateID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, cid);
            rs = ps.executeQuery();
            while (rs.next()) {
                 list.add(new Product(
                    rs.getInt("id"), rs.getString("name"), rs.getString("image"), rs.getDouble("price"),
                    rs.getString("brand"), rs.getString("description"), rs.getInt("cateID"),
                    rs.getString("delivery"), rs.getString("image2"), rs.getString("image3")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }

    public List<Product> getProductBySellIDAndIndex(int id, int indexPage) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product \r\n"
        		+ "where sell_ID = ?\r\n"
        		+ "order by [id]\r\n"
        		+ "offset ? rows\r\n"
        		+ "fetch next 5 rows only";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ps.setInt(2, (indexPage-1)*5);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14)));
            }
        } catch (Exception e) {
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> getProductByIndex(int indexPage) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product \r\n"
        		+ "order by [id]\r\n"
        		+ "offset ? rows\r\n"
        		+ "fetch next 9 rows only";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, (indexPage-1)*9);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                         rs.getInt(7), // cateID
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }

    public List<Product> searchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product where LOWER([name]) like LOWER(?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                 list.add(new Product(
                    rs.getInt("id"), rs.getString("name"), rs.getString("image"), rs.getDouble("price"),
                    rs.getString("brand"), rs.getString("description"), rs.getInt("cateID"),
                    rs.getString("delivery"), rs.getString("image2"), rs.getString("image3")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Invoice> searchByNgayXuat(String ngayXuat) {
        List<Invoice> list = new ArrayList<>();
        String query = "select * from Invoice\r\n"
        		+ "where [ngayXuat] ='"+ngayXuat+"'";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, ngayXuat);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Invoice(rs.getInt(1),
                        rs.getInt(2),
                        rs.getDouble(3),
                        rs.getDate(4),
                        rs.getString(5),
                        rs.getDate(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }
    
    public List<Product> searchPriceUnder100() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product\r\n"
        		+ "where [price] < 100";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                         rs.getInt(7), // cateID
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> searchPrice100To200() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product\r\n"
        		+ "where [price] >= 100 and [price]<=200";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                         rs.getInt(7), // cateID
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> searchColorWhite() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product\r\n"
        		+ "where color = 'White'";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                         rs.getInt(7), // cateID
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> searchColorGray() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product\r\n"
        		+ "where color = 'Gray'";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                         rs.getInt(7), // cateID
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> searchColorBlack() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product\r\n"
        		+ "where color = 'Black'";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                         rs.getInt(7), // cateID
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> searchColorYellow() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product\r\n"
        		+ "where color = 'Yellow'";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                         rs.getInt(7), // cateID
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    public List<Product> searchByPriceMinToMax(String priceMin,String priceMax) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product\r\n"
        		+ "where [price] >= ? and [price]<=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, priceMin);
            ps.setString(2, priceMax);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                         rs.getInt(7), // cateID
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> searchPriceAbove200() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product\r\n"
        		+ "where [price] > 200";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                         rs.getInt(7), // cateID
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> getRelatedProduct(int cateIDProductDetail) {
        List<Product> list = new ArrayList<>();
        String query = "select top 4 * from product\r\n"
        		+ "where [cateID] =?\r\n"
        		+ "order by id desc";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, cateIDProductDetail);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Database structure: id, name, image, price, brand, description, cateID, delivery, image2, image3
                list.add(new Product(rs.getInt(1),      // id
                        rs.getString(2),                // name  
                        rs.getString(3),                // image
                        rs.getDouble(4),                // price
                        rs.getString(5),                // brand (was title)
                        rs.getString(6),                // description
                        "",                             // model (removed from DB)
                        "",                             // color (removed from DB)
                        rs.getString(8),                // delivery
                        rs.getString(9),                // image2
                        rs.getString(10),               // image3
                        ""));                           // image4 (removed from DB)
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    
    public List<Review> getAllReviewByProductID(String productId) {
        List<Review> list = new ArrayList<>();
        String query = "select * from Review\r\n"
        		+ "where [productID] =?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, productId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Review(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4)
                       ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Product getProductByID(String id) {
        String query = "select * from Product where id = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Product p = new Product(
                    rs.getInt("id"), rs.getString("name"), rs.getString("image"), rs.getDouble("price"),
                    rs.getString("brand"), rs.getString("description"), rs.getInt("cateID"),
                    rs.getString("delivery"), rs.getString("image2"), rs.getString("image3")
                );
                applyDiscountToProduct(p);
                return p;
            }
        } catch (Exception e) {
             e.printStackTrace();
        }
        return null;
    }
    
    public List<Cart> getCartByAccountID(int accountID) {
    	 List<Cart> list = new ArrayList<>();
        String query = "select * from Cart where accountID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Cart(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Cart checkCartExist(int accountID,int productID) {

       String query = "select * from Cart\r\n"
       		+ "where [accountID] = ? and [productID] = ?";
       try {
           ps = conn.prepareStatement(query);
           ps.setInt(1, accountID);
           ps.setInt(2, productID);
           rs = ps.executeQuery();
           while (rs.next()) {
               return new Cart(rs.getInt(1),
                       rs.getInt(2),
                       rs.getInt(3),
                       rs.getInt(4),
                       rs.getString(5));
           }
       } catch (Exception e) {
       }
      return null;
   }
    
    public int checkAccountAdmin(int userID) {

        String query = "select isAdmin from Account where [uID]=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, userID);

            rs = ps.executeQuery();  
            while (rs.next()) {
            	 return rs.getInt(1);
             }
        } catch (Exception e) {
        	
        }
        return 0;
    }
    
    public TongChiTieuBanHang checkTongChiTieuBanHangExist(int userID) {

        String query = "select * from TongChiTieuBanHang where [userID]=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, userID);
           
            rs = ps.executeQuery();
            while (rs.next()) {
                return new TongChiTieuBanHang(rs.getInt(1),
                        rs.getDouble(2),
                        rs.getDouble(3)
                        );
            }
        } catch (Exception e) {
        }
       return null;
    }
    
    public SoLuongDaBan checkSoLuongDaBanExist(int productID) {

        String query = "select * from SoLuongDaBan where productID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, productID);
           
            rs = ps.executeQuery();
            while (rs.next()) {
                return new SoLuongDaBan(rs.getInt(1),
                        rs.getInt(2)
                       );
            }
        } catch (Exception e) {
        }
       return null;
    }
    
    
    
    public List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();
        String query = "select * from Category";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1),
                        rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list;
    }
    
    
//
    public Product getLast() {
        String query = "select top 1 * from Product order by id desc";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                Product p = new Product(
                    rs.getInt("id"), rs.getString("name"), rs.getString("image"), rs.getDouble("price"),
                    rs.getString("brand"), rs.getString("description"), rs.getInt("cateID"),
                    rs.getString("delivery"), rs.getString("image2"), rs.getString("image3")
                );
                applyDiscountToProduct(p);
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Product> get8Last() {
    	List<Product> list = new ArrayList<>();
        String query = "select top 8 * from Product order by id desc";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
            	list.add(new Product(
                    rs.getInt("id"), rs.getString("name"), rs.getString("image"), rs.getDouble("price"),
                    rs.getString("brand"), rs.getString("description"), rs.getInt("cateID"),
                    rs.getString("delivery"), rs.getString("image2"), rs.getString("image3")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> get4NikeLast() {
    	List<Product> list = new ArrayList<>();
        String query = "select top 4 * from Product\r\n"
        		+ "where cateID = 2\r\n"
        		+ "order by id desc";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Database structure: id, name, image, price, brand, description, cateID, delivery, image2, image3
            	list.add(new Product(rs.getInt(1),      // id
                        rs.getString(2),                // name  
                        rs.getString(3),                // image
                        rs.getDouble(4),                // price
                        rs.getString(5),                // brand (was title)
                        rs.getString(6),                // description
                        rs.getInt(7),                   // cateID
                        rs.getString(8),                // delivery
                        rs.getString(9),                // image2
                        rs.getString(10)));             // image3
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }
    
    public List<Product> get4AdidasLast() {
    	List<Product> list = new ArrayList<>();
        String query = "select top 4 * from Product\r\n"
        		+ "where cateID = 1\r\n"
        		+ "order by id desc";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Database structure: id, name, image, price, brand, description, cateID, delivery, image2, image3
            	list.add(new Product(rs.getInt(1),      // id
                        rs.getString(2),                // name  
                        rs.getString(3),                // image
                        rs.getDouble(4),                // price
                        rs.getString(5),                // brand (was title)
                        rs.getString(6),                // description
                        rs.getInt(7),                   // cateID
                        rs.getString(8),                // delivery
                        rs.getString(9),                // image2
                        rs.getString(10)));             // image3
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }

    public Account login(String user, String pass) {
        String query = "select * from Account where [user] = ? and pass = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(
                    rs.getInt("uID"), rs.getString("user"), rs.getString("pass"),
                    0, rs.getInt("isAdmin"), rs.getString("email"),
                    rs.getString("fullName"), rs.getString("phone"), rs.getString("address"), rs.getString("province")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // No discount logic for Account
    }

    public Account checkAccountExist(String user) {
        String query = "select * from Account where [user] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(
                    rs.getInt("uID"), rs.getString("user"), rs.getString("pass"),
                    0, rs.getInt("isAdmin"), rs.getString("email"),
                    rs.getString("fullName"), rs.getString("phone"), rs.getString("address"), rs.getString("province")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // No discount logic for Account
    }
    
    public Account checkAccountExistByUsernameAndEmail(String username, String email) {
        String query = "select * from Account\r\n"
        		+ "where [user] = ? or [email] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Database structure: uID, user, pass, isAdmin, fullName, phone, address, province, email
                return new Account(
                    rs.getInt("uID"), rs.getString("user"), rs.getString("pass"),
                    0, rs.getInt("isAdmin"), rs.getString("email"),
                    rs.getString("fullName"), rs.getString("phone"), rs.getString("address"), rs.getString("province")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Review getNewReview(int accountID, int productID) {
        String query = "select top 1 * from Review\r\n"
        		+ "where accountID = ? and productID = ?\r\n"
        		+ "order by maReview desc";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.setInt(2, productID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Review(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void singup(String user, String pass, String email) {
        String query = "insert into Account\n"
                + "values(?,?,0,0,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, email);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteInvoiceByAccountId(String id) {
        String query = "delete from Invoice\n"
                + "where [accountID] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void deleteTongChiTieuBanHangByUserID(String id) {
        String query = "delete from TongChiTieuBanHang\n"
                + "where [userID] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    
    public void deleteProduct(String pid) {
        String query = "delete from Product\n"
                + "where [id] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, pid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void deleteProductBySellID(String id) {
        String query = "delete from Product\n"
                + "where [sell_ID] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void deleteCartByAccountID(int accountID) {
        String query = "delete from Cart \r\n"
        		+ "where [accountID]=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void deleteCartByProductID(String productID) {
        String query = "delete from Cart where [productID]=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, productID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void deleteSoLuongDaBanByProductID(String productID) {
        String query = "delete from SoLuongDaBan where [productID]=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, productID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void deleteReviewByProductID(String productID) {
        String query = "delete from Review where [productID] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, productID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void deleteReviewByAccountID(String id) {
        String query = "delete from Review where [accountID] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void deleteAccount(String id) {
        String query = "delete from Account where uID= ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void deleteSupplier(String idSupplier) {
        String query = "delete from Supplier\r\n"
        		+ "where idSupplier=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, idSupplier);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void deleteCart(int productID) {
        String query = "delete from Cart where productID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, productID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void insertProduct(String name, String image, String price, String brand, String description, String category, String delivery, String image2, String image3) {
        String query = "insert into Product([name],[image],[price],[brand],[description],[cateID],[delivery],[image2],[image3]) values(?,?,?,?,?,?,?,?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setDouble(3, Double.parseDouble(price)); // Correct type
            ps.setString(4, brand);
            ps.setString(5, description);
            ps.setInt(6, Integer.parseInt(category)); // Correct type
            ps.setString(7, delivery);
            ps.setString(8, image2);
            ps.setString(9, image3);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void insertAccount(String user, String pass, String isAdmin, String email) {
        String query = "insert into Account([user], pass, isAdmin, email) values(?,?,?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, isAdmin);
            ps.setString(4, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void insertTongChiTieuBanHang(int userID, double tongChiTieu, double tongBanHang) {
        String query = "insert TongChiTieuBanHang(userID,TongChiTieu,TongBanHang)\r\n"
        		+ "values(?,?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, userID);
            ps.setDouble(2, tongChiTieu);
            ps.setDouble(3, tongBanHang);
        
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void insertSoLuongDaBan(int productID, int soLuongDaBan) {
        String query = "insert SoLuongDaBan(productID,soLuongDaBan)\r\n"
        		+ "values(?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, productID);
            ps.setInt(2, soLuongDaBan);
           
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void insertSupplier(String nameSupplier, String phoneSupplier, String emailSupplier, String addressSupplier, String cateID) {
        String query = "insert Supplier(nameSupplier, phoneSupplier, emailSupplier, addressSupplier, cateID) \r\n"
        		+ "values(?,?,?,?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, nameSupplier);
            ps.setString(2, phoneSupplier);
            ps.setString(3, emailSupplier);
            ps.setString(4, addressSupplier);
            ps.setString(5, cateID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    private static java.sql.Date getCurrentDate() {
        java.util.Date today = new java.util.Date();
        return new java.sql.Date(today.getTime());
    }
  
    public void insertReview(int accountID, int productID, String contentReview) {
        String query = "insert Review(accountID, productID, contentReview, dateReview)\r\n"
        		+ "values(?,?,?,?)";

        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.setInt(2, productID);
            ps.setString(3, contentReview);
            ps.setDate(4,getCurrentDate());
            ps.executeUpdate();
           
        } catch (Exception e) {	
        }
    }
    
    public void insertInvoice(int accountID, double tongGia) {
        String query = "insert Invoice(accountID,tongGia,ngayXuat)\r\n"
        		+ "values(?,?,?)";

        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.setDouble(2, tongGia);
            ps.setDate(3,getCurrentDate());
            ps.executeUpdate();
           
        } catch (Exception e) {	
        	
        }
    }
    
    public void insertCart(int accountID, int productID, int amount, String size) {
        String query = "insert Cart(accountID, productID, amount,size)\r\n"
        		+ "values(?,?,?,?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.setInt(2, productID);
            ps.setInt(3, amount);
            ps.setString(4, size);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void editProduct(String pname, String pimage, String pprice, String ptitle, String pdescription, String pcategory, 
    		String pmodel, String pcolor, 
    		String pdelivery, String pimage2, String pimage3, String pimage4, String pid) {
        String query = "update Product\r\n"
        		+ "set [name] = ?,\r\n"
        		+ "[image] = ?,\r\n"
        		+ "price = ?,\r\n"
        		+ "brand = ?,\r\n"
        		+ "[description] = ?,\r\n"
        		+ "cateID = ?,\r\n"
        		+ "delivery = ?,\r\n"
        		+ "image2 = ?,\r\n"
        		+ "image3 = ?\r\n"
        		+ "where [id] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, pname);
            ps.setString(2, pimage);
            ps.setDouble(3, Double.parseDouble(pprice));
            ps.setString(4, ptitle);
            ps.setString(5, pdescription);
            ps.setInt(6, Integer.parseInt(pcategory));
            ps.setString(7, pdelivery);
            ps.setString(8, pimage2);
            ps.setString(9, pimage3);
            ps.setInt(10, Integer.parseInt(pid));
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Error updating product: " + e.getMessage(), e);
        }
    }
    
    
    public void editProfile(String username, String password, String email, int uID) {
        String query = "update Account set [user]=?,\r\n"
        		+ "[pass]=?,\r\n"
        		+ "[email]=?\r\n"
        		+ "where [uID] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setInt(4, uID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    // Method cập nhật profile với đầy đủ thông tin
    public void editProfileWithFullInfo(String username, String password, String email, 
                                       String fullName, String phone, String address, String province, int uID) {
        String query = "UPDATE Account SET [user]=?, [pass]=?, [email]=?, [fullName]=?, [phone]=?, [address]=?, [province]=? WHERE [uID] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, fullName);
            ps.setString(5, phone);
            ps.setString(6, address);
            ps.setString(7, province);
            ps.setInt(8, uID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Method để lấy chi tiết đơn hàng từ bảng Cart
    public List<Cart> getOrderDetailsByInvoiceId(int invoiceId) {
        List<Cart> list = new ArrayList<>();
        String query = "SELECT c.* FROM Cart c " +
                      "INNER JOIN Invoice i ON c.accountID = i.accountID " +
                      "WHERE i.maHD = ? AND c.amount > 0";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, invoiceId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Cart(
                    rs.getInt("accountID"),
                    rs.getInt("productID"),
                    rs.getInt("amount"),
                    rs.getInt("maCart"),
                    rs.getString("size")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Method để lấy chi tiết đơn hàng (giả lập từ Cart history)
    public List<Cart> getOrderDetailsByInvoiceId(int invoiceId, int accountId) {
        // This method has errors (undefined variable 'limit') and seems unused.
        // Commenting out to prevent compile errors.
        /*
        List<Cart> list = new ArrayList<>();
        String query = "SELECT TOP (?) p.*, i.amount FROM Product p " +
                       "JOIN Invoice i ON p.id = i.productID " +
                       "WHERE i.accountID = ? AND i.status = 'Hoàn thành' " +
                       "ORDER BY i.ngayXuat DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, limit);
            ps.setInt(2, accountId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getDouble("price"),
                    rs.getString("brand"),
                    rs.getString("description"),
                    rs.getInt("cateID"),
                    rs.getString("delivery"),
                    rs.getString("image2"),
                    rs.getString("image3")
                );
                // This logic is flawed as it tries to add a Product to a List<Cart>
                // list.add(product); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
        */
        return new ArrayList<>(); // Return empty list to avoid breaking method signature
    }
    
    // Method để lấy sản phẩm đã mua nhiều nhất
    public List<Product> getTopPurchasedProducts(int accountId, int limit) {
        // This method has constructor errors and seems unused.
        // Commenting out to prevent compile errors.
        /*
        List<Product> list = new ArrayList<>();
        String query = "SELECT TOP (?) p.* FROM Product p " +
                      "INNER JOIN Cart c ON p.id = c.productID " +
                      "INNER JOIN Invoice i ON c.accountID = i.accountID " +
                      "WHERE i.accountID = ? " +
                      "GROUP BY p.id, p.name, p.image, p.price, p.brand, p.description, p.cateID, p.delivery, p.image2, p.image3 " +
                      "ORDER BY SUM(c.amount) DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, limit);
            ps.setInt(2, accountId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7), // Corrected constructor
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
        */
        return new ArrayList<>(); // Return empty list
    }
    
    public void editTongChiTieu(int accountID, double totalMoneyVAT) {
        String query = "update TongChiTieuBanHang set tongChiTieu = tongChiTieu + ? where userID =?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            ps.setDouble(2, totalMoneyVAT);
          
            ps.executeUpdate();
            
        } catch (Exception e) {
        	
        }
    }
    
    public void editSoLuongDaBan(int productID, int soLuongBanThem) {
        String query = "exec dbo.proc_CapNhatSoLuongDaBan ?,?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, productID);
            ps.setInt(2, soLuongBanThem);
          
            ps.executeUpdate();
            
        } catch (Exception e) {
        	
        }
    }
    
    public void editTongBanHang(int sell_ID, double tongTienBanHangThem) {
        String query = "exec dbo.proc_CapNhatTongBanHang ?,?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, sell_ID);
            ps.setDouble(2, tongTienBanHangThem);
          
            ps.executeUpdate();
            
        } catch (Exception e) {
        	
        }
    }
    
    public void editAmountAndSizeCart(int accountID, int productID, int amount, String size) {
        String query = "update Cart set [amount]=?,\r\n"
        		+ "[size]=?\r\n"
        		+ "where [accountID]=? and [productID]=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, amount);
            ps.setString(2, size);
            ps.setInt(3, accountID);
            ps.setInt(4, productID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void editAmountCart(int accountID, int productID, int amount) {
        String query = "update Cart set [amount]=?\r\n"
        		+ "where [accountID]=? and [productID]=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, amount);
            ps.setInt(2, accountID);
            ps.setInt(3, productID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Product> getAllProductByPriceAsc() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product order by price asc";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5), // brand (was title)
                        rs.getString(6),
                        "", // model (removed)
                        "", // color (removed)
                        rs.getString(8), // delivery
                        rs.getString(9), // image2
                        rs.getString(10), // image3
                        "")); // image4 (removed)
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }

    public List<Product> getAllProductByPriceDesc() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product order by price desc";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5), // brand (was title)
                        rs.getString(6),
                        "", // model (removed)
                        "", // color (removed)
                        rs.getString(8), // delivery
                        rs.getString(9), // image2
                        rs.getString(10), // image3
                        "")); // image4 (removed)
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }

    public List<Product> getProductByCategoryPriceAsc(String cid) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product where cateID = ? order by price asc";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, cid);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5), // brand (was title)
                        rs.getString(6),
                        "", // model (removed)
                        "", // color (removed)
                        rs.getString(8), // delivery
                        rs.getString(9), // image2
                        rs.getString(10), // image3
                        "")); // image4 (removed)
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }

    public List<Product> getProductByCategoryPriceDesc(String cid) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product where cateID = ? order by price desc";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, cid);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5), // brand (was title)
                        rs.getString(6),
                        "", // model (removed)
                        "", // color (removed)
                        rs.getString(8), // delivery
                        rs.getString(9), // image2
                        rs.getString(10), // image3
                        "")); // image4 (removed)
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }

   public static void main(String[] args) {
        DAO dao = new DAO();
//        List<Review> list = 
//        	dao.insertProduct("Giày Bóng Đá Nam Bitis Hunter Football","https://product.hstatic.net/1000230642/product/02400vag__1__5d559f914caf4864ad99a37c18cc1a1b_1024x1024.jpg",
//        					"535","Giày Bóng Đá Nam Biti Hunter Football","Với thiết kế năng động, Giày bóng đá Biti's Hunter được tung ra với 5 màu sắc nổi bật tạo điểm nhấn trên sân đấu.",
//        					"3",1,"G39","Yellow","Ho Chi Minh","https://product.hstatic.net/1000230642/product/02400vag__3__3a83e45335054285a27fba37cafb23c1_1024x1024.jpg",
//        					"https://product.hstatic.net/1000230642/product/02400vag__4__d3693ef3babe4fc3a2908d8eb2df6e3b_1024x1024.jpg","https://product.hstatic.net/1000230642/product/02400vag__4__d3693ef3babe4fc3a2908d8eb2df6e3b_1024x1024.jpg");
//        dao.editProduct("Giay chay du lich 2","https://giaygiare.vn/upload/sanpham/nike-sb-dunk-low-eire-net-deep-orange.jpg","301","title 3",
//       		"desciption desciption 3", "1", "G66", "Blue", "Ho Chi Minh", "https://giaygiare.vn/upload/sanpham/nike-sb-dunk-low-eire-net-deep-orange.jpg",
//       		"https://giaygiare.vn/upload/sanpham/nike-sb-dunk-low-eire-net-deep-orange.jpg",
//        		"https://giaygiare.vn/upload/sanpham/nike-sb-dunk-low-eire-net-deep-orange.jpg", "3");

//        List<Invoice> list = dao.searchByNgayXuat("2021-11-20");
//        for (Invoice o : list) 
//        { 
//        	System.out.println(o); 
//        }
//      int s = dao.checkAccountAdmin(1);
//      System.out.println(s);
//      System.out.println("da chay xong");

		/*
		 * for (Review o : list) { System.out.println(o); }
		 */
   }

    public void updatePassword(int accountId, String newPassword) {
        String query = "update Account set [pass]=? where [uID]=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setInt(2, accountId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Product> searchProductByName(String name) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT id, name FROM Product WHERE name LIKE ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        applyDiscountToList(list);
        return list;
    }

    /**
     * Check if email already exists in Account table
     * @param email Email to check
     * @return true if email exists, false otherwise
     */
    public boolean checkEmailExists(String email) {
        String query = "select count(*) from Account where [email] = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }



    // Cập nhật method signup để lưu đầy đủ thông tin vào bảng Account
    public void signupWithFullInfo(String user, String pass, String fullName, String phone, 
                                  String address, String province, String email) {
        String query = "INSERT INTO Account ([user], pass, isAdmin, fullName, phone, address, province, email) " +
                      "VALUES (?, ?, 0, ?, ?, ?, ?, ?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, fullName);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.setString(6, province);
            ps.setString(7, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy thông tin account đầy đủ bao gồm thông tin cá nhân
    public Account getAccountWithFullInfo(int accountID) {
        String query = "SELECT uID, [user], pass, isAdmin, fullName, phone, address, province, email " +
                      "FROM Account WHERE uID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(
                    rs.getInt("uID"), rs.getString("user"), rs.getString("pass"),
                    0, rs.getInt("isAdmin"), rs.getString("email"),
                    rs.getString("fullName"), rs.getString("phone"), rs.getString("address"), rs.getString("province")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // No discount logic
    }
    
    public void updateInvoiceStatus(int maHD, String status) {
        String query = "UPDATE Invoice SET status = ?, deliveryDate = ? WHERE maHD = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            
            // Nếu status = "Hoàn thành" thì set deliveryDate = ngày hiện tại
            if ("Hoàn thành".equals(status)) {
                ps.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis()));
            } else {
                ps.setNull(2, java.sql.Types.TIMESTAMP);
            }
            
            ps.setInt(3, maHD);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateRevenueAndSales(int maHD) {
        String query = "SELECT c.productID, c.amount, p.price, i.accountID " +
                      "FROM Cart c INNER JOIN Product p ON c.productID = p.id " +
                      "INNER JOIN Invoice i ON c.accountID = i.accountID " +
                      "WHERE i.maHD = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, maHD);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                int productID = rs.getInt("productID");
                int amount = rs.getInt("amount");
                
                // Cập nhật số lượng đã bán
                updateSoLuongDaBan(productID, amount);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void updateSoLuongDaBan(int productID, int amount) {
        // Kiểm tra xem productID đã có trong bảng SoLuongDaBan chưa
        String checkQuery = "SELECT soLuongDaBan FROM SoLuongDaBan WHERE productID = ?";
        String updateQuery = "UPDATE SoLuongDaBan SET soLuongDaBan = soLuongDaBan + ? WHERE productID = ?";
        String insertQuery = "INSERT INTO SoLuongDaBan (productID, soLuongDaBan) VALUES (?, ?)";
        
        try {
            // Kiểm tra tồn tại
            ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                // Đã tồn tại, cập nhật
                ps = conn.prepareStatement(updateQuery);
                ps.setInt(1, amount);
                ps.setInt(2, productID);
                ps.executeUpdate();
            } else {
                // Chưa tồn tại, thêm mới
                ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, productID);
                ps.setInt(2, amount);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public int countCompletedInvoices() {
        String query = "SELECT COUNT(*) FROM Invoice WHERE status = N'Hoàn thành'";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void deleteInvoiceById(int maHD) {
        try {
            // Lấy accountID từ Invoice
            String getAccountIdQuery = "SELECT accountID FROM Invoice WHERE maHD = ?";
            ps = conn.prepareStatement(getAccountIdQuery);
            ps.setInt(1, maHD);
            rs = ps.executeQuery();
            int accountID = -1;
            if (rs.next()) {
                accountID = rs.getInt(1);
            }
            // Xóa Invoice trước
            new InvoiceDAO().deleteInvoice(maHD);
            // Sau đó xóa Cart nếu cần
            if (accountID != -1) {
                deleteCartByAccountID(accountID);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Product> getFilteredAndSortedProducts(String cid, String searchKeyword, String sortType, String priceMinStr, String priceMaxStr) {
        List<Product> list = new ArrayList<>();
        
        // First check if the category exists and has products
        if (cid != null && !cid.isEmpty()) {
            try {
                String checkQuery = "SELECT COUNT(*) FROM Product WHERE cateID = ?";
                try (Connection checkConn = new DBContext().getConnection();
                     PreparedStatement checkPs = checkConn.prepareStatement(checkQuery)) {
                    checkPs.setInt(1, Integer.parseInt(cid));
                    ResultSet checkRs = checkPs.executeQuery();
                    if (checkRs.next() && checkRs.getInt(1) == 0) {
                        // If no products in this category, return empty list
                        return list;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                return list;
            }
        }

        StringBuilder query = new StringBuilder("SELECT p.*, " +
            "CASE WHEN d.percentOff IS NOT NULL THEN d.percentOff ELSE 0 END as discountPercent, " +
            "CASE WHEN d.percentOff IS NOT NULL THEN (p.price * (100 - d.percentOff) / 100) ELSE p.price END as salePrice " +
            "FROM Product p " +
            "LEFT JOIN Discount d ON p.id = d.productID AND d.isActive = 1 AND GETDATE() BETWEEN d.startDate AND d.endDate " +
            "WHERE 1=1");

        if (cid != null && !cid.isEmpty()) {
            query.append(" AND p.cateID = ?");
        }
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            query.append(" AND p.name LIKE ?");
        }
        if (priceMinStr != null && !priceMinStr.isEmpty()) {
            query.append(" AND CASE WHEN d.percentOff IS NOT NULL THEN (p.price * (100 - d.percentOff) / 100) ELSE p.price END >= ?");
        }
        if (priceMaxStr != null && !priceMaxStr.isEmpty()) {
            query.append(" AND CASE WHEN d.percentOff IS NOT NULL THEN (p.price * (100 - d.percentOff) / 100) ELSE p.price END <= ?");
        }

        if (sortType != null && !sortType.isEmpty()) {
            switch (sortType) {
                case "az":
                    query.append(" ORDER BY p.name ASC");
                    break;
                case "za":
                    query.append(" ORDER BY p.name DESC");
                    break;
                case "price_asc":
                    query.append(" ORDER BY salePrice ASC");
                    break;
                case "price_desc":
                    query.append(" ORDER BY salePrice DESC");
                    break;
                case "new":
                    query.append(" ORDER BY p.id DESC");
                    break;
                default:
                     query.append(" ORDER BY p.id ASC");
                    break;
            }
        } else {
            query.append(" ORDER BY p.id ASC");
        }

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (cid != null && !cid.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(cid));
            }
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchKeyword + "%");
            }
            if (priceMinStr != null && !priceMinStr.isEmpty()) {
                ps.setDouble(paramIndex++, Double.parseDouble(priceMinStr));
            }
            if (priceMaxStr != null && !priceMaxStr.isEmpty()) {
                ps.setDouble(paramIndex++, Double.parseDouble(priceMaxStr));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int discountPercent = rs.getInt("discountPercent");
                double salePrice = rs.getDouble("salePrice");
                double originalPrice = rs.getDouble("price");
                
                // Debug logging
                System.out.println("Product ID: " + rs.getInt("id") + 
                                 ", Name: " + rs.getString("name") + 
                                 ", Original Price: " + originalPrice + 
                                 ", Discount Percent: " + discountPercent + 
                                 ", Sale Price: " + salePrice);
                
                // Ensure salePrice is not 0 when there's no discount
                if (discountPercent == 0) {
                    salePrice = originalPrice;
                }
                
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        originalPrice,
                        rs.getString("brand"),
                        rs.getString("description"),
                        rs.getInt("cateID"),
                        rs.getString("delivery"),
                        rs.getString("image2"),
                        rs.getString("image3"),
                        discountPercent,
                        salePrice
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
