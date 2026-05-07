package com.ktx.dao;

import com.ktx.model.KhaoSat;
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
}