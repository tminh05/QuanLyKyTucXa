package com.ktx.model;

public class NhanVien {
    private int idNhanVien;
    private String hoTen;
    private String chucVu;
    private String sdt;
    private String email;
    private String matKhau;
    
    // Constructors
    public NhanVien() {}
    
    public NhanVien(String hoTen, String chucVu, String sdt, String email, String matKhau) {
        this.hoTen = hoTen;
        this.chucVu = chucVu;
        this.sdt = sdt;
        this.email = email;
        this.matKhau = matKhau;
    }
    
    // Getters and Setters
    public int getIdNhanVien() {
        return idNhanVien;
    }
    
    public void setIdNhanVien(int idNhanVien) {
        this.idNhanVien = idNhanVien;
    }
    
    public String getHoTen() {
        return hoTen;
    }
    
    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }
    
    public String getChucVu() {
        return chucVu;
    }
    
    public void setChucVu(String chucVu) {
        this.chucVu = chucVu;
    }
    
    public String getSdt() {
        return sdt;
    }
    
    public void setSdt(String sdt) {
        this.sdt = sdt;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getMatKhau() {
        return matKhau;
    }
    
    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }
    
    // Kiểm tra có phải quản lý không
    public boolean isManager() {
        return "Quản lý".equals(chucVu);
    }
    
    @Override
    public String toString() {
        return hoTen + " (" + chucVu + ")";
    }
}