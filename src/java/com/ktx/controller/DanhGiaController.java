package com.ktx.controller;

import com.ktx.dao.DanhGiaDAO;
import com.ktx.model.DanhGia;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/danhgia")
public class DanhGiaController {

    @Autowired
    private DanhGiaDAO danhGiaDAO;

    // Hiển thị trang đánh giá
    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("danhSachDanhGia", danhGiaDAO.getAll());
        model.addAttribute("tongDanhGia", danhGiaDAO.count());
        model.addAttribute("diemTrungBinh", danhGiaDAO.avgSao());
        return "danhgia/list";
    }

    // Gửi đánh giá mới
    @PostMapping("/add")
    public String add(
            @RequestParam String mssv,
            @RequestParam String hoTen,
            @RequestParam String noiDung,
            @RequestParam int soSao,
            @RequestParam String tag,
            Model model) {
        try {
            DanhGia d = new DanhGia();
            d.setMssv(mssv);
            d.setHoTen(hoTen);
            d.setNoiDung(noiDung);
            d.setSoSao(soSao);
            d.setTag(tag);
            danhGiaDAO.add(d);
        } catch (Exception e) {
            System.out.println("Lỗi thêm đánh giá: " + e.getMessage());
        }
        return "redirect:/danhgia/list";
    }

    // Like đánh giá
    @PostMapping("/like/{id}")
    public String like(@PathVariable int id) {
        danhGiaDAO.like(id);
        return "redirect:/danhgia/list";
    }
}