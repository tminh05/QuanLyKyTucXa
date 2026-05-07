<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="header-action" style="display:flex; justify-content: space-between;">
    <h2>Danh sách Sinh viên</h2>
    <a href="add" class="btn-primary" style="padding: 10px; background: #27ae60; color: white; border-radius: 5px;">+ Thêm mới</a>
</div>
<table border="1" width="100%" style="margin-top: 20px; border-collapse: collapse;">
    <tr style="background: #ecf0f1;">
        <th>MSSV</th><th>Họ Tên</th><th>Lớp</th><th>Khoa</th><th>Thao tác</th>
    </tr>
    <c:forEach var="sv" items="${dsSinhVien}">
    <tr>
        <td>${sv.mssv}</td>
        <td>${sv.hoTen}</td>
        <td>${sv.lop}</td>
        <td>${sv.khoa}</td>
        <td>
            <a href="edit/${sv.mssv}">Sửa</a> | 
            <a href="delete/${sv.mssv}" onclick="return confirm('Xóa sinh viên này?')">Xóa</a>
        </td>
    </tr>
    </c:forEach>
</table>