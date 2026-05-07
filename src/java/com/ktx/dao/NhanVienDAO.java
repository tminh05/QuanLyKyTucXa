package com.ktx.dao;

import com.ktx.model.NhanVien;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class NhanVienDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // RowMapper cho NhanVien
    private RowMapper<NhanVien> nhanVienRowMapper = (rs, rowNum) -> {
        NhanVien nv = new NhanVien();
        nv.setIdNhanVien(rs.getInt("ID_NhanVien"));
        nv.setHoTen(rs.getString("HoTen"));
        nv.setChucVu(rs.getString("ChucVu"));
        nv.setSdt(rs.getString("SDT"));
        nv.setEmail(rs.getString("Email"));
        nv.setMatKhau(rs.getString("MatKhau"));
        return nv;
    };
    
    // Lấy tất cả nhân viên
    public List<NhanVien> getAll() {
        String sql = "SELECT * FROM NHAN_VIEN ORDER BY ID_NhanVien";
        return jdbcTemplate.query(sql, nhanVienRowMapper);
    }
    
    // Lấy nhân viên theo ID
    public NhanVien getById(int id) {
        String sql = "SELECT * FROM NHAN_VIEN WHERE ID_NhanVien = ?";
        try {
            return jdbcTemplate.queryForObject(sql, nhanVienRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Lấy nhân viên theo email
    public NhanVien getByEmail(String email) {
        String sql = "SELECT * FROM NHAN_VIEN WHERE Email = ?";
        try {
            return jdbcTemplate.queryForObject(sql, nhanVienRowMapper, email);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Thêm nhân viên mới
    public int add(NhanVien nv) {
        String sql = "INSERT INTO NHAN_VIEN (HoTen, ChucVu, SDT, Email, MatKhau) "
                   + "VALUES (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, nv.getHoTen(), nv.getChucVu(), 
                                   nv.getSdt(), nv.getEmail(), nv.getMatKhau());
    }
    
    // Cập nhật nhân viên
    public int update(NhanVien nv) {
        String sql = "UPDATE NHAN_VIEN SET HoTen=?, ChucVu=?, SDT=?, Email=?, MatKhau=? "
                   + "WHERE ID_NhanVien=?";
        return jdbcTemplate.update(sql, nv.getHoTen(), nv.getChucVu(),
                                   nv.getSdt(), nv.getEmail(), nv.getMatKhau(), 
                                   nv.getIdNhanVien());
    }
    
    // Xóa nhân viên
    public int delete(int id) {
        String sql = "DELETE FROM NHAN_VIEN WHERE ID_NhanVien = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    // Tìm kiếm nhân viên
    public List<NhanVien> search(String keyword) {
        String sql = "SELECT * FROM NHAN_VIEN WHERE HoTen LIKE ? OR ChucVu LIKE ? OR Email LIKE ?";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, nhanVienRowMapper, searchPattern, searchPattern, searchPattern);
    }
    
    // Đếm tổng số nhân viên
    public int count() {
        String sql = "SELECT COUNT(*) FROM NHAN_VIEN";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Kiểm tra đăng nhập
    public boolean checkLogin(String email, String matKhau) {
        String sql = "SELECT COUNT(*) FROM NHAN_VIEN WHERE Email = ? AND MatKhau = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email, matKhau);
        return count != null && count > 0;
    }
    
    // Lấy nhân viên theo chức vụ
    public List<NhanVien> getByRole(String chucVu) {
        String sql = "SELECT * FROM NHAN_VIEN WHERE ChucVu = ?";
        return jdbcTemplate.query(sql, nhanVienRowMapper, chucVu);
    }
    
    // Lấy danh sách quản lý
    public List<NhanVien> getManagers() {
        String sql = "SELECT * FROM NHAN_VIEN WHERE ChucVu = N'Quản lý'";
        return jdbcTemplate.query(sql, nhanVienRowMapper);
    }
    
    // Lấy danh sách nhân viên kỹ thuật
    public List<NhanVien> getTechnicians() {
        String sql = "SELECT * FROM NHAN_VIEN WHERE ChucVu = N'Kỹ thuật' OR ChucVu = N'Bảo trì'";
        return jdbcTemplate.query(sql, nhanVienRowMapper);
    }
    
    // Kiểm tra email đã tồn tại
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM NHAN_VIEN WHERE Email = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email);
        return count != null && count > 0;
    }
}