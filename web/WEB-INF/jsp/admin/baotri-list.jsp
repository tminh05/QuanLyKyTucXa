<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Bảo trì - Admin</title>
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
        .filter-bar select {
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
        
        .action-buttons { display: flex; gap: 8px; }
        .btn-process {
            background: #FFC107;
            color: #333;
            padding: 5px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
        }
        .btn-delete {
            background: #e53935;
            color: white;
            padding: 5px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-pending {
            background: #FFF8E1;
            color: #f57f17;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        .status-processing {
            background: #E3F2FD;
            color: #1565C0;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        .status-done {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        .status-cancelled {
            background: #f5f5f5;
            color: #888;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
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
        
        .stats-row {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }
        .stat-badge {
            background: #f8f9ff;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            border: 1px solid #e3eaf5;
        }
        .stat-badge span {
            font-weight: 700;
            color: #1565C0;
            font-size: 16px;
            margin-right: 5px;
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
            <a href="${pageContext.request.contextPath}/admin/baotri" class="active">🔧 Quản lý Bảo trì</a>
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
            <div class="page-title">🔧 Quản lý Bảo trì</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <c:if test="${not empty success}">
            <div class="alert-success">✅ ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert-error">⚠️ ${error}</div>
        </c:if>

        <div class="stats-row">
            <div class="stat-badge"><span>📊</span> Tổng: <strong>${yeuCauList.size()}</strong> yêu cầu</div>
        </div>

        <div class="data-card">
            <div class="card-header">
                <h2>📋 Danh sách yêu cầu bảo trì</h2>
                <div class="filter-bar">
                    <form action="${pageContext.request.contextPath}/admin/baotri" method="get" style="display: flex; gap: 10px;">
                        <select name="trangThai">
                            <option value="">📌 Tất cả</option>
                            <option value="Chờ xử lý">⏳ Chờ xử lý</option>
                            <option value="Đang xử lý">🔧 Đang xử lý</option>
                            <option value="Hoàn thành">✅ Hoàn thành</option>
                            <option value="Đã hủy">❌ Đã hủy</option>
                        </select>
                        <button type="submit">Lọc</button>
                    </form>
                </div>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Phòng</th>
                        <th>MSSV</th>
                        <th>Sinh viên</th>
                        <th>Nội dung</th>
                        <th>Ngày tạo</th>
                        <th>Ngày cập nhật</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="yc" items="${yeuCauList}">
                        <tr>
                            <td>${yc.idYeuCau}</td>
                            <td>🏠 ${yc.tenPhong}</td>
                            <td>${yc.mssv}</td>
                            <td>${yc.hoTenSinhVien}</td>
                            <td><span title="${yc.noiDung}">${yc.noiDung.length() > 40 ? yc.noiDung.substring(0,40).concat("...") : yc.noiDung}</span></td>
                            <td><fmt:formatDate value="${yc.ngayTao}" pattern="dd/MM/yyyy"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty yc.ngayCapNhat}">
                                        <fmt:formatDate value="${yc.ngayCapNhat}" pattern="dd/MM/yyyy"/>
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${yc.trangThai == 'Chờ xử lý'}">
                                        <span class="status-pending">⏳ Chờ xử lý</span>
                                    </c:when>
                                    <c:when test="${yc.trangThai == 'Đang xử lý'}">
                                        <span class="status-processing">🔧 Đang xử lý</span>
                                    </c:when>
                                    <c:when test="${yc.trangThai == 'Hoàn thành'}">
                                        <span class="status-done">✅ Hoàn thành</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-cancelled">❌ ${yc.trangThai}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/admin/baotri/process/${yc.idYeuCau}" class="btn-process">Xử lý</a>
                                <a href="${pageContext.request.contextPath}/admin/baotri/delete/${yc.idYeuCau}"
                                   onclick="return confirm('Bạn có chắc muốn xóa yêu cầu #${yc.idYeuCau}?')"
                                   class="btn-delete">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty yeuCauList}">
                        <tr>
                            <td colspan="9" class="text-center">🔧 Không có yêu cầu bảo trì nào</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>