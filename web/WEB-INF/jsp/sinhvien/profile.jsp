<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân - KTX UTE</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f0f4f8; }

        .header { background: white; border-bottom: 3px solid #1565C0; padding: 12px 30px;
                  display: flex; align-items: center; gap: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .header img { height: 65px; }
        .header-university { font-size: 13px; color: #1565C0; font-weight: 600; text-transform: uppercase; }
        .header-school { font-size: 20px; font-weight: 800; color: #1565C0; text-transform: uppercase; }
        .header-system { font-size: 15px; font-weight: 700; color: #e53935; text-transform: uppercase; }

        .main-nav { background: #1976D2; }
        .nav-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; }
        .main-nav a { color: white; text-decoration: none; padding: 12px 22px; font-size: 15px;
                      font-weight: 500; display: block; transition: background 0.2s;
                      border-right: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:first-child { border-left: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:hover, .main-nav a.active { background: #0D47A1; }

        .page-header { background: linear-gradient(135deg, #BBDEFB, #64B5F6, #2196F3);
                       color: white; padding: 24px 0; }
        .page-header-inner { max-width: 1000px; margin: 0 auto; padding: 0 20px;
                             display: flex; align-items: center; gap: 20px; }
        .avatar { width: 70px; height: 70px; background: rgba(255, 82, 82, 0.2);
                  border-radius: 50%; display: flex; align-items: center;
                  justify-content: center; font-size: 32px; border: 3px solid white; }
        .page-header h1 { font-size: 22px; font-weight: 800; }
        .page-header p { font-size: 13px; opacity: 0.85; margin-top: 3px; }

        .wrap { max-width: 1000px; margin: 24px auto; padding: 0 20px;
                display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .wrap-full { max-width: 1000px; margin: 0 auto; padding: 0 20px 24px; }

        .card { background: white; border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.07); overflow: hidden; }
        .card-title { background: #1565C0; color: white; padding: 12px 18px;
                      font-size: 14px; font-weight: 700; text-transform: uppercase;
                      display: flex; align-items: center; gap: 8px; }
        .card-body { padding: 18px; }

        /* THÔNG TIN CÁ NHÂN */
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
        .info-item label { display: block; font-size: 11px; font-weight: 700;
                           color: #888; text-transform: uppercase; margin-bottom: 3px; }
        .info-item .value { font-size: 14px; color: #333; font-weight: 500; }
        .info-item .value.highlight { color: #1565C0; font-weight: 700; }

        .badge { display: inline-block; padding: 3px 10px; border-radius: 12px;
                 font-size: 12px; font-weight: 600; }
        .badge-nam { background: #E3F2FD; color: #1565C0; }
        .badge-nu { background: #FCE4EC; color: #c62828; }

        /* FORM CHỈNH SỬA */
        .form-group { margin-bottom: 14px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600;
                            color: #333; margin-bottom: 5px; }
        .form-group input { width: 100%; padding: 9px 12px; border: 1.5px solid #ddd;
                            border-radius: 6px; font-size: 13px; outline: none;
                            transition: border-color 0.2s; }
        .form-group input:focus { border-color: #1565C0; }
        .form-group input[readonly] { background: #f8f9ff; color: #888; cursor: not-allowed; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }

        .btn-submit { width: 100%; padding: 11px; background: #1565C0; color: white;
                      border: none; border-radius: 6px; font-size: 14px; font-weight: 700;
                      cursor: pointer; transition: background 0.2s; margin-top: 4px; }
        .btn-submit:hover { background: #0D47A1; }
        .btn-submit.green { background: #2e7d32; }
        .btn-submit.green:hover { background: #1b5e20; }

        .readonly-note { font-size: 11px; color: #aaa; margin-top: 3px; font-style: italic; }

        /* HỢP ĐỒNG */
        .contract-table { width: 100%; border-collapse: collapse; font-size: 13px; }
        .contract-table th { background: #f8f9ff; padding: 9px 12px; text-align: left;
                             font-weight: 600; color: #555; border-bottom: 2px solid #e3eaf5; }
        .contract-table td { padding: 9px 12px; border-bottom: 1px solid #f5f5f5; color: #333; }
        .contract-table tr:last-child td { border-bottom: none; }

        .badge-hieuluc { background: #e8f5e9; color: #2e7d32; padding: 3px 10px;
                         border-radius: 12px; font-size: 11px; font-weight: 700; }
        .badge-hethan  { background: #ffebee; color: #c62828; padding: 3px 10px;
                         border-radius: 12px; font-size: 11px; font-weight: 700; }

        .alert-success { background: #e8f5e9; border: 1px solid #a5d6a7; color: #2e7d32;
                         padding: 11px 16px; border-radius: 6px; margin-bottom: 14px;
                         font-size: 13px; }
        .alert-error { background: #ffebee; border: 1px solid #ef9a9a; color: #c62828;
                       padding: 11px 16px; border-radius: 6px; margin-bottom: 14px;
                       font-size: 13px; }

        .site-footer { background: #1565C0; color: rgba(255,255,255,0.85);
                       text-align: center; padding: 14px; font-size: 13px; margin-top: 10px; }
        .site-footer strong { color: white; }

        /* TABS ĐỔI MẬT KHẨU */
        .tab-btns { display: flex; border-bottom: 2px solid #e3eaf5; margin-bottom: 16px; }
        .tab-btn { padding: 8px 18px; font-size: 13px; font-weight: 600; cursor: pointer;
                   border: none; background: none; color: #888; border-bottom: 2px solid transparent;
                   margin-bottom: -2px; transition: all 0.2s; }
        .tab-btn.active { color: #1565C0; border-bottom-color: #1565C0; }
        .tab-content { display: none; }
        .tab-content.active { display: block; }
    </style>
</head>
<body>

    <!-- HEADER -->
    <div class="header">
        <img src="${pageContext.request.contextPath}/resources/image/logo_ute.png" alt="Logo">
        <div>
            <div class="header-university">Đại học Đà Nẵng</div>
            <div class="header-school">Trường Đại học Sư phạm Kỹ thuật</div>
            <div class="header-system">Hệ thống Quản lý Ký túc xá</div>
        </div>
    </div>

    <!-- NAV -->
    <nav class="main-nav">
        <div class="nav-inner">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/sinhvien/profile" class="active">👤 Sinh viên</a>
            <a href="${pageContext.request.contextPath}/phong/phong-cua-toi">🏠 Phòng</a>
            <a href="${pageContext.request.contextPath}/hopdong/hopdong-cua-toi">📄 Hợp đồng</a>
            <a href="${pageContext.request.contextPath}/baotri/baotri-cua-toi">🔧 Bảo trì</a>
            <a href="${pageContext.request.contextPath}/danhgia/list">⭐ Đánh giá</a>
            <a href="${pageContext.request.contextPath}/thuvien/list">📚 Thư viện</a>
        </div>
    </nav>

    <!-- PAGE HEADER -->
    <div class="page-header">
        <div class="page-header-inner">
            <div class="avatar">👤</div>
            <div>
                <h1>${sinhVien.hoTen}</h1>
                <p>MSSV: ${sinhVien.mssv} &nbsp;|&nbsp; ${sinhVien.lop} &nbsp;|&nbsp; ${sinhVien.khoa}</p>
            </div>
        </div>
    </div>

    <!-- THÔNG BÁO -->
    <div style="max-width:1000px; margin:16px auto 0; padding:0 20px;">
        <c:if test="${not empty success}">
            <div class="alert-success">✅ ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert-error">⚠️ ${error}</div>
        </c:if>
        <c:if test="${not empty successMatKhau}">
            <div class="alert-success">✅ ${successMatKhau}</div>
        </c:if>
        <c:if test="${not empty errorMatKhau}">
            <div class="alert-error">⚠️ ${errorMatKhau}</div>
        </c:if>
    </div>

    <!-- CONTENT -->
    <div class="wrap">

        <!-- THÔNG TIN CÁ NHÂN -->
        <div class="card">
            <div class="card-title">📋 Thông tin cá nhân</div>
            <div class="card-body">
                <div class="info-grid">
                    <div class="info-item">
                        <label>MSSV</label>
                        <div class="value highlight">${sinhVien.mssv}</div>
                    </div>
                    <div class="info-item">
                        <label>Họ và tên</label>
                        <div class="value">${sinhVien.hoTen}</div>
                    </div>
                    <div class="info-item">
                        <label>Ngày sinh</label>
                        <div class="value">
                            <fmt:formatDate value="${sinhVien.ngaySinh}" pattern="dd/MM/yyyy"/>
                        </div>
                    </div>
                    <div class="info-item">
                        <label>Giới tính</label>
                        <div class="value">
                            <span class="badge ${sinhVien.gioiTinh == 'Nam' ? 'badge-nam' : 'badge-nu'}">
                                ${sinhVien.gioiTinh}
                            </span>
                        </div>
                    </div>
                    <div class="info-item">
                        <label>CCCD/CMND</label>
                        <div class="value">${sinhVien.cccd}</div>
                    </div>
                    <div class="info-item">
                        <label>Lớp</label>
                        <div class="value">${sinhVien.lop}</div>
                    </div>
                    <div class="info-item">
                        <label>Khoa</label>
                        <div class="value">${sinhVien.khoa}</div>
                    </div>
                    <div class="info-item">
                        <label>Số điện thoại</label>
                        <div class="value">${sinhVien.sdt}</div>
                    </div>
                    <div class="info-item" style="grid-column: 1/-1;">
                        <label>Email</label>
                        <div class="value">${sinhVien.email}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- CHỈNH SỬA & ĐỔI MẬT KHẨU -->
        <div class="card">
            <div class="card-title">✏️ Cập nhật thông tin & tài khoản cá nhân</div>
            <div class="card-body">

                <!-- TABS -->
                <div class="tab-btns">
                    <button class="tab-btn active" onclick="showTab('tab-edit')">
                        ✏️ Chỉnh sửa thông tin
                    </button>
                    <button class="tab-btn" onclick="showTab('tab-password')">
                        🔒 Đổi mật khẩu
                    </button>
                </div>

                <!-- TAB CHỈNH SỬA -->
                <div id="tab-edit" class="tab-content active">
                    <form action="${pageContext.request.contextPath}/sinhvien/profile/update" method="post">
                        <input type="hidden" name="mssv" value="${sinhVien.mssv}"/>

                        <div class="form-group">
                            <label>MSSV (không thể thay đổi)</label>
                            <input type="text" value="${sinhVien.mssv}" readonly/>
                            <div class="readonly-note">🔒 MSSV không được phép chỉnh sửa</div>
                        </div>

                        <div class="form-group">
                            <label>Họ và tên (không thể thay đổi)</label>
                            <input type="text" value="${sinhVien.hoTen}" readonly/>
                            <div class="readonly-note">🔒 Liên hệ ban quản lý để thay đổi</div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Số điện thoại ✏️</label>
                                <input type="text" name="sdt" value="${sinhVien.sdt}" placeholder="0901234567"/>
                            </div>
                            <div class="form-group">
                                <label>Email ✏️</label>
                                <input type="email" name="email" value="${sinhVien.email}" placeholder="sv@gmail.com"/>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Lớp ✏️</label>
                                <input type="text" name="lop" value="${sinhVien.lop}" placeholder="CNTT-K18"/>
                            </div>
                            <div class="form-group">
                                <label>Khoa ✏️</label>
                                <input type="text" name="khoa" value="${sinhVien.khoa}" placeholder="Công nghệ Thông tin"/>
                            </div>
                        </div>

                        <button type="submit" class="btn-submit">💾 Lưu thay đổi</button>
                    </form>
                </div>

                <!-- TAB ĐỔI MẬT KHẨU -->
                <div id="tab-password" class="tab-content">
                    <form action="${pageContext.request.contextPath}/sinhvien/profile/doimatkhau" method="post">
                        <input type="hidden" name="mssv" value="${sinhVien.mssv}"/>

                        <div class="form-group">
                            <label>Mật khẩu hiện tại *</label>
                            <input type="password" name="matKhauCu" placeholder="Nhập mật khẩu hiện tại" required/>
                        </div>
                        <div class="form-group">
                            <label>Mật khẩu mới *</label>
                            <input type="password" name="matKhauMoi" id="matKhauMoi"
                                   placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)"
                                   minlength="3" required/>
                        </div>
                        <div class="form-group">
                            <label>Xác nhận mật khẩu mới *</label>
                            <input type="password" name="xacNhanMatKhau" id="xacNhanMatKhau"
                                   placeholder="Nhập lại mật khẩu mới" required/>
                        </div>

                        <button type="submit" class="btn-submit green"
                                onclick="return checkPassword()">
                            🔒 Xác nhận đổi mật khẩu
                        </button>
                    </form>
                </div>

            </div>
        </div>
    </div>

    <!-- HỢP ĐỒNG -->
    <div class="wrap-full">
        <div class="card">
            <div class="card-title">📄 Hợp đồng của tôi</div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty hopDongList}">
                        <div style="text-align:center; padding:20px; color:#aaa; font-size:14px;">
                            📭 Bạn chưa có hợp đồng nào
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="contract-table">
                            <tr>
                                <th>Phòng</th>
                                <th>Ngày bắt đầu</th>
                                <th>Ngày kết thúc</th>
                                <th>Trạng thái</th>
                            </tr>
                            <c:forEach var="hd" items="${hopDongList}">
                                <tr>
                                    <td><strong>${hd.tenPhong}</strong></td>
                                    <td><fmt:formatDate value="${hd.ngayBatDau}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${hd.ngayKetThuc}" pattern="dd/MM/yyyy"/></td>
                                    <td>
                                        <span class="${hd.trangThai == 'Hiệu lực' ? 'badge-hieuluc' : 'badge-hethan'}">
                                            ${hd.trangThai}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <div class="site-footer">
        &copy; 2026 &mdash; <strong>Hệ thống Quản lý Ký túc xá</strong>
        &mdash; Trường Đại học Sư phạm Kỹ thuật Đà Nẵng
    </div>

    <script>
        function showTab(tabId) {
            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            event.target.classList.add('active');
        }

        function checkPassword() {
            const mk1 = document.getElementById('matKhauMoi').value;
            const mk2 = document.getElementById('xacNhanMatKhau').value;
            if (mk1 !== mk2) {
                alert('Mật khẩu mới và xác nhận không khớp!');
                return false;
            }
            return true;
        }
    </script>

</body>
</html>