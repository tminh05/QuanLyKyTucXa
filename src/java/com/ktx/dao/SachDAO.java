package com.ktx.dao;

import com.ktx.model.MuonSach;
import com.ktx.model.Sach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class SachDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Sach> sachMapper = (rs, rowNum) -> {
        Sach s = new Sach();
        s.setIdSach(rs.getInt("ID_Sach"));
        s.setTenSach(rs.getString("TenSach"));
        s.setTacGia(rs.getString("TacGia"));
        s.setTheLoai(rs.getString("TheLoai"));
        s.setMoTa(rs.getString("MoTa"));
        s.setSoLuong(rs.getInt("SoLuong"));
        s.setSoLuongConLai(rs.getInt("SoLuongConLai"));
        s.setAnhBia(rs.getString("AnhBia"));
        s.setNamXuatBan(rs.getInt("NamXuatBan"));
        s.setTrangThai(rs.getString("TrangThai"));
        return s;
    };

    private RowMapper<MuonSach> muonMapper = (rs, rowNum) -> {
        MuonSach m = new MuonSach();
        m.setIdMuonSach(rs.getInt("ID_MuonSach"));
        m.setMssv(rs.getString("MSSV"));
        m.setHoTen(rs.getString("HoTen"));
        m.setIdSach(rs.getInt("ID_Sach"));
        m.setTenSach(rs.getString("TenSach"));
        m.setNgayMuon(rs.getDate("NgayMuon"));
        m.setNgayHenTra(rs.getDate("NgayHenTra"));
        m.setNgayTraThuc(rs.getDate("NgayTraThuc"));
        m.setTrangThai(rs.getString("TrangThai"));
        return m;
    };

    // Lấy tất cả sách
    public List<Sach> getAll() {
        return jdbcTemplate.query(
            "SELECT * FROM SACH ORDER BY TheLoai, TenSach", sachMapper);
    }

    // Lấy sách theo thể loại
    public List<Sach> getByTheLoai(String theLoai) {
        return jdbcTemplate.query(
            "SELECT * FROM SACH WHERE TheLoai = ? ORDER BY TenSach",
            sachMapper, theLoai);
    }

    // Tìm kiếm sách
    public List<Sach> search(String keyword) {
        String kw = "%" + keyword + "%";
        return jdbcTemplate.query(
            "SELECT * FROM SACH WHERE TenSach LIKE ? OR TacGia LIKE ? OR TheLoai LIKE ?",
            sachMapper, kw, kw, kw);
    }

    // Lấy sách theo ID
    public Sach getById(int id) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM SACH WHERE ID_Sach = ?", sachMapper, id);
        } catch (Exception e) { return null; }
    }

    // Đăng ký mượn sách
    public int muonSach(String mssv, String hoTen, int idSach) {
        // Trừ số lượng còn lại
        jdbcTemplate.update(
            "UPDATE SACH SET SoLuongConLai = SoLuongConLai - 1 " +
            "WHERE ID_Sach = ? AND SoLuongConLai > 0", idSach);
        // Cập nhật trạng thái
        jdbcTemplate.update(
            "UPDATE SACH SET TrangThai = CASE " +
            "WHEN SoLuongConLai <= 0 THEN N'Hết sách' ELSE N'Còn sách' END " +
            "WHERE ID_Sach = ?", idSach);
        // Thêm bản ghi mượn (hạn trả 14 ngày)
        return jdbcTemplate.update(
            "INSERT INTO MUON_SACH (MSSV, HoTen, ID_Sach, NgayHenTra) " +
            "VALUES (?, ?, ?, DATEADD(day, 14, GETDATE()))",
            mssv, hoTen, idSach);
    }

    // Xem sách đang mượn theo MSSV
    public List<MuonSach> getSachDangMuon(String mssv) {
        return jdbcTemplate.query(
            "SELECT ms.*, s.TenSach FROM MUON_SACH ms " +
            "JOIN SACH s ON ms.ID_Sach = s.ID_Sach " +
            "WHERE ms.MSSV = ? ORDER BY ms.NgayMuon DESC",
            muonMapper, mssv);
    }

    // Lấy danh sách thể loại
    public List<String> getTheLoaiList() {
        return jdbcTemplate.queryForList(
            "SELECT DISTINCT TheLoai FROM SACH ORDER BY TheLoai", String.class);
    }
}