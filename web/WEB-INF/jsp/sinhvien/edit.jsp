<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cập nhật sinh viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>✏️ Cập nhật sinh viên</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/sinhvien/list">Danh sách</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <h2>Sửa thông tin sinh viên</h2>
            
            <form:form action="${pageContext.request.contextPath}/sinhvien/edit" method="post" modelAttribute="sinhVien" class="form">
                <div class="form-row">
                    <div class="form-group">
                        <label>MSSV</label>
                        <form:input path="mssv" readonly="true" cssClass="readonly"/>
                        <small class="info-text">MSSV không thể thay đổi</small>
                    </div>
                    
                    <div class="form-group">
                        <label>Họ tên <span class="required">*</span></label>
                        <form:input path="hoTen" required="required" maxlength="100"/>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Ngày sinh</label>
                        <form:input path="ngaySinh" type="date"/>
                    </div>
                    
                    <div class="form-group">
                        <label>Giới tính</label>
                        <form:select path="gioiTinh">
                            <form:option value="Nam">Nam</form:option>
                            <form:option value="Nữ">Nữ</form:option>
                        </form:select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Lớp</label>
                        <form:input path="lop" maxlength="50"/>
                    </div>
                    
                    <div class="form-group">
                        <label>Khoa</label>
                        <form:input path="khoa" maxlength="50"/>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <form:input path="sdt" maxlength="15"/>
                    </div>
                    
                    <div class="form-group">
                        <label>Email</label>
                        <form:input path="email" type="email" maxlength="100"/>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>CCCD/CMND</label>
                        <form:input path="cccd" maxlength="20"/>
                    </div>
                    
                    <div class="form-group">
                        <label>Mật khẩu</label>
                        <form:password path="matKhau" placeholder="Để trống nếu không đổi mật khẩu"/>
                    </div>
                </div>
                
                <div class="form-buttons">
                    <button type="submit" class="btn-submit">💾 Cập nhật</button>
                    <a href="${pageContext.request.contextPath}/sinhvien/list" class="btn-cancel">❌ Hủy bỏ</a>
                </div>
            </form:form>
        </main>
    </div>
</body>
</html>