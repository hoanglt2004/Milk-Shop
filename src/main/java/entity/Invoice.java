package entity;

import java.sql.Date;

public class Invoice {
	private int maHD;
	private int accountID;
	private double tongGia;
	private Date ngayXuat;
	private String status;
	private Date deliveryDate;

	public Invoice() {
	}

	public Invoice(int maHD, int accountID, double tongGia, Date ngayXuat) {
		this.maHD = maHD;
		this.accountID = accountID;
		this.tongGia = tongGia;
		this.ngayXuat = ngayXuat;
		this.status = "Chờ xác nhận";
	}

	public Invoice(int maHD, int accountID, double tongGia, Date ngayXuat, String status, Date deliveryDate) {
		this.maHD = maHD;
		this.accountID = accountID;
		this.tongGia = tongGia;
		this.ngayXuat = ngayXuat;
		this.status = status;
		this.deliveryDate = deliveryDate;
	}

	public int getMaHD() {
		return maHD;
	}

	public void setMaHD(int maHD) {
		this.maHD = maHD;
	}

	public int getAccountID() {
		return accountID;
	}

	public void setAccountID(int accountID) {
		this.accountID = accountID;
	}

	public double getTongGia() {
		return tongGia;
	}

	public void setTongGia(double tongGia) {
		this.tongGia = tongGia;
	}

	public Date getNgayXuat() {
		return ngayXuat;
	}

	public void setNgayXuat(Date ngayXuat) {
		this.ngayXuat = ngayXuat;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}

	@Override
	public String toString() {
		return "Invoice [maHD=" + maHD + ", accountID=" + accountID + ", tongGia=" + tongGia 
				+ ", ngayXuat=" + ngayXuat + ", status=" + status + ", deliveryDate=" + deliveryDate + "]";
	}
}
