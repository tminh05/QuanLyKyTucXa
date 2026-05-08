<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Bảo trì - KTX UTE</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }

        /* HEADER */
        .header { background: white; border-bottom: 3px solid #1565C0; padding: 12px 30px;
                  display: flex; align-items: center; gap: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .header img { height: 65px; }
        .header-university { font-size: 13px; color: #1565C0; font-weight: 600; text-transform: uppercase; }
        .header-school { font-size: 20px; font-weight: 800; color: #1565C0; text-transform: uppercase; }
        .header-system { font-size: 15px; font-weight: 700; color: #e53935; text-transform: uppercase; }

        /* NAV */
        .main-nav { background: #1976D2; }
        .nav-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; }
        .main-nav a { color: white; text-decoration: none; padding: 12px 22px; font-size: 15px;
                      font-weight: 500; display: block; transition: background 0.2s;
                      border-right: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:first-child { border-left: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:hover, .main-nav a.active { background: #0D47A1; }

        /* PAGE HEADER */
        .page-header { background: linear-gradient(135deg, #1565C0, #0D47A1); color: white; padding: 30px 0; }
        .page-header-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
        .page-header h1 { font-size: 28px; font-weight: 800; margin-bottom: 8px; }
        .page-header p { font-size: 14px; opacity: 0.9; }

        /* CONTAINER */
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }

        /* ALERT */
        .alert { padding: 14px 20px; border-radius: 10px; margin-bottom: 24px; display: flex; align-items: center; gap: 10px; }
        .alert-success { background: #e8f5e9; border-left: 4px solid #2e7d32; color: #2e7d32; }
        .alert-error { background: #ffebee; border-left: 4px solid #c62828; color: #c62828; }

        /* STUDENT HEADER */
        .student-header { background: white; border-radius: 12px; padding: 20px 24px; margin-bottom: 24px;
                          box-shadow: 0 2px 10px rgba(0,0,0,0.05); display: flex; justify-content: space-between;
                          align-items: center; flex-wrap: wrap; gap: 15px; }
        .student-info h3 { font-size: 18px; color: #0D47A1; margin-bottom: 5px; }
        .student-info p { font-size: 13px; color: #666; }
        .student-badge { background: #E3F2FD; color: #1565C0; padding: 8px 16px; border-radius: 30px; font-size: 13px; font-weight: 600; }

        /* STATS */
        .stats { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 20px; border-radius: 12px; text-align: center;
                     box-shadow: 0 2px 10px rgba(0,0,0,0.05); transition: transform 0.2s; }
        .stat-card:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0,0,0,0.1); }
        .stat-number { font-size: 32px; font-weight: 800; color: #1565C0; }
        .stat-label { font-size: 13px; color: #888; margin-top: 8px; }

        /* TABLE CARD */
        .table-card { background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); overflow: hidden; }
        .table-header { padding: 18px 24px; background: #f8f9ff; border-bottom: 1px solid #e3eaf5; display: flex;
                        justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px; }
        .table-header h2 { font-size: 18px; color: #0D47A1; display: flex; align-items: center; gap: 8px; }
        .btn-add { background: #1565C0; color: white; padding: 8px 20px; border-radius: 8px; text-decoration: none;
                   font-size: 14px; font-weight: 600; transition: background 0.2s; display: inline-flex; align-items: center; gap: 8px; }
        .btn-add:hover { background: #0D47A1; }

        table { width: 100%; border-collapse: collapse; }
        th { background: #f8f9ff; padding: 14px 16px; text-align: left; font-size: 13px; font-weight: 600;
             color: #555; border-bottom: 1px solid #e3eaf5; }
        td { padding: 14px 16px; font-size: 13px; color: #333; border-bottom: 1px solid #f0f0f0; }
        tr:hover { background: #f8f9ff; }

        .status { padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; display: inline-block; }
        .status-pending { background: #FFF8E1; color: #f57f17; }
        .status-processing { background: #E3F2FD; color: #1565C0; }
        .status-done { background: #e8f5e9; color: #2e7d32; }
        .status-cancelled { background: #f5f5f5; color: #888; }

        .btn-cancel { background: #e53935; color: white; padding: 6px 14px; border-radius: 6px; text-decoration: none;
                      font-size: 12px; font-weight: 600; display: inline-block; transition: background 0.2s; }
        .btn-cancel:hover { background: #c62828; }
        .btn-edit { background: #FFC107; color: #333; padding: 6px 14px; border-radius: 6px; text-decoration: none;
                    font-size: 12px; font-weight: 600; display: inline-block; margin-right: 8px; }
        .btn-delete { background: #e53935; color: white; padding: 6px 14px; border-radius: 6px; text-decoration: none;
                      font-size: 12px; font-weight: 600; display: inline-block; }
        .btn-edit:hover { background: #FFB300; }
        .btn-delete:hover { background: #c62828; }

        .empty-row td { text-align: center; padding: 50px; color: #999; }

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
            <h1>🔧 Quản lý bảo trì</h1>
            <p>Gửi yêu cầu sửa chữa và theo dõi trạng thái xử lý</p>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <span>✅</span> ${success}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <span>⚠️</span> ${error}
            </div>
        </c:if>

        <!-- Student Info & Stats -->
        <c:if test="${isStudent}">
            <div class="student-header">
                <div class="student-info">
                    <h3>👤 ${sinhVien.hoTen}</h3>
                    <p>MSSV: ${sinhVien.mssv} | Lớp: ${sinhVien.lop} | Khoa: ${sinhVien.khoa}</p>
                </div>
                <div class="student-badge">🎓 Sinh viên</div>
            </div>

            <div class="stats">
                <div class="stat-card">
                    <div class="stat-number">${yeuCauList.size()}</div>
                    <div class="stat-label">Tổng yêu cầu</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">
                        <c:set var="countCho" value="0"/>
                        <c:forEach items="${yeuCauList}" var="yc">
                            <c:if test="${yc.trangThai == 'Chờ xử lý'}"><c:set var="countCho" value="${countCho + 1}"/></c:if>
                        </c:forEach>
                        ${countCho}
                    </div>
                    <div class="stat-label">Chờ xử lý</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">
                        <c:set var="countDang" value="0"/>
                        <c:forEach items="${yeuCauList}" var="yc">
                            <c:if test="${yc.trangThai == 'Đang xử lý'}"><c:set var="countDang" value="${countDang + 1}"/></c:if>
                        </c:forEach>
                        ${countDang}
                    </div>
                    <div class="stat-label">Đang xử lý</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">
                        <c:set var="countXong" value="0"/>
                        <c:forEach items="${yeuCauList}" var="yc">
                            <c:if test="${yc.trangThai == 'Hoàn thành'}"><c:set var="countXong" value="${countXong + 1}"/></c:if>
                        </c:forEach>
                        ${countXong}
                    </div>
                    <div class="stat-label">Hoàn thành</div>
                </div>
            </div>
        </c:if>

        <!-- Table -->
        <div class="table-card">
            <div class="table-header">
                <h2>📋 Danh sách yêu cầu</h2>
                <a href="${pageContext.request.contextPath}/baotri/add" class="btn-add">➕ Tạo yêu cầu mới</a>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Phòng</th>
                        <c:if test="${not isStudent}">
                            <th>MSSV</th>
                            <th>Sinh viên</th>
                        </c:if>
                        <th>Nội dung</th>
                        <th>Ngày tạo</th>
                        <th>Cập nhật</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty yeuCauList}">
                            <tr class="empty-row">
                                <td colspan="${isStudent ? 8 : 10}">
                                    <div style="text-align:center; padding: 20px;">
                                        <span style="font-size: 48px;">🔧</span>
                                        <p style="margin-top: 10px;">Chưa có yêu cầu bảo trì nào</p>
                                        <a href="${pageContext.request.contextPath}/baotri/add" style="color:#1565C0; margin-top: 10px; display: inline-block;">➕ Tạo yêu cầu ngay</a>
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${yeuCauList}" var="yc">
                                <tr>
                                    <td>#${yc.idYeuCau}</td>
                                    <td>🏠 ${yc.tenPhong}</td>
                                    <c:if test="${not isStudent}">
                                        <td>${yc.mssv}</td>
                                        <td>${yc.hoTenSinhVien}</td>
                                    </c:if>
                                    <td style="max-width: 300px;">${yc.noiDung}</td>
                                    <td><fmt:formatDate value="${yc.ngayTao}" pattern="dd/MM/yyyy"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty yc.ngayCapNhat}">
                                                <fmt:formatDate value="${yc.ngayCapNhat}" pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>--</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${yc.trangThai == 'Chờ xử lý'}">
                                                <span class="status status-pending">⏳ Chờ xử lý</span>
                                            </c:when>
                                            <c:when test="${yc.trangThai == 'Đang xử lý'}">
                                                <span class="status status-processing">🔧 Đang xử lý</span>
                                            </c:when>
                                            <c:when test="${yc.trangThai == 'Hoàn thành'}">
                                                <span class="status status-done">✅ Hoàn thành</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status status-cancelled">❌ ${yc.trangThai}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${isStudent}">
                                                <c:if test="${yc.trangThai == 'Chờ xử lý'}">
                                                    <a href="${pageContext.request.contextPath}/baotri/cancel/${yc.idYeuCau}"
                                                       class="btn-cancel"
                                                       onclick="return confirm('Hủy yêu cầu này?')">❌ Hủy</a>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/baotri/process/${yc.idYeuCau}" class="btn-edit">✏️ Xử lý</a>
                                                <a href="${pageContext.request.contextPath}/baotri/delete/${yc.idYeuCau}"
                                                   onclick="return confirm('Xóa yêu cầu này?')"
                                                   class="btn-delete">🗑️ Xóa</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <div class="footer">
        &copy; 2026 — <strong>Hệ thống Quản lý Ký túc xá</strong> — Trường Đại học Sư phạm Kỹ thuật Đà Nẵng
    </div>
</body>
</html>