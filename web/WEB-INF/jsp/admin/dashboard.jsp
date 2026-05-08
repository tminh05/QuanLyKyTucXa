<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Quản lý Ký túc xá</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f4f8;
        }
        /* SIDEBAR */
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
        .sidebar-header {
            padding: 24px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }
        .sidebar-header h2 {
            font-size: 18px;
            font-weight: 700;
        }
        .sidebar-header p {
            font-size: 12px;
            opacity: 0.7;
            margin-top: 5px;
        }
        .sidebar-menu {
            padding: 20px 0;
        }
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
        .sidebar-menu a:hover {
            background: rgba(255,255,255,0.15);
        }
        .sidebar-menu a.active {
            background: rgba(255,255,255,0.25);
            border-left: 3px solid #FFD700;
        }
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
        /* MAIN CONTENT */
        .main-content {
            margin-left: 260px;
            padding: 20px;
        }
        /* TOP BAR */
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
        .page-title {
            font-size: 22px;
            font-weight: 700;
            color: #0D47A1;
        }
        .admin-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .admin-name {
            font-weight: 600;
            color: #333;
        }
        .logout-btn {
            background: #e53935;
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            transition: background 0.2s;
        }
        .logout-btn:hover {
            background: #c62828;
        }
        /* STATS CARDS */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .stat-icon {
            font-size: 32px;
            margin-bottom: 12px;
        }
        .stat-number {
            font-size: 28px;
            font-weight: 800;
            color: #1565C0;
        }
        .stat-label {
            font-size: 13px;
            color: #888;
            margin-top: 5px;
        }
        /* QUICK ACTIONS */
        .quick-actions {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 24px;
        }
        .section-title {
            font-size: 16px;
            font-weight: 700;
            color: #0D47A1;
            margin-bottom: 16px;
            padding-bottom: 8px;
            border-bottom: 2px solid #e3eaf5;
        }
        .action-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        .action-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: #f0f4f8;
            color: #333;
            text-decoration: none;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s;
        }
        .action-btn:hover {
            background: #1565C0;
            color: white;
        }
        /* RECENT TABLE */
        .recent-table {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .recent-table table {
            width: 100%;
            border-collapse: collapse;
        }
        .recent-table th {
            background: #f8f9ff;
            padding: 14px 16px;
            text-align: left;
            font-size: 12px;
            font-weight: 600;
            color: #666;
            border-bottom: 2px solid #e3eaf5;
        }
        .recent-table td {
            padding: 12px 16px;
            font-size: 13px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
        }
        .status-pending {
            background: #FFF8E1;
            color: #f57f17;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        .status-done {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        .badge-active {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        .btn-view {
            color: #1565C0;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>🏠 KTX UTE</h2>
            <p>Hệ thống quản lý</p>
        </div>
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">
                📊 Tổng quan
            </a>
            <a href="${pageContext.request.contextPath}/admin/sinhvien">
                👨‍🎓 Quản lý Sinh viên
            </a>
            <a href="${pageContext.request.contextPath}/admin/phong">
                🏢 Quản lý Phòng
            </a>
            <a href="${pageContext.request.contextPath}/admin/hopdong">
                📄 Quản lý Hợp đồng
            </a>
            <a href="${pageContext.request.contextPath}/admin/baotri">
                🔧 Quản lý Bảo trì
            </a>
            <a href="${pageContext.request.contextPath}/admin/nhanvien">
                👥 Quản lý Nhân viên
            </a>
            <a href="${pageContext.request.contextPath}/admin/baiviet">
                📰 Quản lý Bài viết
            </a>
            <a href="${pageContext.request.contextPath}/admin/thongke">
                📈 Thống kê
            </a>
        </div>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/admin/logout" style="color:white; text-decoration:none;">
                🔓 Đăng xuất
            </a>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="top-bar">
            <div class="page-title">📊 Tổng quan hệ thống</div>
            <div class="admin-info">
                <span class="admin-name">👋 Xin chào, Admin</span>
                <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
            </div>
        </div>

        <!-- STATS CARDS -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">👨‍🎓</div>
                <div class="stat-number">${tongSinhVien}</div>
                <div class="stat-label">Tổng số sinh viên</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🏢</div>
                <div class="stat-number">${tongPhong}</div>
                <div class="stat-label">Tổng số phòng</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📄</div>
                <div class="stat-number">${hopDongHieuLuc}</div>
                <div class="stat-label">Hợp đồng hiệu lực</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🔧</div>
                <div class="stat-number">${yeuCauChuaXuLy}</div>
                <div class="stat-label">Yêu cầu bảo trì chưa xử lý</div>
            </div>
        </div>

        <!-- QUICK ACTIONS -->
        <div class="quick-actions">
            <div class="section-title">⚡ Thao tác nhanh</div>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/admin/sinhvien/add" class="action-btn">➕ Thêm sinh viên</a>
                <a href="${pageContext.request.contextPath}/admin/phong/add" class="action-btn">🏠 Thêm phòng mới</a>
                <a href="${pageContext.request.contextPath}/admin/hopdong/add" class="action-btn">📄 Tạo hợp đồng</a>
                <a href="${pageContext.request.contextPath}/admin/nhanvien/add" class="action-btn">👥 Thêm nhân viên</a>
            </div>
        </div>

        <!-- HỢP ĐỒNG SẮP HẾT HẠN -->
        <div class="recent-table">
            <div style="padding: 16px 20px; background: #f8f9ff; border-bottom: 1px solid #e3eaf5;">
                <strong>📅 Hợp đồng sắp hết hạn (30 ngày tới)</strong>
            </div>
            <table>
                <thead>
                    <tr><th>MSSV</th><th>Sinh viên</th><th>Phòng</th><th>Ngày kết thúc</th><th>Trạng thái</th><th></th></tr>
                </thead>
                <tbody>
                    <c:forEach var="hd" items="${hopDongSapHetHan}">
                        <tr>
                            <td>${hd.mssv}</td>
                            <td>${hd.hoTenSinhVien}</td>
                            <td>${hd.tenPhong}</td>
                            <td><fmt:formatDate value="${hd.ngayKetThuc}" pattern="dd/MM/yyyy"/></td>
                            <td><span class="status-pending">Sắp hết hạn</span></td>
                            <td><a href="#" class="btn-view">Gia hạn</a></td>
                         </tr>
                    </c:forEach>
                    <c:if test="${empty hopDongSapHetHan}">
                        <tr><td colspan="6" style="text-align:center; padding:30px;">✅ Không có hợp đồng nào sắp hết hạn</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>