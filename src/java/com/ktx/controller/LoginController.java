package com.ktx.controller;

import com.ktx.dao.SinhVienDAO;
import com.ktx.model.SinhVien;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
public class LoginController {

    @Autowired
    private SinhVienDAO sinhVienDAO;

    // Hiển thị trang đăng nhập
    @GetMapping("/login")
    public String showLogin(HttpSession session) {
        if (session.getAttribute("sinhVien") != null) {
            return "redirect:/home";
        }
        return "login";  
    }

    // Xử lý đăng nhập
    @PostMapping("/login")
    public String doLogin(@RequestParam String mssv,
                          @RequestParam String matKhau,
                          HttpSession session,
                          Model model) {
        try {
            boolean valid = sinhVienDAO.checkLogin(mssv, matKhau);
            if (valid) {
                SinhVien sv = sinhVienDAO.getById(mssv);
                session.setAttribute("sinhVien", sv);
                
                // KIỂM TRA CÓ TRANG MUỐN QUAY LẠI KHÔNG
                String redirectUrl = (String) session.getAttribute("redirectUrl");
                if (redirectUrl != null && !redirectUrl.isEmpty()) {
                    session.removeAttribute("redirectUrl");
                    return "redirect:" + redirectUrl;
                }
                
                return "redirect:/home";
            } else {
                model.addAttribute("loginError", "MSSV hoặc mật khẩu không đúng!");
                return "login";
            }
        } catch (Exception e) {
            model.addAttribute("loginError", "Lỗi hệ thống: " + e.getMessage());
            return "login";
        }
    }

    // Xử lý đăng ký
    @PostMapping("/register")
    public String doRegister(
            @RequestParam String mssv,
            @RequestParam String hoTen,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date ngaySinh,
            @RequestParam(required = false) String gioiTinh,
            @RequestParam(required = false) String sdt,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String lop,
            @RequestParam(required = false) String khoa,
            @RequestParam String cccd,
            @RequestParam String matKhau,
            Model model) {
        try {
            // Kiểm tra MSSV đã tồn tại chưa
            if (sinhVienDAO.getById(mssv) != null) {
                model.addAttribute("registerError", "MSSV " + mssv + " đã tồn tại!");
                return "login";
            }

            // Tạo sinh viên mới
            SinhVien sv = new SinhVien();
            sv.setMssv(mssv);
            sv.setHoTen(hoTen);
            sv.setNgaySinh(ngaySinh);
            sv.setGioiTinh(gioiTinh);
            sv.setSdt(sdt);
            sv.setEmail(email);
            sv.setLop(lop);
            sv.setKhoa(khoa);
            sv.setCccd(cccd);
            sv.setMatKhau(matKhau);

            sinhVienDAO.add(sv);
            model.addAttribute("registerSuccess",
                "Đăng ký thành công! Vui lòng đăng nhập.");
            return "login";

        } catch (Exception e) {
            model.addAttribute("registerError", "Đăng ký thất bại: " + e.getMessage());
            return "login";
        }
    }

    // Đăng xuất
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}