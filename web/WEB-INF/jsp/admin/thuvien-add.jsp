<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm sách - Admin</title>
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
        
        .icon-preview {
            display: inline-block;
            padding: 8px 15px;
            background: #f0f4f8;
            border-radius: 8px;
            font-size: 28px;
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
            <div class="page-title">➕ Thêm sách mới</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <div class="form-card">
            <div class="card-header">
                <h2>📚 Thông tin sách</h2>
            </div>
            <div class="form-body">
                <c:if test="${not empty error}">
                    <div class="alert-error">⚠️ ${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/thuvien/add" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Tên sách <span class="required">*</span></label>
                            <input type="text" name="tenSach" placeholder="VD: Nhà giả kim" required>
                        </div>
                        <div class="form-group">
                            <label>Tác giả</label>
                            <input type="text" name="tacGia" placeholder="VD: Paulo Coelho">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Thể loại <span class="required">*</span></label>
                            <select name="theLoai" required>
                                <option value="">-- Chọn thể loại --</option>
                                <option value="Lịch sử - Văn hóa">🏛️ Lịch sử - Văn hóa</option>
                                <option value="Triết lý kinh doanh">💼 Triết lý kinh doanh</option>
                                <option value="Bước chân vào đời">👟 Bước chân vào đời</option>
                                <option value="Chia sẻ - Cộng hưởng">🤝 Chia sẻ - Cộng hưởng</option>
                                <option value="Thực tập sinh">🎓 Thực tập sinh</option>
                                <option value="Khoa học - Kỹ thuật - AI">🤖 Khoa học - Kỹ thuật - AI</option>
                                <option value="Khoa học - Kỹ thuật">🔬 Khoa học - Kỹ thuật</option>
                                <option value="Âm nhạc">🎵 Âm nhạc</option>
                                <option value="Phim truyện">🎬 Phim truyện</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Năm xuất bản</label>
                            <input type="number" name="namXuatBan" placeholder="VD: 2020" min="1900" max="2026">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Mô tả ngắn</label>
                        <textarea name="moTa" rows="3" placeholder="Mô tả nội dung chính của cuốn sách..."></textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Số lượng <span class="required">*</span></label>
                            <input type="number" name="soLuong" id="soLuong" value="1" min="1" max="100" required>
                            <div class="info-text">Tổng số lượng sách nhập vào thư viện</div>
                        </div>
                        <div class="form-group">
                            <label>Ảnh bìa (tên file)</label>
                            <input type="text" name="anhBia" placeholder="VD: sach-nha-gia-kim.jpg">
                            <div class="info-text">Đặt ảnh trong thư mục /resources/image/sach/</div>
                        </div>
                    </div>

                    <div class="icon-preview">
                        📖 Sách sẽ hiển thị với icon theo thể loại
                    </div>

                    <div class="form-buttons">
                        <button type="submit" class="btn-submit">💾 Thêm sách</button>
                        <a href="${pageContext.request.contextPath}/admin/thuvien" class="btn-cancel">❌ Hủy bỏ</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        document.getElementById('soLuong').addEventListener('change', function() {
            if(this.value < 1) this.value = 1;
            if(this.value > 100) this.value = 100;
        });
    </script>
</body>
</html>