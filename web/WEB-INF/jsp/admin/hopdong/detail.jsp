<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/sidebar.jsp" />

<h3>Chi Tiết Hợp Đồng #${hopDong.idHopDong}</h3>
<div class="card shadow mt-3 w-50">
    <div class="card-body">
        <table class="table">
            <tr><th>MSSV:</th><td>${hopDong.mssv}</td></tr>
            <tr><th>Tên Sinh Viên:</th><td>${hopDong.hoTenSinhVien}</td></tr>
            <tr><th>Phòng Thuê:</th><td>${hopDong.tenPhong}</td></tr>
            <tr><th>Ngày Bắt Đầu:</th><td>${hopDong.ngayBatDau}</td></tr>
            <tr><th>Ngày Kết Thúc:</th><td>${hopDong.ngayKetThuc}</td></tr>
            <tr><th>Trạng Thái:</th>
                <td><span class="badge bg-success">${hopDong.trangThai}</span></td>
            </tr>
        </table>
        <a href="${pageContext.request.contextPath}/admin/hopdong/list" class="btn btn-secondary">Quay Lại</a>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />