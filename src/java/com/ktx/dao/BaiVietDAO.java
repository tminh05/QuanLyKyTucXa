package com.ktx.dao;

import com.ktx.model.BaiViet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@Repository
public class BaiVietDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<BaiViet> getDanhSachTheoLoai(String loai) {
        String sql = "SELECT * FROM BAI_VIET WHERE LoaiBaiViet = ? ORDER BY NgayDang DESC";
        return jdbcTemplate.query(sql, new BaiVietRowMapper(), loai);
    }

    public BaiViet getBaiVietById(int id) {
        String sql = "SELECT * FROM BAI_VIET WHERE ID_BaiViet = ?";
        List<BaiViet> list = jdbcTemplate.query(sql, new BaiVietRowMapper(), id);
        return list.isEmpty() ? null : list.get(0);
    }

    public void tangLuotXem(int id) {
        String sql = "UPDATE BAI_VIET SET LuotXem = LuotXem + 1 WHERE ID_BaiViet = ?";
        jdbcTemplate.update(sql, id);
    }

    private static class BaiVietRowMapper implements RowMapper<BaiViet> {
        @Override
        public BaiViet mapRow(ResultSet rs, int rowNum) throws SQLException {
            BaiViet b = new BaiViet();
            b.setIdBaiViet(rs.getInt("ID_BaiViet"));
            b.setTieuDe(rs.getString("TieuDe"));
            b.setTomTat(rs.getString("TomTat"));
            b.setNoiDung(rs.getString("NoiDung"));
            b.setAnhDaiDien(rs.getString("AnhDaiDien"));
            b.setLoaiBaiViet(rs.getString("LoaiBaiViet"));
            if (rs.getDate("NgayDang") != null) {
                b.setNgayDang(rs.getDate("NgayDang").toLocalDate());
            }
            b.setLuotXem(rs.getInt("LuotXem"));
            return b;
        }
    }
}