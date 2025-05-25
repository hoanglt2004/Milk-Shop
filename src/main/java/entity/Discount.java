package entity;

import java.util.Date;

public class Discount {
    private int discountID;
    private int productID;
    private int percentOff;
    private Date startDate;
    private Date endDate;
    private boolean isActive;
    private Product product; // Thêm quan hệ với Product

    public Discount() {
    }

    public Discount(int discountID, int productID, int percentOff, Date startDate, Date endDate, boolean isActive) {
        this.discountID = discountID;
        this.productID = productID;
        this.percentOff = percentOff;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getDiscountID() {
        return discountID;
    }

    public void setDiscountID(int discountID) {
        this.discountID = discountID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getPercentOff() {
        return percentOff;
    }

    public void setPercentOff(int percentOff) {
        this.percentOff = percentOff;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
} 