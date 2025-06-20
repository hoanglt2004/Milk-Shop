/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

public class Account {
    private int id;
    private String user;
    private String pass;
    private int isSell;
    private int isAdmin;
    private String email;
    
    // Các trường mới từ Customer table
    private String fullName;
    private String phone;
    private String address;
    private String province;

    public Account() {
    }

    public Account(int id, String user, String pass, int isSell, int isAdmin, String email) {
        this.id = id;
        this.user = user;
        this.pass = pass;
        this.isSell = isSell;
        this.isAdmin = isAdmin;
        this.email = email;
    }
    
    public Account(int id, String user, String pass, int isSell, int isAdmin, String email,
                   String fullName, String phone, String address, String province) {
        this.id = id;
        this.user = user;
        this.pass = pass;
        this.isSell = isSell;
        this.isAdmin = isAdmin;
        this.email = email;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.province = province;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public int getIsSell() {
        return isSell;
    }

    public void setIsSell(int isSell) {
        this.isSell = isSell;
    }

    public int getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(int isAdmin) {
        this.isAdmin = isAdmin;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    @Override
    public String toString() {
        return "Account{" +
                "id=" + id +
                ", user='" + user + '\'' +
                ", pass='" + pass + '\'' +
                ", isSell=" + isSell +
                ", isAdmin=" + isAdmin +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", province='" + province + '\'' +
                '}';
    }
}
