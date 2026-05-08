<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý mượn sách - Admin</title>
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
        .btn-back {
            background: #f0f4f8;
            color: #333;
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
        
        .status-dang-muon {
            background: #FFF8E1;
            color: #f57f17;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        .status-da-tra {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        .status-qua-han {
            background: #ffebee;
            color: #c62828;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        
        .btn-return {
            background: #2e7d32;
            color: white;
            padding: 5px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            border: none;
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
        .note-box {
            background: #FFF8E1;
            border-left: 4px solid #f57f17;
            padding: 12px 16px;
            margin-bottom: 20px;
            font-size: 13px;
        }
        
        .quahan-badge {
            background: #c62828;
            color: white;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 10px;
            margin-left: 8px;
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
            <a href="${pageContext.request.contextPath}/admin/baiviet">📰 Quản lý Bài viết</a>
            <a href="${pageContext.request.contextPath}/admin/thongke">📈 Thống kê</a>
        </div>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/admin/logout">🔓 Đăng xuất</a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div class="page-title">📋 Quản lý mượn/trả sách</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <c:if test="${not empty success}">
            <div class="alert-success">✅ ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert-error">⚠️ ${error}</div>
        </c:if>

        <div class="note-box">
            📌 <strong>Hướng dẫn:</strong> Khi sinh viên đến trả sách, nhấn nút "📖 Trả sách" để cập nhật.
        </div>

        <div class="data-card">
            <div class="card-header">
                <h2>📋 Danh sách mượn sách</h2>
                <div style="display: flex; gap: 12px;">
                    <form action="${pageContext.request.contextPath}/admin/thuvien/muon" method="get" class="search-box">
                        <input type="text" name="mssv" placeholder="🔍 Tìm theo MSSV...">
                        <button type="submit">Tìm</button>
                    </form>
                    <a href="${pageContext.request.contextPath}/admin/thuvien" class="btn-back">← Quay lại thư viện</a>
                </div>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>MSSV</th>
                        <th>Họ tên</th>
                        <th>Tên sách</th>
                        <th>Ngày mượn</th>
                        <th>Hạn trả</th>
                        <th>Ngày trả</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ms" items="${muonSachList}">
                        <c:set var="isQuaHan" value="${ms.trangThai == 'Đang mượn' and ms.ngayHenTra.time < now.time}"/>
                        <tr>
                            <td>${ms.idMuonSach}</td>
                            <td><strong>${ms.mssv}</strong></td>
                            <td>${ms.hoTen}</td>
                            <td>📖 ${ms.tenSach}</td>
                            <td><fmt:formatDate value="${ms.ngayMuon}" pattern="dd/MM/yyyy"/></td>
                            <td>
                                <fmt:formatDate value="${ms.ngayHenTra}" pattern="dd/MM/yyyy"/>
                                <c:if test="${isQuaHan}">
                                    <span class="quahan-badge">Quá hạn</span>
                                </c:if>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty ms.ngayTraThuc}">
                                        <fmt:formatDate value="${ms.ngayTraThuc}" pattern="dd/MM/yyyy"/>
                                    </c:when>
                                    <c:otherwise>--</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${ms.trangThai == 'Đang mượn'}">
                                        <span class="status-dang-muon">📖 Đang mượn</span>
                                    </c:when>
                                    <c:when test="${ms.trangThai == 'Đã trả'}">
                                        <span class="status-da-tra">✅ Đã trả</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-qua-han">⚠️ ${ms.trangThai}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="action-buttons">
                                <c:if test="${ms.trangThai == 'Đang mượn'}">
                                    <a href="${pageContext.request.contextPath}/admin/thuvien/return/${ms.idMuonSach}" 
                                       class="btn-return"
                                       onclick="return confirm('Xác nhận sinh viên ${ms.hoTen} đã trả sách?')">
                                        📖 Trả sách
                                    </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/admin/thuvien/delete-muon/${ms.idMuonSach}"
                                   onclick="return confirm('Bạn có chắc muốn xóa bản ghi mượn này?')"
                                   class="btn-delete">🗑️ Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty muonSachList}">
                        <tr>
                            <td colspan="9" class="text-center">📭 Không có dữ liệu mượn sách</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>