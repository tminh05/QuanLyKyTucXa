package com.ktx.controller;

import com.ktx.dao.SachDAO;
import com.ktx.model.Sach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/thuvien")
public class ThuVienController {

    @Autowired
    private SachDAO sachDAO;

    // Trang danh sách sách
    @GetMapping("/list")
    public String list(
            @RequestParam(required = false) String theLoai,
            @RequestParam(required = false) String keyword,
            Model model) {
        if (keyword != null && !keyword.trim().isEmpty()) {
            model.addAttribute("danhSachSach", sachDAO.search(keyword));
            model.addAttribute("keyword", keyword);
        } else if (theLoai != null && !theLoai.trim().isEmpty()) {
            model.addAttribute("danhSachSach", sachDAO.getByTheLoai(theLoai));
            model.addAttribute("theLoaiChon", theLoai);
        } else {
            model.addAttribute("danhSachSach", sachDAO.getAll());
        }
        model.addAttribute("danhSachTheLoai", sachDAO.getTheLoaiList());
        return "thuvien/list";
    }

    // Đăng ký mượn sách
    @PostMapping("/muon")
    public String muon(
            @RequestParam String mssv,
            @RequestParam String hoTen,
            @RequestParam int idSach,
            Model model) {
        try {
            Sach sach = sachDAO.getById(idSach);
            if (sach == null || sach.getSoLuongConLai() <= 0) {
                model.addAttribute("error", "Sách đã hết! Vui lòng chọn sách khác.");
            } else {
                sachDAO.muonSach(mssv, hoTen, idSach);
                model.addAttribute("success",
                    "Đăng ký mượn thành công! Đến phòng quản lý KTX để nhận sách. Hạn trả: 14 ngày.");
            }
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi: " + e.getMessage());
        }
        model.addAttribute("danhSachSach", sachDAO.getAll());
        model.addAttribute("danhSachTheLoai", sachDAO.getTheLoaiList());
        return "thuvien/list";
    }

    // Xem sách đang mượn
    @GetMapping("/dangmuon")
    public String dangMuon(@RequestParam String mssv, Model model) {
        model.addAttribute("sachDangMuon", sachDAO.getSachDangMuon(mssv));
        model.addAttribute("mssv", mssv);
        return "thuvien/dangmuon";
    }
}