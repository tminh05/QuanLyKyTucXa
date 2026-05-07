package com.ktx.controller;

import com.ktx.model.KhaoSat;
import com.ktx.service.KhaoSatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/khaosat")
public class KhaoSatController {

    @Autowired
    private KhaoSatService service;

    @GetMapping("/form")
    public String showForm(Model model) {
        model.addAttribute("khaoSat", new KhaoSat());
        return "khaosat/form-khaosat";
    }

    @PostMapping("/gui")
    public String guiKhaoSat(
            @RequestParam("hoTen") String hoTen,
            @RequestParam(value = "lop", required = false) String lop,
            @RequestParam(value = "mssv", required = false) String mssv,
            @RequestParam(value = "gmail", required = false) String gmail,
            @RequestParam("cau1")  int cau1,
            @RequestParam("cau2")  int cau2,
            @RequestParam("cau3")  int cau3,
            @RequestParam("cau4")  int cau4,
            @RequestParam("cau5")  int cau5,
            @RequestParam("cau6")  int cau6,
            @RequestParam("cau7")  int cau7,
            @RequestParam("cau8")  int cau8,
            @RequestParam("cau9")  int cau9,
            @RequestParam("cau10") int cau10,
            @RequestParam("yKien") String yKien,
            Model model) {

        try {
            KhaoSat ks = new KhaoSat();
            ks.setHoTen(hoTen);
            ks.setLop(lop);
            ks.setMssv(mssv);
            ks.setGmail(gmail);
            ks.setCau1(cau1);   ks.setCau2(cau2);
            ks.setCau3(cau3);   ks.setCau4(cau4);
            ks.setCau5(cau5);   ks.setCau6(cau6);
            ks.setCau7(cau7);   ks.setCau8(cau8);
            ks.setCau9(cau9);   ks.setCau10(cau10);
            ks.setDanhGiaSao(0);
            ks.setYKien(yKien);
            service.luuKhaoSat(ks);
            return "khaosat/thanh-cong";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi: " + e.getMessage());
            return "khaosat/form-khaosat";
        }
    }
}