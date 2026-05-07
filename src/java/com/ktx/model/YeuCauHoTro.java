package com.ktx.model;

import java.util.Date;

public class YeuCauHoTro {
    private int idYeuCau;
    private String mssv;
    private String hoTen;
    private Date ngaySinh;
    private String gioiTinh;
    private String cccd;
    private String lop;
    private String sdt;
    private String email;
    private String diaChi;
    private String loaiGiayTo;
    private String loaiChinhSach;
    private String moTa;
    private String trangThai;
    private Date ngayNop;

    public YeuCauHoTro() {}

    public int getIdYeuCau() { return idYeuCau; }
    public void setIdYeuCau(int idYeuCau) { this.idYeuCau = idYeuCau; }

    public String getMssv() { return mssv; }
    public void setMssv(String mssv) { this.mssv = mssv; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public Date getNgaySinh() { return ngaySinh; }
    public void setNgaySinh(Date ngaySinh) { this.ngaySinh = ngaySinh; }

    public String getGioiTinh() { return gioiTinh; }
    public void setGioiTinh(String gioiTinh) { this.gioiTinh = gioiTinh; }

    public String getCccd() { return cccd; }
    public void setCccd(String cccd) { this.cccd = cccd; }

    public String getLop() { return lop; }
    public void setLop(String lop) { this.lop = lop; }

    public String getSdt() { return sdt; }
    public void setSdt(String sdt) { this.sdt = sdt; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDiaChi() { return diaChi; }
    public void setDiaChi(String diaChi) { this.diaChi = diaChi; }

    public String getLoaiGiayTo() { return loaiGiayTo; }
    public void setLoaiGiayTo(String loaiGiayTo) { this.loaiGiayTo = loaiGiayTo; }

    public String getLoaiChinhSach() { return loaiChinhSach; }
    public void setLoaiChinhSach(String loaiChinhSach) { this.loaiChinhSach = loaiChinhSach; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public Date getNgayNop() { return ngayNop; }
    public void setNgayNop(Date ngayNop) { this.ngayNop = ngayNop; }
}