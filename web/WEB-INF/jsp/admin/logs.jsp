<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nhật ký hệ thống - Admin</title>
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
        
        .filter-bar {
            display: flex;
            gap: 10px;
        }
        .filter-bar input, .filter-bar select {
            padding: 8px 14px;
            border: 1.5px solid #ddd;
            border-radius: 8px;
            font-size: 13px;
        }
        .filter-bar button {
            padding: 8px 16px;
            background: #1565C0;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th {
            background: #f8f9ff;
            padding: 14px 16px;
            text-align: left;
            font-size: 12px;
            font-weight: 600;
            color: #666;
            border-bottom: 2px solid #e3eaf5;
        }
        td {
            padding: 12px 16px;
            font-size: 13px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
        }
        tr:hover { background: #f8f9ff; }
        
        .badge-info {
            background: #E3F2FD;
            color: #1565C0;
            padding: 3px 10px;
            border-radius: 15px;
            font-size: 11px;
            display: inline-block;
        }
        .badge-warning {
            background: #FFF8E1;
            color: #f57f17;
            padding: 3px 10px;
            border-radius: 15px;
            font-size: 11px;
            display: inline-block;
        }
        .badge-danger {
            background: #ffebee;
            color: #c62828;
            padding: 3px 10px;
            border-radius: 15px;
            font-size: 11px;
            display: inline-block;
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
            <div class="page-title">📋 Nhật ký hệ thống</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <div class="data-card">
            <div class="card-header">
                <h2>📜 Lịch sử hoạt động</h2>
                <div class="filter-bar">
                    <form action="${pageContext.request.contextPath}/admin/logs" method="get" style="display: flex; gap: 10px;">
                        <input type="date" name="tuNgay" value="${param.tuNgay}" placeholder="Từ ngày">
                        <input type="date" name="denNgay" value="${param.denNgay}" placeholder="Đến ngày">
                        <select name="hanhDong">
                            <option value="">📌 Tất cả</option>
                            <option value="THEM" ${param.hanhDong == 'THEM' ? 'selected' : ''}>Thêm</option>
                            <option value="SUA" ${param.hanhDong == 'SUA' ? 'selected' : ''}>Sửa</option>
                            <option value="XOA" ${param.hanhDong == 'XOA' ? 'selected' : ''}>Xóa</option>
                            <option value="DANG_NHAP" ${param.hanhDong == 'DANG_NHAP' ? 'selected' : ''}>Đăng nhập</option>
                            <option value="DANG_XUAT" ${param.hanhDong == 'DANG_XUAT' ? 'selected' : ''}>Đăng xuất</option>
                        </select>
                        <button type="submit">🔍 Lọc</button>
                    </form>
                </div>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Thời gian</th>
                        <th>Hành động</th>
                        <th>Bảng</th>
                        <th>ID bản ghi</th>
                        <th>Người thực hiện</th>
                        <th>IP</th>
                        <th>Chi tiết</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="log" items="${logList}">
                        <tr>
                            <td>${log.id}</td>
                            <td><fmt:formatDate value="${log.thoiGian}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${log.hanhDong == 'THEM'}">
                                        <span class="badge-info">➕ Thêm</span>
                                    </c:when>
                                    <c:when test="${log.hanhDong == 'SUA'}">
                                        <span class="badge-warning">✏️ Sửa</span>
                                    </c:when>
                                    <c:when test="${log.hanhDong == 'XOA'}">
                                        <span class="badge-danger">🗑️ Xóa</span>
                                    </c:when>
                                    <c:when test="${log.hanhDong == 'DANG_NHAP'}">
                                        <span class="badge-info">🔓 Đăng nhập</span>
                                    </c:when>
                                    <c:when test="${log.hanhDong == 'DANG_XUAT'}">
                                        <span class="badge-warning">🔒 Đăng xuất</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-info">${log.hanhDong}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${log.bang}</td>
                            <td>${log.idBanGhi}</td>
                            <td><strong>${log.nguoiThucHien}</strong></td>
                            <td>${log.ipAddress}</td>
                            <td><span title="${log.chiTiet}">${log.chiTiet.length() > 50 ? log.chiTiet.substring(0,50).concat('...') : log.chiTiet}</span></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty logList}">
                        <tr>
                            <td colspan="8" class="text-center">📜 Không có dữ liệu nhật ký</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>