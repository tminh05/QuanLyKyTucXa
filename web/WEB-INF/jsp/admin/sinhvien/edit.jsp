<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/sidebar.jsp" />

<h3>Cập Nhật Sinh Viên: ${sinhVien.hoTen}</h3>
<div class="card shadow mt-3">
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/sinhvien/save" method="POST">
            <input type="hidden" name="mssv" value="${sinhVien.mssv}">
            
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">MSSV</label>
                    <input type="text" class="form-control" value="${sinhVien.mssv}" disabled>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Họ và Tên</label>
                    <input type="text" name="hoTen" class="form-control" value="${sinhVien.hoTen}" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Ngày Sinh</label>
                    <input type="date" name="ngaySinh" class="form-control" value="${sinhVien.ngaySinh}">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Giới Tính</label>
                    <select name="gioiTinh" class="form-select">
                        <option value="Nam" ${sinhVien.gioiTinh == 'Nam' ? 'selected' : ''}>Nam</option>
                        <option value="Nữ" ${sinhVien.gioiTinh == 'Nữ' ? 'selected' : ''}>Nữ</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Lớp</label>
                    <input type="text" name="lop" class="form-control" value="${sinhVien.lop}">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Khoa</label>
                    <input type="text" name="khoa" class="form-control" value="${sinhVien.khoa}">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Số Điện Thoại</label>
                    <input type="text" name="sdt" class="form-control" value="${sinhVien.sdt}">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Mật khẩu</label>
                    <input type="password" name="matKhau" class="form-control" value="${sinhVien.matKhau}">
                </div>
            </div>
            <button type="submit" class="btn btn-warning"><i class="fas fa-edit"></i> Cập Nhật</button>
            <a href="${pageContext.request.contextPath}/admin/sinhvien/list" class="btn btn-secondary">Quay lại</a>
        </form>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />