<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa bài viết - Admin</title>
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
            max-width: 900px;
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
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
            font-family: inherit;
        }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { border-color: #1565C0; }
        .form-group textarea { resize: vertical; }
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
        
        .category-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .badge-tintuc { background: #E3F2FD; color: #1565C0; }
        .badge-thongbao { background: #FFF8E1; color: #f57f17; }
        .badge-noiquy { background: #e8f5e9; color: #2e7d32; }
        
        .meta-info {
            background: #f8f9ff;
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 20px;
            display: flex;
            gap: 20px;
            font-size: 13px;
        }
        .meta-info span { color: #666; }
        .meta-info strong { color: #1565C0; }
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
            <a href="${pageContext.request.contextPath}/admin/baiviet" class="active">📰 Quản lý Bài viết</a>
            <a href="${pageContext.request.contextPath}/admin/thongke">📈 Thống kê</a>
        </div>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/admin/logout">🔓 Đăng xuất</a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div class="page-title">✏️ Sửa bài viết</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <div class="form-card">
            <div class="card-header">
                <h2>📝 Cập nhật bài viết</h2>
            </div>
            <div class="form-body">
                <c:if test="${not empty error}">
                    <div class="alert-error">⚠️ ${error}</div>
                </c:if>

               <div class="meta-info">
    <span>📅 Ngày đăng: <strong>${baiViet.ngayDang}</strong></span>
    <span>👁️ Lượt xem: <strong>${baiViet.luotXem}</strong></span>
</div>

                <form action="${pageContext.request.contextPath}/admin/baiviet/edit" method="post">
                    <input type="hidden" name="idBaiViet" value="${baiViet.idBaiViet}">

                    <div class="form-row">
                        <div class="form-group">
                            <label>Tiêu đề <span class="required">*</span></label>
                            <input type="text" name="tieuDe" value="${baiViet.tieuDe}" required>
                        </div>
                        <div class="form-group">
                            <label>Loại bài viết</label>
                            <div>
                                <c:choose>
                                    <c:when test="${baiViet.loaiBaiViet == 'tin-tuc'}">
                                        <span class="category-badge badge-tintuc">📰 Tin tức & Sự kiện</span>
                                    </c:when>
                                    <c:when test="${baiViet.loaiBaiViet == 'thong-bao'}">
                                        <span class="category-badge badge-thongbao">🔔 Thông báo</span>
                                    </c:when>
                                    <c:when test="${baiViet.loaiBaiViet == 'noi-quy'}">
                                        <span class="category-badge badge-noiquy">📋 Nội quy & Quy định</span>
                                    </c:when>
                                </c:choose>
                                <input type="hidden" name="loaiBaiViet" value="${baiViet.loaiBaiViet}">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Tóm tắt</label>
                        <textarea name="tomTat" rows="3">${baiViet.tomTat}</textarea>
                        <div class="info-text">Tóm tắt ngắn gọn nội dung, hiển thị ở trang danh sách</div>
                    </div>

                    <div class="form-group">
                        <label>Nội dung <span class="required">*</span></label>
                        <textarea name="noiDung" rows="12" required>${baiViet.noiDung}</textarea>
                        <div class="info-text">Hỗ trợ HTML: p, h1-h6, strong, em, mark, ul, li, a</div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Ảnh đại diện</label>
                            <input type="text" name="anhDaiDien" value="${baiViet.anhDaiDien}" placeholder="Tên file ảnh (VD: anh-bai-viet.jpg)">
                            <div class="info-text">Đặt ảnh trong thư mục /resources/image/</div>
                        </div>
                        <div class="form-group">
                            <label>Ngày đăng</label>
                            <input type="text" value="${baiViet.ngayDang}" readonly>
                        </div>
                    </div>

                    <div class="form-buttons">
                        <button type="submit" class="btn-submit">💾 Lưu cập nhật</button>
                        <a href="${pageContext.request.contextPath}/admin/baiviet" class="btn-cancel">❌ Hủy bỏ</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>