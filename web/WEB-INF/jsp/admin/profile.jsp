<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ Admin - KTX UTE</title>
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
        
        .profile-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
            max-width: 700px;
        }
        .profile-header {
            background: linear-gradient(135deg, #1565C0, #0D47A1);
            padding: 30px;
            text-align: center;
            color: white;
        }
        .profile-avatar {
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            margin: 0 auto 15px;
            border: 3px solid white;
        }
        .profile-name {
            font-size: 22px;
            font-weight: 700;
        }
        .profile-role {
            font-size: 13px;
            opacity: 0.9;
            margin-top: 5px;
        }
        
        .tab-btns {
            display: flex;
            border-bottom: 2px solid #e3eaf5;
        }
        .tab-btn {
            flex: 1;
            padding: 14px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            background: none;
            color: #888;
            border-bottom: 2px solid transparent;
            transition: all 0.2s;
        }
        .tab-btn.active {
            color: #1565C0;
            border-bottom-color: #1565C0;
        }
        .tab-content {
            display: none;
            padding: 24px;
        }
        .tab-content.active {
            display: block;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
        }
        .form-group input {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }
        .form-group input:focus {
            border-color: #1565C0;
        }
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
        
        .info-text {
            font-size: 11px;
            color: #888;
            margin-top: 5px;
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
            <div class="page-title">👤 Hồ sơ Admin</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <c:if test="${not empty success}">
            <div class="alert-success">✅ ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert-error">⚠️ ${error}</div>
        </c:if>
        <c:if test="${not empty successPass}">
            <div class="alert-success">✅ ${successPass}</div>
        </c:if>
        <c:if test="${not empty errorPass}">
            <div class="alert-error">⚠️ ${errorPass}</div>
        </c:if>

        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">👑</div>
                <div class="profile-name">${admin.hoTen}</div>
                <div class="profile-role">${admin.chucVu} | ${admin.vaiTro == 'ADMIN' ? 'Quản trị viên' : 'Nhân viên'}</div>
            </div>
            
            <div class="tab-btns">
                <button class="tab-btn active" onclick="showTab('tab-edit')">✏️ Chỉnh sửa thông tin</button>
                <button class="tab-btn" onclick="showTab('tab-password')">🔒 Đổi mật khẩu</button>
            </div>

            <!-- TAB CHỈNH SỬA THÔNG TIN -->
            <div id="tab-edit" class="tab-content active">
                <form action="${pageContext.request.contextPath}/admin/profile/update" method="post">
                    <input type="hidden" name="id" value="${admin.idNhanVien}">
                    
                    <div class="form-group">
                        <label>Họ và tên</label>
                        <input type="text" name="hoTen" value="${admin.hoTen}" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" name="sdt" value="${admin.sdt}">
                    </div>
                    
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" value="${admin.email}" required>
                        <div class="info-text">Email dùng để đăng nhập hệ thống</div>
                    </div>
                    
                    <button type="submit" class="btn-submit">💾 Lưu thay đổi</button>
                </form>
            </div>

            <!-- TAB ĐỔI MẬT KHẨU -->
            <div id="tab-password" class="tab-content">
                <form action="${pageContext.request.contextPath}/admin/profile/changepassword" method="post">
                    <input type="hidden" name="id" value="${admin.idNhanVien}">
                    
                    <div class="form-group">
                        <label>Mật khẩu hiện tại <span style="color:red">*</span></label>
                        <input type="password" name="matKhauCu" placeholder="Nhập mật khẩu hiện tại" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Mật khẩu mới <span style="color:red">*</span></label>
                        <input type="password" name="matKhauMoi" id="matKhauMoi" placeholder="Nhập mật khẩu mới" required>
                        <div class="info-text">Mật khẩu tối thiểu 3 ký tự</div>
                    </div>
                    
                    <div class="form-group">
                        <label>Xác nhận mật khẩu mới <span style="color:red">*</span></label>
                        <input type="password" name="xacNhanMatKhau" id="xacNhanMatKhau" placeholder="Nhập lại mật khẩu mới" required>
                    </div>
                    
                    <button type="submit" class="btn-submit" onclick="return checkPassword()">🔒 Đổi mật khẩu</button>
                </form>
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