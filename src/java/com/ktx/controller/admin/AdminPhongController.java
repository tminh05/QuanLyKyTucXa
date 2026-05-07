package com.ktx.controller.admin;

import com.ktx.model.Phong;
import com.ktx.service.PhongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/phong")
public class AdminPhongController {
    @Autowired private PhongService phongService;

    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("dsPhong", phongService.getAllPhong());
        return "admin/phong/list";
    }

    @GetMapping("/add")
    public String add(Model model) {
        model.addAttribute("phong", new Phong());
        return "admin/phong/form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("phong") Phong p) {
        if (p.getIdPhong() > 0) phongService.updatePhong(p);
        else phongService.addPhong(p);
        return "redirect:/admin/phong/list";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        phongService.deletePhong(id);
        return "redirect:/admin/phong/list";
    }
}