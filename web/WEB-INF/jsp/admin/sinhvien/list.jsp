<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/sidebar.jsp" />

<div class="d-flex justify-content-between align-items-center mb-3">
    <h3>Danh Sách Sinh Viên</h3>
    <a href="${pageContext.request.contextPath}/admin/sinhvien/add" class="btn btn-success"><i class="fas fa-plus"></i> Thêm Sinh Viên</a>
</div>

<div class="card shadow">
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/sinhvien/list" method="GET" class="d-flex mb-3">
            <input type="text" name="keyword" class="form-control me-2" placeholder="Nhập MSSV, Tên hoặc Lớp để tìm kiếm...">
            <button type="submit" class="btn btn-primary">Tìm</button>
        </form>

        <table class="table table-bordered table-hover align-middle">
            <thead class="table-dark">
                <tr>
                    <th>MSSV</th>
                    <th>Họ Tên</th>
                    <th>Ngày Sinh</th>
                    <th>Lớp</th>
                    <th>Số Điện Thoại</th>
                    <th class="text-center">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="sv" items="${dsSinhVien}">
                <tr>
                    <td>${sv.mssv}</td>
                    <td>${sv.hoTen}</td>
                    <td>${sv.ngaySinh}</td>
                    <td>${sv.lop}</td>
                    <td>${sv.sdt}</td>
                    <td class="text-center">
                        <a href="${pageContext.request.contextPath}/admin/sinhvien/edit/${sv.mssv}" class="btn btn-sm btn-warning"><i class="fas fa-edit"></i> Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/sinhvien/delete/${sv.mssv}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa sinh viên ${sv.hoTen}?');"><i class="fas fa-trash"></i> Xóa</a>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />