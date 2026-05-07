package com.ktx.model;

import java.util.Date;

public class ThanhToan {
    private int idThanhToan;
    private int idHoaDon;
    private Date ngayThanhToan;
    private double soTienDaTra;
    private String phuongThuc;
    
    // Constructors
    public ThanhToan() {}
    
    public ThanhToan(int idHoaDon, double soTienDaTra, String phuongThuc) {
        this.idHoaDon = idHoaDon;
        this.soTienDaTra = soTienDaTra;
        this.phuongThuc = phuongThuc;
    }
    
    // Getters and Setters
    public int getIdThanhToan() {
        return idThanhToan;
    }
    
    public void setIdThanhToan(int idThanhToan) {
        this.idThanhToan = idThanhToan;
    }
    
    public int getIdHoaDon() {
        return idHoaDon;
    }
    
    public void setIdHoaDon(int idHoaDon) {
        this.idHoaDon = idHoaDon;
    }
    
    public Date getNgayThanhToan() {
        return ngayThanhToan;
    }
    
    public void setNgayThanhToan(Date ngayThanhToan) {
        this.ngayThanhToan = ngayThanhToan;
    }
    
    public double getSoTienDaTra() {
        return soTienDaTra;
    }
    
    public void setSoTienDaTra(double soTienDaTra) {
        this.soTienDaTra = soTienDaTra;
    }
    
    public String getPhuongThuc() {
        return phuongThuc;
    }
    
    public void setPhuongThuc(String phuongThuc) {
        this.phuongThuc = phuongThuc;
    }
}