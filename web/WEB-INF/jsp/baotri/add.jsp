<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gửi yêu cầu bảo trì - KTX UTE</title>
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

        .container { max-width: 800px; margin: 30px auto; padding: 0 20px; }

        .form-card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); overflow: hidden; }
        .form-header { padding: 24px 28px; background: #f8f9ff; border-bottom: 1px solid #e3eaf5; }
        .form-header h2 { font-size: 20px; color: #0D47A1; display: flex; align-items: center; gap: 10px; }
        .form-body { padding: 28px; }

        .form-group { margin-bottom: 24px; }
        .form-group label { display: block; font-size: 14px; font-weight: 600; color: #333; margin-bottom: 8px; }
        .required { color: #e53935; }
        .form-group select, .form-group textarea { width: 100%; padding: 12px 16px; border: 1.5px solid #ddd;
                    border-radius: 10px; font-size: 14px; font-family: inherit; transition: border-color 0.2s; }
        .form-group select:focus, .form-group textarea:focus { outline: none; border-color: #1565C0; }
        .form-group textarea { resize: vertical; min-height: 140px; }

        .room-info { background: #E3F2FD; padding: 16px 20px; border-radius: 12px; margin-bottom: 24px;
                     border-left: 4px solid #1565C0; display: flex; align-items: center; gap: 12px; }
        .room-info-icon { font-size: 28px; }
        .room-info-text { font-size: 15px; color: #333; }
        .room-info-text strong { color: #1565C0; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 24px; }
        .form-row .form-group { margin-bottom: 0; }

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
        .alert-warning { background: #FFF8E1; border-left: 4px solid #f57f17; color: #f57f17; }

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
            <c:choose>
                <c:when test="${isStudent}">
                    <a href="${pageContext.request.contextPath}/sinhvien/profile">👤 Sinh viên</a>
                    <a href="${pageContext.request.contextPath}/phong/phong-cua-toi">🏠 Phòng</a>
                    <a href="${pageContext.request.contextPath}/hopdong/hopdong-cua-toi">📄 Hợp đồng</a>
                    <a href="${pageContext.request.contextPath}/baotri/list" class="active">🔧 Bảo trì</a>
                    <a href="${pageContext.request.contextPath}/danhgia/list">⭐ Đánh giá</a>
                    <a href="${pageContext.request.contextPath}/thuvien/list">📚 Thư viện</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/sinhvien/list">👨‍🎓 Sinh viên</a>
                    <a href="${pageContext.request.contextPath}/phong/list">🏢 Phòng</a>
                    <a href="${pageContext.request.contextPath}/hopdong/list">📄 Hợp đồng</a>
                    <a href="${pageContext.request.contextPath}/baotri/list" class="active">🔧 Bảo trì</a>
                    <a href="${pageContext.request.contextPath}/danhgia/list">⭐ Đánh giá</a>
                    <a href="${pageContext.request.contextPath}/thuvien/list">📚 Thư viện</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <div class="page-header">
        <div class="page-header-inner">
            <h1>📝 Gửi yêu cầu bảo trì</h1>
            <p>Vui lòng mô tả chi tiết vấn đề để được hỗ trợ nhanh nhất</p>
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
                <h2>🔧 Thông tin yêu cầu</h2>
            </div>
            <div class="form-body">
                <c:if test="${isStudent and empty autoPhongId}">
                    <div class="alert alert-warning">
                        ⚠️ Bạn chưa có phòng ở hoặc chưa có hợp đồng hiệu lực.<br>
                        Vui lòng liên hệ ban quản lý KTX để được hỗ trợ.
                    </div>
                </c:if>

                <form:form action="${pageContext.request.contextPath}/baotri/add" method="post" modelAttribute="yeuCau">

                    <c:if test="${isStudent}">
                        <c:if test="${not empty autoPhongId}">
                            <div class="room-info">
                                <div class="room-info-icon">📍</div>
                                <div class="room-info-text">Phòng hiện tại: <strong>${autoTenPhong}</strong></div>
                            </div>
                            <input type="hidden" name="idPhong" value="${autoPhongId}">
                        </c:if>
                    </c:if>

                    <c:if test="${not isStudent}">
                        <div class="form-row">
                            <div class="form-group">
                                <label>Phòng <span class="required">*</span></label>
                                <form:select path="idPhong" required="required">
                                    <form:option value="0">-- Chọn phòng --</form:option>
                                    <c:forEach items="${phongList}" var="p">
                                        <form:option value="${p.idPhong}">${p.tenPhong}</form:option>
                                    </c:forEach>
                                </form:select>
                            </div>
                            <div class="form-group">
                                <label>Sinh viên <span class="required">*</span></label>
                                <form:select path="mssv" required="required">
                                    <form:option value="">-- Chọn sinh viên --</form:option>
                                    <c:forEach items="${sinhVienList}" var="sv">
                                        <form:option value="${sv.mssv}">${sv.mssv} - ${sv.hoTen}</form:option>
                                    </c:forEach>
                                </form:select>
                            </div>
                        </div>
                    </c:if>

                    <div class="form-group">
                        <label>Nội dung yêu cầu <span class="required">*</span></label>
                        <form:textarea path="noiDung" rows="5" 
                            placeholder="Mô tả chi tiết vấn đề cần sửa chữa (ví dụ: đèn hỏng, vòi nước rỉ, điều hòa không mát, ổ cắm điện cháy...)"
                            required="required"/>
                        <div style="font-size: 12px; color: #888; margin-top: 6px;">
                            💡 Mô tả càng chi tiết, nhân viên kỹ thuật sẽ xử lý nhanh hơn
                        </div>
                    </div>

                    <div class="form-buttons">
                        <button type="submit" class="btn-submit">📤 Gửi yêu cầu</button>
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