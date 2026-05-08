package com.ktx.dao;

import com.ktx.model.YeuCauBaoTri;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import static javax.swing.text.html.HTML.Attribute.N;

@Repository
public class BaoTriDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // RowMapper cho YeuCauBaoTri
    private RowMapper<YeuCauBaoTri> yeuCauRowMapper = (rs, rowNum) -> {
        YeuCauBaoTri yc = new YeuCauBaoTri();
        yc.setIdYeuCau(rs.getInt("ID_YeuCau"));
        yc.setIdPhong(rs.getInt("ID_Phong"));
        yc.setMssv(rs.getString("MSSV"));
        yc.setIdNhanVien(rs.getInt("ID_NhanVien"));
        yc.setNoiDung(rs.getString("NoiDung"));
        yc.setNgayTao(rs.getDate("NgayTao"));
        yc.setNgayCapNhat(rs.getDate("NgayCapNhat"));
        yc.setTrangThai(rs.getString("TrangThai"));
        
        // Lấy thêm thông tin từ bảng liên quan
        try {
            yc.setTenPhong(rs.getString("TenPhong"));
        } catch (SQLException e) {
            yc.setTenPhong("");
        }
        try {
            yc.setHoTenSinhVien(rs.getString("HoTen"));
        } catch (SQLException e) {
            yc.setHoTenSinhVien("");
        }
        try {
            yc.setTenNhanVien(rs.getString("TenNhanVien"));
        } catch (SQLException e) {
            yc.setTenNhanVien("");
        }
        
        return yc;
    };
    
    // Lấy tất cả yêu cầu bảo trì
    public List<YeuCauBaoTri> getAll() {
        String sql = "SELECT yc.*, p.TenPhong, sv.HoTen, nv.HoTen as TenNhanVien " +
                    "FROM YEU_CAU_BAO_TRI yc " +
                    "LEFT JOIN PHONG p ON yc.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN SINH_VIEN sv ON yc.MSSV = sv.MSSV " +
                    "LEFT JOIN NHAN_VIEN nv ON yc.ID_NhanVien = nv.ID_NhanVien " +
                    "ORDER BY yc.NgayTao DESC";
        return jdbcTemplate.query(sql, yeuCauRowMapper);
    }
    
    // Lấy yêu cầu bảo trì theo ID
    public YeuCauBaoTri getById(int id) {
        String sql = "SELECT yc.*, p.TenPhong, sv.HoTen, nv.HoTen as TenNhanVien " +
                    "FROM YEU_CAU_BAO_TRI yc " +
                    "LEFT JOIN PHONG p ON yc.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN SINH_VIEN sv ON yc.MSSV = sv.MSSV " +
                    "LEFT JOIN NHAN_VIEN nv ON yc.ID_NhanVien = nv.ID_NhanVien " +
                    "WHERE yc.ID_YeuCau = ?";
        try {
            return jdbcTemplate.queryForObject(sql, yeuCauRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Thêm yêu cầu bảo trì mới
    public int add(YeuCauBaoTri yc) {
    String sql = "INSERT INTO YEU_CAU_BAO_TRI (ID_Phong, MSSV, NoiDung, NgayTao, TrangThai) "
               + "VALUES (?, ?, ?, GETDATE(), ?)";
    return jdbcTemplate.update(sql, yc.getIdPhong(), yc.getMssv(), 
                               yc.getNoiDung(), "Chờ xử lý");
    }
    
    // Cập nhật yêu cầu bảo trì
    public int update(YeuCauBaoTri yc) {
        String sql = "UPDATE YEU_CAU_BAO_TRI SET ID_NhanVien=?, NoiDung=?, " +
                    "NgayCapNhat=GETDATE(), TrangThai=? WHERE ID_YeuCau=?";
        return jdbcTemplate.update(sql, yc.getIdNhanVien(), yc.getNoiDung(),
                                   yc.getTrangThai(), yc.getIdYeuCau());
    }
    
    // Xóa yêu cầu bảo trì
    public int delete(int id) {
        String sql = "DELETE FROM YEU_CAU_BAO_TRI WHERE ID_YeuCau = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    // Lấy yêu cầu theo trạng thái
    public List<YeuCauBaoTri> getByStatus(String status) {
        String sql = "SELECT yc.*, p.TenPhong, sv.HoTen, nv.HoTen as TenNhanVien " +
                    "FROM YEU_CAU_BAO_TRI yc " +
                    "LEFT JOIN PHONG p ON yc.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN SINH_VIEN sv ON yc.MSSV = sv.MSSV " +
                    "LEFT JOIN NHAN_VIEN nv ON yc.ID_NhanVien = nv.ID_NhanVien " +
                    "WHERE yc.TrangThai = ? " +
                    "ORDER BY yc.NgayTao DESC";
        return jdbcTemplate.query(sql, yeuCauRowMapper, status);
    }
    
    // Lấy yêu cầu theo phòng
    public List<YeuCauBaoTri> getByRoom(int phongId) {
        String sql = "SELECT yc.*, p.TenPhong, sv.HoTen, nv.HoTen as TenNhanVien " +
                    "FROM YEU_CAU_BAO_TRI yc " +
                    "LEFT JOIN PHONG p ON yc.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN SINH_VIEN sv ON yc.MSSV = sv.MSSV " +
                    "LEFT JOIN NHAN_VIEN nv ON yc.ID_NhanVien = nv.ID_NhanVien " +
                    "WHERE yc.ID_Phong = ? " +
                    "ORDER BY yc.NgayTao DESC";
        return jdbcTemplate.query(sql, yeuCauRowMapper, phongId);
    }
    
    // Lấy yêu cầu theo sinh viên
    public List<YeuCauBaoTri> getByStudent(String mssv) {
    String sql = "SELECT yc.*, p.TenPhong, sv.HoTen, nv.HoTen as TenNhanVien " +
                "FROM YEU_CAU_BAO_TRI yc " +
                "LEFT JOIN PHONG p ON yc.ID_Phong = p.ID_Phong " +
                "LEFT JOIN SINH_VIEN sv ON yc.MSSV = sv.MSSV " +
                "LEFT JOIN NHAN_VIEN nv ON yc.ID_NhanVien = nv.ID_NhanVien " +
                "WHERE yc.MSSV = ? " +
                "ORDER BY yc.NgayTao DESC";
    return jdbcTemplate.query(sql, yeuCauRowMapper, mssv);
    }
    
    public int cancel(int id, String mssv) {
    String sql = "UPDATE YEU_CAU_BAO_TRI SET TrangThai = N'Đã hủy', NgayCapNhat = GETDATE() " +
                "WHERE ID_YeuCau = ? AND MSSV = ? AND TrangThai = N'Chờ xử lý'";
    return jdbcTemplate.update(sql, id, mssv);
    }
    
    public int getCurrentRoom(String mssv) {
    String sql = "SELECT TOP 1 ID_Phong FROM HOP_DONG WHERE MSSV = ? AND TrangThai = N'Hiệu lực'";
    try {
        return jdbcTemplate.queryForObject(sql, Integer.class, mssv);
    } catch (Exception e) {
        return 0;
    }
    }
    
    // Lấy yêu cầu theo nhân viên xử lý
    public List<YeuCauBaoTri> getByStaff(int nhanVienId) {
        String sql = "SELECT yc.*, p.TenPhong, sv.HoTen, nv.HoTen as TenNhanVien " +
                    "FROM YEU_CAU_BAO_TRI yc " +
                    "LEFT JOIN PHONG p ON yc.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN SINH_VIEN sv ON yc.MSSV = sv.MSSV " +
                    "LEFT JOIN NHAN_VIEN nv ON yc.ID_NhanVien = nv.ID_NhanVien " +
                    "WHERE yc.ID_NhanVien = ? " +
                    "ORDER BY yc.NgayCapNhat DESC";
        return jdbcTemplate.query(sql, yeuCauRowMapper, nhanVienId);
    }
    
    // Đếm tổng số yêu cầu
    public int count() {
        String sql = "SELECT COUNT(*) FROM YEU_CAU_BAO_TRI";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Đếm số yêu cầu đang chờ xử lý
    public int countPendingRequests() {
        String sql = "SELECT COUNT(*) FROM YEU_CAU_BAO_TRI WHERE TrangThai = N'Chờ xử lý'";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Đếm số yêu cầu đang xử lý
    public int countProcessingRequests() {
        String sql = "SELECT COUNT(*) FROM YEU_CAU_BAO_TRI WHERE TrangThai = N'Đang xử lý'";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Đếm số yêu cầu đã hoàn thành
    public int countCompletedRequests() {
        String sql = "SELECT COUNT(*) FROM YEU_CAU_BAO_TRI WHERE TrangThai = N'Hoàn thành'";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Cập nhật trạng thái yêu cầu
    public int updateStatus(int yeuCauId, String status, int nhanVienId) {
        String sql = "UPDATE YEU_CAU_BAO_TRI SET TrangThai=?, ID_NhanVien=?, NgayCapNhat=GETDATE() " +
                    "WHERE ID_YeuCau=?";
        return jdbcTemplate.update(sql, status, nhanVienId, yeuCauId);
    }
    // Cập nhật nội dung yêu cầu bảo trì
    public int updateContent(YeuCauBaoTri yc) {
    String sql = "UPDATE YEU_CAU_BAO_TRI SET NoiDung=?, NgayCapNhat=GETDATE() WHERE ID_YeuCau=?";
    return jdbcTemplate.update(sql, yc.getNoiDung(), yc.getIdYeuCau());
    }
    
    // Gán nhân viên xử lý yêu cầu
    public int assignStaff(int yeuCauId, int nhanVienId) {
        String sql = "UPDATE YEU_CAU_BAO_TRI SET ID_NhanVien=?, TrangThai=N'Đang xử lý', NgayCapNhat=GETDATE() " +
                    "WHERE ID_YeuCau=?";
        return jdbcTemplate.update(sql, nhanVienId, yeuCauId);
    }
    
    // Hoàn thành yêu cầu
    public int completeRequest(int yeuCauId) {
        String sql = "UPDATE YEU_CAU_BAO_TRI SET TrangThai=N'Hoàn thành', NgayCapNhat=GETDATE() " +
                    "WHERE ID_YeuCau=?";
        return jdbcTemplate.update(sql, yeuCauId);
    }
    
    // Hủy yêu cầu
    public int cancelRequest(int yeuCauId) {
        String sql = "UPDATE YEU_CAU_BAO_TRI SET TrangThai=N'Đã hủy', NgayCapNhat=GETDATE() " +
                    "WHERE ID_YeuCau=?";
        return jdbcTemplate.update(sql, yeuCauId);
    }
    
    // Tìm kiếm yêu cầu
    public List<YeuCauBaoTri> search(String keyword) {
        String sql = "SELECT yc.*, p.TenPhong, sv.HoTen, nv.HoTen as TenNhanVien " +
                    "FROM YEU_CAU_BAO_TRI yc " +
                    "LEFT JOIN PHONG p ON yc.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN SINH_VIEN sv ON yc.MSSV = sv.MSSV " +
                    "LEFT JOIN NHAN_VIEN nv ON yc.ID_NhanVien = nv.ID_NhanVien " +
                    "WHERE yc.NoiDung LIKE ? OR p.TenPhong LIKE ? OR sv.HoTen LIKE ? " +
                    "ORDER BY yc.NgayTao DESC";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, yeuCauRowMapper, searchPattern, searchPattern, searchPattern);
    }
    
    // Thống kê số lượng yêu cầu theo tháng
    public List<Object[]> getStatsByMonth(int year) {
        String sql = "SELECT MONTH(NgayTao) as Thang, COUNT(*) as SoLuong " +
                    "FROM YEU_CAU_BAO_TRI " +
                    "WHERE YEAR(NgayTao) = ? " +
                    "GROUP BY MONTH(NgayTao) " +
                    "ORDER BY Thang";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            return new Object[]{rs.getInt("Thang"), rs.getInt("SoLuong")};
        }, year);
    }
    
    // Thống kê số lượng yêu cầu theo trạng thái
    public List<Object[]> getStatsByStatus() {
        String sql = "SELECT TrangThai, COUNT(*) as SoLuong " +
                    "FROM YEU_CAU_BAO_TRI " +
                    "GROUP BY TrangThai";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            return new Object[]{rs.getString("TrangThai"), rs.getInt("SoLuong")};
        });
    }
    
    // Tính thời gian xử lý trung bình (ngày)
    public double getAverageProcessTime() {
        String sql = "SELECT AVG(DATEDIFF(day, NgayTao, NgayCapNhat)) as TrungBinh " +
                    "FROM YEU_CAU_BAO_TRI " +
                    "WHERE TrangThai = N'Hoàn thành' AND NgayCapNhat IS NOT NULL";
        Double result = jdbcTemplate.queryForObject(sql, Double.class);
        return result != null ? result : 0;
    }
    
    // Lấy yêu cầu theo khoảng thời gian
    public List<YeuCauBaoTri> getByDateRange(String startDate, String endDate) {
        String sql = "SELECT yc.*, p.TenPhong, sv.HoTen, nv.HoTen as TenNhanVien " +
                    "FROM YEU_CAU_BAO_TRI yc " +
                    "LEFT JOIN PHONG p ON yc.ID_Phong = p.ID_Phong " +
                    "LEFT JOIN SINH_VIEN sv ON yc.MSSV = sv.MSSV " +
                    "LEFT JOIN NHAN_VIEN nv ON yc.ID_NhanVien = nv.ID_NhanVien " +
                    "WHERE yc.NgayTao BETWEEN ? AND ? " +
                    "ORDER BY yc.NgayTao DESC";
        return jdbcTemplate.query(sql, yeuCauRowMapper, startDate, endDate);
    }
    
    // Lấy top phòng có nhiều yêu cầu bảo trì nhất
    public List<Object[]> getTopRoomsWithIssues(int limit) {
        String sql = "SELECT TOP (?) p.TenPhong, COUNT(*) as SoLuongYeuCau " +
                    "FROM YEU_CAU_BAO_TRI yc " +
                    "JOIN PHONG p ON yc.ID_Phong = p.ID_Phong " +
                    "GROUP BY p.TenPhong " +
                    "ORDER BY SoLuongYeuCau DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            return new Object[]{rs.getString("TenPhong"), rs.getInt("SoLuongYeuCau")};
        }, limit);
    }
    
}