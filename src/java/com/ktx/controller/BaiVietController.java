package com.ktx.controller;

import com.ktx.model.BaiViet;
import com.ktx.service.BaiVietService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/baiviet")
public class BaiVietController {

    @Autowired
    private BaiVietService service;

    @RequestMapping("/tin-tuc")
    public String tinTuc(Model model) {
        List<BaiViet> ds = service.getDanhSachTheoLoai("tin-tuc");
        model.addAttribute("danhSachBaiViet", ds);
        model.addAttribute("loaiBaiViet", "tin-tuc");
        model.addAttribute("tenLoai", "Tin tức & Sự kiện");
        return "baiviet/danhsach-baiviet";
    }

    @RequestMapping("/thong-bao")
    public String thongBao(Model model) {
        List<BaiViet> ds = service.getDanhSachTheoLoai("thong-bao");
        model.addAttribute("danhSachBaiViet", ds);
        model.addAttribute("loaiBaiViet", "thong-bao");
        model.addAttribute("tenLoai", "Thông báo");
        return "baiviet/danhsach-baiviet";
    }

    @RequestMapping("/noi-quy")
    public String noiQuy(Model model) {
        List<BaiViet> ds = service.getDanhSachTheoLoai("noi-quy");
        model.addAttribute("danhSachBaiViet", ds);
        model.addAttribute("loaiBaiViet", "noi-quy");
        model.addAttribute("tenLoai", "Nội quy & Quy định");
        return "baiviet/danhsach-baiviet";
    }

    @RequestMapping("/chitiet")
    public String chiTiet(@RequestParam("id") int id, Model model) {
        BaiViet bv = service.getChiTiet(id);
        if (bv == null) return "redirect:/home";
        model.addAttribute("baiViet", bv);
        return "baiviet/chitiet-baiviet";
    }
}