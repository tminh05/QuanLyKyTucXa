package com.ktx.model;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

public class HopDong {
    private int idHopDong;
    private String mssv;
    private int idPhong;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ngayBatDau;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ngayKetThuc;
    
    private String trangThai;
    
    // Thêm các trường phụ để hiển thị
    private String hoTenSinhVien;
    private String tenPhong;
    private double giaPhong;
    
    // Constructors
    public HopDong() {}
    
    public HopDong(String mssv, int idPhong, Date ngayBatDau, Date ngayKetThuc) {
        this.mssv = mssv;
        this.idPhong = idPhong;
        this.ngayBatDau = ngayBatDau;
        this.ngayKetThuc = ngayKetThuc;
        this.trangThai = "Hiệu lực";
    }
    
    // Getters and Setters
    public int getIdHopDong() {
        return idHopDong;
    }
    
    public void setIdHopDong(int idHopDong) {
        this.idHopDong = idHopDong;
    }
    
    public String getMssv() {
        return mssv;
    }
    
    public void setMssv(String mssv) {
        this.mssv = mssv;
    }
    
    public int getIdPhong() {
        return idPhong;
    }
    
    public void setIdPhong(int idPhong) {
        this.idPhong = idPhong;
    }
    
    public Date getNgayBatDau() {
        return ngayBatDau;
    }
    
    public void setNgayBatDau(Date ngayBatDau) {
        this.ngayBatDau = ngayBatDau;
    }
    
    public Date getNgayKetThuc() {
        return ngayKetThuc;
    }
    
    public void setNgayKetThuc(Date ngayKetThuc) {
        this.ngayKetThuc = ngayKetThuc;
    }
    
    public String getTrangThai() {
        return trangThai;
    }
    
    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    
    public String getHoTenSinhVien() {
        return hoTenSinhVien;
    }
    
    public void setHoTenSinhVien(String hoTenSinhVien) {
        this.hoTenSinhVien = hoTenSinhVien;
    }
    
    public String getTenPhong() {
        return tenPhong;
    }
    
    public void setTenPhong(String tenPhong) {
        this.tenPhong = tenPhong;
    }
    
    public double getGiaPhong() {
        return giaPhong;
    }
    
    public void setGiaPhong(double giaPhong) {
        this.giaPhong = giaPhong;
    }
    
    // Kiểm tra hợp đồng còn hiệu lực không
    public boolean isActive() {
        Date today = new Date();
        return "Hiệu lực".equals(trangThai) && 
               ngayBatDau.before(today) && 
               ngayKetThuc.after(today);
    }
    
    // Kiểm tra hợp đồng sắp hết hạn (trong 30 ngày)
    public boolean isExpiringSoon() {
        Date today = new Date();
        long diff = ngayKetThuc.getTime() - today.getTime();
        long days = diff / (1000 * 60 * 60 * 24);
        return days <= 30 && days > 0;
    }
    
    @Override
    public String toString() {
        return "Hợp đồng " + idHopDong + " - " + mssv;
    }
}