package com.ktx.model;

import java.time.LocalDate;

public class BaiViet {
    private int idBaiViet;
    private String tieuDe;
    private String tomTat;
    private String noiDung;
    private String anhDaiDien;
    private String loaiBaiViet;
    private LocalDate ngayDang;
    private int luotXem;

    public BaiViet() {}

    public BaiViet(int idBaiViet, String tieuDe, String tomTat, String noiDung,
                   String anhDaiDien, String loaiBaiViet, LocalDate ngayDang, int luotXem) {
        this.idBaiViet   = idBaiViet;
        this.tieuDe      = tieuDe;
        this.tomTat      = tomTat;
        this.noiDung     = noiDung;
        this.anhDaiDien  = anhDaiDien;
        this.loaiBaiViet = loaiBaiViet;
        this.ngayDang    = ngayDang;
        this.luotXem     = luotXem;
    }

    public int getIdBaiViet()              { return idBaiViet; }
    public void setIdBaiViet(int v)        { this.idBaiViet = v; }
    public String getTieuDe()             { return tieuDe; }
    public void setTieuDe(String v)       { this.tieuDe = v; }
    public String getTomTat()             { return tomTat; }
    public void setTomTat(String v)       { this.tomTat = v; }
    public String getNoiDung()            { return noiDung; }
    public void setNoiDung(String v)      { this.noiDung = v; }
    public String getAnhDaiDien()         { return anhDaiDien; }
    public void setAnhDaiDien(String v)   { this.anhDaiDien = v; }
    public String getLoaiBaiViet()        { return loaiBaiViet; }
    public void setLoaiBaiViet(String v)  { this.loaiBaiViet = v; }
    public LocalDate getNgayDang()        { return ngayDang; }
    public void setNgayDang(LocalDate v)  { this.ngayDang = v; }
    public int getLuotXem()               { return luotXem; }
    public void setLuotXem(int v)         { this.luotXem = v; }

    public String getTenLoai() {
        if (loaiBaiViet == null) return "";
        switch (loaiBaiViet) {
            case "tin-tuc":   return "Tin tức & Sự kiện";
            case "thong-bao": return "Thông báo";
            case "noi-quy":   return "Nội quy & Quy định";
            default:          return loaiBaiViet;
        }
    }
}