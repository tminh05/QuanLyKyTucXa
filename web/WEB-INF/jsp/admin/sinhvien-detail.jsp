<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Sinh viên - Admin</title>
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
        
        .detail-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 24px;
        }
        .card-header {
            padding: 18px 24px;
            background: #f8f9ff;
            border-bottom: 1px solid #e3eaf5;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .card-header h2 { font-size: 18px; color: #0D47A1; }
        .btn-back {
            background: #f0f4f8;
            color: #333;
            padding: 6px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 0;
        }
        .info-item {
            padding: 16px 24px;
            border-bottom: 1px solid #f0f0f0;
            border-right: 1px solid #f0f0f0;
        }
        .info-item:nth-child(2n) { border-right: none; }
        .info-item:nth-last-child(-n+2) { border-bottom: none; }
        .info-label {
            font-size: 12px;
            color: #999;
            text-transform: uppercase;
            margin-bottom: 6px;
        }
        .info-value {
            font-size: 15px;
            font-weight: 600;
            color: #333;
        }
        .info-value.highlight { color: #1565C0; }
        
        .badge-nam { background: #E3F2FD; color: #1565C0; padding: 4px 12px; border-radius: 20px; font-size: 12px; display: inline-block; }
        .badge-nu { background: #FCE4EC; color: #c62828; padding: 4px 12px; border-radius: 20px; font-size: 12px; display: inline-block; }
        .badge-active { background: #e8f5e9; color: #2e7d32; padding: 4px 12px; border-radius: 20px; font-size: 12px; display: inline-block; }
        .badge-expired { background: #ffebee; color: #c62828; padding: 4px 12px; border-radius: 20px; font-size: 12px; display: inline-block; }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th {
            background: #f8f9ff;
            padding: 12px 16px;
            text-align: left;
            font-size: 12px;
            font-weight: 600;
            color: #666;
            border-bottom: 2px solid #e3eaf5;
        }
        td {
            padding: 10px 16px;
            font-size: 13px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
        }
        .text-center { text-align: center; padding: 30px; color: #999; }
        
        .action-buttons { display: flex; gap: 10px; margin-top: 20px; }
        .btn-edit {
            background: #FFC107;
            color: #333;
            padding: 8px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }
        .btn-back-list {
            background: #f0f4f8;
            color: #333;
            padding: 8px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
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
            <a href="${pageContext.request.contextPath}/admin/sinhvien" class="active">👨‍🎓 Quản lý Sinh viên</a>
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
            <div class="page-title">👨‍🎓 Chi tiết sinh viên</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <!-- THÔNG TIN CÁ NHÂN -->
        <div class="detail-card">
            <div class="card-header">
                <h2>📋 Thông tin cá nhân</h2>
                <a href="${pageContext.request.contextPath}/admin/sinhvien" class="btn-back">← Quay lại</a>
            </div>
            <div class="info-grid">
                <div class="info-item">
                    <div class="info-label">MSSV</div>
                    <div class="info-value highlight">${sinhVien.mssv}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Họ và tên</div>
                    <div class="info-value">${sinhVien.hoTen}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Ngày sinh</div>
                    <div class="info-value"><fmt:formatDate value="${sinhVien.ngaySinh}" pattern="dd/MM/yyyy"/></div>
                </div>
                <div class="info-item">
                    <div class="info-label">Giới tính</div>
                    <div class="info-value">
                        <span class="${sinhVien.gioiTinh == 'Nam' ? 'badge-nam' : 'badge-nu'}">${sinhVien.gioiTinh}</span>
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">Lớp</div>
                    <div class="info-value">${sinhVien.lop}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Khoa</div>
                    <div class="info-value">${sinhVien.khoa}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Số điện thoại</div>
                    <div class="info-value">${sinhVien.sdt}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Email</div>
                    <div class="info-value">${sinhVien.email}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">CCCD/CMND</div>
                    <div class="info-value">${sinhVien.cccd}</div>
                </div>
            </div>
            <div class="action-buttons" style="padding: 20px 24px; border-top: 1px solid #f0f0f0;">
                <a href="${pageContext.request.contextPath}/admin/sinhvien/edit/${sinhVien.mssv}" class="btn-edit">✏️ Chỉnh sửa</a>
                <a href="${pageContext.request.contextPath}/admin/sinhvien" class="btn-back-list">← Danh sách sinh viên</a>
            </div>
        </div>

        <!-- DANH SÁCH HỢP ĐỒNG -->
        <div class="detail-card">
            <div class="card-header">
                <h2>📄 Lịch sử hợp đồng</h2>
            </div>
            <c:choose>
                <c:when test="${empty hopDongList}">
                    <div class="text-center">📭 Sinh viên chưa có hợp đồng nào</div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Mã HĐ</th>
                                <th>Phòng</th>
                                <th>Ngày bắt đầu</th>
                                <th>Ngày kết thúc</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="hd" items="${hopDongList}">
                                <tr>
                                    <td>${hd.idHopDong}</td>
                                    <td>🏠 ${hd.tenPhong}</td>
                                    <td><fmt:formatDate value="${hd.ngayBatDau}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${hd.ngayKetThuc}" pattern="dd/MM/yyyy"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${hd.trangThai == 'Hiệu lực'}">
                                                <span class="badge-active">✅ Hiệu lực</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-expired">⛔ ${hd.trangThai}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/hopdong/edit/${hd.idHopDong}" style="color:#1565C0;">Xem</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>