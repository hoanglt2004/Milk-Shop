package entity;

import java.util.Date;

public class Warehouse {
    private int warehouseID;
    private int productID;
    private int quantity;
    private Date importDate;
    private int remainingQuantity;
    private Product product; // Thêm quan hệ với Product

    public Warehouse() {
    }

    public Warehouse(int warehouseID, int productID, int quantity, Date importDate, int remainingQuantity) {
        this.warehouseID = warehouseID;
        this.productID = productID;
        this.quantity = quantity;
        this.importDate = importDate;
        this.remainingQuantity = remainingQuantity;
    }

    // Getters and Setters
    public int getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(int warehouseID) {
        this.warehouseID = warehouseID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public int getRemainingQuantity() {
        return remainingQuantity;
    }

    public void setRemainingQuantity(int remainingQuantity) {
        this.remainingQuantity = remainingQuantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
} 