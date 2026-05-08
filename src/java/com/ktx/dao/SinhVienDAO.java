package com.ktx.dao;

import com.ktx.model.SinhVien;
import com.ktx.model.HopDong;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class SinhVienDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // RowMapper cho SinhVien
    private RowMapper<SinhVien> sinhVienRowMapper = (rs, rowNum) -> {
        SinhVien sv = new SinhVien();
        sv.setMssv(rs.getString("MSSV"));
        sv.setHoTen(rs.getString("HoTen"));
        sv.setNgaySinh(rs.getDate("NgaySinh"));
        sv.setGioiTinh(rs.getString("GioiTinh"));
        sv.setSdt(rs.getString("SDT"));
        sv.setEmail(rs.getString("Email"));
        sv.setLop(rs.getString("Lop"));
        sv.setKhoa(rs.getString("Khoa"));
        sv.setCccd(rs.getString("CCCD"));
        sv.setMatKhau(rs.getString("MatKhau"));
        return sv;
    };
    
    // Lấy tất cả sinh viên
    public List<SinhVien> getAll() {
        String sql = "SELECT * FROM SINH_VIEN ORDER BY MSSV";
        return jdbcTemplate.query(sql, sinhVienRowMapper);
    }
    
    // Lấy sinh viên theo MSSV
    public SinhVien getById(String mssv) {
        String sql = "SELECT * FROM SINH_VIEN WHERE MSSV = ?";
        try {
            return jdbcTemplate.queryForObject(sql, sinhVienRowMapper, mssv);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Thêm sinh viên mới
    public int add(SinhVien sv) {
        String sql = "INSERT INTO SINH_VIEN (MSSV, HoTen, NgaySinh, GioiTinh, SDT, Email, Lop, Khoa, CCCD, MatKhau) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, sv.getMssv(), sv.getHoTen(), sv.getNgaySinh(), 
                                   sv.getGioiTinh(), sv.getSdt(), sv.getEmail(), 
                                   sv.getLop(), sv.getKhoa(), sv.getCccd(), sv.getMatKhau());
    }
    
    // Cập nhật sinh viên
    public int update(SinhVien sv) {
        String sql = "UPDATE SINH_VIEN SET HoTen=?, NgaySinh=?, GioiTinh=?, SDT=?, "
                   + "Email=?, Lop=?, Khoa=?, CCCD=?, MatKhau=? WHERE MSSV=?";
        return jdbcTemplate.update(sql, sv.getHoTen(), sv.getNgaySinh(), sv.getGioiTinh(),
                                   sv.getSdt(), sv.getEmail(), sv.getLop(), sv.getKhoa(),
                                   sv.getCccd(), sv.getMatKhau(), sv.getMssv());
    }
    
    // Xóa sinh viên
    public int delete(String mssv) {
        String sql = "DELETE FROM SINH_VIEN WHERE MSSV = ?";
        return jdbcTemplate.update(sql, mssv);
    }
    
    // Tìm kiếm sinh viên
    public List<SinhVien> search(String keyword) {
        String sql = "SELECT * FROM SINH_VIEN WHERE MSSV LIKE ? OR HoTen LIKE ? OR Lop LIKE ? OR Khoa LIKE ?";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, sinhVienRowMapper, searchPattern, searchPattern, searchPattern, searchPattern);
    }
    
    // Đếm tổng số sinh viên
    public int count() {
        String sql = "SELECT COUNT(*) FROM SINH_VIEN";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Kiểm tra sinh viên có hợp đồng đang hiệu lực không
    public boolean hasActiveContract(String mssv) {
        String sql = "SELECT COUNT(*) FROM HOP_DONG WHERE MSSV = ? AND TrangThai = N'Hiệu lực'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, mssv);
        return count != null && count > 0;
    }
    
    // Lấy danh sách hợp đồng của sinh viên
    public List<HopDong> getContracts(String mssv) {
        String sql = "SELECT hd.*, p.TenPhong FROM HOP_DONG hd " +
                    "JOIN PHONG p ON hd.ID_Phong = p.ID_Phong " +
                    "WHERE hd.MSSV = ? ORDER BY hd.NgayBatDau DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            HopDong hd = new HopDong();
            hd.setIdHopDong(rs.getInt("ID_HopDong"));
            hd.setMssv(rs.getString("MSSV"));
            hd.setIdPhong(rs.getInt("ID_Phong"));
            hd.setNgayBatDau(rs.getDate("NgayBatDau"));
            hd.setNgayKetThuc(rs.getDate("NgayKetThuc"));
            hd.setTrangThai(rs.getString("TrangThai"));
            hd.setTenPhong(rs.getString("TenPhong"));
            return hd;
        }, mssv);
    }
    
    // Lấy sinh viên chưa có hợp đồng
    public List<SinhVien> getStudentsWithoutContract() {
        String sql = "SELECT sv.* FROM SINH_VIEN sv " +
                    "WHERE sv.MSSV NOT IN (SELECT DISTINCT MSSV FROM HOP_DONG WHERE TrangThai = N'Hiệu lực')";
        return jdbcTemplate.query(sql, sinhVienRowMapper);
    }
    
    // Kiểm tra đăng nhập
    public boolean checkLogin(String mssv, String matKhau) {
        String sql = "SELECT COUNT(*) FROM SINH_VIEN WHERE MSSV = ? AND MatKhau = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, mssv, matKhau);
        return count != null && count > 0;
    }
    
    // Lấy sinh viên theo lớp
    public List<SinhVien> getByClass(String lop) {
        String sql = "SELECT * FROM SINH_VIEN WHERE Lop = ? ORDER BY HoTen";
        return jdbcTemplate.query(sql, sinhVienRowMapper, lop);
    }
    
    // Lấy sinh viên theo khoa
    public List<SinhVien> getByFaculty(String khoa) {
        String sql = "SELECT * FROM SINH_VIEN WHERE Khoa = ? ORDER BY HoTen";
        return jdbcTemplate.query(sql, sinhVienRowMapper, khoa);
    }
    
    public Map<String, Integer> countByFaculty() {
    String sql = "SELECT Khoa, COUNT(*) as SoLuong FROM SINH_VIEN GROUP BY Khoa";
    Map<String, Integer> result = new HashMap<>();
    jdbcTemplate.query(sql, (rs) -> {
        result.put(rs.getString("Khoa"), rs.getInt("SoLuong"));
    });
    return result;
    }

}