package com.ktx.model;

public class ThietBi {
    private int idThietBi;
    private int idPhong;
    private String tenThietBi;
    private int soLuong;
    private String tinhTrang;
    
    // Constructors
    public ThietBi() {}
    
    public ThietBi(int idPhong, String tenThietBi, int soLuong, String tinhTrang) {
        this.idPhong = idPhong;
        this.tenThietBi = tenThietBi;
        this.soLuong = soLuong;
        this.tinhTrang = tinhTrang;
    }
    
    // Getters and Setters
    public int getIdThietBi() {
        return idThietBi;
    }
    
    public void setIdThietBi(int idThietBi) {
        this.idThietBi = idThietBi;
    }
    
    public int getIdPhong() {
        return idPhong;
    }
    
    public void setIdPhong(int idPhong) {
        this.idPhong = idPhong;
    }
    
    public String getTenThietBi() {
        return tenThietBi;
    }
    
    public void setTenThietBi(String tenThietBi) {
        this.tenThietBi = tenThietBi;
    }
    
    public int getSoLuong() {
        return soLuong;
    }
    
    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }
    
    public String getTinhTrang() {
        return tinhTrang;
    }
    
    public void setTinhTrang(String tinhTrang) {
        this.tinhTrang = tinhTrang;
    }
}