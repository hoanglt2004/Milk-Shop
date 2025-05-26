package entity;

public class ProductStock {
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
}