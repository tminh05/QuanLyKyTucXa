package com.ktx.dao;

import com.ktx.model.DanhGia;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class DanhGiaDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<DanhGia> rowMapper = (rs, rowNum) -> {
        DanhGia d = new DanhGia();
        d.setIdDanhGia(rs.getInt("ID_DanhGia"));
        d.setMssv(rs.getString("MSSV"));
        d.setHoTen(rs.getString("HoTen"));
        d.setNoiDung(rs.getString("NoiDung"));
        d.setSoSao(rs.getInt("SoSao"));
        d.setSoLike(rs.getInt("SoLike"));
        d.setTag(rs.getString("Tag"));
        d.setNgayDang(rs.getTimestamp("NgayDang"));
        return d;
    };

    // Lấy tất cả đánh giá
    public List<DanhGia> getAll() {
        String sql = "SELECT * FROM DANH_GIA ORDER BY NgayDang DESC";
        return jdbcTemplate.query(sql, rowMapper);
    }

    // Thêm đánh giá mới
    public int add(DanhGia d) {
        String sql = "INSERT INTO DANH_GIA (MSSV, HoTen, NoiDung, SoSao, Tag) " +
                     "VALUES (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
                d.getMssv(), d.getHoTen(), d.getNoiDung(),
                d.getSoSao(), d.getTag());
    }

    // Like đánh giá
    public int like(int idDanhGia) {
        String sql = "UPDATE DANH_GIA SET SoLike = SoLike + 1 WHERE ID_DanhGia = ?";
        return jdbcTemplate.update(sql, idDanhGia);
    }

    // Đếm tổng đánh giá
    public int count() {
        String sql = "SELECT COUNT(*) FROM DANH_GIA";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    // Tính điểm trung bình sao
    public double avgSao() {
        String sql = "SELECT AVG(CAST(SoSao AS FLOAT)) FROM DANH_GIA";
        Double avg = jdbcTemplate.queryForObject(sql, Double.class);
        return avg != null ? avg : 0;
    }
}