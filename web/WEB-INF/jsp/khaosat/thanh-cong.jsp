<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gửi khảo sát thành công</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f4f8; }

        .top-bar { background: #1565C0; color: white; padding: 14px 0; }
        .top-bar-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px;
                         display: flex; gap: 30px; }
        .top-bar a { color: white; text-decoration: none; opacity: 0.85;
                     display: flex; align-items: center; gap: 5px; }
        .top-bar a:hover { opacity: 1; }

        .site-header { background: white; border-bottom: 3px solid #1565C0; padding: 12px 0; }
        .header-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px;
                        display: flex; align-items: center; gap: 18px; }
        .header-logo { height: 110px; }
        .header-university { font-size: 20px; color: #1565C0; font-weight: 600; text-transform: uppercase; }
        .header-school { font-size: 32px; font-weight: 800; color: #1565C0; text-transform: uppercase; }
        .header-system { font-size: 25px; font-weight: 700; color: #e53935; text-transform: uppercase; }

        .main-nav { background: #1565C0; }
        .nav-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; }
        .main-nav a { color: white; text-decoration: none; padding: 12px 22px; font-size: 14px;
                      font-weight: 500; display: block; transition: background 0.2s;
                      border-right: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:first-child { border-left: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:hover { background: #0D47A1; }

        .wrapper { max-width: 600px; margin: 60px auto; padding: 0 20px; text-align: center; }

        .success-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            padding: 50px 40px;
        }
        .success-icon { font-size: 72px; margin-bottom: 20px; }
        .success-title {
            font-size: 26px;
            font-weight: 800;
            color: #2e7d32;
            margin-bottom: 12px;
        }
        .success-msg {
            font-size: 15px;
            color: #555;
            line-height: 1.7;
            margin-bottom: 30px;
        }
        .btn-home {
            display: inline-block;
            padding: 13px 35px;
            background: #1565C0;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 700;
            transition: background 0.2s;
            margin: 6px;
        }
        .btn-home:hover { background: #0D47A1; }
        .btn-secondary {
            display: inline-block;
            padding: 13px 35px;
            background: white;
            color: #1565C0;
            text-decoration: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 700;
            border: 2px solid #1565C0;
            transition: background 0.2s;
            margin: 6px;
        }
        .btn-secondary:hover { background: #f0f4ff; }

        .site-footer { background: #1565C0; color: rgba(255,255,255,0.85);
                       text-align: center; padding: 14px; font-size: 13px; margin-top: 60px; }
        .site-footer strong { color: white; }
    </style>
</head>
<body>

<!-- TOP BAR -->
<div class="top-bar">
    <div class="top-bar-inner">
        <a href="${pageContext.request.contextPath}/baiviet/tin-tuc">&#128240; Tin tức &amp; Sự kiện</a>
        <a href="${pageContext.request.contextPath}/baiviet/thong-bao">&#128276; Thông báo</a>
        <a href="${pageContext.request.contextPath}/baiviet/noi-quy">&#128203; Nội quy &amp; Quy định</a>
    </div>
</div>

<!-- HEADER -->
<div class="site-header">
    <div class="header-inner">
        <img src="${pageContext.request.contextPath}/resources/image/logo_ute.png"
             alt="Logo" class="header-logo">
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

<!-- NỘI DUNG -->
<div class="wrapper">
    <div class="success-card">
        <div class="success-icon">&#9989;</div>
        <div class="success-title">Gửi khảo sát thành công!</div>
        <div class="success-msg">
            Cảm ơn bạn đã dành thời gian tham gia khảo sát định kỳ 2025-2026.<br>
            Ý kiến của bạn sẽ giúp Ban quản lý ký túc xá cải thiện<br>
            chất lượng dịch vụ tốt hơn trong thời gian tới.
        </div>
        <a href="${pageContext.request.contextPath}/home" class="btn-home">
            &#127968; Về trang chủ
        </a>
        <a href="${pageContext.request.contextPath}/baiviet/thong-bao" class="btn-secondary">
            &#128276; Xem thông báo khác
        </a>
    </div>
</div>

<!-- FOOTER -->
<div class="site-footer">
    &copy; 2026 &mdash; <strong>Hệ thống Quản lý Ký túc xá</strong> &mdash;
    Trường Đại học Sư phạm Kỹ thuật Đà Nẵng
</div>

</body>
</html>