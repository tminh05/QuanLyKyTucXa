<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thống kê - Admin</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }
        
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 260px;
            height: 100%;
            background: linear-gradient(180deg, #0D47A1, #1565C0);
            color: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            z-index: 100;
        }
        .sidebar-header { padding: 24px 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.2); }
        .sidebar-header h2 { font-size: 18px; font-weight: 700; }
        .sidebar-header p { font-size: 12px; opacity: 0.7; margin-top: 5px; }
        .sidebar-menu { padding: 20px 0; }
        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 24px;
            color: white;
            text-decoration: none;
            transition: background 0.2s;
            font-size: 14px;
        }
        .sidebar-menu a:hover { background: rgba(255,255,255,0.15); }
        .sidebar-menu a.active { background: rgba(255,255,255,0.25); border-left: 3px solid #FFD700; }
        .sidebar-footer {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 20px;
            border-top: 1px solid rgba(255,255,255,0.2);
            font-size: 12px;
            text-align: center;
        }
        .sidebar-footer a { color: white; text-decoration: none; }
        
        .main-content { margin-left: 260px; padding: 20px; }
        
        .top-bar {
            background: white;
            border-radius: 12px;
            padding: 16px 24px;
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .page-title { font-size: 22px; font-weight: 700; color: #0D47A1; }
        .logout-btn {
            background: #e53935;
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .stat-card:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0,0,0,0.1); }
        .stat-icon { font-size: 32px; margin-bottom: 12px; }
        .stat-number { font-size: 28px; font-weight: 800; color: #1565C0; }
        .stat-label { font-size: 13px; color: #888; margin-top: 5px; }
        
        .stats-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 24px;
        }
        .stats-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .stats-card h3 {
            font-size: 16px;
            font-weight: 700;
            color: #0D47A1;
            margin-bottom: 16px;
            padding-bottom: 8px;
            border-bottom: 2px solid #e3eaf5;
        }
        .list-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .list-item:last-child { border-bottom: none; }
        .list-label { font-size: 13px; color: #555; }
        .list-value { font-size: 13px; font-weight: 700; color: #1565C0; }
        .progress-bar {
            height: 8px;
            background: #e3eaf5;
            border-radius: 4px;
            overflow: hidden;
            margin-top: 8px;
        }
        .progress-fill {
            height: 100%;
            background: #1565C0;
            border-radius: 4px;
        }
        
        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-green { background: #e8f5e9; color: #2e7d32; }
        .badge-red { background: #ffebee; color: #c62828; }
        .badge-blue { background: #E3F2FD; color: #1565C0; }
        .badge-orange { background: #FFF8E1; color: #f57f17; }
        
        .sub-stats {
            display: flex;
            gap: 20px;
            margin-top: 15px;
        }
        .sub-stat {
            flex: 1;
            text-align: center;
            padding: 12px;
            background: #f8f9ff;
            border-radius: 8px;
        }
        .sub-stat .number { font-size: 20px; font-weight: 800; color: #1565C0; }
        .sub-stat .label { font-size: 11px; color: #999; margin-top: 4px; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">
            <h2>🏠 KTX UTE</h2>
            <p>Hệ thống quản lý</p>
        </div>
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/admin/dashboard">📊 Tổng quan</a>
            <a href="${pageContext.request.contextPath}/admin/sinhvien">👨‍🎓 Quản lý Sinh viên</a>
            <a href="${pageContext.request.contextPath}/admin/phong">🏢 Quản lý Phòng</a>
            <a href="${pageContext.request.contextPath}/admin/hopdong">📄 Quản lý Hợp đồng</a>
            <a href="${pageContext.request.contextPath}/admin/baotri">🔧 Quản lý Bảo trì</a>
            <a href="${pageContext.request.contextPath}/admin/nhanvien">👥 Quản lý Nhân viên</a>
            <a href="${pageContext.request.contextPath}/admin/baiviet">📰 Quản lý Bài viết</a>
            <a href="${pageContext.request.contextPath}/admin/thongke" class="active">📈 Thống kê</a>
        </div>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/admin/logout">🔓 Đăng xuất</a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div class="page-title">📈 Thống kê hệ thống</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">Đăng xuất</a>
        </div>

        <!-- TỔNG QUAN -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">👨‍🎓</div>
                <div class="stat-number">${tongSinhVien}</div>
                <div class="stat-label">Tổng số sinh viên</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🏢</div>
                <div class="stat-number">${tongPhong}</div>
                <div class="stat-label">Tổng số phòng</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📄</div>
                <div class="stat-number">${hopDongHieuLuc}</div>
                <div class="stat-label">Hợp đồng hiệu lực</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🔧</div>
                <div class="stat-number">${yeuCauBaoTri}</div>
                <div class="stat-label">Yêu cầu bảo trì</div>
            </div>
        </div>

        <!-- CHI TIẾT THỐNG KÊ -->
        <div class="stats-row">
            <!-- PHÒNG -->
            <div class="stats-card">
                <h3>🏠 Thống kê phòng</h3>
                <div class="list-item">
                    <span class="list-label">Phòng trống</span>
                    <span class="list-value">${phongTrong} phòng</span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: ${phongTrong * 100 / tongPhong}%"></div>
                </div>
                <div class="list-item">
                    <span class="list-label">Phòng đầy</span>
                    <span class="list-value">${phongDay} phòng</span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: ${phongDay * 100 / tongPhong}%; background:#e53935;"></div>
                </div>
                <div class="sub-stats">
                    <div class="sub-stat">
                        <div class="number">${(phongTrong * 100 / tongPhong) - (phongTrong * 100 / tongPhong) % 1}%</div>
                        <div class="label">Tỷ lệ trống</div>
                    </div>
                    <div class="sub-stat">
                        <div class="number">${(phongDay * 100 / tongPhong) - (phongDay * 100 / tongPhong) % 1}%</div>
                        <div class="label">Tỷ lệ đầy</div>
                    </div>
                </div>
            </div>

            <!-- HỢP ĐỒNG & BẢO TRÌ -->
            <div class="stats-card">
                <h3>📄 Hợp đồng & Bảo trì</h3>
                <div class="list-item">
                    <span class="list-label">Hợp đồng hiệu lực</span>
                    <span class="list-value"><span class="badge badge-green">${hopDongHieuLuc}</span></span>
                </div>
                <div class="list-item">
                    <span class="list-label">Yêu cầu bảo trì chưa xử lý</span>
                    <span class="list-value"><span class="badge badge-orange">${yeuCauChuaXuLy}</span></span>
                </div>
                <div class="list-item">
                    <span class="list-label">Yêu cầu đang xử lý</span>
                    <span class="list-value"><span class="badge badge-blue">${yeuCauDangXuLy}</span></span>
                </div>
                <div class="list-item">
                    <span class="list-label">Yêu cầu đã hoàn thành</span>
                    <span class="list-value"><span class="badge badge-green">${yeuCauHoanThanh}</span></span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>