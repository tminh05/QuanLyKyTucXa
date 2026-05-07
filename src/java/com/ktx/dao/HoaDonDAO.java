package com.ktx.dao;

import com.ktx.model.HoaDon;
import com.ktx.model.ThanhToan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class HoaDonDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // RowMapper cho HoaDon
    private RowMapper<HoaDon> hoaDonRowMapper = (rs, rowNum) -> {
        HoaDon hd = new HoaDon();
        hd.setIdHoaDon(rs.getInt("ID_HoaDon"));
        hd.setIdPhong(rs.getInt("ID_Phong"));
        hd.setIdNhanVien(rs.getInt("ID_NhanVien"));
        hd.setKyHoaDon(rs.getString("KyHoaDon"));
        hd.setChiSoDienCu(rs.getInt("ChiSoDienCu"));
        hd.setChiSoDienMoi(rs.getInt("ChiSoDienMoi"));
        hd.setChiSoNuocCu(rs.getInt("ChiSoNuocCu"));
        hd.setChiSoNuocMoi(rs.getInt("ChiSoNuocMoi"));
        hd.setTongTien(rs.getDouble("TongTien"));
        hd.setTrangThai(rs.getString("TrangThai"));
        try {
            hd.setTenPhong(rs.getString("TenPhong"));
        } catch (SQLException e) {}
        try {
            hd.setTenNhanVien(rs.getString("HoTen"));
        } catch (SQLException e) {}
        return hd;
    };
    
    // RowMapper cho ThanhToan (THÊM VÀO)
    private RowMapper<ThanhToan> thanhToanRowMapper = (rs, rowNum) -> {
        ThanhToan tt = new ThanhToan();
        tt.setIdThanhToan(rs.getInt("ID_ThanhToan"));
        tt.setIdHoaDon(rs.getInt("ID_HoaDon"));
        tt.setNgayThanhToan(rs.getDate("NgayThanhToan"));
        tt.setSoTienDaTra(rs.getDouble("SoTienDaTra"));
        tt.setPhuongThuc(rs.getString("PhuongThuc"));
        return tt;
    };
    
    // Lấy tất cả hóa đơn
    public List<HoaDon> getAll() {
        String sql = "SELECT hd.*, p.TenPhong, nv.HoTen " +
                    "FROM HOA_DON hd " +
                    "LEFT JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN NHAN_VIEN nv ON hd.ID_NhanVien = nv.ID_NhanVien " +
                    "ORDER BY hd.KyHoaDon DESC";
        return jdbcTemplate.query(sql, hoaDonRowMapper);
    }
    
    // Lấy hóa đơn theo ID
    public HoaDon getById(int id) {
        String sql = "SELECT hd.*, p.TenPhong, nv.HoTen " +
                    "FROM HOA_DON hd " +
                    "LEFT JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN NHAN_VIEN nv ON hd.ID_NhanVien = nv.ID_NhanVien " +
                    "WHERE hd.ID_HoaDon = ?";
        try {
            return jdbcTemplate.queryForObject(sql, hoaDonRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Thêm hóa đơn mới
    public int add(HoaDon hd) {
        String sql = "INSERT INTO HOA_DON (ID_Phong, ID_NhanVien, KyHoaDon, ChiSoDienCu, " +
                    "ChiSoDienMoi, ChiSoNuocCu, ChiSoNuocMoi, TongTien, TrangThai) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, hd.getIdPhong(), hd.getIdNhanVien(), hd.getKyHoaDon(),
                                   hd.getChiSoDienCu(), hd.getChiSoDienMoi(), hd.getChiSoNuocCu(),
                                   hd.getChiSoNuocMoi(), hd.getTongTien(), "Chưa thanh toán");
    }
    
    // Cập nhật hóa đơn
    public int update(HoaDon hd) {
        String sql = "UPDATE HOA_DON SET ChiSoDienCu=?, ChiSoDienMoi=?, ChiSoNuocCu=?, " +
                    "ChiSoNuocMoi=?, TongTien=?, TrangThai=? WHERE ID_HoaDon=?";
        return jdbcTemplate.update(sql, hd.getChiSoDienCu(), hd.getChiSoDienMoi(),
                                   hd.getChiSoNuocCu(), hd.getChiSoNuocMoi(),
                                   hd.getTongTien(), hd.getTrangThai(), hd.getIdHoaDon());
    }
    
    // Xóa hóa đơn
    public int delete(int id) {
        // Xóa các bản ghi thanh toán liên quan trước
        String deleteThanhToan = "DELETE FROM THANH_TOAN WHERE ID_HoaDon = ?";
        jdbcTemplate.update(deleteThanhToan, id);
        
        String sql = "DELETE FROM HOA_DON WHERE ID_HoaDon = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    // Lấy hóa đơn theo phòng
    public List<HoaDon> getByRoom(int phongId) {
        String sql = "SELECT hd.*, p.TenPhong, nv.HoTen " +
                    "FROM HOA_DON hd " +
                    "LEFT JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN NHAN_VIEN nv ON hd.ID_NhanVien = nv.ID_NhanVien " +
                    "WHERE hd.ID_Phong = ? " +
                    "ORDER BY hd.KyHoaDon DESC";
        return jdbcTemplate.query(sql, hoaDonRowMapper, phongId);
    }
    
    // Lấy hóa đơn chưa thanh toán
    public List<HoaDon> getUnpaidInvoices() {
        String sql = "SELECT hd.*, p.TenPhong, nv.HoTen " +
                    "FROM HOA_DON hd " +
                    "LEFT JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN NHAN_VIEN nv ON hd.ID_NhanVien = nv.ID_NhanVien " +
                    "WHERE hd.TrangThai = ? " +
                    "ORDER BY hd.KyHoaDon ASC";
        return jdbcTemplate.query(sql, hoaDonRowMapper, "Chưa thanh toán");
    }
    
    // Thanh toán hóa đơn
    public int payInvoice(int hoaDonId, double soTien, String phuongThuc) {
        // Cập nhật trạng thái hóa đơn
        String sql = "UPDATE HOA_DON SET TrangThai = ? WHERE ID_HoaDon = ?";
        int result = jdbcTemplate.update(sql, "Đã thanh toán", hoaDonId);
        
        // Thêm bản ghi thanh toán
        if (result > 0) {
            String sqlThanhToan = "INSERT INTO THANH_TOAN (ID_HoaDon, SoTienDaTra, PhuongThuc) " +
                                 "VALUES (?, ?, ?)";
            jdbcTemplate.update(sqlThanhToan, hoaDonId, soTien, phuongThuc);
        }
        
        return result;
    }
    
    // Tính tổng doanh thu theo tháng
    public double getRevenueByMonth(String month) {
        String sql = "SELECT ISNULL(SUM(SoTienDaTra), 0) FROM THANH_TOAN tt " +
                    "JOIN HOA_DON hd ON tt.ID_HoaDon = hd.ID_HoaDon " +
                    "WHERE hd.KyHoaDon = ? AND hd.TrangThai = ?";
        Double result = jdbcTemplate.queryForObject(sql, Double.class, month, "Đã thanh toán");
        return result != null ? result : 0;
    }
    
    // Lấy hóa đơn theo kỳ
    public List<HoaDon> getByPeriod(String kyHoaDon) {
        String sql = "SELECT hd.*, p.TenPhong, nv.HoTen " +
                    "FROM HOA_DON hd " +
                    "LEFT JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN NHAN_VIEN nv ON hd.ID_NhanVien = nv.ID_NhanVien " +
                    "WHERE hd.KyHoaDon = ?";
        return jdbcTemplate.query(sql, hoaDonRowMapper, kyHoaDon);
    }
    
    // Lấy lịch sử thanh toán của hóa đơn (ĐÃ SỬA)
    public List<ThanhToan> getPaymentHistory(int hoaDonId) {
        String sql = "SELECT * FROM THANH_TOAN WHERE ID_HoaDon = ? ORDER BY NgayThanhToan DESC";
        return jdbcTemplate.query(sql, thanhToanRowMapper, hoaDonId);
    }
}