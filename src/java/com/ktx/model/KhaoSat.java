package com.ktx.model;

import java.time.LocalDateTime;

public class KhaoSat {
    private int idKhaoSat;
    private String hoTen;
    private String lop;
    private String mssv;
    private String gmail;
    private int cau1, cau2, cau3, cau4, cau5;
    private int cau6, cau7, cau8, cau9, cau10;
    private int danhGiaSao; 
    private String yKien;
    private LocalDateTime ngayGui;

    // Constructor mặc định
    public KhaoSat() {}

    // Getter và Setter cho idKhaoSat
    public int getIdKhaoSat() { return idKhaoSat; }
    public void setIdKhaoSat(int v) { this.idKhaoSat = v; }

    // Getter và Setter cho hoTen
    public String getHoTen() { return hoTen; }
    public void setHoTen(String v) { this.hoTen = v; }

    // Getter và Setter cho lop
    public String getLop() { return lop; }
    public void setLop(String v) { this.lop = v; }

    // Getter và Setter cho mssv (Dùng để map vào cột MaSV trong SQL)
    public String getMssv() { return mssv; }
    public void setMssv(String v) { this.mssv = v; }

    // Getter và Setter cho gmail (Dùng để map vào cột Email trong SQL)
    public String getGmail() { return gmail; }
    public void setGmail(String v) { this.gmail = v; }

    // Getter và Setter cho các câu hỏi từ 1 đến 10
    public int getCau1() { return cau1; }
    public void setCau1(int v) { this.cau1 = v; }

    public int getCau2() { return cau2; }
    public void setCau2(int v) { this.cau2 = v; }

    public int getCau3() { return cau3; }
    public void setCau3(int v) { this.cau3 = v; }

    public int getCau4() { return cau4; }
    public void setCau4(int v) { this.cau4 = v; }

    public int getCau5() { return cau5; }
    public void setCau5(int v) { this.cau5 = v; }

    public int getCau6() { return cau6; }
    public void setCau6(int v) { this.cau6 = v; }

    public int getCau7() { return cau7; }
    public void setCau7(int v) { this.cau7 = v; }

    public int getCau8() { return cau8; }
    public void setCau8(int v) { this.cau8 = v; }

    public int getCau9() { return cau9; }
    public void setCau9(int v) { this.cau9 = v; }

    public int getCau10() { return cau10; }
    public void setCau10(int v) { this.cau10 = v; }

    // Getter và Setter cho danhGiaSao (Bắt buộc vì SQL để NOT NULL)
    public int getDanhGiaSao() { return danhGiaSao; }
    public void setDanhGiaSao(int v) { this.danhGiaSao = v; }

    // Getter và Setter cho yKien (Dùng để map vào cột YKienRieng trong SQL)
    public String getYKien() { return yKien; }
    public void setYKien(String v) { this.yKien = v; }

    // Getter và Setter cho ngayGui
    public LocalDateTime getNgayGui() { return ngayGui; }
    public void setNgayGui(LocalDateTime v) { this.ngayGui = v; }
}