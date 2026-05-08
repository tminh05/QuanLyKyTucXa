<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tạo hóa đơn - Admin</title>
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
        
        .form-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
            max-width: 700px;
        }
        .card-header {
            padding: 18px 24px;
            background: #f8f9ff;
            border-bottom: 1px solid #e3eaf5;
        }
        .card-header h2 { font-size: 18px; color: #0D47A1; }
        .form-body { padding: 24px; }
        
        .form-group { margin-bottom: 20px; }
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
        }
        .required { color: #e53935; }
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
            font-family: inherit;
        }
        .form-group input:focus, .form-group select:focus { border-color: #1565C0; }
        .form-group input[type="number"] { -moz-appearance: textfield; }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .form-buttons {
            display: flex;
            gap: 12px;
            margin-top: 24px;
        }
        .btn-submit {
            background: #1565C0;
            color: white;
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-submit:hover { background: #0D47A1; }
        .btn-cancel {
            background: #f0f4f8;
            color: #333;
            padding: 10px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }
        .alert-error {
            background: #ffebee;
            border: 1px solid #ef9a9a;
            color: #c62828;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .info-box {
            background: #E3F2FD;
            border-left: 4px solid #1565C0;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 13px;
        }
        .price-preview {
            background: #f8f9ff;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            margin-top: 20px;
        }
        .price-preview span {
            font-size: 24px;
            font-weight: 800;
            color: #e53935;
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
            <div class="page-title">➕ Tạo hóa đơn mới</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <div class="form-card">
            <div class="card-header">
                <h2>💰 Thông tin hóa đơn</h2>
            </div>
            <div class="form-body">
                <c:if test="${not empty error}">
                    <div class="alert-error">⚠️ ${error}</div>
                </c:if>

                <div class="info-box">
                    📌 <strong>Giá điện:</strong> 3.000đ/số &nbsp;|&nbsp; 
                    <strong>Giá nước:</strong> 15.000đ/m³
                </div>

                <form action="${pageContext.request.contextPath}/admin/hoadon/add" method="post" id="hoaDonForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Phòng <span class="required">*</span></label>
                            <select name="idPhong" id="idPhong" required>
                                <option value="">-- Chọn phòng --</option>
                                <c:forEach var="p" items="${phongList}">
                                    <option value="${p.idPhong}">${p.tenPhong} (${p.tenToaNha})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Kỳ hóa đơn <span class="required">*</span></label>
                            <input type="text" name="kyHoaDon" placeholder="MM/YYYY (VD: 04/2026)" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Chỉ số điện cũ <span class="required">*</span></label>
                            <input type="number" name="chiSoDienCu" id="chiSoDienCu" value="0" required>
                        </div>
                        <div class="form-group">
                            <label>Chỉ số điện mới <span class="required">*</span></label>
                            <input type="number" name="chiSoDienMoi" id="chiSoDienMoi" value="0" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Chỉ số nước cũ <span class="required">*</span></label>
                            <input type="number" name="chiSoNuocCu" id="chiSoNuocCu" value="0" required>
                        </div>
                        <div class="form-group">
                            <label>Chỉ số nước mới <span class="required">*</span></label>
                            <input type="number" name="chiSoNuocMoi" id="chiSoNuocMoi" value="0" required>
                        </div>
                    </div>

                    <div class="price-preview">
                        <strong>Tổng tiền:</strong> <span id="tongTienPreview">0</span> đ
                    </div>

                    <div class="form-buttons">
                        <button type="submit" class="btn-submit">💾 Tạo hóa đơn</button>
                        <a href="${pageContext.request.contextPath}/admin/hoadon" class="btn-cancel">❌ Hủy bỏ</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        const GIA_DIEN = 3000;
        const GIA_NUOC = 15000;

        function calculateTotal() {
            let dienCu = parseInt(document.getElementById('chiSoDienCu').value) || 0;
            let dienMoi = parseInt(document.getElementById('chiSoDienMoi').value) || 0;
            let nuocCu = parseInt(document.getElementById('chiSoNuocCu').value) || 0;
            let nuocMoi = parseInt(document.getElementById('chiSoNuocMoi').value) || 0;
            
            let soDien = Math.max(0, dienMoi - dienCu);
            let soNuoc = Math.max(0, nuocMoi - nuocCu);
            
            let tienDien = soDien * GIA_DIEN;
            let tienNuoc = soNuoc * GIA_NUOC;
            let tong = tienDien + tienNuoc;
            
            document.getElementById('tongTienPreview').innerHTML = tong.toLocaleString('vi-VN');
        }
        
        document.getElementById('chiSoDienCu').addEventListener('input', calculateTotal);
        document.getElementById('chiSoDienMoi').addEventListener('input', calculateTotal);
        document.getElementById('chiSoNuocCu').addEventListener('input', calculateTotal);
        document.getElementById('chiSoNuocMoi').addEventListener('input', calculateTotal);
        
        calculateTotal();
    </script>
</body>
</html>