package com.ktx.controller;

import com.ktx.dao.YeuCauHoTroDAO;
import com.ktx.model.YeuCauHoTro;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Date;

@Controller
@RequestMapping("/chinhsach")
public class ChinhSachController {

    @Autowired
    private YeuCauHoTroDAO yeuCauHoTroDAO;

    @GetMapping("/form")
    public String showForm(@RequestParam String loai, Model model) {
        model.addAttribute("loaiChinhSach", loai);
        return "chinhsach/form";
    }

    @PostMapping("/guiyeucau")
    public String guiYeuCau(
            @RequestParam String mssv,
            @RequestParam String hoTen,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date ngaySinh,
            @RequestParam(required = false) String gioiTinh,
            @RequestParam String cccd,
            @RequestParam(required = false) String lop,
            @RequestParam String sdt,
            @RequestParam String email,
            @RequestParam String diaChi,
            @RequestParam String loaiGiayTo,
            @RequestParam String loaiChinhSach,
            @RequestParam String moTa,
            Model model) {
        try {
            YeuCauHoTro y = new YeuCauHoTro();
            y.setMssv(mssv);
            y.setHoTen(hoTen);
            y.setNgaySinh(ngaySinh);
            y.setGioiTinh(gioiTinh);
            y.setCccd(cccd);
            y.setLop(lop);
            y.setSdt(sdt);
            y.setEmail(email);
            y.setDiaChi(diaChi);
            y.setLoaiGiayTo(loaiGiayTo);
            y.setLoaiChinhSach(loaiChinhSach);
            y.setMoTa(moTa);

            yeuCauHoTroDAO.add(y);

            model.addAttribute("success",
                "Gửi yêu cầu thành công! Chúng tôi sẽ xét duyệt trong 3-5 ngày làm việc.");
            model.addAttribute("loaiChinhSach", loaiChinhSach);

        } catch (Exception e) {
            model.addAttribute("error", "Gửi thất bại: " + e.getMessage());
            model.addAttribute("loaiChinhSach", loaiChinhSach);
        }
        return "chinhsach/form";
    }
}