package com.ktx.model;

public class HoaDon {
    private int idHoaDon;
    private int idPhong;
    private Integer idNhanVien;
    private String kyHoaDon;
    private int chiSoDienCu;
    private int chiSoDienMoi;
    private int chiSoNuocCu;
    private int chiSoNuocMoi;
    private double tongTien;
    private String trangThai;
    
    // Thêm các trường phụ để hiển thị
    private String tenPhong;
    private String tenNhanVien;
    
    // Các hằng số giá
    private static final double GIA_DIEN = 3000; // 3000đ/số
    private static final double GIA_NUOC = 15000; // 15000đ/m3
    
    // Constructors
    public HoaDon() {}
    
    public HoaDon(int idPhong, String kyHoaDon, int chiSoDienCu, int chiSoDienMoi, 
                  int chiSoNuocCu, int chiSoNuocMoi) {
        this.idPhong = idPhong;
        this.kyHoaDon = kyHoaDon;
        this.chiSoDienCu = chiSoDienCu;
        this.chiSoDienMoi = chiSoDienMoi;
        this.chiSoNuocCu = chiSoNuocCu;
        this.chiSoNuocMoi = chiSoNuocMoi;
        this.trangThai = "Chưa thanh toán";
        this.tongTien = tinhTongTien();
    }
    
    // Getters and Setters
    public int getIdHoaDon() {
        return idHoaDon;
    }
    
    public void setIdHoaDon(int idHoaDon) {
        this.idHoaDon = idHoaDon;
    }
    
    public int getIdPhong() {
        return idPhong;
    }
    
    public void setIdPhong(int idPhong) {
        this.idPhong = idPhong;
    }
    
    public Integer getIdNhanVien() {
        return idNhanVien;
    }
    
    public void setIdNhanVien(Integer idNhanVien) {
        this.idNhanVien = idNhanVien;
    }
    
    public String getKyHoaDon() {
        return kyHoaDon;
    }
    
    public void setKyHoaDon(String kyHoaDon) {
        this.kyHoaDon = kyHoaDon;
    }
    
    public int getChiSoDienCu() {
        return chiSoDienCu;
    }
    
    public void setChiSoDienCu(int chiSoDienCu) {
        this.chiSoDienCu = chiSoDienCu;
    }
    
    public int getChiSoDienMoi() {
        return chiSoDienMoi;
    }
    
    public void setChiSoDienMoi(int chiSoDienMoi) {
        this.chiSoDienMoi = chiSoDienMoi;
    }
    
    public int getChiSoNuocCu() {
        return chiSoNuocCu;
    }
    
    public void setChiSoNuocCu(int chiSoNuocCu) {
        this.chiSoNuocCu = chiSoNuocCu;
    }
    
    public int getChiSoNuocMoi() {
        return chiSoNuocMoi;
    }
    
    public void setChiSoNuocMoi(int chiSoNuocMoi) {
        this.chiSoNuocMoi = chiSoNuocMoi;
    }
    
    public double getTongTien() {
        return tongTien;
    }
    
    public void setTongTien(double tongTien) {
        this.tongTien = tongTien;
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
    
    public String getTenNhanVien() {
        return tenNhanVien;
    }
    
    public void setTenNhanVien(String tenNhanVien) {
        this.tenNhanVien = tenNhanVien;
    }
    
    // Tính số điện đã sử dụng
    public int getSoDienSuDung() {
        return chiSoDienMoi - chiSoDienCu;
    }
    
    // Tính số nước đã sử dụng
    public int getSoNuocSuDung() {
        return chiSoNuocMoi - chiSoNuocCu;
    }
    
    // Tính tiền điện
    public double tinhTienDien() {
        return getSoDienSuDung() * GIA_DIEN;
    }
    
    // Tính tiền nước
    public double tinhTienNuoc() {
        return getSoNuocSuDung() * GIA_NUOC;
    }
    
    // Tính tổng tiền
    public double tinhTongTien() {
        return tinhTienDien() + tinhTienNuoc();
    }
    
    // Kiểm tra đã thanh toán chưa
    public boolean isPaid() {
        return "Đã thanh toán".equals(trangThai);
    }
    
    @Override
    public String toString() {
        return "Hóa đơn " + kyHoaDon + " - Phòng " + tenPhong;
    }
}