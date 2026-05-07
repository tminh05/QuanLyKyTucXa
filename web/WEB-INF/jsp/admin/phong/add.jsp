<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/sidebar.jsp" />

<h3>Thêm Phòng Mới</h3>
<div class="card shadow mt-3">
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/phong/save" method="POST">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Tên Phòng (Ví dụ: P101)</label>
                    <input type="text" name="tenPhong" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">ID Tòa Nhà (Ví dụ: 1)</label>
                    <input type="number" name="idToaNha" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">ID Loại Phòng</label>
                    <input type="number" name="idLoaiPhong" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Sức Chứa (Số người)</label>
                    <input type="number" name="sucChua" class="form-control" required>
                </div>
            </div>
            <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Lưu Phòng</button>
            <a href="${pageContext.request.contextPath}/admin/phong/list" class="btn btn-secondary">Quay lại</a>
        </form>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />