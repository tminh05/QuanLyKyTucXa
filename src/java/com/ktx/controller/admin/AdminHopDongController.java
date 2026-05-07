package com.ktx.controller.admin;

import com.ktx.service.HopDongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/hopdong")
public class AdminHopDongController {
    
    @Autowired 
    private HopDongService hdService;

    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("dsHopDong", hdService.getAllHopDong());
        return "admin/hopdong/list";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable int id, Model model) {
        model.addAttribute("hopDong", hdService.getHopDongById(id));
        return "admin/hopdong/detail";
    }
}