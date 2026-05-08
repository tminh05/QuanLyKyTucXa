package com.ktx.model;

public class NhanVien {
    private int idNhanVien;
    private String hoTen;
    private String chucVu;
    private String sdt;
    private String email;
    private String matKhau;
    private String vaiTro;      // ADMIN, NHAN_VIEN
    private String trangThai;    // HOAT_DONG, KHOA
    private String anhDaiDien;
    
    public NhanVien() {}

    public int getIdNhanVien() { return idNhanVien; }
    public void setIdNhanVien(int idNhanVien) { this.idNhanVien = idNhanVien; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getChucVu() { return chucVu; }
    public void setChucVu(String chucVu) { this.chucVu = chucVu; }

    public String getSdt() { return sdt; }
    public void setSdt(String sdt) { this.sdt = sdt; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }

    public String getVaiTro() { return vaiTro; }
    public void setVaiTro(String vaiTro) { this.vaiTro = vaiTro; }
    
    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
    
    public String getAnhDaiDien() { return anhDaiDien; }
    public void setAnhDaiDien(String anhDaiDien) { this.anhDaiDien = anhDaiDien; }

    public boolean isAdmin() {
        return "ADMIN".equals(vaiTro);
    }
    
    public boolean isActive() {
        return "HOAT_DONG".equals(trangThai);
    }

    @Override
    public String toString() {
        return hoTen + " (" + chucVu + ")";
    }
}