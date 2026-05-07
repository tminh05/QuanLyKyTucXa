package com.ktx.model;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

public class SinhVien {
    
    private String mssv;
    private String hoTen;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ngaySinh;
    
    private String gioiTinh;
    private String sdt;
    private String email;
    private String lop;
    private String khoa;
    private String cccd;
    private String matKhau;
    
    public SinhVien() {}
    
    public SinhVien(String mssv, String hoTen, Date ngaySinh, String gioiTinh,
                    String sdt, String email, String lop, String khoa, String cccd, String matKhau) {
        this.mssv = mssv;
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.sdt = sdt;
        this.email = email;
        this.lop = lop;
        this.khoa = khoa;
        this.cccd = cccd;
        this.matKhau = matKhau;
    }
    
    public String getMssv() { return mssv; }
    public void setMssv(String mssv) { this.mssv = mssv; }
    
    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }
    
    public Date getNgaySinh() { return ngaySinh; }
    public void setNgaySinh(Date ngaySinh) { this.ngaySinh = ngaySinh; }
    
    public String getGioiTinh() { return gioiTinh; }
    public void setGioiTinh(String gioiTinh) { this.gioiTinh = gioiTinh; }
    
    public String getSdt() { return sdt; }
    public void setSdt(String sdt) { this.sdt = sdt; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getLop() { return lop; }
    public void setLop(String lop) { this.lop = lop; }
    
    public String getKhoa() { return khoa; }
    public void setKhoa(String khoa) { this.khoa = khoa; }
    
    public String getCccd() { return cccd; }
    public void setCccd(String cccd) { this.cccd = cccd; }
    
    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }
    
    @Override
    public String toString() {
        return "SinhVien{" +
                "mssv='" + mssv + '\'' +
                ", hoTen='" + hoTen + '\'' +
                ", lop='" + lop + '\'' +
                ", khoa='" + khoa + '\'' +
                '}';
    }

    public int getIdPhong() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}