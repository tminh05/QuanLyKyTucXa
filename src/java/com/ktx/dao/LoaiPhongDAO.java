package com.ktx.dao;

import com.ktx.model.LoaiPhong;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class LoaiPhongDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // RowMapper cho LoaiPhong
    private RowMapper<LoaiPhong> loaiPhongRowMapper = (rs, rowNum) -> {
        LoaiPhong lp = new LoaiPhong();
        lp.setIdLoaiPhong(rs.getInt("ID_LoaiPhong"));
        lp.setTenLoai(rs.getString("TenLoai"));
        lp.setGiaPhong(rs.getDouble("GiaPhong"));
        return lp;
    };
    
    // Lấy tất cả loại phòng
    public List<LoaiPhong> getAll() {
        String sql = "SELECT * FROM LOAI_PHONG ORDER BY GiaPhong";
        return jdbcTemplate.query(sql, loaiPhongRowMapper);
    }
    
    // Lấy loại phòng theo ID
    public LoaiPhong getById(int id) {
        String sql = "SELECT * FROM LOAI_PHONG WHERE ID_LoaiPhong = ?";
        try {
            return jdbcTemplate.queryForObject(sql, loaiPhongRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Lấy loại phòng theo tên
    public LoaiPhong getByName(String tenLoai) {
        String sql = "SELECT * FROM LOAI_PHONG WHERE TenLoai = ?";
        try {
            return jdbcTemplate.queryForObject(sql, loaiPhongRowMapper, tenLoai);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Thêm loại phòng mới
    public int add(LoaiPhong lp) {
        String sql = "INSERT INTO LOAI_PHONG (TenLoai, GiaPhong) VALUES (?, ?)";
        return jdbcTemplate.update(sql, lp.getTenLoai(), lp.getGiaPhong());
    }
    
    // Cập nhật loại phòng
    public int update(LoaiPhong lp) {
        String sql = "UPDATE LOAI_PHONG SET TenLoai=?, GiaPhong=? WHERE ID_LoaiPhong=?";
        return jdbcTemplate.update(sql, lp.getTenLoai(), lp.getGiaPhong(), lp.getIdLoaiPhong());
    }
    
    // Xóa loại phòng
    public int delete(int id) {
        // Kiểm tra xem loại phòng có đang được sử dụng không
        String checkSql = "SELECT COUNT(*) FROM PHONG WHERE ID_LoaiPhong = ?";
        Integer count = jdbcTemplate.queryForObject(checkSql, Integer.class, id);
        if (count != null && count > 0) {
            return 0; // Không thể xóa vì đang được sử dụng
        }
        
        String sql = "DELETE FROM LOAI_PHONG WHERE ID_LoaiPhong = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    // Tìm kiếm loại phòng
    public List<LoaiPhong> search(String keyword) {
        String sql = "SELECT * FROM LOAI_PHONG WHERE TenLoai LIKE ?";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, loaiPhongRowMapper, searchPattern);
    }
    
    // Đếm tổng số loại phòng
    public int count() {
        String sql = "SELECT COUNT(*) FROM LOAI_PHONG";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // Lấy loại phòng theo khoảng giá
    public List<LoaiPhong> getByPriceRange(double minPrice, double maxPrice) {
        String sql = "SELECT * FROM LOAI_PHONG WHERE GiaPhong BETWEEN ? AND ? ORDER BY GiaPhong";
        return jdbcTemplate.query(sql, loaiPhongRowMapper, minPrice, maxPrice);
    }
    
    // Lấy loại phòng rẻ nhất
    public LoaiPhong getCheapest() {
        String sql = "SELECT TOP 1 * FROM LOAI_PHONG ORDER BY GiaPhong ASC";
        try {
            return jdbcTemplate.queryForObject(sql, loaiPhongRowMapper);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Lấy loại phòng đắt nhất
    public LoaiPhong getMostExpensive() {
        String sql = "SELECT TOP 1 * FROM LOAI_PHONG ORDER BY GiaPhong DESC";
        try {
            return jdbcTemplate.queryForObject(sql, loaiPhongRowMapper);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Kiểm tra tên loại phòng đã tồn tại
    public boolean isNameExists(String tenLoai) {
        String sql = "SELECT COUNT(*) FROM LOAI_PHONG WHERE TenLoai = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, tenLoai);
        return count != null && count > 0;
    }
    
    // Cập nhật giá phòng
    public int updatePrice(int id, double newPrice) {
        String sql = "UPDATE LOAI_PHONG SET GiaPhong = ? WHERE ID_LoaiPhong = ?";
        return jdbcTemplate.update(sql, newPrice, id);
    }
    
    // Thống kê số phòng theo loại
    public int countRoomsByType(int loaiPhongId) {
        String sql = "SELECT COUNT(*) FROM PHONG WHERE ID_LoaiPhong = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, loaiPhongId);
    }
    
    // Thống kê số phòng đang có sinh viên ở theo loại
    public int countOccupiedRoomsByType(int loaiPhongId) {
        String sql = "SELECT COUNT(*) FROM PHONG WHERE ID_LoaiPhong = ? AND SoNguoiHienTai > 0";
        return jdbcTemplate.queryForObject(sql, Integer.class, loaiPhongId);
    }
    
    // Tính tổng doanh thu theo loại phòng
    public double getRevenueByType(int loaiPhongId) {
        String sql = "SELECT SUM(lp.GiaPhong) FROM PHONG p " +
                    "JOIN LOAI_PHONG lp ON p.ID_LoaiPhong = lp.ID_LoaiPhong " +
                    "JOIN HOP_DONG hd ON p.ID_Phong = hd.ID_Phong " +
                    "WHERE lp.ID_LoaiPhong = ? AND hd.TrangThai = N'Hiệu lực'";
        Double result = jdbcTemplate.queryForObject(sql, Double.class, loaiPhongId);
        return result != null ? result : 0;
    }
}