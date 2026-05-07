package com.ktx.controller;

import com.ktx.dao.SinhVienDAO;
import com.ktx.model.SinhVien;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/sinhvien")
public class SinhVienController {
    
    @Autowired
    private SinhVienDAO sinhVienDAO;
    
    // Hiển thị danh sách sinh viên (dành cho admin)
    @GetMapping("/list")
    public String listSinhVien(Model model) {
        List<SinhVien> sinhVienList = sinhVienDAO.getAll();
        model.addAttribute("sinhVienList", sinhVienList);
        return "sinhvien/list";
    }
    
    // Hiển thị form thêm sinh viên
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("sinhVien", new SinhVien());
        return "sinhvien/add";
    }
    
    // Xử lý thêm sinh viên
    @PostMapping("/add")
    public String addSinhVien(@ModelAttribute SinhVien sinhVien,
                              RedirectAttributes redirectAttributes) {
        try {
            if (sinhVienDAO.getById(sinhVien.getMssv()) != null) {
                redirectAttributes.addFlashAttribute("error", "MSSV đã tồn tại!");
                return "redirect:/sinhvien/add";
            }
            sinhVienDAO.add(sinhVien);
            redirectAttributes.addFlashAttribute("success", "Thêm sinh viên thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Thêm sinh viên thất bại: " + e.getMessage());
        }
        return "redirect:/sinhvien/list";
    }
    
    // Hiển thị form sửa sinh viên
    @GetMapping("/edit/{mssv}")
    public String showEditForm(@PathVariable String mssv, Model model) {
        SinhVien sinhVien = sinhVienDAO.getById(mssv);
        if (sinhVien == null) return "redirect:/sinhvien/list";
        model.addAttribute("sinhVien", sinhVien);
        return "sinhvien/edit";
    }
    
    // Xử lý cập nhật sinh viên
    @PostMapping("/edit")
    public String updateSinhVien(@ModelAttribute SinhVien sinhVien,
                                 RedirectAttributes redirectAttributes) {
        try {
            sinhVienDAO.update(sinhVien);
            redirectAttributes.addFlashAttribute("success", "Cập nhật sinh viên thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật thất bại: " + e.getMessage());
        }
        return "redirect:/sinhvien/list";
    }
    
    // Xóa sinh viên
    @GetMapping("/delete/{mssv}")
    public String deleteSinhVien(@PathVariable String mssv,
                                 RedirectAttributes redirectAttributes) {
        try {
            if (sinhVienDAO.hasActiveContract(mssv)) {
                redirectAttributes.addFlashAttribute("error",
                    "Không thể xóa sinh viên đang có hợp đồng thuê phòng!");
                return "redirect:/sinhvien/list";
            }
            sinhVienDAO.delete(mssv);
            redirectAttributes.addFlashAttribute("success", "Xóa sinh viên thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Xóa thất bại: " + e.getMessage());
        }
        return "redirect:/sinhvien/list";
    }
    
    // Tìm kiếm sinh viên
    @GetMapping("/search")
    public String searchSinhVien(@RequestParam String keyword, Model model) {
        List<SinhVien> sinhVienList = sinhVienDAO.search(keyword);
        model.addAttribute("sinhVienList", sinhVienList);
        model.addAttribute("keyword", keyword);
        return "sinhvien/list";
    }
    
    // Xem chi tiết sinh viên
    @GetMapping("/detail/{mssv}")
    public String viewDetail(@PathVariable String mssv, Model model) {
        SinhVien sinhVien = sinhVienDAO.getById(mssv);
        if (sinhVien == null) return "redirect:/sinhvien/list";
        model.addAttribute("sinhVien", sinhVien);
        model.addAttribute("hopDongList", sinhVienDAO.getContracts(mssv));
        return "sinhvien/detail";
    }

    // =============================================
    // CHỨC NĂNG DÀNH CHO SINH VIÊN
    // =============================================

    // Xem hồ sơ cá nhân
    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        SinhVien sv = (SinhVien) session.getAttribute("sinhVien");
        if (sv == null) return "redirect:/login";
        SinhVien svMoiNhat = sinhVienDAO.getById(sv.getMssv());
        model.addAttribute("sinhVien", svMoiNhat);
        model.addAttribute("hopDongList", sinhVienDAO.getContracts(sv.getMssv()));
        return "sinhvien/profile";
    }

    // Xử lý cập nhật thông tin cá nhân
    @PostMapping("/profile/update")
    public String updateProfile(
            @RequestParam String mssv,
            @RequestParam String sdt,
            @RequestParam String email,
            @RequestParam(required = false) String lop,
            @RequestParam(required = false) String khoa,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            SinhVien sv = sinhVienDAO.getById(mssv);
            sv.setSdt(sdt);
            sv.setEmail(email);
            sv.setLop(lop);
            sv.setKhoa(khoa);
            sinhVienDAO.update(sv);
            session.setAttribute("sinhVien", sinhVienDAO.getById(mssv));
            redirectAttributes.addFlashAttribute("success", "Cập nhật thông tin thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật thất bại: " + e.getMessage());
        }
        return "redirect:/sinhvien/profile";
    }

    // Đổi mật khẩu
    @PostMapping("/profile/doimatkhau")
    public String doiMatKhau(
            @RequestParam String mssv,
            @RequestParam String matKhauCu,
            @RequestParam String matKhauMoi,
            @RequestParam String xacNhanMatKhau,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            if (!matKhauMoi.equals(xacNhanMatKhau)) {
                redirectAttributes.addFlashAttribute("errorMatKhau",
                    "Mật khẩu mới và xác nhận không khớp!");
                return "redirect:/sinhvien/profile";
            }
            boolean valid = sinhVienDAO.checkLogin(mssv, matKhauCu);
            if (!valid) {
                redirectAttributes.addFlashAttribute("errorMatKhau",
                    "Mật khẩu cũ không đúng!");
                return "redirect:/sinhvien/profile";
            }
            SinhVien sv = sinhVienDAO.getById(mssv);
            sv.setMatKhau(matKhauMoi);
            sinhVienDAO.update(sv);
            redirectAttributes.addFlashAttribute("successMatKhau",
                "Đổi mật khẩu thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMatKhau",
                "Đổi mật khẩu thất bại: " + e.getMessage());
        }
        return "redirect:/sinhvien/profile";
    }
}