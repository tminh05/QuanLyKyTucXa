<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/sidebar.jsp" />

<h3>Thêm Mới Sinh Viên</h3>
<div class="card shadow mt-3">
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/sinhvien/save" method="POST">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">MSSV</label>
                    <input type="text" name="mssv" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Họ và Tên</label>
                    <input type="text" name="hoTen" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Ngày Sinh</label>
                    <input type="date" name="ngaySinh" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Giới Tính</label>
                    <select name="gioiTinh" class="form-select">
                        <option value="Nam">Nam</option>
                        <option value="Nữ">Nữ</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Lớp</label>
                    <input type="text" name="lop" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Khoa</label>
                    <input type="text" name="khoa" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Số Điện Thoại</label>
                    <input type="text" name="sdt" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Mật khẩu (Đăng nhập)</label>
                    <input type="password" name="matKhau" class="form-control" required>
                </div>
            </div>
            <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Lưu Dữ Liệu</button>
            <a href="${pageContext.request.contextPath}/admin/sinhvien/list" class="btn btn-secondary">Hủy bỏ</a>
        </form>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />