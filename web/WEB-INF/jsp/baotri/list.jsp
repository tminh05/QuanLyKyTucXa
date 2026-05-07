<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Bảo trì</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🔧 Quản lý Bảo trì</h1>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/baotri/list">Danh sách</a></li>
                    <li><a href="${pageContext.request.contextPath}/baotri/add">Tạo yêu cầu mới</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <h2>Danh sách yêu cầu bảo trì</h2>

            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <table class="data-table">
                <thead>
                    <tr>
                        <th>Mã yêu cầu</th>
                        <th>Phòng</th>
                        <th>MSSV</th>
                        <th>Nội dung</th>
                        <th>Ngày tạo</th>
                        <th>Ngày cập nhật</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty yeuCauList}">
                            <tr>
                                <td colspan="8" style="text-align:center;">
                                    Không có yêu cầu bảo trì nào.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${yeuCauList}" var="yc">
                                <tr>
                                    <td>${yc.idYeuCau}</td>
                                    <td>${yc.tenPhong}</td>
                                    <td>${yc.mssv}</td>
                                    <td>${yc.noiDung}</td>
                                    <td>
                                        <fmt:formatDate value="${yc.ngayTao}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty yc.ngayCapNhat}">
                                                <fmt:formatDate value="${yc.ngayCapNhat}" pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>--</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${yc.trangThai == 'Cho xu ly'}">
                                                <span class="status-pending">Chờ xử lý</span>
                                            </c:when>
                                            <c:when test="${yc.trangThai == 'Dang xu ly'}">
                                                <span class="status-processing">Đang xử lý</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-done">${yc.trangThai}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/baotri/process/${yc.idYeuCau}" 
                                               class="btn-edit">Xử lý</a>
                                            <a href="${pageContext.request.contextPath}/baotri/delete/${yc.idYeuCau}"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa?')"
                                               class="btn-delete">Xóa</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </main>

        <footer>
            <p>&copy; 2026 - Hệ thống Quản lý Ký túc xá</p>
        </footer>
    </div>
</body>
</html>