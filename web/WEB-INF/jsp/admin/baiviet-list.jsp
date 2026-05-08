<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Bài viết - Admin</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }
        
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 260px;
            height: 100%;
            background: linear-gradient(180deg, #0D47A1, #1565C0);
            color: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            z-index: 100;
        }
        .sidebar-header { padding: 24px 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.2); }
        .sidebar-header h2 { font-size: 18px; font-weight: 700; }
        .sidebar-header p { font-size: 12px; opacity: 0.7; margin-top: 5px; }
        .sidebar-menu { padding: 20px 0; }
        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 24px;
            color: white;
            text-decoration: none;
            transition: background 0.2s;
            font-size: 14px;
        }
        .sidebar-menu a:hover { background: rgba(255,255,255,0.15); }
        .sidebar-menu a.active { background: rgba(255,255,255,0.25); border-left: 3px solid #FFD700; }
        .sidebar-footer {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 20px;
            border-top: 1px solid rgba(255,255,255,0.2);
            font-size: 12px;
            text-align: center;
        }
        .sidebar-footer a { color: white; text-decoration: none; }
        
        .main-content { margin-left: 260px; padding: 20px; }
        
        .top-bar {
            background: white;
            border-radius: 12px;
            padding: 16px 24px;
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .page-title { font-size: 22px; font-weight: 700; color: #0D47A1; }
        .logout-btn {
            background: #e53935;
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
        }
        
        .data-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 24px;
        }
        .card-header {
            padding: 18px 24px;
            border-bottom: 1px solid #e3eaf5;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }
        .card-header h2 { font-size: 18px; color: #0D47A1; }
        .btn-add {
            background: #1565C0;
            color: white;
            padding: 8px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
        }
        
        .category-tab {
            display: flex;
            gap: 5px;
            padding: 12px 20px;
            background: #f8f9ff;
            border-bottom: 1px solid #e3eaf5;
        }
        .category-tab a {
            padding: 6px 16px;
            border-radius: 20px;
            text-decoration: none;
            font-size: 13px;
            background: #eef2f6;
            color: #666;
            transition: all 0.2s;
        }
        .category-tab a.active {
            background: #1565C0;
            color: white;
        }
        .category-tab a:hover:not(.active) {
            background: #ddd;
        }
        
        .post-item {
            display: flex;
            gap: 16px;
            padding: 16px 20px;
            border-bottom: 1px solid #f0f0f0;
            align-items: flex-start;
        }
        .post-item:hover { background: #f8f9ff; }
        .post-thumb {
            width: 80px;
            height: 60px;
            background: #e3eaf5;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            flex-shrink: 0;
        }
        .post-info { flex: 1; }
        .post-title {
            font-size: 15px;
            font-weight: 600;
            color: #1565C0;
            margin-bottom: 5px;
        }
        .post-meta {
            font-size: 11px;
            color: #999;
            margin-bottom: 6px;
        }
        .post-summary {
            font-size: 12px;
            color: #666;
            line-height: 1.5;
        }
        .post-actions {
            display: flex;
            gap: 10px;
            flex-shrink: 0;
        }
        .btn-edit, .btn-delete {
            padding: 5px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
        }
        .btn-edit {
            background: #FFC107;
            color: #333;
        }
        .btn-delete {
            background: #e53935;
            color: white;
        }
        
        .alert-success {
            background: #e8f5e9;
            border: 1px solid #a5d6a7;
            color: #2e7d32;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .empty-msg {
            text-align: center;
            padding: 50px;
            color: #999;
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">
            <h2>🏠 KTX UTE</h2>
            <p>Hệ thống quản lý</p>
        </div>
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/admin/dashboard">📊 Tổng quan</a>
            <a href="${pageContext.request.contextPath}/admin/sinhvien">👨‍🎓 Quản lý Sinh viên</a>
            <a href="${pageContext.request.contextPath}/admin/phong">🏢 Quản lý Phòng</a>
            <a href="${pageContext.request.contextPath}/admin/hopdong">📄 Quản lý Hợp đồng</a>
            <a href="${pageContext.request.contextPath}/admin/baotri">🔧 Quản lý Bảo trì</a>
            <a href="${pageContext.request.contextPath}/admin/nhanvien">👥 Quản lý Nhân viên</a>
            <a href="${pageContext.request.contextPath}/admin/baiviet" class="active">📰 Quản lý Bài viết</a>
            <a href="${pageContext.request.contextPath}/admin/thongke">📈 Thống kê</a>
        </div>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/admin/logout">🔓 Đăng xuất</a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div class="page-title">📰 Quản lý Bài viết</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <c:if test="${not empty success}">
            <div class="alert-success">✅ ${success}</div>
        </c:if>

        <!-- TIN TỨC -->
        <div class="data-card">
            <div class="card-header">
                <h2>📰 Tin tức & Sự kiện</h2>
                <a href="${pageContext.request.contextPath}/admin/baiviet/add?loai=tin-tuc" class="btn-add">➕ Thêm tin tức</a>
            </div>
            <div id="list-tintuc">
                <c:forEach var="bv" items="${baivietList}">
                    <div class="post-item">
                        <div class="post-thumb">📰</div>
                        <div class="post-info">
                            <div class="post-title">${bv.tieuDe}</div>
                            <div class="post-meta">
                                📅 ${bv.ngayDang} &nbsp;|&nbsp; 👁️ ${bv.luotXem} lượt xem
                            </div>
                            <div class="post-summary">${bv.tomTat.length() > 80 ? bv.tomTat.substring(0,80).concat("...") : bv.tomTat}</div>
                        </div>
                        <div class="post-actions">
                            <a href="${pageContext.request.contextPath}/admin/baiviet/edit/${bv.idBaiViet}" class="btn-edit">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/baiviet/delete/${bv.idBaiViet}"
                               onclick="return confirm('Bạn có chắc muốn xóa bài viết này?')"
                               class="btn-delete">Xóa</a>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty baivietList}">
                    <div class="empty-msg">📭 Chưa có tin tức nào</div>
                </c:if>
            </div>
        </div>

        <!-- THÔNG BÁO -->
        <div class="data-card">
            <div class="card-header">
                <h2>🔔 Thông báo</h2>
                <a href="${pageContext.request.contextPath}/admin/baiviet/add?loai=thong-bao" class="btn-add">➕ Thêm thông báo</a>
            </div>
            <div id="list-thongbao">
                <c:forEach var="bv" items="${thongbaoList}">
                    <div class="post-item">
                        <div class="post-thumb">🔔</div>
                        <div class="post-info">
                            <div class="post-title">${bv.tieuDe}</div>
                            <div class="post-meta">
                                📅 ${bv.ngayDang} &nbsp;|&nbsp; 👁️ ${bv.luotXem} lượt xem
                            </div>
                            <div class="post-summary">${bv.tomTat.length() > 80 ? bv.tomTat.substring(0,80).concat("...") : bv.tomTat}</div>
                        </div>
                        <div class="post-actions">
                            <a href="${pageContext.request.contextPath}/admin/baiviet/edit/${bv.idBaiViet}" class="btn-edit">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/baiviet/delete/${bv.idBaiViet}"
                               onclick="return confirm('Bạn có chắc muốn xóa bài viết này?')"
                               class="btn-delete">Xóa</a>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty thongbaoList}">
                    <div class="empty-msg">📭 Chưa có thông báo nào</div>
                </c:if>
            </div>
        </div>

        <!-- NỘI QUY -->
        <div class="data-card">
            <div class="card-header">
                <h2>📋 Nội quy & Quy định</h2>
                <a href="${pageContext.request.contextPath}/admin/baiviet/add?loai=noi-quy" class="btn-add">➕ Thêm nội quy</a>
            </div>
            <div id="list-noiquy">
                <c:forEach var="bv" items="${noiquyList}">
                    <div class="post-item">
                        <div class="post-thumb">📋</div>
                        <div class="post-info">
                            <div class="post-title">${bv.tieuDe}</div>
                            <div class="post-meta">
                                📅 ${bv.ngayDang} &nbsp;|&nbsp; 👁️ ${bv.luotXem} lượt xem
                            </div>
                            <div class="post-summary">${bv.tomTat.length() > 80 ? bv.tomTat.substring(0,80).concat("...") : bv.tomTat}</div>
                        </div>
                        <div class="post-actions">
                            <a href="${pageContext.request.contextPath}/admin/baiviet/edit/${bv.idBaiViet}" class="btn-edit">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/baiviet/delete/${bv.idBaiViet}"
                               onclick="return confirm('Bạn có chắc muốn xóa bài viết này?')"
                               class="btn-delete">Xóa</a>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty noiquyList}">
                    <div class="empty-msg">📭 Chưa có nội quy nào</div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>