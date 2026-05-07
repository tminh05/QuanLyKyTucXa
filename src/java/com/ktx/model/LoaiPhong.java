package com.ktx.model;

public class LoaiPhong {
    private int idLoaiPhong;
    private String tenLoai;
    private double giaPhong;
    
    // Constructors
    public LoaiPhong() {}
    
    public LoaiPhong(String tenLoai, double giaPhong) {
        this.tenLoai = tenLoai;
        this.giaPhong = giaPhong;
    }
    
    // Getters and Setters
    public int getIdLoaiPhong() {
        return idLoaiPhong;
    }
    
    public void setIdLoaiPhong(int idLoaiPhong) {
        this.idLoaiPhong = idLoaiPhong;
    }
    
    public String getTenLoai() {
        return tenLoai;
    }
    
    public void setTenLoai(String tenLoai) {
        this.tenLoai = tenLoai;
    }
    
    public double getGiaPhong() {
        return giaPhong;
    }
    
    public void setGiaPhong(double giaPhong) {
        this.giaPhong = giaPhong;
    }
    
    @Override
    public String toString() {
        return tenLoai + " - " + String.format("%,.0f VNĐ", giaPhong) + "/tháng";
    }
}