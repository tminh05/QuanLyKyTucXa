package com.ktx.dao;

import com.ktx.model.Phong;
import com.ktx.model.SinhVien;
import com.ktx.model.ThietBi;
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
public class PhongDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // RowMapper cho Phong
    private RowMapper<Phong> phongRowMapper = (rs, rowNum) -> {
        Phong p = new Phong();
        p.setIdPhong(rs.getInt("ID_Phong"));
        p.setIdToaNha(rs.getInt("ID_ToaNha"));
        p.setIdLoaiPhong(rs.getInt("ID_LoaiPhong"));
        p.setTenPhong(rs.getString("TenPhong"));
        p.setSucChua(rs.getInt("SucChua"));
        p.setSoNguoiHienTai(rs.getInt("SoNguoiHienTai"));
        p.setTrangThai(rs.getString("TrangThai"));
        p.setTenToaNha(rs.getString("TenToaNha"));
        p.setTenLoaiPhong(rs.getString("TenLoai"));
        p.setGiaPhong(rs.getDouble("GiaPhong"));
        return p;
    };
    
    // Lấy tất cả phòng
    public List<Phong> getAll() {
        String sql = "SELECT p.*, tn.TenToaNha, lp.TenLoai, lp.GiaPhong " +
                    "FROM PHONG p " +
                    "JOIN TOA_NHA tn ON p.ID_ToaNha = tn.ID_ToaNha " +
                    "JOIN LOAI_PHONG lp ON p.ID_LoaiPhong = lp.ID_LoaiPhong " +
                    "ORDER BY tn.TenToaNha, p.TenPhong";
        return jdbcTemplate.query(sql, phongRowMapper);
    }
    
    // Lấy phòng theo ID
    public Phong getById(int id) {
        String sql = "SELECT p.*, tn.TenToaNha, lp.TenLoai, lp.GiaPhong " +
                    "FROM PHONG p " +
                    "JOIN TOA_NHA tn ON p.ID_ToaNha = tn.ID_ToaNha " +
                    "JOIN LOAI_PHONG lp ON p.ID_LoaiPhong = lp.ID_LoaiPhong " +
                    "WHERE p.ID_Phong = ?";
        try {
            return jdbcTemplate.queryForObject(sql, phongRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Thêm phòng mới
    public int add(Phong p) {
    String sql = "INSERT INTO PHONG (ID_ToaNha, ID_LoaiPhong, TenPhong, SucChua, SoNguoiHienTai, TrangThai) "
               + "VALUES (?, ?, ?, ?, ?, ?)";
    return jdbcTemplate.update(sql, p.getIdToaNha(), p.getIdLoaiPhong(), p.getTenPhong(),
                               p.getSucChua(), 0, "Trống");
    }
    
    // Cập nhật phòng
    public int update(Phong p) {
        String sql = "UPDATE PHONG SET ID_ToaNha=?, ID_LoaiPhong=?, TenPhong=?, SucChua=? WHERE ID_Phong=?";
        return jdbcTemplate.update(sql, p.getIdToaNha(), p.getIdLoaiPhong(), p.getTenPhong(), p.getSucChua(), p.getIdPhong());
    }
    
    // Xóa phòng
    public int delete(int id) {
        String sql = "DELETE FROM PHONG WHERE ID_Phong = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    // Tìm kiếm phòng
    public List<Phong> search(String keyword) {
        String sql = "SELECT p.*, tn.TenToaNha, lp.TenLoai, lp.GiaPhong " +
                    "FROM PHONG p " +
                    "JOIN TOA_NHA tn ON p.ID_ToaNha = tn.ID_ToaNha " +
                    "JOIN LOAI_PHONG lp ON p.ID_LoaiPhong = lp.ID_LoaiPhong " +
                    "WHERE p.TenPhong LIKE ? OR tn.TenToaNha LIKE ? OR lp.TenLoai LIKE ?";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, phongRowMapper, searchPattern, searchPattern, searchPattern);
    }
    
    // Lấy phòng theo trạng thái
    public List<Phong> getByStatus(String status) {
        String sql = "SELECT p.*, tn.TenToaNha, lp.TenLoai, lp.GiaPhong " +
                    "FROM PHONG p " +
                    "JOIN TOA_NHA tn ON p.ID_ToaNha = tn.ID_ToaNha " +
                    "JOIN LOAI_PHONG lp ON p.ID_LoaiPhong = lp.ID_LoaiPhong " +
                    "WHERE p.TrangThai = ?";
        return jdbcTemplate.query(sql, phongRowMapper, status);
    }
    
    // Lấy phòng theo tòa nhà
    public List<Phong> getByBuilding(int toaNhaId) {
        String sql = "SELECT p.*, tn.TenToaNha, lp.TenLoai, lp.GiaPhong " +
                    "FROM PHONG p " +
                    "JOIN TOA_NHA tn ON p.ID_ToaNha = tn.ID_ToaNha " +
                    "JOIN LOAI_PHONG lp ON p.ID_LoaiPhong = lp.ID_LoaiPhong " +
                    "WHERE p.ID_ToaNha = ?";
        return jdbcTemplate.query(sql, phongRowMapper, toaNhaId);
    }
    
    // Lấy phòng còn trống
    public List<Phong> getAvailableRooms() {
        String sql = "SELECT p.*, tn.TenToaNha, lp.TenLoai, lp.GiaPhong " +
                    "FROM PHONG p " +
                    "JOIN TOA_NHA tn ON p.ID_ToaNha = tn.ID_ToaNha " +
                    "JOIN LOAI_PHONG lp ON p.ID_LoaiPhong = lp.ID_LoaiPhong " +
                    "WHERE p.SoNguoiHienTai < p.SucChua " +
                    "ORDER BY tn.TenToaNha, p.TenPhong";
        return jdbcTemplate.query(sql, phongRowMapper);
    }
    
    // Đếm tổng số phòng
    public int count() {
        String sql = "SELECT COUNT(*) FROM PHONG";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Đếm số phòng còn trống
    public int countAvailableRooms() {
        String sql = "SELECT COUNT(*) FROM PHONG WHERE SoNguoiHienTai < SucChua";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Lấy ID phòng hiện tại của sinh viên (từ hợp đồng đang hiệu lực)
    public int getCurrentRoom(String mssv) {
    String sql = "SELECT TOP 1 ID_Phong FROM HOP_DONG WHERE MSSV = ? AND TrangThai = N'Hiệu lực'";
    try {
        return jdbcTemplate.queryForObject(sql, Integer.class, mssv);
    } catch (Exception e) {
        return 0;
    }
    }
    
    // Kiểm tra phòng còn chỗ không
    public boolean hasAvailableSlot(int phongId) {
        String sql = "SELECT SoNguoiHienTai, SucChua FROM PHONG WHERE ID_Phong = ?";
        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
            int current = rs.getInt("SoNguoiHienTai");
            int capacity = rs.getInt("SucChua");
            return current < capacity;
        }, phongId);
    }
    
    // Kiểm tra tên phòng đã tồn tại trong tòa nhà chưa
    public boolean isPhongExists(String tenPhong, int toaNhaId) {
        String sql = "SELECT COUNT(*) FROM PHONG WHERE TenPhong = ? AND ID_ToaNha = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, tenPhong, toaNhaId);
        return count != null && count > 0;
    }
    
    // Kiểm tra phòng có sinh viên không
    public boolean hasStudents(int phongId) {
        String sql = "SELECT COUNT(*) FROM HOP_DONG WHERE ID_Phong = ? AND TrangThai = N'Hiệu lực'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, phongId);
        return count != null && count > 0;
    }
    
    // Lấy danh sách sinh viên trong phòng
    public List<SinhVien> getStudentsInRoom(int phongId) {
        String sql = "SELECT sv.* FROM SINH_VIEN sv " +
                    "JOIN HOP_DONG hd ON sv.MSSV = hd.MSSV " +
                    "WHERE hd.ID_Phong = ? AND hd.TrangThai = N'Hiệu lực'";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            SinhVien sv = new SinhVien();
            sv.setMssv(rs.getString("MSSV"));
            sv.setHoTen(rs.getString("HoTen"));
            sv.setSdt(rs.getString("SDT"));
            sv.setEmail(rs.getString("Email"));
            return sv;
        }, phongId);
    }
    
    // Lấy danh sách thiết bị trong phòng
    public List<ThietBi> getEquipment(int phongId) {
        String sql = "SELECT * FROM THIET_BI WHERE ID_Phong = ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            ThietBi tb = new ThietBi();
            tb.setIdThietBi(rs.getInt("ID_ThietBi"));
            tb.setIdPhong(rs.getInt("ID_Phong"));
            tb.setTenThietBi(rs.getString("TenThietBi"));
            tb.setSoLuong(rs.getInt("SoLuong"));
            tb.setTinhTrang(rs.getString("TinhTrang"));
            return tb;
        }, phongId);
    }

    public Map<String, Integer> countByBuilding() {
    String sql = "SELECT tn.TenToaNha, COUNT(p.ID_Phong) as SoLuong FROM PHONG p " +
                "JOIN TOA_NHA tn ON p.ID_ToaNha = tn.ID_ToaNha " +
                "GROUP BY tn.TenToaNha";
    Map<String, Integer> result = new HashMap<>();
    jdbcTemplate.query(sql, (rs) -> {
        result.put(rs.getString("TenToaNha"), rs.getInt("SoLuong"));
    });
    return result;
    }

}