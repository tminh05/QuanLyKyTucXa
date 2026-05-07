<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Phòng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🏢 Chi tiết Phòng</h1>
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

                <table class="data-table">
                    <tr>
                        <th>Tên phòng</th>
                        <td>${phong.tenPhong}</td>
                    </tr>
                    <tr>
                        <th>Tòa nhà</th>
                        <td>${phong.tenToaNha}</td>
                    </tr>
                    <tr>
                        <th>Loại phòng</th>
                        <td>${phong.tenLoaiPhong}</td>
                    </tr>
                    <tr>
                        <th>Giá phòng</th>
                        <td>${phong.giaPhong} VNĐ</td>
                    </tr>
                    <tr>
                        <th>Sức chứa</th>
                        <td>${phong.sucChua} người</td>
                    </tr>
                    <tr>
                        <th>Số người hiện tại</th>
                        <td>${phong.soNguoiHienTai} người</td>
                    </tr>
                    <tr>
                        <th>Trạng thái</th>
                        <td>
                            <c:choose>
                                <c:when test="${phong.trangThai == 'Trống'}">
                                    <span class="status-empty">Trống</span>
                                </c:when>
                                <c:when test="${phong.trangThai == 'Đầy'}">
                                    <span class="status-full">Đầy</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-occupied">Đang ở</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>

                <h2 class="mt-20">Danh sách sinh viên trong phòng</h2>
                <c:choose>
                    <c:when test="${empty sinhVienList}">
                        <p>Chưa có sinh viên nào trong phòng này.</p>
                    </c:when>
                    <c:otherwise>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>MSSV</th>
                                    <th>Họ tên</th>
                                    <th>Số điện thoại</th>
                                    <th>Email</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="sv" items="${sinhVienList}">
                                    <tr>
                                        <td>${sv.mssv}</td>
                                        <td>${sv.hoTen}</td>
                                        <td>${sv.sdt}</td>
                                        <td>${sv.email}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>

                <div class="form-buttons mt-20">
                    <a href="${pageContext.request.contextPath}/phong/list" class="btn-cancel">← Quay lại</a>
                </div>
            </div>
        </main>

        <footer>
            <p>&copy; 2026 - Hệ thống Quản lý Ký túc xá</p>
        </footer>
    </div>
</body>
</html>