<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Hợp đồng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📄 Sửa Hợp đồng</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/hopdong/list">Danh sách</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <div class="form">
                <h2>Thông tin Hợp đồng</h2>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">${error}</div>
                </c:if>

                <form:form action="${pageContext.request.contextPath}/hopdong/edit" 
                           method="post" modelAttribute="hopDong" class="form">
                    
                    <form:hidden path="idHopDong"/>

                    <div class="form-row">
                        <div class="form-group">
                            <label>MSSV</label>
                            <form:input path="mssv" readonly="true" class="readonly"/>
                        </div>
                        <div class="form-group">
                            <label>Phòng</label>
                            <form:input path="tenPhong" readonly="true" class="readonly"/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Ngày bắt đầu</label>
                            <form:input path="ngayBatDau" type="date"/>
                        </div>
                        <div class="form-group">
                            <label>Ngày kết thúc</label>
                            <form:input path="ngayKetThuc" type="date"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Trạng thái</label>
                        <form:select path="trangThai">
                            <form:option value="Hiệu lực">Hiệu lực</form:option>
                            <form:option value="Hết hạn">Hết hạn</form:option>
                            <form:option value="Đã hủy">Đã hủy</form:option>
                        </form:select>
                    </div>

                    <div class="form-buttons">
                        <button type="submit" class="btn-submit">💾 Lưu lại</button>
                        <a href="${pageContext.request.contextPath}/hopdong/list" class="btn-cancel">❌ Hủy bỏ</a>
                    </div>
                </form:form>
            </div>
        </main>

        <footer>
            <p>&copy; 2026 - Hệ thống Quản lý Ký túc xá</p>
        </footer>
    </div>
</body>
</html>