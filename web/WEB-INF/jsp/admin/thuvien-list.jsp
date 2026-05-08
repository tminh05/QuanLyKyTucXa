<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Thư viện - Admin</title>
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
        
        .search-box {
            display: flex;
            gap: 10px;
        }
        .search-box input {
            padding: 8px 14px;
            border: 1.5px solid #ddd;
            border-radius: 8px;
            font-size: 13px;
            width: 220px;
        }
        .search-box button {
            padding: 8px 16px;
            background: #1565C0;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
        
        .filter-links {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .filter-link {
            padding: 6px 14px;
            background: #f0f4f8;
            color: #333;
            text-decoration: none;
            border-radius: 20px;
            font-size: 12px;
            transition: all 0.2s;
        }
        .filter-link:hover, .filter-link.active {
            background: #1565C0;
            color: white;
        }
        
        .books-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            padding: 20px;
        }
        .book-card {
            background: #f8f9ff;
            border: 1px solid #e3eaf5;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .book-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .book-cover {
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            background: linear-gradient(135deg, #1565C0, #42A5F5);
        }
        .book-info {
            padding: 14px;
        }
        .book-title {
            font-size: 14px;
            font-weight: 700;
            color: #1565C0;
            margin-bottom: 4px;
        }
        .book-author {
            font-size: 11px;
            color: #888;
            margin-bottom: 6px;
        }
        .book-category {
            display: inline-block;
            background: #E3F2FD;
            color: #1565C0;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 10px;
            margin-bottom: 6px;
        }
        .book-stats {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 8px;
            font-size: 12px;
        }
        .book-stock {
            color: ${sach.soLuongConLai <= 0 ? '#c62828' : '#2e7d32'};
            font-weight: 600;
        }
        .book-actions {
            display: flex;
            gap: 8px;
            margin-top: 10px;
        }
        .btn-edit {
            flex: 1;
            background: #FFC107;
            color: #333;
            padding: 5px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 11px;
            text-align: center;
        }
        .btn-delete {
            flex: 1;
            background: #e53935;
            color: white;
            padding: 5px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 11px;
            text-align: center;
        }
        
        .alert-success {
            background: #e8f5e9;
            border: 1px solid #a5d6a7;
            color: #2e7d32;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .alert-error {
            background: #ffebee;
            border: 1px solid #ef9a9a;
            color: #c62828;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .text-center { text-align: center; padding: 40px; color: #999; }
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
            <a href="${pageContext.request.contextPath}/admin/baiviet">📰 Quản lý Bài viết</a>
            <a href="${pageContext.request.contextPath}/admin/thongke">📈 Thống kê</a>
        </div>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/admin/logout">🔓 Đăng xuất</a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div class="page-title">📚 Quản lý Thư viện</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <c:if test="${not empty success}">
            <div class="alert-success">✅ ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert-error">⚠️ ${error}</div>
        </c:if>

        <div class="data-card">
            <div class="card-header">
                <h2>📋 Danh sách sách</h2>
                <div style="display: flex; gap: 12px;">
                    <form action="${pageContext.request.contextPath}/admin/thuvien" method="get" class="search-box">
                        <input type="text" name="keyword" placeholder="🔍 Tìm kiếm sách...">
                        <button type="submit">Tìm</button>
                    </form>
                    <a href="${pageContext.request.contextPath}/admin/thuvien/add" class="btn-add">➕ Thêm sách</a>
                </div>
            </div>
            
            <div class="filter-links" style="padding: 0 20px 10px 20px;">
                <a href="${pageContext.request.contextPath}/admin/thuvien" class="filter-link ${empty param.theLoai ? 'active' : ''}">📚 Tất cả</a>
                <c:forEach var="tl" items="${danhSachTheLoai}">
                    <a href="${pageContext.request.contextPath}/admin/thuvien?theLoai=${tl}" class="filter-link ${param.theLoai == tl ? 'active' : ''}">📖 ${tl}</a>
                </c:forEach>
            </div>

            <div class="books-grid">
                <c:forEach var="sach" items="${sachList}">
                    <div class="book-card">
                        <div class="book-cover">
                            <c:choose>
                                <c:when test="${sach.theLoai == 'Lịch sử - Văn hóa'}">🏛️</c:when>
                                <c:when test="${sach.theLoai == 'Triết lý kinh doanh'}">💼</c:when>
                                <c:when test="${sach.theLoai == 'Bước chân vào đời'}">👟</c:when>
                                <c:when test="${sach.theLoai == 'Chia sẻ - Cộng hưởng'}">🤝</c:when>
                                <c:when test="${sach.theLoai == 'Thực tập sinh'}">🎓</c:when>
                                <c:when test="${sach.theLoai == 'Khoa học - Kỹ thuật - AI'}">🤖</c:when>
                                <c:when test="${sach.theLoai == 'Khoa học - Kỹ thuật'}">🔬</c:when>
                                <c:when test="${sach.theLoai == 'Âm nhạc'}">🎵</c:when>
                                <c:when test="${sach.theLoai == 'Phim truyện'}">🎬</c:when>
                                <c:otherwise>📖</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="book-info">
                            <div class="book-title">${sach.tenSach}</div>
                            <div class="book-author">✍️ ${sach.tacGia}</div>
                            <span class="book-category">${sach.theLoai}</span>
                            <div class="book-stats">
                                <span>📅 ${sach.namXuatBan}</span>
                                <span class="book-stock">📚 Còn: ${sach.soLuongConLai}/${sach.soLuong}</span>
                            </div>
                            <div class="book-actions">
                                <a href="${pageContext.request.contextPath}/admin/thuvien/edit/${sach.idSach}" class="btn-edit">✏️ Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/thuvien/delete/${sach.idSach}"
                                   onclick="return confirm('Bạn có chắc muốn xóa sách ${sach.tenSach}?')"
                                   class="btn-delete">🗑️ Xóa</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty sachList}">
                    <div style="grid-column: 1/-1;">
                        <div class="text-center">📚 Không có dữ liệu sách</div>
                    </div>
                </c:if>
            </div>
        </div>
        
        <!-- Nút xem danh sách mượn sách -->
        <div style="text-align: right; margin-top: 10px;">
            <a href="${pageContext.request.contextPath}/admin/thuvien/muon" class="btn-add" style="background: #2e7d32;">📋 Xem danh sách mượn sách</a>
        </div>
    </div>
</body>
</html>