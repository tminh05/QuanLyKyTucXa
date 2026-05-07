<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-md-2 sidebar p-0 shadow-sm">
    <h4 class="text-white text-center py-4 m-0 bg-dark border-bottom border-secondary">KTX ADMIN</h4>
    <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt me-2"></i> Tổng Quan</a>
    <a href="${pageContext.request.contextPath}/admin/sinhvien/list"><i class="fas fa-user-graduate me-2"></i> Quản lý Sinh viên</a>
    <a href="${pageContext.request.contextPath}/admin/phong/list"><i class="fas fa-bed me-2"></i> Quản lý Phòng</a>
    <a href="${pageContext.request.contextPath}/admin/hopdong/list"><i class="fas fa-file-contract me-2"></i> Quản lý Hợp đồng</a>
    <a href="${pageContext.request.contextPath}/logout" class="text-danger mt-3"><i class="fas fa-sign-out-alt me-2"></i> Đăng xuất</a>
</div>
<div class="col-md-10 main-content">
    <nav class="navbar navbar-light bg-white shadow-sm rounded mb-4 px-3">
        <span class="navbar-brand mb-0 h1">Trang Quản Trị Hệ Thống</span>
        <span class="navbar-text fw-bold text-primary">Xin chào, Quản trị viên</span>
    </nav>