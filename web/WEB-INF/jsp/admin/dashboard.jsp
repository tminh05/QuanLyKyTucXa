<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/sidebar.jsp" />

<div class="row">
    <div class="col-md-4">
        <div class="card text-white bg-primary mb-3 shadow">
            <div class="card-body">
                <h5 class="card-title">Tổng Sinh Viên</h5>
                <h2 class="display-5 fw-bold">${totalSV}</h2>
                <a href="${pageContext.request.contextPath}/admin/sinhvien/list" class="text-white text-decoration-none">Xem chi tiết <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card text-white bg-success mb-3 shadow">
            <div class="card-body">
                <h5 class="card-title">Tổng Số Phòng</h5>
                <h2 class="display-5 fw-bold">${totalPhong}</h2>
                <a href="${pageContext.request.contextPath}/admin/phong/list" class="text-white text-decoration-none">Xem chi tiết <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card text-dark bg-warning mb-3 shadow">
            <div class="card-body">
                <h5 class="card-title">Phòng Còn Trống</h5>
                <h2 class="display-5 fw-bold">${availableRooms}</h2>
                <a href="${pageContext.request.contextPath}/admin/phong/list" class="text-dark text-decoration-none">Xem chi tiết <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="layout/footer.jsp" />