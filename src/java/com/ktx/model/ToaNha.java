package com.ktx.model;

public class ToaNha {
    private int idToaNha;
    private String tenToaNha;
    private int soTang;
    private String loaiToaNha;
    
    // Constructors
    public ToaNha() {}
    
    public ToaNha(String tenToaNha, int soTang, String loaiToaNha) {
        this.tenToaNha = tenToaNha;
        this.soTang = soTang;
        this.loaiToaNha = loaiToaNha;
    }
    
    // Getters and Setters
    public int getIdToaNha() {
        return idToaNha;
    }
    
    public void setIdToaNha(int idToaNha) {
        this.idToaNha = idToaNha;
    }
    
    public String getTenToaNha() {
        return tenToaNha;
    }
    
    public void setTenToaNha(String tenToaNha) {
        this.tenToaNha = tenToaNha;
    }
    
    public int getSoTang() {
        return soTang;
    }
    
    public void setSoTang(int soTang) {
        this.soTang = soTang;
    }
    
    public String getLoaiToaNha() {
        return loaiToaNha;
    }
    
    public void setLoaiToaNha(String loaiToaNha) {
        this.loaiToaNha = loaiToaNha;
    }
    
    @Override
    public String toString() {
        return tenToaNha;
    }
}