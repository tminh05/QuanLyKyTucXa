<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm sinh viên mới</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>➕ Thêm sinh viên mới</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/sinhvien/list">Danh sách</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <h2>Thông tin sinh viên</h2>
            
            <form:form action="${pageContext.request.contextPath}/sinhvien/add" method="post" modelAttribute="sinhVien" class="form">
                <div class="form-row">
                    <div class="form-group">
                        <label>MSSV <span class="required">*</span></label>
                        <form:input path="mssv" required="required" maxlength="20" placeholder="Nhập MSSV"/>
                    </div>
                    
                    <div class="form-group">
                        <label>Họ tên <span class="required">*</span></label>
                        <form:input path="hoTen" required="required" maxlength="100" placeholder="Nhập họ tên"/>
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
                        <form:input path="lop" maxlength="50" placeholder="Nhập lớp"/>
                    </div>
                    
                    <div class="form-group">
                    <label>Khoa</label>
                    <form:select path="khoa">
                        <form:option value="">-- Chọn khoa --</form:option>
                        <form:option value="Công nghệ Thông tin">Công nghệ Thông tin</form:option>
                        <form:option value="Điện tử Viễn thông">Điện tử Viễn thông</form:option>
                        <form:option value="Cơ khí">Cơ khí</form:option>
                        <form:option value="Xây dựng">Xây dựng</form:option>
                        <form:option value="Kinh tế">Kinh tế</form:option>
                        <form:option value="Ngoại ngữ">Ngoại ngữ</form:option>
                        <form:option value="Điện - Điện tử">Điện - Điện tử</form:option>
                        </form:select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <form:input path="sdt" maxlength="15" placeholder="Nhập số điện thoại"/>
                    </div>
                    
                    <div class="form-group">
                        <label>Email</label>
                        <form:input path="email" type="email" maxlength="100" placeholder="Nhập email"/>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>CCCD/CMND</label>
                        <form:input path="cccd" maxlength="20" placeholder="Nhập CCCD/CMND"/>
                    </div>
                    
                    <div class="form-group">
                        <label>Mật khẩu <span class="required">*</span></label>
                        <form:password path="matKhau" required="required" placeholder="Nhập mật khẩu"/>
                    </div>
                </div>
                
                <div class="form-buttons">
                    <button type="submit" class="btn-submit">💾 Lưu lại</button>
                    <a href="${pageContext.request.contextPath}/sinhvien/list" class="btn-cancel">❌ Hủy bỏ</a>
                </div>
            </form:form>
        </main>
    </div>
</body>
</html>