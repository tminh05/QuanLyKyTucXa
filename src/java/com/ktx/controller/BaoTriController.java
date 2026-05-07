package com.ktx.controller;

import com.ktx.dao.BaoTriDAO;
import com.ktx.dao.PhongDAO;
import com.ktx.dao.SinhVienDAO;
import com.ktx.dao.NhanVienDAO;
import com.ktx.model.YeuCauBaoTri;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

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
    
    // Hiển thị danh sách yêu cầu bảo trì
    @GetMapping("/list")
    public String listYeuCau(Model model) {
        List<YeuCauBaoTri> yeuCauList = baoTriDAO.getAll();
        model.addAttribute("yeuCauList", yeuCauList);
        return "baotri/list";
    }
    
    // Hiển thị form tạo yêu cầu bảo trì
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("yeuCau", new YeuCauBaoTri());
        model.addAttribute("phongList", phongDAO.getAll());
        model.addAttribute("sinhVienList", sinhVienDAO.getAll());
        return "baotri/add";
    }
    
    // Xử lý tạo yêu cầu bảo trì
    @PostMapping("/add")
    public String addYeuCau(@ModelAttribute YeuCauBaoTri yeuCau,
                            RedirectAttributes redirectAttributes) {
        try {
            baoTriDAO.add(yeuCau);
            redirectAttributes.addFlashAttribute("success", "Tạo yêu cầu bảo trì thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Tạo yêu cầu thất bại: " + e.getMessage());
        }
        return "redirect:/baotri/list";
    }
    
    // Hiển thị form xử lý yêu cầu bảo trì
    @GetMapping("/process/{id}")
    public String showProcessForm(@PathVariable int id, Model model) {
        YeuCauBaoTri yeuCau = baoTriDAO.getById(id);
        if (yeuCau == null) {
            return "redirect:/baotri/list";
        }
        model.addAttribute("yeuCau", yeuCau);
        model.addAttribute("nhanVienList", nhanVienDAO.getAll());
        return "baotri/process";
    }
    
    // Xử lý cập nhật yêu cầu bảo trì
    @PostMapping("/process")
    public String processYeuCau(@ModelAttribute YeuCauBaoTri yeuCau,
                                RedirectAttributes redirectAttributes) {
        try {
            baoTriDAO.update(yeuCau);
            redirectAttributes.addFlashAttribute("success", "Cập nhật yêu cầu bảo trì thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật thất bại: " + e.getMessage());
        }
        return "redirect:/baotri/list";
    }
    
    // Xóa yêu cầu bảo trì
    @GetMapping("/delete/{id}")
    public String deleteYeuCau(@PathVariable int id,
                               RedirectAttributes redirectAttributes) {
        try {
            baoTriDAO.delete(id);
            redirectAttributes.addFlashAttribute("success", "Xóa yêu cầu bảo trì thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Xóa thất bại: " + e.getMessage());
        }
        return "redirect:/baotri/list";
    }
    
    // Xem chi tiết yêu cầu bảo trì
    @GetMapping("/detail/{id}")
    public String viewDetail(@PathVariable int id, Model model) {
        YeuCauBaoTri yeuCau = baoTriDAO.getById(id);
        if (yeuCau == null) {
            return "redirect:/baotri/list";
        }
        model.addAttribute("yeuCau", yeuCau);
        return "baotri/detail";
    }
    
    // Lọc yêu cầu theo trạng thái
    @GetMapping("/filter")
    public String filterByStatus(@RequestParam String status, Model model) {
        List<YeuCauBaoTri> yeuCauList = baoTriDAO.getByStatus(status);
        model.addAttribute("yeuCauList", yeuCauList);
        model.addAttribute("status", status);
        return "baotri/list";
    }
    
    // Lọc yêu cầu theo phòng
    @GetMapping("/filterByRoom")
    public String filterByRoom(@RequestParam int phongId, Model model) {
        List<YeuCauBaoTri> yeuCauList = baoTriDAO.getByRoom(phongId);
        model.addAttribute("yeuCauList", yeuCauList);
        model.addAttribute("phongList", phongDAO.getAll());
        model.addAttribute("selectedRoom", phongId);
        return "baotri/list";
    }
    
    // Thống kê bảo trì
    @GetMapping("/statistics")
    public String statistics(Model model) {
        model.addAttribute("totalRequests", baoTriDAO.count());
        model.addAttribute("pendingRequests", baoTriDAO.countPendingRequests());
        model.addAttribute("processingRequests", baoTriDAO.countProcessingRequests());
        model.addAttribute("completedRequests", baoTriDAO.countCompletedRequests());
        model.addAttribute("avgProcessTime", baoTriDAO.getAverageProcessTime());
        return "baotri/statistics";
    }
}