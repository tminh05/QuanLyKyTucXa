package com.ktx.model;

import java.util.Date;

public class MuonSach {
    private int idMuonSach;
    private String mssv;
    private String hoTen;
    private int idSach;
    private String tenSach;
    private Date ngayMuon;
    private Date ngayHenTra;
    private Date ngayTraThuc;
    private String trangThai;

    public MuonSach() {}

    public int getIdMuonSach() { return idMuonSach; }
    public void setIdMuonSach(int idMuonSach) { this.idMuonSach = idMuonSach; }

    public String getMssv() { return mssv; }
    public void setMssv(String mssv) { this.mssv = mssv; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public int getIdSach() { return idSach; }
    public void setIdSach(int idSach) { this.idSach = idSach; }

    public String getTenSach() { return tenSach; }
    public void setTenSach(String tenSach) { this.tenSach = tenSach; }

    public Date getNgayMuon() { return ngayMuon; }
    public void setNgayMuon(Date ngayMuon) { this.ngayMuon = ngayMuon; }

    public Date getNgayHenTra() { return ngayHenTra; }
    public void setNgayHenTra(Date ngayHenTra) { this.ngayHenTra = ngayHenTra; }

    public Date getNgayTraThuc() { return ngayTraThuc; }
    public void setNgayTraThuc(Date ngayTraThuc) { this.ngayTraThuc = ngayTraThuc; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
}