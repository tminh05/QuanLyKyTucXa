<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm hợp đồng mới</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>➕ Thêm hợp đồng mới</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/hopdong/list">Danh sách</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <h2>Thông tin hợp đồng</h2>

            <%-- Hiển thị thông báo lỗi/thành công --%>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form:form action="${pageContext.request.contextPath}/hopdong/add" 
                       method="post" modelAttribute="hopDong" class="form">

                <div class="form-row">
                    <div class="form-group">
                        <label>MSSV <span class="required">*</span></label>
                        <form:select path="mssv" required="required">
                            <%-- Giữ nguyên value="" vì mssv là String --%>
                            <form:option value="">-- Chọn sinh viên --</form:option>
                            <c:forEach items="${sinhVienList}" var="sv">
                                <form:option value="${sv.mssv}">${sv.mssv} - ${sv.hoTen}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>

                    <div class="form-group">
                        <label>Phòng <span class="required">*</span></label>
                        <form:select path="idPhong" required="required">
                            <%-- SỬA: value="0" thay vì value="" vì idPhong là int --%>
                            <form:option value="0">-- Chọn phòng --</form:option>
                            <c:forEach items="${phongList}" var="p">
                                <form:option value="${p.idPhong}">
                                    ${p.tenPhong} (Còn ${p.sucChua - p.soNguoiHienTai} chỗ)
                                </form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Ngày bắt đầu <span class="required">*</span></label>
                        <form:input path="ngayBatDau" type="date" required="required"/>
                    </div>

                    <div class="form-group">
                        <label>Ngày kết thúc <span class="required">*</span></label>
                        <form:input path="ngayKetThuc" type="date" required="required"/>
                    </div>
                </div>

                <div class="form-group">
                    <label>Trạng thái</label>
                    <form:select path="trangThai">
                        <form:option value="Hiệu lực">Hiệu lực</form:option>
                        <form:option value="Hết hạn">Hết hạn</form:option>
                    </form:select>
                </div>

                <div class="form-buttons">
                    <button type="submit" class="btn-submit">💾 Lưu lại</button>
                    <a href="${pageContext.request.contextPath}/hopdong/list" class="btn-cancel">❌ Hủy bỏ</a>
                </div>

            </form:form>
        </main>
    </div>
</body>
</html>