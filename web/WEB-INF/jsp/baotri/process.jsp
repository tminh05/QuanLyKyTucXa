<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xử lý yêu cầu bảo trì</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🔧 Quản lý Bảo trì</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/baotri/list">Danh sách yêu cầu</a></li>
                    <li><a href="${pageContext.request.contextPath}/baotri/add">Tạo yêu cầu mới</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <h2>Xử lý yêu cầu bảo trì #${yeuCau.idYeuCau}</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <%-- Thông tin yêu cầu (chỉ đọc) --%>
            <div class="info-box">
                <table class="info-table">
                    <tr>
                        <th>Phòng:</th>
                        <td>${yeuCau.tenPhong}</td>
                        <th>Sinh viên:</th>
                        <td>${yeuCau.mssv} - ${yeuCau.hoTenSinhVien}</td>
                    </tr>
                    <tr>
                        <th>Ngày tạo:</th>
                        <td><fmt:formatDate value="${yeuCau.ngayTao}" pattern="dd/MM/yyyy"/></td>
                        <th>Trạng thái hiện tại:</th>
                        <td>
                            <c:choose>
                                <c:when test="${yeuCau.trangThai == 'Chờ xử lý'}">
                                    <span class="status-pending">${yeuCau.trangThai}</span>
                                </c:when>
                                <c:when test="${yeuCau.trangThai == 'Đang xử lý'}">
                                    <span class="status-processing">${yeuCau.trangThai}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-done">${yeuCau.trangThai}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>Nội dung:</th>
                        <td colspan="3">${yeuCau.noiDung}</td>
                    </tr>
                </table>
            </div>

            <%-- Form xử lý --%>
            <form:form action="${pageContext.request.contextPath}/baotri/process"
                       method="post" modelAttribute="yeuCau" class="form">

                <%-- Hidden field giữ lại ID --%>
                <form:hidden path="idYeuCau"/>
                <form:hidden path="idPhong"/>
                <form:hidden path="mssv"/>

                <div class="form-row">
                    <div class="form-group">
                        <label>Nhân viên xử lý</label>
                        <form:select path="idNhanVien">
                            <form:option value="">-- Chọn nhân viên --</form:option>
                            <c:forEach items="${nhanVienList}" var="nv">
                                <form:option value="${nv.idNhanVien}">${nv.hoTen}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>

                    <div class="form-group">
                        <label>Cập nhật trạng thái <span class="required">*</span></label>
                        <form:select path="trangThai" required="required">
                            <form:option value="Chờ xử lý">Chờ xử lý</form:option>
                            <form:option value="Đang xử lý">Đang xử lý</form:option>
                            <form:option value="Hoàn thành">Hoàn thành</form:option>
                            <form:option value="Đã hủy">Đã hủy</form:option>
                        </form:select>
                    </div>
                </div>

                <div class="form-group">
                    <label>Ghi chú / Cập nhật nội dung</label>
                    <form:textarea path="noiDung" rows="4"/>
                </div>

                <div class="form-buttons">
                    <button type="submit" class="btn-submit">💾 Lưu cập nhật</button>
                    <a href="${pageContext.request.contextPath}/baotri/list" class="btn-cancel">❌ Hủy bỏ</a>
                </div>

            </form:form>
        </main>

        <footer>
            <p>© 2026 - Hệm thống Quản lý Ký túc xá</p>
        </footer>
    </div>
</body>
</html>