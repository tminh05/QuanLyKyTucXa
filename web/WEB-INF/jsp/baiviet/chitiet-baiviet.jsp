<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${baiViet.tieuDe} - Quản lý Ký túc xá</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }

        .top-bar { background: #1565C0; color: white; padding: 14px 0; font-size: 16px; }
        .top-bar-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px;
                         display: flex; gap: 30px; align-items: center; }
        .top-bar a { color: white; text-decoration: none; display: flex; align-items: center;
                     gap: 5px; opacity: 0.85; transition: opacity 0.2s; }
        .top-bar a:hover { opacity: 1; }

        .site-header { background: white; border-bottom: 3px solid #1565C0;
                       padding: 12px 0; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .header-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px;
                        display: flex; align-items: center; gap: 18px; }
        .header-logo { height: 110px; width: auto; }
        .header-university { font-size: 20px; color: #1565C0; font-weight: 600; text-transform: uppercase; }
        .header-school { font-size: 32px; font-weight: 800; color: #1565C0; text-transform: uppercase; line-height: 1.2; }
        .header-system { font-size: 25px; font-weight: 700; color: #e53935; text-transform: uppercase; margin-top: 2px; }

        .main-nav { background: #1565C0; }
        .nav-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; }
        .main-nav a { color: white; text-decoration: none; padding: 12px 22px; font-size: 14px;
                      font-weight: 500; display: block; transition: background 0.2s;
                      border-right: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:first-child { border-left: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:hover { background: #0D47A1; }

        .breadcrumb { background: white; border-bottom: 1px solid #e0e7f0; padding: 10px 0; }
        .breadcrumb-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px;
                            font-size: 13px; color: #666; display: flex; align-items: center; gap: 6px; flex-wrap: wrap; }
        .breadcrumb-inner a { color: #1565C0; text-decoration: none; }
        .breadcrumb-inner a:hover { text-decoration: underline; }

        .content-wrapper { max-width: 1200px; margin: 28px auto; padding: 0 20px;
                           display: grid; grid-template-columns: 1fr 300px; gap: 24px; }

        .article-card { background: white; border-radius: 8px;
                        box-shadow: 0 2px 10px rgba(0,0,0,0.07); padding: 28px 32px; }

        .article-title { font-size: 22px; font-weight: 700; color: #1a2b4a;
                         line-height: 1.45; margin-bottom: 10px; }

        .article-meta { display: flex; align-items: center; gap: 18px; font-size: 13px; color: #888;
                        margin-bottom: 20px; padding-bottom: 14px; border-bottom: 1px solid #e5eaf5; }

        .article-body { font-size: 15px; color: #333; line-height: 1.85; }
        .article-body p  { margin-bottom: 12px; }
        .article-body h3 { font-size: 16px; font-weight: 700; color: #1565C0; margin: 20px 0 8px; }
        .article-body a  { color: #1565C0; }
        .article-body strong { font-weight: 700; }
        .article-body em { font-style: italic; }
        .article-body mark { background: #ffe066; padding: 1px 4px; border-radius: 3px; }

        .back-btn { display: inline-flex; align-items: center; gap: 6px; margin-top: 28px;
                    padding: 9px 20px; background: #1565C0; color: white; text-decoration: none;
                    border-radius: 5px; font-size: 14px; font-weight: 600; transition: background 0.2s; }
        .back-btn:hover { background: #0D47A1; }

        .sidebar { display: flex; flex-direction: column; gap: 16px; }
        .sidebar-card { background: white; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); overflow: hidden; }
        .card-title-bar { background: #1565C0; color: white; padding: 10px 18px; font-size: 14px;
                          font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px;
                          display: flex; align-items: center; gap: 8px; }
        .sidebar-links { padding: 8px 0; }
        .sidebar-link { display: flex; align-items: center; gap: 10px; padding: 10px 16px;
                        font-size: 13px; color: #333; text-decoration: none;
                        border-bottom: 1px solid #f0f0f0; transition: background 0.2s; }
        .sidebar-link:last-child { border-bottom: none; }
        .sidebar-link:hover { background: #f0f4ff; color: #1565C0; }
        .sidebar-dot { width: 7px; height: 7px; background: #1565C0; border-radius: 50%; flex-shrink: 0; }

        .site-footer { background: #1565C0; color: rgba(255,255,255,0.85);
                       text-align: center; padding: 14px; font-size: 13px; margin-top: 30px; }
        .site-footer strong { color: white; }
    </style>
</head>
<body>

<!-- TOP BAR -->
<div class="top-bar">
    <div class="top-bar-inner">
        <a href="${pageContext.request.contextPath}/baiviet/tin-tuc"><span>📰</span> Tin tức &amp; Sự kiện</a>
        <a href="${pageContext.request.contextPath}/baiviet/thong-bao"><span>🔔</span> Thông báo</a>
        <a href="${pageContext.request.contextPath}/baiviet/noi-quy"><span>📋</span> Nội quy &amp; Quy định</a>
    </div>
</div>

<!-- HEADER -->
<div class="site-header">
    <div class="header-inner">
        <img src="${pageContext.request.contextPath}/resources/image/logo_ute.png"
             alt="Logo UTE" class="header-logo">
        <div>
            <div class="header-university">Đại học Đà Nẵng</div>
            <div class="header-school">Trường Đại học Sư phạm Kỹ thuật</div>
            <div class="header-system">Hệ thống Quản lý Ký túc xá</div>
        </div>
    </div>
</div>

<!-- NAV -->
<nav class="main-nav">
    <div class="nav-inner">
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/sinhvien/list">Sinh viên</a>
        <a href="${pageContext.request.contextPath}/phong/list">Phòng</a>
        <a href="${pageContext.request.contextPath}/hopdong/list">Hợp đồng</a>
        <a href="${pageContext.request.contextPath}/baotri/list">Bảo trì</a>
    </div>
</nav>

<!-- BREADCRUMB -->
<div class="breadcrumb">
    <div class="breadcrumb-inner">
        <a href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a>
        <span>›</span>
        <a href="${pageContext.request.contextPath}/baiviet/${baiViet.loaiBaiViet}">
            ${baiViet.tenLoai}
        </a>
        <span>›</span>
        <span>${baiViet.tieuDe}</span>
    </div>
</div>

<!-- CONTENT -->
<div class="content-wrapper">

    <!-- BÀI VIẾT -->
    <div class="article-card">
        <h1 class="article-title">${baiViet.tieuDe}</h1>
        <div class="article-meta">
            <span>📅 ${baiViet.ngayDang}</span>
            <span>👁 ${baiViet.luotXem}</span>
        </div>
        <div class="article-body">
    <c:choose>
        <c:when test="${baiViet.noiDung == 'KHAO_SAT_FORM'}">
            <div style="text-align:center; padding: 20px 0;">
                <p style="font-size:16px; color:#444; margin-bottom:20px;">
                    Ban quản lý ký túc xá kính mời sinh viên tham gia khảo sát định kỳ
                    năm học 2025-2026 để giúp chúng tôi cải thiện chất lượng dịch vụ.
                </p>
                <a href="${pageContext.request.contextPath}/khaosat/form"
   style="display:inline-block; padding:14px 32px; background:#1565C0;
          color:white; text-decoration:none; border-radius:8px;
          font-size:16px; font-weight:700;">
    &#128203; Tham gia khảo sát ngay
</a>
            </div>
        </c:when>
        <c:otherwise>
            ${baiViet.noiDung}
        </c:otherwise>
    </c:choose>
</div>
        <a href="${pageContext.request.contextPath}/baiviet/${baiViet.loaiBaiViet}"
           class="back-btn">← Quay lại danh sách</a>
    </div>

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-card">
            <div class="card-title-bar">📂 Chuyên mục</div>
            <div class="sidebar-links">
                <a href="${pageContext.request.contextPath}/baiviet/tin-tuc" class="sidebar-link">
                    <span class="sidebar-dot"></span> Tin tức &amp; Sự kiện
                </a>
                <a href="${pageContext.request.contextPath}/baiviet/thong-bao" class="sidebar-link">
                    <span class="sidebar-dot"></span> Thông báo
                </a>
                <a href="${pageContext.request.contextPath}/baiviet/noi-quy" class="sidebar-link">
                    <span class="sidebar-dot"></span> Nội quy &amp; Quy định
                </a>
            </div>
        </div>
        <div class="sidebar-card">
            <div class="card-title-bar">📌 Liên kết nhanh</div>
            <div class="sidebar-links">
                <a href="${pageContext.request.contextPath}/sinhvien/add" class="sidebar-link">
                    <span class="sidebar-dot"></span> Đăng ký phòng mới
                </a>
                <a href="${pageContext.request.contextPath}/hopdong/add" class="sidebar-link">
                    <span class="sidebar-dot"></span> Tạo hợp đồng
                </a>
                <a href="${pageContext.request.contextPath}/baotri/add" class="sidebar-link">
                    <span class="sidebar-dot"></span> Gửi yêu cầu bảo trì
                </a>
                <a href="${pageContext.request.contextPath}/phong/list" class="sidebar-link">
                    <span class="sidebar-dot"></span> Xem phòng còn trống
                </a>
            </div>
        </div>
        <div class="sidebar-card">
            <div class="card-title-bar">📞 Liên hệ hỗ trợ</div>
            <div class="sidebar-links">
                <a href="#" class="sidebar-link"><span class="sidebar-dot"></span> Ban quản lý KTX</a>
                <a href="#" class="sidebar-link"><span class="sidebar-dot"></span> Hotline: 0236.xxx.xxx</a>
                <a href="#" class="sidebar-link"><span class="sidebar-dot"></span> Email: ktx@ute.udn.vn</a>
                <a href="#" class="sidebar-link"><span class="sidebar-dot"></span> Website trường</a>
            </div>
        </div>
    </div>

</div>

<!-- FOOTER -->
<div class="site-footer">
    &copy; 2026 &mdash; <strong>Hệ thống Quản lý Ký túc xá</strong> &mdash;
    Trường Đại học Sư phạm Kỹ thuật Đà Nẵng
</div>

</body>
</html>