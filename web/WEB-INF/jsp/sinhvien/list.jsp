<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Sinh viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📋 Quản lý Sinh viên</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/sinhvien/list">Danh sách</a></li>
                    <li><a href="${pageContext.request.contextPath}/sinhvien/add">Thêm mới</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <h2>Danh sách Sinh viên</h2>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            
            <div class="search-box">
                <form action="${pageContext.request.contextPath}/sinhvien/search" method="get">
                    <input type="text" name="keyword" placeholder="Tìm kiếm theo MSSV, họ tên, lớp..." value="${keyword}">
                    <button type="submit">🔍 Tìm kiếm</button>
                </form>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>MSSV</th>
                        <th>Họ tên</th>
                        <th>Ngày sinh</th>
                        <th>Giới tính</th>
                        <th>Lớp</th>
                        <th>Khoa</th>
                        <th>Số điện thoại</th>
                        <th>Email</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${sinhVienList}" var="sv">
                        <tr>
                            <td>${sv.mssv}</td>
                            <td>${sv.hoTen}</td>
                            <td><fmt:formatDate value="${sv.ngaySinh}" pattern="dd/MM/yyyy"/></td>
                            <td>${sv.gioiTinh}</td>
                            <td>${sv.lop}</td>
                            <td>${sv.khoa}</td>
                            <td>${sv.sdt}</td>
                            <td>${sv.email}</td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/sinhvien/edit/${sv.mssv}" class="btn-edit">Sửa</a>
                                <a href="${pageContext.request.contextPath}/sinhvien/delete/${sv.mssv}" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa sinh viên này?')" 
                                   class="btn-delete">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty sinhVienList}">
                        <tr>
                            <td colspan="9" class="text-center">Không có dữ liệu sinh viên</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>