package com.ktx.controller;

import com.ktx.dao.HopDongDAO;
import com.ktx.dao.SinhVienDAO;
import com.ktx.dao.PhongDAO;
import com.ktx.model.HopDong;
import com.ktx.model.SinhVien;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/hopdong")
public class HopDongController {

    @Autowired
    private HopDongDAO hopDongDAO;

    @Autowired
    private SinhVienDAO sinhVienDAO;

    @Autowired
    private PhongDAO phongDAO;

    // Hiển thị danh sách hợp đồng
    @GetMapping("/list")
    public String listHopDong(Model model) {
        List<HopDong> hopDongList = hopDongDAO.getAll();
        model.addAttribute("hopDongList", hopDongList);
        return "hopdong/list";
    }

    // Hiển thị form thêm hợp đồng
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("hopDong", new HopDong());
        model.addAttribute("sinhVienList", sinhVienDAO.getStudentsWithoutContract());
        model.addAttribute("phongList", phongDAO.getAvailableRooms());
        return "hopdong/add";
    }

    // Xử lý thêm hợp đồng
    @PostMapping("/add")
    public String addHopDong(@ModelAttribute HopDong hopDong,
                             RedirectAttributes redirectAttributes) {
        try {
            // SỬA: Kiểm tra sinh viên chưa được chọn
            if (hopDong.getMssv() == null || hopDong.getMssv().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Vui lòng chọn sinh viên!");
                return "redirect:/hopdong/add";
            }

            // SỬA: Kiểm tra phòng chưa được chọn (idPhong == 0 là chưa chọn)
            if (hopDong.getIdPhong() == 0) {
                redirectAttributes.addFlashAttribute("error", "Vui lòng chọn phòng!");
                return "redirect:/hopdong/add";
            }

            // Kiểm tra sinh viên đã có hợp đồng hiệu lực chưa
            if (hopDongDAO.hasActiveContract(hopDong.getMssv())) {
                redirectAttributes.addFlashAttribute("error",
                        "Sinh viên đã có hợp đồng hiệu lực!");
                return "redirect:/hopdong/add";
            }

            // Kiểm tra phòng còn chỗ không
            if (!phongDAO.hasAvailableSlot(hopDong.getIdPhong())) {
                redirectAttributes.addFlashAttribute("error",
                        "Phòng đã đầy, không thể thêm hợp đồng mới!");
                return "redirect:/hopdong/add";
            }

            hopDongDAO.add(hopDong);
            redirectAttributes.addFlashAttribute("success", "Thêm hợp đồng thành công!");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Thêm hợp đồng thất bại: " + e.getMessage());
        }
        return "redirect:/hopdong/list";
    }

    // Hiển thị form sửa hợp đồng
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable int id, Model model) {
        HopDong hopDong = hopDongDAO.getById(id);
        if (hopDong == null) {
            return "redirect:/hopdong/list";
        }
        model.addAttribute("hopDong", hopDong);
        model.addAttribute("phongList", phongDAO.getAvailableRooms());
        return "hopdong/edit";
    }

    // Xử lý cập nhật hợp đồng
    @PostMapping("/edit")
    public String updateHopDong(@ModelAttribute HopDong hopDong,
                                RedirectAttributes redirectAttributes) {
        try {
            hopDongDAO.update(hopDong);
            redirectAttributes.addFlashAttribute("success", "Cập nhật hợp đồng thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật thất bại: " + e.getMessage());
        }
        return "redirect:/hopdong/list";
    }

    // Xóa hợp đồng
    @GetMapping("/delete/{id}")
    public String deleteHopDong(@PathVariable int id,
                                RedirectAttributes redirectAttributes) {
        try {
            hopDongDAO.delete(id);
            redirectAttributes.addFlashAttribute("success", "Xóa hợp đồng thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Xóa thất bại: " + e.getMessage());
        }
        return "redirect:/hopdong/list";
    }

    // Xem chi tiết hợp đồng
    @GetMapping("/detail/{id}")
    public String viewDetail(@PathVariable int id, Model model) {
        HopDong hopDong = hopDongDAO.getById(id);
        if (hopDong == null) {
            return "redirect:/hopdong/list";
        }
        model.addAttribute("hopDong", hopDong);
        model.addAttribute("hoaDonList", hopDongDAO.getInvoices(id));
        return "hopdong/detail";
    }

    // Gia hạn hợp đồng
    @GetMapping("/renew/{id}")
    public String renewContract(@PathVariable int id,
                                @RequestParam String newEndDate,
                                RedirectAttributes redirectAttributes) {
        try {
            hopDongDAO.renewContract(id, newEndDate);
            redirectAttributes.addFlashAttribute("success", "Gia hạn hợp đồng thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Gia hạn thất bại: " + e.getMessage());
        }
        return "redirect:/hopdong/list";
    }

        // Xem hợp đồng của sinh viên đang đăng nhập
@GetMapping("/hopdong-cua-toi")
public String hopDongCuaToi(HttpSession session, Model model) {
    SinhVien sv = (SinhVien) session.getAttribute("sinhVien");
    if (sv == null) return "redirect:/login";
    try {
        model.addAttribute("hopDongList", hopDongDAO.getByStudent(sv.getMssv()));
        model.addAttribute("sinhVien", sv);
    } catch (Exception e) {
        System.out.println("Lỗi hợp đồng: " + e.getMessage());
    }
    return "hopdong/hopdong-cua-toi";
}  

    // Tìm kiếm hợp đồng
    @GetMapping("/search")
    public String searchHopDong(@RequestParam String keyword, Model model) {
        List<HopDong> hopDongList = hopDongDAO.search(keyword);
        model.addAttribute("hopDongList", hopDongList);
        model.addAttribute("keyword", keyword);
        return "hopdong/list";
    }
}