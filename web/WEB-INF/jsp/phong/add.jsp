<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm phòng mới</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>➕ Thêm phòng mới</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/phong/list">Danh sách</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <div class="form">
                <h2>Thông tin phòng</h2>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">${error}</div>
                </c:if>

                <form:form action="${pageContext.request.contextPath}/phong/add" 
                           method="post" modelAttribute="phong" class="form">

                    <div class="form-row">
                        <div class="form-group">
                            <label>Tên phòng <span class="required">*</span></label>
                            <form:input path="tenPhong" required="required" 
                                       maxlength="50" placeholder="VD: A-101"/>
                        </div>

                        <div class="form-group">
                            <label>Tòa nhà <span class="required">*</span></label>
                            <form:select path="idToaNha">
                                <form:option value="0">-- Chọn tòa nhà --</form:option>
                                <c:forEach items="${toaNhaList}" var="tn">
                                    <form:option value="${tn.idToaNha}">${tn.tenToaNha}</form:option>
                                </c:forEach>
                            </form:select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Loại phòng <span class="required">*</span></label>
                            <form:select path="idLoaiPhong">
                                <form:option value="0">-- Chọn loại phòng --</form:option>
                                <c:forEach items="${loaiPhongList}" var="lp">
                                    <form:option value="${lp.idLoaiPhong}">${lp.tenLoai} - ${lp.giaPhong} VNĐ/tháng</form:option>
                                </c:forEach>
                            </form:select>
                        </div>

                        <div class="form-group">
                            <label>Sức chứa <span class="required">*</span></label>
                            <form:input path="sucChua" type="number" 
                                       required="required" min="1" 
                                       placeholder="Số lượng sinh viên tối đa"/>
                        </div>
                    </div>

                    <div class="form-buttons">
                        <button type="submit" class="btn-submit">💾 Lưu lại</button>
                        <a href="${pageContext.request.contextPath}/phong/list" class="btn-cancel">❌ Hủy bỏ</a>
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