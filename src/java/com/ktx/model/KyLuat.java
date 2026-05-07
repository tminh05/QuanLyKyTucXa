package com.ktx.model;

import java.util.Date;

public class KyLuat {
    private int idKyLuat;
    private String mssv;
    private Integer idNhanVien;
    private String hinhThuc;
    private String lyDo;
    private Date ngayLap;
    
    // Thêm trường phụ để hiển thị
    private String hoTenSinhVien;
    private String tenNhanVien;
    
    // Constructors
    public KyLuat() {}
    
    public KyLuat(String mssv, String hinhThuc, String lyDo) {
        this.mssv = mssv;
        this.hinhThuc = hinhThuc;
        this.lyDo = lyDo;
    }
    
    // Getters and Setters
    public int getIdKyLuat() {
        return idKyLuat;
    }
    
    public void setIdKyLuat(int idKyLuat) {
        this.idKyLuat = idKyLuat;
    }
    
    public String getMssv() {
        return mssv;
    }
    
    public void setMssv(String mssv) {
        this.mssv = mssv;
    }
    
    public Integer getIdNhanVien() {
        return idNhanVien;
    }
    
    public void setIdNhanVien(Integer idNhanVien) {
        this.idNhanVien = idNhanVien;
    }
    
    public String getHinhThuc() {
        return hinhThuc;
    }
    
    public void setHinhThuc(String hinhThuc) {
        this.hinhThuc = hinhThuc;
    }
    
    public String getLyDo() {
        return lyDo;
    }
    
    public void setLyDo(String lyDo) {
        this.lyDo = lyDo;
    }
    
    public Date getNgayLap() {
        return ngayLap;
    }
    
    public void setNgayLap(Date ngayLap) {
        this.ngayLap = ngayLap;
    }
    
    public String getHoTenSinhVien() {
        return hoTenSinhVien;
    }
    
    public void setHoTenSinhVien(String hoTenSinhVien) {
        this.hoTenSinhVien = hoTenSinhVien;
    }
    
    public String getTenNhanVien() {
        return tenNhanVien;
    }
    
    public void setTenNhanVien(String tenNhanVien) {
        this.tenNhanVien = tenNhanVien;
    }
}