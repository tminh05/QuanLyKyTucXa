<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/sidebar.jsp" />

<div class="d-flex justify-content-between align-items-center mb-3">
    <h3>Quản Lý Phòng</h3>
    <a href="${pageContext.request.contextPath}/admin/phong/add" class="btn btn-success"><i class="fas fa-plus"></i> Thêm Phòng</a>
</div>

<div class="card shadow">
    <div class="card-body">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tên Phòng</th>
                    <th>Tòa Nhà</th>
                    <th>Sức Chứa</th>
                    <th>Đang Ở</th>
                    <th>Trạng Thái</th>
                    <th class="text-center">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${dsPhong}">
                <tr>
                    <td>${p.idPhong}</td>
                    <td><strong>${p.tenPhong}</strong></td>
                    <td>${p.tenToaNha}</td>
                    <td>${p.sucChua}</td>
                    <td>${p.soNguoiHienTai}</td>
                    <td>
                        <span class="badge ${p.trangThai == 'Trống' ? 'bg-success' : (p.trangThai == 'Đầy' ? 'bg-danger' : 'bg-warning')}">
                            ${p.trangThai}
                        </span>
                    </td>
                    <td class="text-center">
                        <a href="${pageContext.request.contextPath}/admin/phong/delete/${p.idPhong}" class="btn btn-sm btn-danger" onclick="return confirm('Xóa phòng này?');"><i class="fas fa-trash"></i> Xóa</a>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />