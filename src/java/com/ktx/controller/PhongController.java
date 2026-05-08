package com.ktx.controller;

import com.ktx.dao.PhongDAO;
import com.ktx.dao.ToaNhaDAO;
import com.ktx.dao.LoaiPhongDAO;
import com.ktx.model.Phong;
import com.ktx.model.SinhVien;
import com.ktx.model.ToaNha;
import com.ktx.model.LoaiPhong;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/phong")
public class PhongController {
    
    @Autowired
    private PhongDAO phongDAO;
    
    @Autowired
    private ToaNhaDAO toaNhaDAO;
    
    @Autowired
    private LoaiPhongDAO loaiPhongDAO;
    
    // Hiển thị danh sách phòng (dành cho Admin)
    @GetMapping("/list")
    public String listPhong(Model model) {
        List<Phong> phongList = phongDAO.getAll();
        model.addAttribute("phongList", phongList);
        return "phong/list";
    }
    
    // Xem thông tin phòng của sinh viên đang đăng nhập
    @GetMapping("/phong-cua-toi")
    public String phongCuaToi(HttpSession session, Model model) {
        SinhVien sv = (SinhVien) session.getAttribute("sinhVien");
        if (sv == null) {
            return "redirect:/login";
        }
        
        // Lấy phòng hiện tại của sinh viên
        int phongId = phongDAO.getCurrentRoom(sv.getMssv());
        
        if (phongId > 0) {
            Phong phong = phongDAO.getById(phongId);
            model.addAttribute("phong", phong);
            model.addAttribute("thanhVienList", phongDAO.getStudentsInRoom(phongId));
            model.addAttribute("thietBiList", phongDAO.getEquipment(phongId));
        } else {
            model.addAttribute("phong", null);
        }
        
        return "phong/phong-cua-toi";
    }
    
    // Hiển thị form thêm phòng
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("phong", new Phong());
        model.addAttribute("toaNhaList", toaNhaDAO.getAll());
        model.addAttribute("loaiPhongList", loaiPhongDAO.getAll());
        return "phong/add";
    }
    
    // Xử lý thêm phòng
    @PostMapping("/add")
    public String addPhong(@ModelAttribute Phong phong,
                           RedirectAttributes redirectAttributes) {
        try {
            // Kiểm tra tên phòng đã tồn tại trong tòa nhà chưa
            if (phongDAO.isPhongExists(phong.getTenPhong(), phong.getIdToaNha())) {
                redirectAttributes.addFlashAttribute("error", 
                    "Tên phòng đã tồn tại trong tòa nhà này!");
                return "redirect:/phong/add";
            }
            
            phongDAO.add(phong);
            redirectAttributes.addFlashAttribute("success", "Thêm phòng thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Thêm phòng thất bại: " + e.getMessage());
        }
        return "redirect:/phong/list";
    }
    
    // Xem chi tiết phòng (dành cho Admin)
    @GetMapping("/detail/{id}")
    public String viewDetail(@PathVariable int id, Model model) {
        Phong phong = phongDAO.getById(id);
        if (phong == null) {
            return "redirect:/phong/list";
        }
        model.addAttribute("phong", phong);
        model.addAttribute("sinhVienList", phongDAO.getStudentsInRoom(id));
        model.addAttribute("thietBiList", phongDAO.getEquipment(id));
        return "phong/detail";
    }
    
    // Hiển thị form sửa phòng
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable int id, Model model) {
        Phong phong = phongDAO.getById(id);
        if (phong == null) {
            return "redirect:/phong/list";
        }
        model.addAttribute("phong", phong);
        model.addAttribute("toaNhaList", toaNhaDAO.getAll());
        model.addAttribute("loaiPhongList", loaiPhongDAO.getAll());
        return "phong/edit";
    }
    
    // Xử lý cập nhật phòng
    @PostMapping("/edit")
    public String updatePhong(@ModelAttribute Phong phong,
                              RedirectAttributes redirectAttributes) {
        try {
            phongDAO.update(phong);
            redirectAttributes.addFlashAttribute("success", "Cập nhật phòng thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật thất bại: " + e.getMessage());
        }
        return "redirect:/phong/list";
    }
    
    // Xóa phòng
    @GetMapping("/delete/{id}")
    public String deletePhong(@PathVariable int id,
                              RedirectAttributes redirectAttributes) {
        try {
            // Kiểm tra phòng có sinh viên đang ở không
            if (phongDAO.hasStudents(id)) {
                redirectAttributes.addFlashAttribute("error", 
                    "Không thể xóa phòng đang có sinh viên ở!");
                return "redirect:/phong/list";
            }
            
            phongDAO.delete(id);
            redirectAttributes.addFlashAttribute("success", "Xóa phòng thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Xóa thất bại: " + e.getMessage());
        }
        return "redirect:/phong/list";
    }
    
    // Tìm kiếm phòng
    @GetMapping("/search")
    public String searchPhong(@RequestParam String keyword, Model model) {
        List<Phong> phongList = phongDAO.search(keyword);
        model.addAttribute("phongList", phongList);
        model.addAttribute("keyword", keyword);
        return "phong/list";
    }
    
    // Lọc phòng theo trạng thái
    @GetMapping("/filter")
    public String filterByStatus(@RequestParam String status, Model model) {
        List<Phong> phongList = phongDAO.getByStatus(status);
        model.addAttribute("phongList", phongList);
        model.addAttribute("status", status);
        return "phong/list";
    }
    
    // Lọc phòng theo tòa nhà
    @GetMapping("/filterByBuilding")
    public String filterByBuilding(@RequestParam int toaNhaId, Model model) {
        List<Phong> phongList = phongDAO.getByBuilding(toaNhaId);
        model.addAttribute("phongList", phongList);
        model.addAttribute("toaNhaList", toaNhaDAO.getAll());
        model.addAttribute("selectedBuilding", toaNhaId);
        return "phong/list";
    }
}