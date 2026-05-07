package com.ktx.controller.admin;

import com.ktx.service.PhongService;
import com.ktx.service.SinhVienService;
import com.ktx.service.HopDongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {
    @Autowired private SinhVienService svService;
    @Autowired private PhongService phongService;
    @Autowired private HopDongService hdService;

    @RequestMapping(value = {"", "/", "/dashboard"})
    public String index(Model model) {
        model.addAttribute("totalSV", svService.countSinhVien()); //
        model.addAttribute("totalPhong", phongService.countPhong()); //
        model.addAttribute("availableRooms", phongService.countAvailableRooms()); //
        return "admin/dashboard";
    }
}