package com.ktx.dao;

import com.ktx.model.ToaNha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ToaNhaDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // RowMapper cho ToaNha
    private RowMapper<ToaNha> toaNhaRowMapper = (rs, rowNum) -> {
        ToaNha tn = new ToaNha();
        tn.setIdToaNha(rs.getInt("ID_ToaNha"));
        tn.setTenToaNha(rs.getString("TenToaNha"));
        tn.setSoTang(rs.getInt("SoTang"));
        tn.setLoaiToaNha(rs.getString("LoaiToaNha"));
        return tn;
    };
    
    // Lấy tất cả tòa nhà
    public List<ToaNha> getAll() {
        String sql = "SELECT * FROM TOA_NHA ORDER BY TenToaNha";
        return jdbcTemplate.query(sql, toaNhaRowMapper);
    }
    
    // Lấy tòa nhà theo ID
    public ToaNha getById(int id) {
        String sql = "SELECT * FROM TOA_NHA WHERE ID_ToaNha = ?";
        try {
            return jdbcTemplate.queryForObject(sql, toaNhaRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Lấy tòa nhà theo tên
    public ToaNha getByName(String tenToaNha) {
        String sql = "SELECT * FROM TOA_NHA WHERE TenToaNha = ?";
        try {
            return jdbcTemplate.queryForObject(sql, toaNhaRowMapper, tenToaNha);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Thêm tòa nhà mới
    public int add(ToaNha tn) {
        String sql = "INSERT INTO TOA_NHA (TenToaNha, SoTang, LoaiToaNha) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, tn.getTenToaNha(), tn.getSoTang(), tn.getLoaiToaNha());
    }
    
    // Cập nhật tòa nhà
    public int update(ToaNha tn) {
        String sql = "UPDATE TOA_NHA SET TenToaNha=?, SoTang=?, LoaiToaNha=? WHERE ID_ToaNha=?";
        return jdbcTemplate.update(sql, tn.getTenToaNha(), tn.getSoTang(), tn.getLoaiToaNha(), tn.getIdToaNha());
    }
    
    // Xóa tòa nhà
    public int delete(int id) {
        // Kiểm tra xem tòa nhà có phòng không trước khi xóa
        String checkSql = "SELECT COUNT(*) FROM PHONG WHERE ID_ToaNha = ?";
        Integer count = jdbcTemplate.queryForObject(checkSql, Integer.class, id);
        if (count != null && count > 0) {
            return 0; // Không thể xóa vì còn phòng
        }
        
        String sql = "DELETE FROM TOA_NHA WHERE ID_ToaNha = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    // Tìm kiếm tòa nhà
    public List<ToaNha> search(String keyword) {
        String sql = "SELECT * FROM TOA_NHA WHERE TenToaNha LIKE ? OR LoaiToaNha LIKE ?";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, toaNhaRowMapper, searchPattern, searchPattern);
    }
    
    // Đếm tổng số tòa nhà
    public int count() {
        String sql = "SELECT COUNT(*) FROM TOA_NHA";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Lấy tòa nhà theo loại (nam/nữ)
    public List<ToaNha> getByType(String loaiToaNha) {
        String sql = "SELECT * FROM TOA_NHA WHERE LoaiToaNha = ?";
        return jdbcTemplate.query(sql, toaNhaRowMapper, loaiToaNha);
    }
    
    // Lấy tòa nhà dành cho nam
    public List<ToaNha> getForMale() {
        String sql = "SELECT * FROM TOA_NHA WHERE LoaiToaNha LIKE N'%nam%'";
        return jdbcTemplate.query(sql, toaNhaRowMapper);
    }
    
    // Lấy tòa nhà dành cho nữ
    public List<ToaNha> getForFemale() {
        String sql = "SELECT * FROM TOA_NHA WHERE LoaiToaNha LIKE N'%nữ%'";
        return jdbcTemplate.query(sql, toaNhaRowMapper);
    }
    
    // Kiểm tra tên tòa nhà đã tồn tại
    public boolean isNameExists(String tenToaNha) {
        String sql = "SELECT COUNT(*) FROM TOA_NHA WHERE TenToaNha = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, tenToaNha);
        return count != null && count > 0;
    }
    
    // Thống kê số phòng theo tòa nhà
    public int countRoomsByBuilding(int toaNhaId) {
        String sql = "SELECT COUNT(*) FROM PHONG WHERE ID_ToaNha = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, toaNhaId);
    }
    
    // Thống kê số phòng trống theo tòa nhà
    public int countAvailableRoomsByBuilding(int toaNhaId) {
        String sql = "SELECT COUNT(*) FROM PHONG WHERE ID_ToaNha = ? AND SoNguoiHienTai < SucChua";
        return jdbcTemplate.queryForObject(sql, Integer.class, toaNhaId);
    }
}