<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Khảo sát - Admin</title>
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
        
        .stats-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 24px;
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .stat-number {
            font-size: 32px;
            font-weight: 800;
            color: #1565C0;
        }
        .stat-label {
            font-size: 13px;
            color: #888;
            margin-top: 5px;
        }
        .stars {
            color: #FFC107;
            font-size: 24px;
            margin-top: 5px;
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
        tr:hover { background: #f8f9ff; cursor: pointer; }
        
        .star-rating {
            color: #FFC107;
            font-size: 14px;
        }
        
        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            z-index: 100;
            justify-content: center;
            align-items: center;
        }
        .modal-overlay.show { display: flex; }
        .modal-box {
            background: white;
            border-radius: 12px;
            width: 600px;
            max-width: 90%;
            max-height: 80vh;
            overflow-y: auto;
            animation: slideIn 0.3s ease;
        }
        @keyframes slideIn {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        .modal-title {
            background: #1565C0;
            color: white;
            padding: 16px 20px;
            font-size: 15px;
            font-weight: 700;
            position: sticky;
            top: 0;
        }
        .modal-body { padding: 20px; }
        .detail-row {
            margin-bottom: 12px;
            padding: 8px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .detail-label {
            font-weight: 600;
            color: #666;
            font-size: 12px;
            margin-bottom: 4px;
        }
        .detail-value {
            font-size: 14px;
            color: #333;
        }
        .detail-value strong { color: #1565C0; }
        .btn-close {
            width: 100%;
            padding: 10px;
            background: #f0f4f8;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 10px;
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
            <div class="page-title">📝 Quản lý Khảo sát</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <!-- Thống kê -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-number">${tongKhaoSat}</div>
                <div class="stat-label">Tổng số bài khảo sát</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">
                    <fmt:formatNumber value="${diemTrungBinh}" maxFractionDigits="1"/> / 5
                </div>
                <div class="stat-label">Điểm trung bình</div>
                <div class="stars">
                    <c:forEach begin="1" end="5" var="i">
                        <c:choose>
                            <c:when test="${i <= diemTrungBinh}">★</c:when>
                            <c:otherwise>☆</c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${diemTrungBinh >= 4 ? '⭐ Tốt' : diemTrungBinh >= 3 ? '👍 Trung bình' : '⚠️ Cần cải thiện'}</div>
                <div class="stat-label">Đánh giá chung</div>
            </div>
        </div>

        <!-- Danh sách khảo sát -->
        <div class="data-card">
            <div class="card-header">
                <h2>📋 Danh sách bài khảo sát</h2>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>Lớp</th>
                        <th>MSSV</th>
                        <th>Email</th>
                        <th>Đánh giá sao</th>
                        <th>Ngày gửi</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ks" items="${khaoSatList}">
                        <tr onclick="openDetailModal(${ks.idKhaoSat})">
                            <td>${ks.idKhaoSat}</td>
                            <td>${ks.hoTen}</td>
                            <td>${ks.lop}</td>
                            <td>${ks.mssv}</td>
                            <td>${ks.gmail}</td>
                            <td>
                                <div class="star-rating">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= ks.danhGiaSao}">⭐</c:when>
                                            <c:otherwise>☆</c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    (${ks.danhGiaSao}/5)
                                </div>
                            </td>
                            <td><fmt:formatDate value="${ks.ngayGui}" pattern="dd/MM/yyyy HH:mm"/></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty khaoSatList}">
                        <tr>
                            <td colspan="7" class="text-center">📝 Chưa có bài khảo sát nào</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- MODAL CHI TIẾT KHẢO SÁT -->
    <div class="modal-overlay" id="modal-detail">
        <div class="modal-box">
            <div class="modal-title">📋 Chi tiết khảo sát</div>
            <div class="modal-body" id="detail-content">
                <!-- Nội dung sẽ được load bằng JS -->
            </div>
            <button class="btn-close" onclick="closeDetailModal()">Đóng</button>
        </div>
    </div>

    <script>
        function openDetailModal(id) {
            fetch('${pageContext.request.contextPath}/admin/khaosat/detail/' + id)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('detail-content').innerHTML = html;
                    document.getElementById('modal-detail').classList.add('show');
                })
                .catch(error => {
                    document.getElementById('detail-content').innerHTML = '<p style="color:red;">Lỗi tải dữ liệu</p>';
                    document.getElementById('modal-detail').classList.add('show');
                });
        }
        
        function closeDetailModal() {
            document.getElementById('modal-detail').classList.remove('show');
        }
    </script>
</body>
</html>