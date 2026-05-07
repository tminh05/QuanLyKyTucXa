package com.ktx.model;

import java.util.Date;

public class DanhGia {
    private int idDanhGia;
    private String mssv;
    private String hoTen;
    private String noiDung;
    private int soSao;
    private int soLike;
    private String tag;
    private Date ngayDang;

    public DanhGia() {}

    public int getIdDanhGia() { return idDanhGia; }
    public void setIdDanhGia(int idDanhGia) { this.idDanhGia = idDanhGia; }

    public String getMssv() { return mssv; }
    public void setMssv(String mssv) { this.mssv = mssv; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }

    public int getSoSao() { return soSao; }
    public void setSoSao(int soSao) { this.soSao = soSao; }

    public int getSoLike() { return soLike; }
    public void setSoLike(int soLike) { this.soLike = soLike; }

    public String getTag() { return tag; }
    public void setTag(String tag) { this.tag = tag; }

    public Date getNgayDang() { return ngayDang; }
    public void setNgayDang(Date ngayDang) { this.ngayDang = ngayDang; }
}