<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Hóa đơn - Admin</title>
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
        .btn-add {
            background: #1565C0;
            color: white;
            padding: 8px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
        }
        .btn-add:hover { background: #0D47A1; }
        
        .filter-bar {
            display: flex;
            gap: 10px;
        }
        .filter-bar select, .filter-bar input {
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
        .btn-pay {
            background: #2e7d32;
            color: white;
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
        
        .status-unpaid {
            background: #ffebee;
            color: #c62828;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        .status-paid {
            background: #e8f5e9;
            color: #2e7d32;
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
            width: 400px;
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
        .payment-method {
            width: 100%;
            padding: 10px;
            border: 1.5px solid #ddd;
            border-radius: 6px;
            margin-top: 10px;
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
            <div class="page-title">💰 Quản lý Hóa đơn</div>
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
                <h2>📋 Danh sách hóa đơn</h2>
                <div style="display: flex; gap: 12px;">
                    <div class="filter-bar">
                        <form action="${pageContext.request.contextPath}/admin/hoadon" method="get" style="display: flex; gap: 10px;">
                            <select name="trangThai">
                                <option value="">📌 Tất cả</option>
                                <option value="chua-thanh-toan" ${param.trangThai == 'chua-thanh-toan' ? 'selected' : ''}>⏳ Chưa thanh toán</option>
                            </select>
                            <input type="text" name="kyHoaDon" placeholder="🔍 Kỳ hóa đơn (MM/YYYY)" value="${param.kyHoaDon}">
                            <button type="submit">Lọc</button>
                        </form>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/hoadon/add" class="btn-add">➕ Tạo hóa đơn</a>
                </div>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Phòng</th>
                        <th>Kỳ hóa đơn</th>
                        <th>Điện (Cũ → Mới)</th>
                        <th>Nước (Cũ → Mới)</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="hd" items="${hoaDonList}">
                        <tr>
                            <td>${hd.idHoaDon}</td>
                            <td>🏠 ${hd.tenPhong}</td>
                            <td><strong>Tháng ${hd.kyHoaDon}</strong></td>
                            <td>${hd.chiSoDienCu} → ${hd.chiSoDienMoi}<br>
                                <span style="font-size:11px; color:#2e7d32;">(+${hd.soDienSuDung} số)</span>
                            </td>
                            <td>${hd.chiSoNuocCu} → ${hd.chiSoNuocMoi}<br>
                                <span style="font-size:11px; color:#0277bd;">(+${hd.soNuocSuDung} m³)</span>
                            </td>
                            <td>
                                <strong style="color:#e53935;">
                                    <fmt:formatNumber value="${hd.tongTien}" type="number" groupingUsed="true"/> đ
                                </strong>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${hd.trangThai == 'Chưa thanh toán'}">
                                        <span class="status-unpaid">⏳ Chưa thanh toán</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-paid">✅ Đã thanh toán</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="action-buttons">
                                <c:if test="${hd.trangThai == 'Chưa thanh toán'}">
                                    <button class="btn-pay" onclick="openPayModal(${hd.idHoaDon}, ${hd.tongTien})">💳 Thanh toán</button>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/admin/hoadon/delete/${hd.idHoaDon}"
                                   onclick="return confirm('Bạn có chắc muốn xóa hóa đơn này?')"
                                   class="btn-delete">🗑️ Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty hoaDonList}">
                        <tr>
                            <td colspan="8" class="text-center">💰 Không có dữ liệu hóa đơn</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- MODAL THANH TOÁN -->
    <div class="modal-overlay" id="modal-pay">
        <div class="modal-box">
            <div class="modal-title">💳 Thanh toán hóa đơn</div>
            <div class="modal-body">
                <form id="payForm" action="${pageContext.request.contextPath}/admin/hoadon/pay" method="get">
                    <input type="hidden" name="id" id="hoaDonId">
                    <p><strong>Số tiền cần thanh toán:</strong> <span id="soTien" style="color:#e53935; font-size:18px;"></span></p>
                    <select name="phuongThuc" class="payment-method" required>
                        <option value="">-- Chọn phương thức --</option>
                        <option value="Tiền mặt">💵 Tiền mặt</option>
                        <option value="Chuyển khoản">🏦 Chuyển khoản</option>
                        <option value="Thẻ tín dụng">💳 Thẻ tín dụng</option>
                    </select>
                    <div class="modal-btns">
                        <button type="submit" class="btn-confirm">✅ Xác nhận thanh toán</button>
                        <button type="button" class="btn-cancel-modal" onclick="closePayModal()">❌ Hủy</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openPayModal(id, soTien) {
            document.getElementById('hoaDonId').value = id;
            document.getElementById('soTien').innerHTML = new Intl.NumberFormat('vi-VN').format(soTien) + ' đ';
            document.getElementById('modal-pay').classList.add('show');
        }
        function closePayModal() {
            document.getElementById('modal-pay').classList.remove('show');
        }
    </script>
</body>
</html>