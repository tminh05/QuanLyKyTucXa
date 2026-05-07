<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tạo yêu cầu bảo trì</title>
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
            <h2>Tạo yêu cầu bảo trì mới</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form:form action="${pageContext.request.contextPath}/baotri/add"
                       method="post" modelAttribute="yeuCau" class="form">

                <div class="form-row">
                    <div class="form-group">
                        <label>Phòng <span class="required">*</span></label>
                        <form:select path="idPhong" required="required">
                            <%-- idPhong là int nên dùng value="0" --%>
                            <form:option value="0">-- Chọn phòng --</form:option>
                            <c:forEach items="${phongList}" var="p">
                                <form:option value="${p.idPhong}">${p.tenPhong}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>

                    <div class="form-group">
                        <label>Sinh viên (MSSV) <span class="required">*</span></label>
                        <form:select path="mssv" required="required">
                            <form:option value="">-- Chọn sinh viên --</form:option>
                            <c:forEach items="${sinhVienList}" var="sv">
                                <form:option value="${sv.mssv}">${sv.mssv} - ${sv.hoTen}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>

                <div class="form-group">
                    <label>Nội dung yêu cầu <span class="required">*</span></label>
                    <form:textarea path="noiDung" rows="4" 
                                   placeholder="Mô tả chi tiết vấn đề cần bảo trì..."
                                   required="required"/>
                </div>

                <div class="form-buttons">
                    <button type="submit" class="btn-submit">💾 Gửi yêu cầu</button>
                    <a href="${pageContext.request.contextPath}/baotri/list" class="btn-cancel">❌ Hủy bỏ</a>
                </div>

            </form:form>
        </main>

        <footer>
            <p>© 2026 - Hệ thống Quản lý Ký túc xá</p>
        </footer>
    </div>
</body>
</html>