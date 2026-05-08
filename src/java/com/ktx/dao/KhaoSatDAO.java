package com.ktx.dao;

import com.ktx.model.KhaoSat;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class KhaoSatDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void luuKhaoSat(KhaoSat ks) {
        // Tên cột phải khớp 100% với CREATE TABLE KHAO_SAT trong SQL
        String sql = "INSERT INTO KHAO_SAT " +
            "(HoTen, Lop, MaSV, Email, Cau1, Cau2, Cau3, Cau4, Cau5, " +
            "Cau6, Cau7, Cau8, Cau9, Cau10, DanhGiaSao, YKienRieng) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql,
            ks.getHoTen(), 
            ks.getLop(), 
            ks.getMssv(),       // Map vào cột MaSV trong SQL
            ks.getGmail(),      // Map vào cột Email trong SQL
            ks.getCau1(), 
            ks.getCau2(), 
            ks.getCau3(), 
            ks.getCau4(), 
            ks.getCau5(),
            ks.getCau6(), 
            ks.getCau7(), 
            ks.getCau8(), 
            ks.getCau9(), 
            ks.getCau10(),
            ks.getDanhGiaSao(), // Đã thêm vào Model ở trên
            ks.getYKien()       // Map vào cột YKienRieng trong SQL
        );
    }

    public List<KhaoSat> getAll() {
    String sql = "SELECT * FROM KHAO_SAT ORDER BY NgayGui DESC";
    return jdbcTemplate.query(sql, (rs, rowNum) -> {
        KhaoSat ks = new KhaoSat();
        ks.setIdKhaoSat(rs.getInt("ID"));
        ks.setHoTen(rs.getString("HoTen"));
        ks.setLop(rs.getString("Lop"));
        ks.setMssv(rs.getString("MaSV"));
        ks.setGmail(rs.getString("Email"));
        ks.setCau1(rs.getInt("Cau1"));
        ks.setCau2(rs.getInt("Cau2"));
        ks.setCau3(rs.getInt("Cau3"));
        ks.setCau4(rs.getInt("Cau4"));
        ks.setCau5(rs.getInt("Cau5"));
        ks.setCau6(rs.getInt("Cau6"));
        ks.setCau7(rs.getInt("Cau7"));
        ks.setCau8(rs.getInt("Cau8"));
        ks.setCau9(rs.getInt("Cau9"));
        ks.setCau10(rs.getInt("Cau10"));
        ks.setDanhGiaSao(rs.getInt("DanhGiaSao"));
        ks.setYKien(rs.getString("YKienRieng"));
        ks.setNgayGui(rs.getTimestamp("NgayGui").toLocalDateTime());
        return ks;
    });
    }

    public int count() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM KHAO_SAT", Integer.class);
    }

    public double avgSao() {
        Double avg = jdbcTemplate.queryForObject("SELECT AVG(CAST(DanhGiaSao AS FLOAT)) FROM KHAO_SAT", Double.class);
        return avg != null ? avg : 0;
    }
}