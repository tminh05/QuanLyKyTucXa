package com.ktx.controller;

import com.ktx.dao.SinhVienDAO;
import com.ktx.dao.PhongDAO;
import com.ktx.dao.HopDongDAO;
import com.ktx.dao.BaoTriDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @Autowired
    private SinhVienDAO sinhVienDAO;

    @Autowired
    private PhongDAO phongDAO;

    @Autowired
    private HopDongDAO hopDongDAO;

    @Autowired
    private BaoTriDAO baoTriDAO;

    @GetMapping("/")
    public String root() {
        return "redirect:/home";
    }

    @GetMapping("/home")
    public String home(Model model) {
        try {
            int soSinhVien = sinhVienDAO.count();
            int soPhong = phongDAO.count();
            int soHopDong = hopDongDAO.count();
            int soYeuCauBaoTri = baoTriDAO.count();

            System.out.println("============================");
            System.out.println("SinhVien: " + soSinhVien);
            System.out.println("Phong: " + soPhong);
            System.out.println("HopDong: " + soHopDong);
            System.out.println("BaoTri: " + soYeuCauBaoTri);
            System.out.println("============================");

            model.addAttribute("soSinhVien", soSinhVien);
            model.addAttribute("soPhong", soPhong);
            model.addAttribute("soHopDong", soHopDong);
            model.addAttribute("soYeuCauBaoTri", soYeuCauBaoTri);
        } catch (Exception e) {
            System.out.println("LỖI KẾT NỐI: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("soSinhVien", 0);
            model.addAttribute("soPhong", 0);
            model.addAttribute("soHopDong", 0);
            model.addAttribute("soYeuCauBaoTri", 0);
        }
        return "index";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        try {
            model.addAttribute("totalStudents", sinhVienDAO.count());
            model.addAttribute("totalRooms", phongDAO.count());
            model.addAttribute("availableRooms", phongDAO.countAvailableRooms());
            model.addAttribute("activeContracts", hopDongDAO.countActiveContracts());
            model.addAttribute("pendingRepairs", baoTriDAO.countPendingRequests());
            model.addAttribute("expiringContracts", hopDongDAO.getExpiringContracts());
        } catch (Exception e) {
            System.out.println("LỖI DASHBOARD: " + e.getMessage());
        }
        return "dashboard";
    }
}