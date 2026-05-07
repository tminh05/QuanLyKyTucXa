package com.ktx.dao;

import com.ktx.model.YeuCauHoTro;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class YeuCauHoTroDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<YeuCauHoTro> rowMapper = (rs, rowNum) -> {
        YeuCauHoTro y = new YeuCauHoTro();
        y.setIdYeuCau(rs.getInt("ID_YeuCau"));
        y.setMssv(rs.getString("MSSV"));
        y.setHoTen(rs.getString("HoTen"));
        y.setNgaySinh(rs.getDate("NgaySinh"));
        y.setGioiTinh(rs.getString("GioiTinh"));
        y.setCccd(rs.getString("CCCD"));
        y.setLop(rs.getString("Lop"));
        y.setSdt(rs.getString("SDT"));
        y.setEmail(rs.getString("Email"));
        y.setDiaChi(rs.getString("DiaChi"));
        y.setLoaiGiayTo(rs.getString("LoaiGiayTo"));
        y.setLoaiChinhSach(rs.getString("LoaiChinhSach"));
        y.setMoTa(rs.getString("MoTa"));
        y.setTrangThai(rs.getString("TrangThai"));
        y.setNgayNop(rs.getDate("NgayNop"));
        return y;
    };

    public int add(YeuCauHoTro y) {
        String sql = "INSERT INTO YEU_CAU_HO_TRO " +
                     "(MSSV, HoTen, NgaySinh, GioiTinh, CCCD, Lop, SDT, Email, " +
                     "DiaChi, LoaiGiayTo, LoaiChinhSach, MoTa) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
                y.getMssv(), y.getHoTen(), y.getNgaySinh(), y.getGioiTinh(),
                y.getCccd(), y.getLop(), y.getSdt(), y.getEmail(),
                y.getDiaChi(), y.getLoaiGiayTo(), y.getLoaiChinhSach(), y.getMoTa());
    }

    public List<YeuCauHoTro> getAll() {
        String sql = "SELECT * FROM YEU_CAU_HO_TRO ORDER BY NgayNop DESC";
        return jdbcTemplate.query(sql, rowMapper);
    }
}