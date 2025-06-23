/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author 
 */
public class Product {
    private int id;
    private String name;
    private String image;
    private double price;
    private String brand;
    private String description;
    private String delivery;
    private String image2;
    private String image3;
	public Product(int id, String name, String image, double price, String brand, String description,
			String delivery, String image2, String image3) {
		
		this.id = id;
		this.name = name;
		this.image = image;
		this.price = price;
		this.brand = brand;
		this.description = description;
		this.delivery = delivery;
		this.image2 = image2;
		this.image3 = image3;
	}
	
	// Constructor tương thích ngược với code cũ
	public Product(int id, String name, String image, double price, String title, String description, String model,
			String color, String delivery, String image2, String image3, String image4) {
		
		this.id = id;
		this.name = name;
		this.image = image;
		this.price = price;
		this.brand = title; // title được map thành brand
		this.description = description;
		this.delivery = delivery;
		this.image2 = image2;
		this.image3 = image3;
		// Bỏ qua model, color, image4 vì không còn trong schema mới
	}
	
	public Product() {
		
	}
	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", image=" + image + ", price=" + price + ", brand=" + brand
				+ ", description=" + description + ", delivery=" + delivery
				+ ", image2=" + image2 + ", image3=" + image3 + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	
	// Getter tương thích ngược cho title
	public String getTitle() {
		return brand;
	}
	public void setTitle(String title) {
		this.brand = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDelivery() {
		return delivery;
	}
	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}
	public String getImage2() {
		return image2;
	}
	public void setImage2(String image2) {
		this.image2 = image2;
	}
	public String getImage3() {
		return image3;
	}
	public void setImage3(String image3) {
		this.image3 = image3;
	}
	
	// Getter/setter tương thích ngược cho các field đã xóa
	public String getModel() {
		return ""; // Trả về empty string vì đã xóa khỏi DB
	}
	public void setModel(String model) {
		// Không làm gì vì field đã bị xóa
	}
	
	public String getColor() {
		return ""; // Trả về empty string vì đã xóa khỏi DB  
	}
	public void setColor(String color) {
		// Không làm gì vì field đã bị xóa
	}
	
	public String getImage4() {
		return ""; // Trả về empty string vì đã xóa khỏi DB
	}
	public void setImage4(String image4) {
		// Không làm gì vì field đã bị xóa
	}
    
	
    
    
}
