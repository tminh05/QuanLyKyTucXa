<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Hợp đồng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📄 Quản lý Hợp đồng</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/hopdong/list">Danh sách</a></li>
                    <li><a href="${pageContext.request.contextPath}/hopdong/add">Thêm mới</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <h2>Danh sách Hợp đồng thuê phòng</h2>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Mã hợp đồng</th>
                        <th>MSSV</th>
                        <th>Họ tên sinh viên</th>
                        <th>Phòng</th>
                        <th>Ngày bắt đầu</th>
                        <th>Ngày kết thúc</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${hopDongList}" var="hd">
                        <tr>
                            <td>${hd.idHopDong}</td>
                            <td>${hd.mssv}</td>
                            <td>${hd.hoTenSinhVien}</td>
                            <td>${hd.tenPhong}</td>
                            <td><fmt:formatDate value="${hd.ngayBatDau}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${hd.ngayKetThuc}" pattern="dd/MM/yyyy"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${hd.trangThai == 'Hiệu lực'}">
                                        <span class="status-active">Hiệu lực</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-expired">Hết hạn</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/hopdong/edit/${hd.idHopDong}" class="btn-edit">Sửa</a>
                                <a href="${pageContext.request.contextPath}/hopdong/delete/${hd.idHopDong}" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa hợp đồng này?')" 
                                   class="btn-delete">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty hopDongList}">
                        <tr>
                            <td colspan="8" class="text-center">Không có dữ liệu hợp đồng</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>