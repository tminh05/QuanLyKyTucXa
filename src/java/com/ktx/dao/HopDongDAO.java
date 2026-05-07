package com.ktx.dao;

import com.ktx.model.HopDong;
import com.ktx.model.HoaDon;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@Repository
public class HopDongDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // RowMapper cho HopDong
    private RowMapper<HopDong> hopDongRowMapper = (rs, rowNum) -> {
        HopDong hd = new HopDong();
        hd.setIdHopDong(rs.getInt("ID_HopDong"));
        hd.setMssv(rs.getString("MSSV"));
        hd.setIdPhong(rs.getInt("ID_Phong"));
        hd.setNgayBatDau(rs.getDate("NgayBatDau"));
        hd.setNgayKetThuc(rs.getDate("NgayKetThuc"));
        hd.setTrangThai(rs.getString("TrangThai"));
        hd.setHoTenSinhVien(rs.getString("HoTen"));
        hd.setTenPhong(rs.getString("TenPhong"));
        return hd;
    };
    
    // Lấy tất cả hợp đồng
    public List<HopDong> getAll() {
        String sql = "SELECT hd.*, sv.HoTen, p.TenPhong " +
                    "FROM HOP_DONG hd " +
                    "JOIN SINH_VIEN sv ON hd.MSSV = sv.MSSV " +
                    "JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "ORDER BY hd.NgayBatDau DESC";
        return jdbcTemplate.query(sql, hopDongRowMapper);
    }
    
    // Lấy hợp đồng theo ID
    public HopDong getById(int id) {
        String sql = "SELECT hd.*, sv.HoTen, p.TenPhong " +
                    "FROM HOP_DONG hd " +
                    "JOIN SINH_VIEN sv ON hd.MSSV = sv.MSSV " +
                    "JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "WHERE hd.ID_HopDong = ?";
        try {
            return jdbcTemplate.queryForObject(sql, hopDongRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Thêm hợp đồng mới
    public int add(HopDong hd) {
    String sql = "INSERT INTO HOP_DONG (MSSV, ID_Phong, NgayBatDau, NgayKetThuc, TrangThai) "
               + "VALUES (?, ?, ?, ?, ?)";
    return jdbcTemplate.update(sql, hd.getMssv(), hd.getIdPhong(), 
                               hd.getNgayBatDau(), hd.getNgayKetThuc(), "Hiệu lực");
    }
    
    // Cập nhật hợp đồng
    public int update(HopDong hd) {
        String sql = "UPDATE HOP_DONG SET NgayBatDau=?, NgayKetThuc=?, TrangThai=? WHERE ID_HopDong=?";
        return jdbcTemplate.update(sql, hd.getNgayBatDau(), hd.getNgayKetThuc(), 
                                   hd.getTrangThai(), hd.getIdHopDong());
    }
    
    // Xóa hợp đồng
    public int delete(int id) {
        String sql = "DELETE FROM HOP_DONG WHERE ID_HopDong = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    // Tìm kiếm hợp đồng
    public List<HopDong> search(String keyword) {
        String sql = "SELECT hd.*, sv.HoTen, p.TenPhong " +
                    "FROM HOP_DONG hd " +
                    "JOIN SINH_VIEN sv ON hd.MSSV = sv.MSSV " +
                    "JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "WHERE sv.HoTen LIKE ? OR sv.MSSV LIKE ? OR p.TenPhong LIKE ?";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, hopDongRowMapper, searchPattern, searchPattern, searchPattern);
    }
    
    // Lấy hợp đồng theo sinh viên
    public List<HopDong> getByStudent(String mssv) {
        String sql = "SELECT hd.*, sv.HoTen, p.TenPhong " +
                    "FROM HOP_DONG hd " +
                    "JOIN SINH_VIEN sv ON hd.MSSV = sv.MSSV " +
                    "JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "WHERE hd.MSSV = ? " +
                    "ORDER BY hd.NgayBatDau DESC";
        return jdbcTemplate.query(sql, hopDongRowMapper, mssv);
    }
    
    // Lấy hợp đồng theo phòng
    public List<HopDong> getByRoom(int phongId) {
        String sql = "SELECT hd.*, sv.HoTen, p.TenPhong " +
                    "FROM HOP_DONG hd " +
                    "JOIN SINH_VIEN sv ON hd.MSSV = sv.MSSV " +
                    "JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "WHERE hd.ID_Phong = ? AND hd.TrangThai = N'Hiệu lực'";
        return jdbcTemplate.query(sql, hopDongRowMapper, phongId);
    }
    
    // Đếm tổng số hợp đồng
    public int count() {
        String sql = "SELECT COUNT(*) FROM HOP_DONG";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Đếm số hợp đồng đang hiệu lực
    public int countActiveContracts() {
        String sql = "SELECT COUNT(*) FROM HOP_DONG WHERE TrangThai = N'Hiệu lực'";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Kiểm tra sinh viên có hợp đồng hiệu lực không
    public boolean hasActiveContract(String mssv) {
        String sql = "SELECT COUNT(*) FROM HOP_DONG WHERE MSSV = ? AND TrangThai = N'Hiệu lực'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, mssv);
        return count != null && count > 0;
    }
    
    // Gia hạn hợp đồng
    public int renewContract(int hopDongId, String newEndDate) {
        String sql = "UPDATE HOP_DONG SET NgayKetThuc = ? WHERE ID_HopDong = ?";
        return jdbcTemplate.update(sql, newEndDate, hopDongId);
    }
    
    // Lấy danh sách hợp đồng sắp hết hạn (trong 30 ngày)
    public List<HopDong> getExpiringContracts() {
        String sql = "SELECT hd.*, sv.HoTen, p.TenPhong " +
                    "FROM HOP_DONG hd " +
                    "JOIN SINH_VIEN sv ON hd.MSSV = sv.MSSV " +
                    "JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "WHERE hd.TrangThai = N'Hiệu lực' " +
                    "AND hd.NgayKetThuc BETWEEN GETDATE() AND DATEADD(day, 30, GETDATE()) " +
                    "ORDER BY hd.NgayKetThuc ASC";
        return jdbcTemplate.query(sql, hopDongRowMapper);
    }
    
    // Lấy danh sách hóa đơn của hợp đồng
    public List<HoaDon> getInvoices(int hopDongId) {
        String sql = "SELECT hd.* FROM HOA_DON hd " +
                    "JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "JOIN HOP_DONG h ON p.ID_Phong = h.ID_Phong " +
                    "WHERE h.ID_HopDong = ? " +
                    "ORDER BY hd.KyHoaDon DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            HoaDon hoaDon = new HoaDon();
            hoaDon.setIdHoaDon(rs.getInt("ID_HoaDon"));
            hoaDon.setKyHoaDon(rs.getString("KyHoaDon"));
            hoaDon.setTongTien(rs.getDouble("TongTien"));
            hoaDon.setTrangThai(rs.getString("TrangThai"));
            return hoaDon;
        }, hopDongId);
    }
}