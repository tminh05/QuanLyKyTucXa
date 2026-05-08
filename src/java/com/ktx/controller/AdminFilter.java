package com.ktx.controller;

import com.ktx.model.NhanVien;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        
        String uri = request.getRequestURI();
        String ctx = request.getContextPath();
        
        System.out.println("AdminFilter - Đang xử lý: " + uri); // Để debug
        
        // Cho phép vào trang login admin mà không cần đăng nhập
        if (uri.equals(ctx + "/admin/login")) {
            chain.doFilter(req, res);
            return;
        }
        
        // Cho phép logout
        if (uri.equals(ctx + "/admin/logout")) {
            chain.doFilter(req, res);
            return;
        }
        
        // Kiểm tra đã đăng nhập admin chưa
        if (session != null && session.getAttribute("admin") != null) {
            NhanVien admin = (NhanVien) session.getAttribute("admin");
            if (admin != null && "ADMIN".equals(admin.getVaiTro())) {
                chain.doFilter(req, res);
                return;
            }
        }
        
        // Chưa đăng nhập -> chuyển về login admin
        System.out.println("AdminFilter - Chưa đăng nhập, chuyển về login");
        response.sendRedirect(ctx + "/admin/login");
    }

    @Override public void init(FilterConfig fc) {}
    @Override public void destroy() {}
}