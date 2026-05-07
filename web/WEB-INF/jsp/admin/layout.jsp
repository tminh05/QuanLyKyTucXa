<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Quản Lý KTX</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        .admin-wrapper { display: flex; min-height: 100vh; }
        .sidebar { width: 250px; background: #2c3e50; color: white; padding: 20px; }
        .sidebar a { color: white; display: block; padding: 10px; text-decoration: none; }
        .sidebar a:hover { background: #34495e; }
        .main-content { flex: 1; padding: 20px; background: #f4f7f6; }
        .card-stats { display: flex; gap: 20px; margin-bottom: 20px; }
        .card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); flex: 1; }
    </style>
</head>
<body>
    <div class="admin-wrapper">
        <div class="sidebar">
            <h3>KTX ADMIN</h3>
            <hr>
            <a href="<c:url value='/admin/dashboard'/>">Dashboard</a>
            <a href="<c:url value='/admin/sinhvien/list'/>">Quản lý Sinh viên</a>
            <a href="<c:url value='/admin/phong/list'/>">Quản lý Phòng</a>
            <a href="<c:url value='/admin/hopdong/list'/>">Quản lý Hợp đồng</a>
            <a href="<c:url value='/logout'/>" style="margin-top: 50px; color: #e74c3c;">Đăng xuất</a>
        </div>
        <div class="main-content">
            <jsp:doBody />
        </div>
    </div>
</body>
</html>