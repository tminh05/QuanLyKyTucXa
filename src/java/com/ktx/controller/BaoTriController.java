package com.ktx.controller;

import com.ktx.dao.BaoTriDAO;
import com.ktx.dao.PhongDAO;
import com.ktx.dao.SinhVienDAO;
import com.ktx.dao.NhanVienDAO;
import com.ktx.model.Phong;
import com.ktx.model.SinhVien;
import com.ktx.model.YeuCauBaoTri;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/baotri")
public class BaoTriController {
    
    @Autowired
    private BaoTriDAO baoTriDAO;
    
    @Autowired
    private PhongDAO phongDAO;
    
    @Autowired
    private SinhVienDAO sinhVienDAO;
    
    @Autowired
    private NhanVienDAO nhanVienDAO;
    
    // ==================== HIỂN THỊ DANH SÁCH ====================
    // Nếu là admin -> xem tất cả
    // Nếu là sinh viên -> chỉ xem yêu cầu của mình
    @GetMapping("/list")
    public String listYeuCau(HttpSession session, Model model) {
        SinhVien sv = (SinhVien) session.getAttribute("sinhVien");
        
        List<YeuCauBaoTri> yeuCauList;
        
        if (sv != null) {
            // Sinh viên: chỉ xem yêu cầu của mình
            yeuCauList = baoTriDAO.getByStudent(sv.getMssv());
            model.addAttribute("isStudent", true);
            model.addAttribute("sinhVien", sv);
        } else {
            // Admin: xem tất cả
            yeuCauList = baoTriDAO.getAll();
            model.addAttribute("isStudent", false);
        }
        
        model.addAttribute("yeuCauList", yeuCauList);
        return "baotri/list";
    }
    
    // ==================== HIỂN THỊ FORM THÊM YÊU CẦU ====================
    @GetMapping("/add")
    public String showAddForm(HttpSession session, Model model) {
        SinhVien sv = (SinhVien) session.getAttribute("sinhVien");
        
        model.addAttribute("yeuCau", new YeuCauBaoTri());
        
        if (sv != null) {
            // Sinh viên: tự động lấy phòng của mình
            int phongId = baoTriDAO.getCurrentRoom(sv.getMssv());
            if (phongId > 0) {
                Phong p = phongDAO.getById(phongId);
                model.addAttribute("autoPhongId", phongId);
                model.addAttribute("autoTenPhong", p != null ? p.getTenPhong() : "");
            }
            model.addAttribute("isStudent", true);
            model.addAttribute("sinhVien", sv);
        } else {
            // Admin: chọn phòng và sinh viên
            model.addAttribute("phongList", phongDAO.getAll());
            model.addAttribute("sinhVienList", sinhVienDAO.getAll());
            model.addAttribute("isStudent", false);
        }
        
        return "baotri/add";
    }
    
    // ==================== XỬ LÝ THÊM YÊU CẦU ====================
    @PostMapping("/add")
    public String addYeuCau(@ModelAttribute YeuCauBaoTri yeuCau,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        SinhVien sv = (SinhVien) session.getAttribute("sinhVien");
        
        try {
            if (sv != null) {
                // Sinh viên: tự động gán MSSV và ID_Phong
                yeuCau.setMssv(sv.getMssv());
                int phongId = baoTriDAO.getCurrentRoom(sv.getMssv());
                yeuCau.setIdPhong(phongId);
            }
            
            baoTriDAO.add(yeuCau);
            redirectAttributes.addFlashAttribute("success", "Gửi yêu cầu bảo trì thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Gửi yêu cầu thất bại: " + e.getMessage());
        }
        
        return "redirect:/baotri/list";
    }
    
    // ==================== HIỂN THỊ FORM XỬ LÝ (CHỈ ADMIN) ====================
    @GetMapping("/process/{id}")
    public String showProcessForm(@PathVariable int id, HttpSession session, Model model) {
        SinhVien sv = (SinhVien) session.getAttribute("sinhVien");
        
        // Chỉ admin mới được xử lý
        if (sv != null) {
            return "redirect:/baotri/list";
        }
        
        YeuCauBaoTri yeuCau = baoTriDAO.getById(id);
        if (yeuCau == null) {
            return "redirect:/baotri/list";
        }
        model.addAttribute("yeuCau", yeuCau);
        model.addAttribute("nhanVienList", nhanVienDAO.getAll());
        return "baotri/process";
    }
    
    // ==================== XỬ LÝ CẬP NHẬT (CHỈ ADMIN) ====================
    @PostMapping("/process")
    public String processYeuCau(@ModelAttribute YeuCauBaoTri yeuCau,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        SinhVien sv = (SinhVien) session.getAttribute("sinhVien");
        
        // Chỉ admin mới được xử lý
        if (sv != null) {
            return "redirect:/baotri/list";
        }
        
        try {
            baoTriDAO.update(yeuCau);
            redirectAttributes.addFlashAttribute("success", "Cập nhật yêu cầu bảo trì thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật thất bại: " + e.getMessage());
        }
        return "redirect:/baotri/list";
    }
    
    // ==================== XÓA YÊU CẦU (CHỈ ADMIN) ====================
    @GetMapping("/delete/{id}")
    public String deleteYeuCau(@PathVariable int id,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        SinhVien sv = (SinhVien) session.getAttribute("sinhVien");
        
        // Chỉ admin mới được xóa
        if (sv != null) {
            return "redirect:/baotri/list";
        }
        
        try {
            baoTriDAO.delete(id);
            redirectAttributes.addFlashAttribute("success", "Xóa yêu cầu bảo trì thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Xóa thất bại: " + e.getMessage());
        }
        return "redirect:/baotri/list";
    }
    
    // ==================== HỦY YÊU CẦU (DÀNH CHO SINH VIÊN) ====================
    @GetMapping("/cancel/{id}")
    public String cancelYeuCau(@PathVariable int id,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        SinhVien sv = (SinhVien) session.getAttribute("sinhVien");
        
        if (sv == null) {
            return "redirect:/login";
        }
        
        int result = baoTriDAO.cancel(id, sv.getMssv());
        if (result > 0) {
            redirectAttributes.addFlashAttribute("success", "Đã hủy yêu cầu!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Không thể hủy yêu cầu này!");
        }
        return "redirect:/baotri/list";
    }
    // Sửa nội dung yêu cầu bảo trì (dành cho sinh viên)
    @PostMapping("/edit-content")
    public String editContent(@RequestParam int id,
                          @RequestParam String noiDung,
                          HttpSession session,
                          RedirectAttributes ra) {
    SinhVien sv = (SinhVien) session.getAttribute("sinhVien");
    if (sv == null) return "redirect:/login";
    
    // Kiểm tra yêu cầu thuộc về sinh viên này và đang ở trạng thái "Chờ xử lý"
    YeuCauBaoTri yc = baoTriDAO.getById(id);
    if (yc == null || !yc.getMssv().equals(sv.getMssv()) || !"Chờ xử lý".equals(yc.getTrangThai())) {
        ra.addFlashAttribute("error", "Không thể sửa yêu cầu này!");
        return "redirect:/baotri/list";
    }
    
    if (noiDung == null || noiDung.trim().isEmpty()) {
        ra.addFlashAttribute("error", "Vui lòng nhập nội dung!");
        return "redirect:/baotri/list";
    }
    
    yc.setNoiDung(noiDung);
    yc.setNgayCapNhat(new java.util.Date());
    baoTriDAO.updateContent(yc);
    
    ra.addFlashAttribute("success", "Đã cập nhật nội dung yêu cầu!");
    return "redirect:/baotri/list";
    }
    
}