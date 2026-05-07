<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/sidebar.jsp" />

<div class="container-fluid px-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="mt-4">Cập Nhật Thông Tin Phòng: <span class="text-primary">${phong.tenPhong}</span></h3>
        <a href="${pageContext.request.contextPath}/admin/phong/list" class="btn btn-secondary shadow-sm">
            <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
        </a>
    </div>

    <div class="card shadow mb-4">
        <div class="card-header bg-warning text-dark fw-bold">
            <i class="fas fa-edit me-1"></i> Form Chỉnh Sửa Phòng
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/phong/save" method="POST">
                <input type="hidden" name="idPhong" value="${phong.idPhong}">
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Tên Phòng</label>
                        <input type="text" name="tenPhong" class="form-control" value="${phong.tenPhong}" placeholder="Ví dụ: P101, P102..." required>
                        <div class="form-text">Tên phòng không nên trùng trong cùng một tòa nhà.</div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Sức Chứa (Người)</label>
                        <input type="number" name="sucChua" class="form-control" value="${phong.sucChua}" min="1" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">ID Tòa Nhà</label>
                        <input type="number" name="idToaNha" class="form-control" value="${phong.idToaNha}" required>
                        <div class="form-text">Nhập mã số tòa nhà hiện có trong hệ thống.</div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">ID Loại Phòng</label>
                        <input type="number" name="idLoaiPhong" class="form-control" value="${phong.idLoaiPhong}" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label text-muted">Trạng Thái Hiện Tại</label>
                        <input type="text" class="form-control bg-light" value="${phong.trangThai}" readonly>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label text-muted">Số Người Đang Ở</label>
                        <input type="text" class="form-control bg-light" value="${phong.soNguoiHienTai}" readonly>
                    </div>
                </div>

                <hr class="my-4">

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-warning px-4 shadow-sm">
                        <i class="fas fa-save me-1"></i> Lưu Thay Đổi
                    </button>
                    <button type="reset" class="btn btn-outline-secondary px-4">
                        Khôi phục ban đầu
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />