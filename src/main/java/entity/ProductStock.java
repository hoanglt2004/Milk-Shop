package entity;

import java.util.Date;

public class ProductStock {
    private int productID;
    private String productName;
    private int totalRemaining;
    private Date lastStockDate; // Ngày bắt đầu hết hàng (remainingQuantity = 0)
    private int daysRemaining; // Số ngày còn lại trước khi tự động xóa (5-0)

    public ProductStock() {
    }

    public ProductStock(int productID, String productName, int totalRemaining) {
        this.productID = productID;
        this.productName = productName;
        this.totalRemaining = totalRemaining;
    }
    
    public ProductStock(int productID, String productName, int totalRemaining, Date lastStockDate, int daysRemaining) {
        this.productID = productID;
        this.productName = productName;
        this.totalRemaining = totalRemaining;
        this.lastStockDate = lastStockDate;
        this.daysRemaining = daysRemaining;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getTotalRemaining() {
        return totalRemaining;
    }

    public void setTotalRemaining(int totalRemaining) {
        this.totalRemaining = totalRemaining;
    }
    
    public Date getLastStockDate() {
        return lastStockDate;
    }

    public void setLastStockDate(Date lastStockDate) {
        this.lastStockDate = lastStockDate;
    }

    public int getDaysRemaining() {
        return daysRemaining;
    }

    public void setDaysRemaining(int daysRemaining) {
        this.daysRemaining = daysRemaining;
    }
}