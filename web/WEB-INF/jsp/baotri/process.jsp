<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xử lý bảo trì - Admin</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }

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

        .page-header { background: linear-gradient(135deg, #1565C0, #0D47A1); color: white; padding: 30px 0; }
        .page-header-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
        .page-header h1 { font-size: 28px; font-weight: 800; margin-bottom: 8px; }
        .page-header p { font-size: 14px; opacity: 0.9; }

        .container { max-width: 900px; margin: 30px auto; padding: 0 20px; }

        .form-card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); overflow: hidden; }
        .form-header { padding: 24px 28px; background: #f8f9ff; border-bottom: 1px solid #e3eaf5; }
        .form-header h2 { font-size: 20px; color: #0D47A1; display: flex; align-items: center; gap: 10px; }
        .form-body { padding: 28px; }

        .info-card { background: #f8f9ff; border-radius: 12px; padding: 20px; margin-bottom: 28px; }
        .info-row { display: flex; padding: 10px 0; border-bottom: 1px solid #e3eaf5; }
        .info-row:last-child { border-bottom: none; }
        .info-label { width: 130px; font-weight: 600; color: #666; }
        .info-value { flex: 1; color: #333; }
        .info-value strong { color: #1565C0; }

        .status { padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; display: inline-block; }
        .status-pending { background: #FFF8E1; color: #f57f17; }
        .status-processing { background: #E3F2FD; color: #1565C0; }
        .status-done { background: #e8f5e9; color: #2e7d32; }

        .form-group { margin-bottom: 24px; }
        .form-group label { display: block; font-size: 14px; font-weight: 600; color: #333; margin-bottom: 8px; }
        .required { color: #e53935; }
        .form-group select, .form-group textarea { width: 100%; padding: 12px 16px; border: 1.5px solid #ddd;
                    border-radius: 10px; font-size: 14px; font-family: inherit; transition: border-color 0.2s; }
        .form-group select:focus, .form-group textarea:focus { outline: none; border-color: #1565C0; }
        .form-group textarea { resize: vertical; min-height: 120px; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }

        .form-buttons { display: flex; gap: 16px; margin-top: 28px; }
        .btn-submit { flex: 1; background: #1565C0; color: white; padding: 14px; border: none; border-radius: 10px;
                      font-size: 16px; font-weight: 700; cursor: pointer; transition: background 0.2s; }
        .btn-submit:hover { background: #0D47A1; }
        .btn-cancel { flex: 1; background: #f0f4f8; color: #333; padding: 14px; border: none; border-radius: 10px;
                      font-size: 16px; font-weight: 600; text-align: center; text-decoration: none; transition: background 0.2s; }
        .btn-cancel:hover { background: #e0e8f0; }

        .alert { padding: 14px 20px; border-radius: 10px; margin-bottom: 24px; display: flex; align-items: center; gap: 10px; }
        .alert-success { background: #e8f5e9; border-left: 4px solid #2e7d32; color: #2e7d32; }
        .alert-error { background: #ffebee; border-left: 4px solid #c62828; color: #c62828; }

        .footer { background: #1565C0; color: rgba(255,255,255,0.85); text-align: center; padding: 20px;
                  font-size: 13px; margin-top: 40px; }
        .footer strong { color: white; }
    </style>
</head>
<body>

    <div class="header">
        <img src="${pageContext.request.contextPath}/resources/image/logo_ute.png" alt="Logo">
        <div>
            <div class="header-university">Đại học Đà Nẵng</div>
            <div class="header-school">Trường Đại học Sư phạm Kỹ thuật</div>
            <div class="header-system">Hệ thống Quản lý Ký túc xá</div>
        </div>
    </div>

    <nav class="main-nav">
        <div class="nav-inner">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/sinhvien/list">👨‍🎓 Sinh viên</a>
            <a href="${pageContext.request.contextPath}/phong/list">🏢 Phòng</a>
            <a href="${pageContext.request.contextPath}/hopdong/list">📄 Hợp đồng</a>
            <a href="${pageContext.request.contextPath}/baotri/list" class="active">🔧 Bảo trì</a>
            <a href="${pageContext.request.contextPath}/danhgia/list">⭐ Đánh giá</a>
            <a href="${pageContext.request.contextPath}/thuvien/list">📚 Thư viện</a>
        </div>
    </nav>

    <div class="page-header">
        <div class="page-header-inner">
            <h1>✏️ Xử lý yêu cầu bảo trì</h1>
            <p>Cập nhật trạng thái và phân công nhân viên</p>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty error}">
            <div class="alert alert-error">⚠️ ${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">✅ ${success}</div>
        </c:if>

        <div class="form-card">
            <div class="form-header">
                <h2>🔧 Thông tin yêu cầu #${yeuCau.idYeuCau}</h2>
            </div>
            <div class="form-body">
                <div class="info-card">
                    <div class="info-row">
                        <div class="info-label">🏠 Phòng:</div>
                        <div class="info-value"><strong>${yeuCau.tenPhong}</strong></div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">👤 Sinh viên:</div>
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
                            <c:choose>
                                <c:when test="${yeuCau.trangThai == 'Chờ xử lý'}">
                                    <span class="status status-pending">⏳ Chờ xử lý</span>
                                </c:when>
                                <c:when test="${yeuCau.trangThai == 'Đang xử lý'}">
                                    <span class="status status-processing">🔧 Đang xử lý</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status status-done">✅ ${yeuCau.trangThai}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <form:form action="${pageContext.request.contextPath}/baotri/process" method="post" modelAttribute="yeuCau">
                    <form:hidden path="idYeuCau"/>
                    <form:hidden path="idPhong"/>
                    <form:hidden path="mssv"/>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Nhân viên xử lý</label>
                            <form:select path="idNhanVien">
                                <form:option value="">-- Chọn nhân viên --</form:option>
                                <c:forEach items="${nhanVienList}" var="nv">
                                    <form:option value="${nv.idNhanVien}">${nv.hoTen} (${nv.chucVu})</form:option>
                                </c:forEach>
                            </form:select>
                        </div>

                        <div class="form-group">
                            <label>Cập nhật trạng thái <span class="required">*</span></label>
                            <form:select path="trangThai" required="required">
                                <form:option value="Chờ xử lý">⏳ Chờ xử lý</form:option>
                                <form:option value="Đang xử lý">🔧 Đang xử lý</form:option>
                                <form:option value="Hoàn thành">✅ Hoàn thành</form:option>
                                <form:option value="Đã hủy">❌ Đã hủy</form:option>
                            </form:select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Ghi chú / Cập nhật nội dung</label>
                        <form:textarea path="noiDung" rows="4" placeholder="Thêm ghi chú hoặc cập nhật thông tin xử lý..."/>
                    </div>

                    <div class="form-buttons">
                        <button type="submit" class="btn-submit">💾 Lưu cập nhật</button>
                        <a href="${pageContext.request.contextPath}/baotri/list" class="btn-cancel">❌ Hủy bỏ</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>

    <div class="footer">
        &copy; 2026 — <strong>Hệ thống Quản lý Ký túc xá</strong> — Trường Đại học Sư phạm Kỹ thuật Đà Nẵng
    </div>
</body>
</html>