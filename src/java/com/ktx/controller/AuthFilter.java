package com.ktx.controller;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        String uri = request.getRequestURI();
        String ctx = request.getContextPath();

        // ===== QUAN TRỌNG: BỎ QUA CÁC URL CỦA ADMIN =====
        if (uri.startsWith(ctx + "/admin")) {
            chain.doFilter(req, res);
            return;
        }

        // Các URL công khai (không cần đăng nhập)
        boolean isPublic = uri.equals(ctx + "/login")
                || uri.equals(ctx + "/register")
                || uri.equals(ctx + "/")
                || uri.startsWith(ctx + "/resources/")
                || uri.startsWith(ctx + "/baiviet/")
                || uri.startsWith(ctx + "/khaosat/");

        boolean loggedIn = (session != null && session.getAttribute("sinhVien") != null);

        if (isPublic || loggedIn) {
            chain.doFilter(req, res);
        } else {
            response.sendRedirect(ctx + "/login");
        }
    }

    @Override public void init(FilterConfig fc) {}
    @Override public void destroy() {}
}