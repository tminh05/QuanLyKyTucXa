<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Phòng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🏢 Quản lý Phòng</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/phong/list">Danh sách</a></li>
                    <li><a href="${pageContext.request.contextPath}/phong/add">Thêm mới</a></li>
                </ul>
            </nav>
        </header>
        
        <main>

            <h2>Danh sách Phòng</h2>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>   
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Mã phòng</th>
                        <th>Tên phòng</th>
                        <th>Tòa nhà</th>
                        <th>Loại phòng</th>
                        <th>Giá phòng</th>
                        <th>Sức chứa</th>
                        <th>Số người ở</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>

                    <c:forEach items="${phongList}" var="p">
                        <tr>
                            <td>${p.idPhong}</td>
                            <td>${p.tenPhong}</td>
                            <td>${p.tenToaNha}</td>
                            <td>${p.tenLoaiPhong}</td>
                            <td><fmt:formatNumber value="${p.giaPhong}" type="currency" currencySymbol="VNĐ"/></td>
                            <td>${p.sucChua}</td>
                            <td>${p.soNguoiHienTai}</td>
                            <td>

                                <c:choose>
                                    <c:when test="${p.trangThai == 'Trống'}">
                                        <span class="status-empty">Trống</span>
                                    </c:when>
                                    <c:when test="${p.trangThai == 'Đầy'}">
                                        <span class="status-full">Đầy</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-occupied">Đang ở</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/phong/detail/${p.idPhong}" class="btn-view">Chi tiết</a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty phongList}">
                        <tr>
                            <td colspan="9" class="text-center">Không có dữ liệu phòng</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </main>
    </div>
</body>

</html>