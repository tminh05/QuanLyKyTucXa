<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa nhân viên - Admin</title>
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
        .form-group input[readonly] {
            background: #f5f5f5;
            color: #666;
            cursor: not-allowed;
        }
        
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
        .info-text {
            font-size: 11px;
            color: #888;
            margin-top: 5px;
        }
        
        .tab-btns {
            display: flex;
            border-bottom: 2px solid #e3eaf5;
            margin-bottom: 20px;
        }
        .tab-btn {
            padding: 8px 20px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            background: none;
            color: #888;
            border-bottom: 2px solid transparent;
            margin-bottom: -2px;
            transition: all 0.2s;
        }
        .tab-btn.active {
            color: #1565C0;
            border-bottom-color: #1565C0;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        .badge-admin {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        .badge-staff {
            background: #E3F2FD;
            color: #1565C0;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
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
            <a href="${pageContext.request.contextPath}/admin/nhanvien" class="active">👥 Quản lý Nhân viên</a>
            <a href="${pageContext.request.contextPath}/admin/baiviet">📰 Quản lý Bài viết</a>
            <a href="${pageContext.request.contextPath}/admin/thongke">📈 Thống kê</a>
        </div>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/admin/logout">🔓 Đăng xuất</a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div class="page-title">✏️ Sửa thông tin nhân viên</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <div class="form-card">
            <div class="card-header">
                <h2>👥 Cập nhật thông tin: <strong>${nhanVien.hoTen}</strong>
                    <c:if test="${nhanVien.vaiTro == 'ADMIN'}">
                        <span class="badge-admin" style="margin-left: 10px;">👑 Admin</span>
                    </c:if>
                </h2>
            </div>
            <div class="form-body">
                <c:if test="${not empty error}">
                    <div class="alert-error">⚠️ ${error}</div>
                </c:if>

                <!-- TABS -->
                <div class="tab-btns">
                    <button class="tab-btn active" onclick="showTab('tab-edit')">✏️ Chỉnh sửa thông tin</button>
                    <button class="tab-btn" onclick="showTab('tab-password')">🔒 Đổi mật khẩu</button>
                </div>

                <!-- TAB CHỈNH SỬA THÔNG TIN -->
                <div id="tab-edit" class="tab-content active">
                    <form action="${pageContext.request.contextPath}/admin/nhanvien/edit" method="post">
                        <input type="hidden" name="idNhanVien" value="${nhanVien.idNhanVien}">

                        <div class="form-row">
                            <div class="form-group">
                                <label>Họ và tên <span class="required">*</span></label>
                                <input type="text" name="hoTen" value="${nhanVien.hoTen}" required>
                            </div>
                            <div class="form-group">
                                <label>Chức vụ <span class="required">*</span></label>
                                <select name="chucVu" required>
                                    <option value="Quản lý" ${nhanVien.chucVu == 'Quản lý' ? 'selected' : ''}>Quản lý</option>
                                    <option value="Nhân viên bảo trì" ${nhanVien.chucVu == 'Nhân viên bảo trì' ? 'selected' : ''}>Nhân viên bảo trì</option>
                                    <option value="Nhân viên kế toán" ${nhanVien.chucVu == 'Nhân viên kế toán' ? 'selected' : ''}>Nhân viên kế toán</option>
                                    <option value="Bảo vệ" ${nhanVien.chucVu == 'Bảo vệ' ? 'selected' : ''}>Bảo vệ</option>
                                    <option value="Tạp vụ" ${nhanVien.chucVu == 'Tạp vụ' ? 'selected' : ''}>Tạp vụ</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input type="text" name="sdt" value="${nhanVien.sdt}">
                            </div>
                            <div class="form-group">
                                <label>Email <span class="required">*</span></label>
                                <input type="email" name="email" value="${nhanVien.email}" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Vai trò <span class="required">*</span></label>
                                <select name="vaiTro" required>
                                    <option value="NHAN_VIEN" ${nhanVien.vaiTro == 'NHAN_VIEN' ? 'selected' : ''}>👤 Nhân viên</option>
                                    <option value="ADMIN" ${nhanVien.vaiTro == 'ADMIN' ? 'selected' : ''}>👑 Admin (quyền cao nhất)</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Trạng thái</label>
                                <select name="trangThai">
                                    <option value="HOAT_DONG" ${nhanVien.trangThai == 'HOAT_DONG' ? 'selected' : ''}>🟢 Hoạt động</option>
                                    <option value="KHOA" ${nhanVien.trangThai == 'KHOA' ? 'selected' : ''}>🔴 Khóa</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-buttons">
                            <button type="submit" class="btn-submit">💾 Lưu cập nhật</button>
                            <a href="${pageContext.request.contextPath}/admin/nhanvien" class="btn-cancel">❌ Hủy bỏ</a>
                        </div>
                    </form>
                </div>

                <!-- TAB ĐỔI MẬT KHẨU -->
                <div id="tab-password" class="tab-content">
                    <form action="${pageContext.request.contextPath}/admin/nhanvien/changepassword" method="post">
                        <input type="hidden" name="id" value="${nhanVien.idNhanVien}">

                        <div class="form-group">
                            <label>Mật khẩu mới <span class="required">*</span></label>
                            <input type="password" name="matKhauMoi" id="matKhauMoi" placeholder="Nhập mật khẩu mới" required>
                            <div class="info-text">Mật khẩu tối thiểu 3 ký tự</div>
                        </div>
                        <div class="form-group">
                            <label>Xác nhận mật khẩu mới <span class="required">*</span></label>
                            <input type="password" name="xacNhanMatKhau" id="xacNhanMatKhau" placeholder="Nhập lại mật khẩu mới" required>
                        </div>

                        <button type="submit" class="btn-submit" onclick="return checkPassword()">🔒 Đổi mật khẩu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showTab(tabId) {
            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            event.target.classList.add('active');
        }

        function checkPassword() {
            var mk1 = document.getElementById('matKhauMoi').value;
            var mk2 = document.getElementById('xacNhanMatKhau').value;
            if (mk1 !== mk2) {
                alert('Mật khẩu mới và xác nhận không khớp!');
                return false;
            }
            if (mk1.length < 3) {
                alert('Mật khẩu phải có ít nhất 3 ký tự!');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>