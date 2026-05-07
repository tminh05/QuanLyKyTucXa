package com.ktx.controller.admin;

import com.ktx.model.SinhVien;
import com.ktx.service.SinhVienService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/sinhvien")
public class AdminSinhVienController {
    @Autowired private SinhVienService svService;

    @GetMapping("/list")
    public String list(Model model, @RequestParam(required = false) String keyword) {
        model.addAttribute("dsSinhVien", (keyword != null) ? svService.searchSinhVien(keyword) : svService.getAllSinhVien());
        return "admin/sinhvien/list";
    }

    @GetMapping("/add")
    public String add(Model model) {
        model.addAttribute("sinhVien", new SinhVien());
        return "admin/sinhvien/form";
    }

    @GetMapping("/edit/{mssv}")
    public String edit(@PathVariable String mssv, Model model) {
        model.addAttribute("sinhVien", svService.getSinhVienByMssv(mssv));
        return "admin/sinhvien/form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("sinhVien") SinhVien sv) {
        if (svService.getSinhVienByMssv(sv.getMssv()) != null) svService.updateSinhVien(sv);
        else svService.addSinhVien(sv);
        return "redirect:/admin/sinhvien/list";
    }

    @GetMapping("/delete/{mssv}")
    public String delete(@PathVariable String mssv) {
        svService.deleteSinhVien(mssv);
        return "redirect:/admin/sinhvien/list";
    }
}