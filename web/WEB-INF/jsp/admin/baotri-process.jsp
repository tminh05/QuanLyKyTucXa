<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xử lý yêu cầu bảo trì - Admin</title>
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
            max-width: 800px;
        }
        .card-header {
            padding: 18px 24px;
            background: #f8f9ff;
            border-bottom: 1px solid #e3eaf5;
        }
        .card-header h2 { font-size: 18px; color: #0D47A1; }
        .form-body { padding: 24px; }
        
        .info-section {
            background: #f8f9ff;
            border-radius: 10px;
            padding: 16px;
            margin-bottom: 24px;
            border: 1px solid #e3eaf5;
        }
        .info-row {
            display: flex;
            padding: 8px 0;
            border-bottom: 1px solid #eef2f6;
        }
        .info-row:last-child { border-bottom: none; }
        .info-label {
            width: 130px;
            font-weight: 600;
            color: #666;
            font-size: 13px;
        }
        .info-value {
            flex: 1;
            color: #333;
            font-size: 13px;
        }
        .info-value strong { color: #1565C0; }
        
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        .status-pending { background: #FFF8E1; color: #f57f17; }
        .status-processing { background: #E3F2FD; color: #1565C0; }
        .status-done { background: #e8f5e9; color: #2e7d32; }
        
        .form-group { margin-bottom: 20px; }
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
        }
        .required { color: #e53935; }
        .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
            font-family: inherit;
        }
        .form-group select:focus, .form-group textarea:focus { border-color: #1565C0; }
        .form-group textarea { resize: vertical; min-height: 100px; }
        
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
            <a href="${pageContext.request.contextPath}/admin/baotri" class="active">🔧 Quản lý Bảo trì</a>
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
            <div class="page-title">🔧 Xử lý yêu cầu bảo trì #${yeuCau.idYeuCau}</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <div class="form-card">
            <div class="card-header">
                <h2>📋 Thông tin yêu cầu</h2>
            </div>
            <div class="form-body">
                <c:if test="${not empty error}">
                    <div class="alert-error">⚠️ ${error}</div>
                </c:if>

                <!-- Thông tin chi tiết -->
                <div class="info-section">
                    <div class="info-row">
                        <div class="info-label">🏠 Phòng:</div>
                        <div class="info-value"><strong>${yeuCau.tenPhong}</strong></div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">👨‍🎓 Sinh viên:</div>
                        <div class="info-value">${yeuCau.mssv} - ${yeuCau.hoTenSinhVien}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">📅 Ngày tạo:</div>
                        <div class="info-value"><fmt:formatDate value="${yeuCau.ngayTao}" pattern="dd/MM/yyyy HH:mm"/></div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">📝 Nội dung:</div>
                        <div class="info-value">${yeuCau.noiDung}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">🔖 Trạng thái hiện tại:</div>
                        <div class="info-value">
                            <span class="status-badge 
                                ${yeuCau.trangThai == 'Chờ xử lý' ? 'status-pending' : 
                                  (yeuCau.trangThai == 'Đang xử lý' ? 'status-processing' : 'status-done')}">
                                ${yeuCau.trangThai}
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Form xử lý -->
                <form action="${pageContext.request.contextPath}/admin/baotri/process" method="post">
                    <input type="hidden" name="idYeuCau" value="${yeuCau.idYeuCau}">
                    <input type="hidden" name="idPhong" value="${yeuCau.idPhong}">
                    <input type="hidden" name="mssv" value="${yeuCau.mssv}">

                    <div class="form-row">
                        <div class="form-group">
                            <label>Nhân viên xử lý</label>
                            <select name="idNhanVien">
                                <option value="">-- Chọn nhân viên --</option>
                                <c:forEach var="nv" items="${nhanVienList}">
                                    <option value="${nv.idNhanVien}" ${yeuCau.idNhanVien == nv.idNhanVien ? 'selected' : ''}>
                                        ${nv.hoTen} (${nv.chucVu})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Cập nhật trạng thái <span class="required">*</span></label>
                            <select name="trangThai" required>
                                <option value="Chờ xử lý" ${yeuCau.trangThai == 'Chờ xử lý' ? 'selected' : ''}>⏳ Chờ xử lý</option>
                                <option value="Đang xử lý" ${yeuCau.trangThai == 'Đang xử lý' ? 'selected' : ''}>🔧 Đang xử lý</option>
                                <option value="Hoàn thành" ${yeuCau.trangThai == 'Hoàn thành' ? 'selected' : ''}>✅ Hoàn thành</option>
                                <option value="Đã hủy" ${yeuCau.trangThai == 'Đã hủy' ? 'selected' : ''}>❌ Đã hủy</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Ghi chú / Cập nhật nội dung</label>
                        <textarea name="noiDung" placeholder="Thêm ghi chú hoặc cập nhật thông tin xử lý...">${yeuCau.noiDung}</textarea>
                    </div>

                    <div class="form-buttons">
                        <button type="submit" class="btn-submit">💾 Lưu cập nhật</button>
                        <a href="${pageContext.request.contextPath}/admin/baotri" class="btn-cancel">❌ Hủy bỏ</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>