<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập / Đăng ký - KTX UTE</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

        /* HEADER */
        .header {
            background: white;
            border-bottom: 3px solid #1565C0;
            padding: 14px 36px;
            display: flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        .header img { height: 80px; }
        .header-text { flex: 1; }
        .header-university { font-size: 16px; color: #1565C0; font-weight: 600; text-transform: uppercase; }
        .header-school { font-size: 26px; font-weight: 800; color: #1565C0; text-transform: uppercase; }
        .header-system { font-size: 18px; font-weight: 700; color: #e53935; text-transform: uppercase; }
        .header-title {
            font-size: 28px;
            font-weight: 700;
            color: #1565C0;
            text-transform: uppercase;
            margin-left: auto;
            letter-spacing: 1px;
        }

        /* MAIN - 2 ảnh chia đôi */
        .main-wrapper {
            display: flex;
            height: calc(100vh - 95px);
        }

        .panel {
            flex: 1;
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .panel img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }
        .panel:hover img { transform: scale(1.04); }

        .panel-overlay {
            position: absolute;
            inset: 0;
            background: rgba(13, 71, 161, 0.45);
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            align-items: center;
            padding-bottom: 200px;
            transition: background 0.3s;
        }
        .panel:hover .panel-overlay { background: rgba(13, 71, 161, 0.6); }

        .panel-label {
            color: white;
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 18px;
            text-shadow: 0 2px 6px rgba(0,0,0,0.4);
        }

        .panel-btn {
            background: transparent;
            color: white;
            border: 2px solid white;
            padding: 12px 45px;
            font-size: 16px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            cursor: pointer;
            border-radius: 4px;
            transition: background 0.2s, color 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        .panel-btn:hover { background: white; color: #1565C0; }

        /* DIVIDER */
        .divider {
            width: 4px;
            background: white;
            z-index: 10;
        }

        /* MODAL */
        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.6);
            z-index: 100;
            justify-content: center;
            align-items: center;
        }
        .modal-overlay.show { display: flex; }

        .modal-box {
            background: white;
            border-radius: 12px;
            width: 100%;
            max-width: 440px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.4);
            animation: slideIn 0.3s ease;
        }
        @keyframes slideIn {
            from { transform: translateY(-30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .modal-title {
            background: #1565C0;
            color: white;
            text-align: center;
            padding: 18px;
            font-size: 19px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .modal-body { padding: 28px; }

        .form-group { margin-bottom: 16px; }
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px 13px;
            border: 1.5px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }
        .form-group input:focus,
        .form-group select:focus { border-color: #1565C0; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background: #1565C0;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: background 0.2s;
            margin-top: 6px;
        }
        .btn-submit:hover { background: #0D47A1; }

        .btn-close {
            display: block;
            text-align: center;
            margin-top: 13px;
            font-size: 16px;
            color: #888;
            cursor: pointer;
            text-decoration: underline;
        }
        .btn-close:hover { color: #333; }

        .alert-error {
            background: #ffebee;
            border: 1px solid #ef9a9a;
            color: #c62828;
            padding: 9px 13px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 16px;
            text-align: center;
        }
        .alert-success {
            background: #e8f5e9;
            border: 1px solid #a5d6a7;
            color: #2e7d32;
            padding: 9px 13px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 16px;
            text-align: center;
        }
    </style>
</head>
<body>

    <!-- HEADER -->
    <div class="header">
        <img src="${pageContext.request.contextPath}/resources/image/logo_ute.png" alt="Logo UTE">
        <div class="header-text">
            <div class="header-university">Đại học Đà Nẵng</div>
            <div class="header-school">Trường Đại học Sư phạm Kỹ thuật</div>
            <div class="header-system">Hệ thống Quản lý Ký túc xá</div>
        </div>
        <div class="header-title">Trang thông tin sinh viên</div>
    </div>

    <!-- MAIN: 2 ảnh chia đôi -->
    <div class="main-wrapper">

        <!-- TRÁI: ĐĂNG KÝ -->
        <div class="panel" onclick="showModal('modal-dangky')">
            <img src="${pageContext.request.contextPath}/resources/image/anh-trang-dang-nhap-dang-ky1.jpg"
                 alt="Đăng ký">
            <div class="panel-overlay">
                <div class="panel-label">Dành cho sinh viên chưa ở KTX</div>
                <span class="panel-btn">Đăng ký</span>
            </div>
        </div>

        <!-- ĐƯỜNG KẺ GIỮA -->
        <div class="divider"></div>

        <!-- PHẢI: ĐĂNG NHẬP -->
        <div class="panel" onclick="showModal('modal-dangnhap')">
            <img src="${pageContext.request.contextPath}/resources/image/anh-trang-dang-nhap-dang-ky2.jpg"
                 alt="Đăng nhập">
            <div class="panel-overlay">
                <div class="panel-label">Dành cho sinh viên đang ở KTX</div>
                <span class="panel-btn">Đăng nhập</span>
            </div>
        </div>

    </div>

    <!-- MODAL ĐĂNG NHẬP -->
    <div class="modal-overlay" id="modal-dangnhap">
        <div class="modal-box">
            <div class="modal-title">🔐 Đăng nhập</div>
            <div class="modal-body">

                <% if (request.getAttribute("loginError") != null) { %>
                    <div class="alert-error">⚠️ <%= request.getAttribute("loginError") %></div>
                <% } %>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-group">
                        <label>Mã số sinh viên (MSSV)</label>
                        <input type="text" name="mssv" placeholder="Ví dụ: SV001" required autofocus/>
                    </div>
                    <div class="form-group">
                        <label>Mật khẩu</label>
                        <input type="password" name="matKhau" placeholder="Nhập mật khẩu..." required/>
                    </div>
                    <button type="submit" class="btn-submit">Đăng nhập</button>
                </form>
                <span class="btn-close" onclick="hideModal('modal-dangnhap')">✕ Đóng</span>
            </div>
        </div>
    </div>

    <!-- MODAL ĐĂNG KÝ -->
    <div class="modal-overlay" id="modal-dangky">
        <div class="modal-box" style="max-width:520px;">
            <div class="modal-title">📝 Đăng ký tài khoản</div>
            <div class="modal-body">

                <% if (request.getAttribute("registerError") != null) { %>
                    <div class="alert-error">⚠️ <%= request.getAttribute("registerError") %></div>
                <% } %>
                <% if (request.getAttribute("registerSuccess") != null) { %>
                    <div class="alert-success">✅ <%= request.getAttribute("registerSuccess") %></div>
                <% } %>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label>MSSV <span style="color:red">*</span></label>
                            <input type="text" name="mssv" placeholder="Ví dụ: SV003" required/>
                        </div>
                        <div class="form-group">
                            <label>Họ và tên <span style="color:red">*</span></label>
                            <input type="text" name="hoTen" placeholder="Nguyễn Văn A" required/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>Ngày sinh</label>
                            <input type="date" name="ngaySinh"/>
                        </div>
                        <div class="form-group">
                            <label>Giới tính</label>
                            <select name="gioiTinh">
                                <option value="Nam">Nam</option>
                                <option value="Nữ">Nữ</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <input type="text" name="sdt" placeholder="0901234567"/>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" placeholder="sv@gmail.com"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>Lớp</label>
                            <input type="text" name="lop" placeholder="CNTT-K18"/>
                        </div>
                        
                        <div class="form-group">
                        <label>Khoa</label>
                            <select name="khoa">
                                <option value="">-- Chọn khoa --</option>
                                <option value="Công nghệ Thông tin">Công nghệ Thông tin</option>
                                <option value="Điện tử Viễn thông">Điện tử Viễn thông</option>
                                <option value="Cơ khí">Cơ khí</option>
                                <option value="Xây dựng">Xây dựng</option>
                                <option value="Kinh tế">Kinh tế</option>
                                <option value="Ngoại ngữ">Ngoại ngữ</option>
                                <option value="Điện - Điện tử">Điện - Điện tử</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>CCCD <span style="color:red">*</span></label>
                        <input type="text" name="cccd" placeholder="012345678901" required/>
                    </div>
                    <div class="form-group">
                        <label>Mật khẩu <span style="color:red">*</span></label>
                        <input type="password" name="matKhau" placeholder="Tạo mật khẩu..." required/>
                    </div>
                    <button type="submit" class="btn-submit">Đăng ký</button>
                </form>
                <span class="btn-close" onclick="hideModal('modal-dangky')">✕ Đóng</span>
            </div>
        </div>
    </div>

    <script>
        function showModal(id) {
            document.getElementById(id).classList.add('show');
        }
        function hideModal(id) {
            document.getElementById(id).classList.remove('show');
        }
        // Tự động mở modal nếu có lỗi
        <% if (request.getAttribute("loginError") != null) { %>
            showModal('modal-dangnhap');
        <% } %>
        <% if (request.getAttribute("registerError") != null || request.getAttribute("registerSuccess") != null) { %>
            showModal('modal-dangky');
        <% } %>
    </script>

</body>
</html>