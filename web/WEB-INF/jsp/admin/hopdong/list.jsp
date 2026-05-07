<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/sidebar.jsp" />

<h3 class="mb-3">Quản Lý Hợp Đồng Ký Túc Xá</h3>

<div class="card shadow">
    <div class="card-body">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-dark">
                <tr>
                    <th>Mã Hợp Đồng</th>
                    <th>MSSV</th>
                    <th>Tên Sinh Viên</th>
                    <th>Phòng</th>
                    <th>Ngày Bắt Đầu</th>
                    <th>Ngày Kết Thúc</th>
                    <th>Trạng Thái</th>
                    <th>Chi tiết</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="hd" items="${dsHopDong}">
                <tr>
                    <td>#${hd.idHopDong}</td>
                    <td>${hd.mssv}</td>
                    <td><strong>${hd.hoTenSinhVien}</strong></td>
                    <td>${hd.tenPhong}</td>
                    <td>${hd.ngayBatDau}</td>
                    <td>${hd.ngayKetThuc}</td>
                    <td>
                        <span class="badge ${hd.trangThai == 'Hiệu lực' ? 'bg-success' : 'bg-secondary'}">
                            ${hd.trangThai}
                        </span>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/hopdong/detail/${hd.idHopDong}" class="btn btn-sm btn-info text-white"><i class="fas fa-eye"></i> Xem</a>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />