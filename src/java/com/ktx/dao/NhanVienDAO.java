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
    
    private RowMapper<NhanVien> nhanVienRowMapper = (rs, rowNum) -> {
        NhanVien nv = new NhanVien();
        nv.setIdNhanVien(rs.getInt("ID_NhanVien"));
        nv.setHoTen(rs.getString("HoTen"));
        nv.setChucVu(rs.getString("ChucVu"));
        nv.setSdt(rs.getString("SDT"));
        nv.setEmail(rs.getString("Email"));
        nv.setMatKhau(rs.getString("MatKhau"));
        try {
            nv.setVaiTro(rs.getString("VaiTro"));
        } catch (Exception e) { nv.setVaiTro("NHAN_VIEN"); }
        try {
            nv.setTrangThai(rs.getString("TrangThai"));
        } catch (Exception e) { nv.setTrangThai("HOAT_DONG"); }
        try {
            nv.setAnhDaiDien(rs.getString("AnhDaiDien"));
        } catch (Exception e) {}
        return nv;
    };
    
    public List<NhanVien> getAll() {
        String sql = "SELECT * FROM NHAN_VIEN ORDER BY ID_NhanVien";
        return jdbcTemplate.query(sql, nhanVienRowMapper);
    }
    
    public NhanVien getById(int id) {
        String sql = "SELECT * FROM NHAN_VIEN WHERE ID_NhanVien = ?";
        try {
            return jdbcTemplate.queryForObject(sql, nhanVienRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }
    
    public NhanVien getByEmail(String email) {
        String sql = "SELECT * FROM NHAN_VIEN WHERE Email = ?";
        try {
            return jdbcTemplate.queryForObject(sql, nhanVienRowMapper, email);
        } catch (Exception e) {
            return null;
        }
    }
    
    public int add(NhanVien nv) {
        String sql = "INSERT INTO NHAN_VIEN (HoTen, ChucVu, SDT, Email, MatKhau, VaiTro, TrangThai) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, nv.getHoTen(), nv.getChucVu(), 
                                   nv.getSdt(), nv.getEmail(), nv.getMatKhau(),
                                   nv.getVaiTro() != null ? nv.getVaiTro() : "NHAN_VIEN",
                                   "HOAT_DONG");
    }
    
    public int update(NhanVien nv) {
        String sql = "UPDATE NHAN_VIEN SET HoTen=?, ChucVu=?, SDT=?, Email=?, VaiTro=?, TrangThai=? "
                   + "WHERE ID_NhanVien=?";
        return jdbcTemplate.update(sql, nv.getHoTen(), nv.getChucVu(),
                                   nv.getSdt(), nv.getEmail(), nv.getVaiTro(),
                                   nv.getTrangThai(), nv.getIdNhanVien());
    }
    
    public int updatePassword(int id, String newPassword) {
        String sql = "UPDATE NHAN_VIEN SET MatKhau=? WHERE ID_NhanVien=?";
        return jdbcTemplate.update(sql, newPassword, id);
    }
    
    public int delete(int id) {
        String sql = "DELETE FROM NHAN_VIEN WHERE ID_NhanVien = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    public List<NhanVien> search(String keyword) {
        String sql = "SELECT * FROM NHAN_VIEN WHERE HoTen LIKE ? OR Email LIKE ? OR ChucVu LIKE ?";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, nhanVienRowMapper, searchPattern, searchPattern, searchPattern);
    }
    
    public int count() {
        String sql = "SELECT COUNT(*) FROM NHAN_VIEN";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    public boolean checkLogin(String email, String matKhau) {
        String sql = "SELECT COUNT(*) FROM NHAN_VIEN WHERE Email = ? AND MatKhau = ? AND TrangThai = 'HOAT_DONG'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email, matKhau);
        return count != null && count > 0;
    }
    
    public List<NhanVien> getByRole(String vaiTro) {
        String sql = "SELECT * FROM NHAN_VIEN WHERE VaiTro = ?";
        return jdbcTemplate.query(sql, nhanVienRowMapper, vaiTro);
    }
    
    public List<NhanVien> getActiveStaff() {
        String sql = "SELECT * FROM NHAN_VIEN WHERE TrangThai = 'HOAT_DONG'";
        return jdbcTemplate.query(sql, nhanVienRowMapper);
    }
    
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM NHAN_VIEN WHERE Email = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email);
        return count != null && count > 0;
    }
    
    public int updateStatus(int id, String status) {
        String sql = "UPDATE NHAN_VIEN SET TrangThai = ? WHERE ID_NhanVien = ?";
        return jdbcTemplate.update(sql, status, id);
    }

    public List<NhanVien> getManagers() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public List<NhanVien> getTechnicians() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}