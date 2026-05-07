package com.ktx.model;

import java.util.Date;

public class YeuCauBaoTri {
    private int idYeuCau;
    private int idPhong;
    private String mssv;
    private Integer idNhanVien;
    private String noiDung;
    private Date ngayTao;
    private Date ngayCapNhat;
    private String trangThai;
    
    // Thêm các trường phụ để hiển thị
    private String tenPhong;
    private String hoTenSinhVien;
    private String tenNhanVien;
    
    // Constructors
    public YeuCauBaoTri() {}
    
    public YeuCauBaoTri(int idPhong, String mssv, String noiDung) {
        this.idPhong = idPhong;
        this.mssv = mssv;
        this.noiDung = noiDung;
        this.trangThai = "Chờ xử lý";
    }
    
    // Getters and Setters
    public int getIdYeuCau() {
        return idYeuCau;
    }
    
    public void setIdYeuCau(int idYeuCau) {
        this.idYeuCau = idYeuCau;
    }
    
    public int getIdPhong() {
        return idPhong;
    }
    
    public void setIdPhong(int idPhong) {
        this.idPhong = idPhong;
    }
    
    public String getMssv() {
        return mssv;
    }
    
    public void setMssv(String mssv) {
        this.mssv = mssv;
    }
    
    public Integer getIdNhanVien() {
        return idNhanVien;
    }
    
    public void setIdNhanVien(Integer idNhanVien) {
        this.idNhanVien = idNhanVien;
    }
    
    public String getNoiDung() {
        return noiDung;
    }
    
    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }
    
    public Date getNgayTao() {
        return ngayTao;
    }
    
    public void setNgayTao(Date ngayTao) {
        this.ngayTao = ngayTao;
    }
    
    public Date getNgayCapNhat() {
        return ngayCapNhat;
    }
    
    public void setNgayCapNhat(Date ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }
    
    public String getTrangThai() {
        return trangThai;
    }
    
    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    
    public String getTenPhong() {
        return tenPhong;
    }
    
    public void setTenPhong(String tenPhong) {
        this.tenPhong = tenPhong;
    }
    
    public String getHoTenSinhVien() {
        return hoTenSinhVien;
    }
    
    public void setHoTenSinhVien(String hoTenSinhVien) {
        this.hoTenSinhVien = hoTenSinhVien;
    }
    
    public String getTenNhanVien() {
        return tenNhanVien;
    }
    
    public void setTenNhanVien(String tenNhanVien) {
        this.tenNhanVien = tenNhanVien;
    }
    
    // Kiểm tra trạng thái
    public boolean isPending() {
        return "Chờ xử lý".equals(trangThai);
    }
    
    public boolean isProcessing() {
        return "Đang xử lý".equals(trangThai);
    }
    
    public boolean isCompleted() {
        return "Hoàn thành".equals(trangThai);
    }
    
    public boolean isCancelled() {
        return "Đã hủy".equals(trangThai);
    }
    
    // Tính thời gian xử lý (ngày)
    public Long getProcessTime() {
        if (ngayCapNhat != null && trangThai.equals("Hoàn thành")) {
            long diff = ngayCapNhat.getTime() - ngayTao.getTime();
            return diff / (1000 * 60 * 60 * 24);
        }
        return null;
    }
    
    @Override
    public String toString() {
        return "Yêu cầu bảo trì #" + idYeuCau + " - " + trangThai;
    }
}