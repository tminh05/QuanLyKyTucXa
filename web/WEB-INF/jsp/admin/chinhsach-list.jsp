<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Chính sách hỗ trợ - Admin</title>
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
        
        .status-pending {
            background: #FFF8E1;
            color: #f57f17;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        .status-approved {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        .status-rejected {
            background: #ffebee;
            color: #c62828;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        
        .badge-chinhsach {
            background: #E3F2FD;
            color: #1565C0;
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        .btn-approve {
            background: #2e7d32;
            color: white;
            padding: 5px 12px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
        }
        .btn-reject {
            background: #e53935;
            color: white;
            padding: 5px 12px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
        }
        .btn-pending {
            background: #f57f17;
            color: white;
            padding: 5px 12px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
        }
        .btn-view {
            background: #1565C0;
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
            width: 500px;
            max-width: 90%;
            overflow: hidden;
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
        }
        .modal-body { padding: 20px; }
        .modal-btns {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .btn-confirm {
            flex: 1;
            padding: 10px;
            background: #1565C0;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn-cancel-modal {
            flex: 1;
            padding: 10px;
            background: #f0f4f8;
            color: #333;
            border: 1px solid #ddd;
            border-radius: 6px;
            cursor: pointer;
        }
        .detail-row {
            margin-bottom: 12px;
            padding-bottom: 8px;
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
            <div class="page-title">🎖️ Quản lý Chính sách hỗ trợ</div>
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
                <h2>📋 Danh sách yêu cầu hỗ trợ</h2>
                <div class="filter-bar">
                    <form action="${pageContext.request.contextPath}/admin/chinhsach" method="get" style="display: flex; gap: 10px;">
                        <select name="trangThai">
                            <option value="">📌 Tất cả</option>
                            <option value="Chờ duyệt" ${param.trangThai == 'Chờ duyệt' ? 'selected' : ''}>⏳ Chờ duyệt</option>
                            <option value="Đã duyệt" ${param.trangThai == 'Đã duyệt' ? 'selected' : ''}>✅ Đã duyệt</option>
                            <option value="Từ chối" ${param.trangThai == 'Từ chối' ? 'selected' : ''}>❌ Từ chối</option>
                        </select>
                        <button type="submit">Lọc</button>
                    </form>
                </div>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>MSSV</th>
                        <th>Họ tên</th>
                        <th>Lớp</th>
                        <th>Chính sách</th>
                        <th>Ngày nộp</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="yc" items="${yeuCauList}">
                        <tr>
                            <td>${yc.idYeuCau}</td>
                            <td><strong>${yc.mssv}</strong></td>
                            <td>${yc.hoTen}</td>
                            <td>${yc.lop}</td>
                            <td><span class="badge-chinhsach">${yc.loaiChinhSach}</span></td>
                            <td><fmt:formatDate value="${yc.ngayNop}" pattern="dd/MM/yyyy"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${yc.trangThai == 'Chờ duyệt'}">
                                        <span class="status-pending">⏳ Chờ duyệt</span>
                                    </c:when>
                                    <c:when test="${yc.trangThai == 'Đã duyệt'}">
                                        <span class="status-approved">✅ Đã duyệt</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-rejected">❌ Từ chối</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="action-buttons">
                                <button class="btn-view" onclick="openDetailModal(${yc.idYeuCau})">🔍 Chi tiết</button>
                                <c:if test="${yc.trangThai == 'Chờ duyệt'}">
                                    <button class="btn-approve" onclick="openApproveModal(${yc.idYeuCau}, '${yc.hoTen}')">✅ Duyệt</button>
                                    <button class="btn-reject" onclick="openRejectModal(${yc.idYeuCau}, '${yc.hoTen}')">❌ Từ chối</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty yeuCauList}">
                        <tr>
                            <td colspan="8" class="text-center">🎖️ Không có yêu cầu hỗ trợ nào</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- MODAL CHI TIẾT -->
    <div class="modal-overlay" id="modal-detail">
        <div class="modal-box">
            <div class="modal-title">📋 Chi tiết yêu cầu hỗ trợ</div>
            <div class="modal-body" id="detail-content">
                <!-- Nội dung sẽ được load bằng JS -->
            </div>
            <div class="modal-btns" style="padding: 0 20px 20px 20px;">
                <button class="btn-cancel-modal" onclick="closeDetailModal()">Đóng</button>
            </div>
        </div>
    </div>

    <!-- MODAL DUYỆT -->
    <div class="modal-overlay" id="modal-approve">
        <div class="modal-box">
            <div class="modal-title">✅ Duyệt yêu cầu</div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn <strong>DUYỆT</strong> yêu cầu của sinh viên <span id="approveName"></span>?</p>
                <p style="margin-top: 10px; color: #2e7d32;">Sau khi duyệt, sinh viên sẽ được hưởng chính sách hỗ trợ.</p>
                <form id="approveForm" action="" method="post">
                    <input type="hidden" name="trangThai" value="Đã duyệt">
                    <div class="modal-btns">
                        <button type="submit" class="btn-confirm">✅ Xác nhận duyệt</button>
                        <button type="button" class="btn-cancel-modal" onclick="closeApproveModal()">❌ Hủy</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- MODAL TỪ CHỐI -->
    <div class="modal-overlay" id="modal-reject">
        <div class="modal-box">
            <div class="modal-title">❌ Từ chối yêu cầu</div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn <strong>TỪ CHỐI</strong> yêu cầu của sinh viên <span id="rejectName"></span>?</p>
                <p style="margin-top: 10px; color: #c62828;">Vui lòng nhập lý do từ chối:</p>
                <form id="rejectForm" action="" method="post">
                    <input type="hidden" name="trangThai" value="Từ chối">
                    <textarea name="lyDo" rows="3" style="width:100%; padding:8px; border:1px solid #ddd; border-radius:6px; margin-top:5px;" placeholder="Nhập lý do từ chối..."></textarea>
                    <div class="modal-btns" style="margin-top: 15px;">
                        <button type="submit" class="btn-confirm" style="background:#e53935;">❌ Xác nhận từ chối</button>
                        <button type="button" class="btn-cancel-modal" onclick="closeRejectModal()">Hủy</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Detail Modal
        function openDetailModal(id) {
            fetch('${pageContext.request.contextPath}/admin/chinhsach/detail/' + id)
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
        
        // Approve Modal
        function openApproveModal(id, name) {
            document.getElementById('approveName').innerText = name;
            document.getElementById('approveForm').action = '${pageContext.request.contextPath}/admin/chinhsach/duyet/' + id;
            document.getElementById('modal-approve').classList.add('show');
        }
        
        function closeApproveModal() {
            document.getElementById('modal-approve').classList.remove('show');
        }
        
        // Reject Modal
        function openRejectModal(id, name) {
            document.getElementById('rejectName').innerText = name;
            document.getElementById('rejectForm').action = '${pageContext.request.contextPath}/admin/chinhsach/duyet/' + id;
            document.getElementById('modal-reject').classList.add('show');
        }
        
        function closeRejectModal() {
            document.getElementById('modal-reject').classList.remove('show');
        }
    </script>
</body>
</html>