<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Phòng của tôi - KTX UTE</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f0f4f8; }

        .header { background: white; border-bottom: 3px solid #1565C0; padding: 12px 30px;
                  display: flex; align-items: center; gap: 15px; }
        .header img { height: 65px; }
        .header-university { font-size: 13px; color: #1565C0; font-weight: 600; }
        .header-school { font-size: 20px; font-weight: 800; color: #1565C0; }
        .header-system { font-size: 15px; font-weight: 700; color: #e53935; }

        .top-bar { background: linear-gradient(to bottom, #0D47A1, #66D9FF); color: white; padding: 12px 0; }
        .top-bar-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; gap: 30px; }
        .top-bar a { color: white; text-decoration: none; display: flex; align-items: center; gap: 5px; }
        .top-bar a:hover { color: #FFD700; }

        .main-nav { background: #1976D2; }
        .nav-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; }
        .main-nav a { color: white; text-decoration: none; padding: 12px 22px; font-size: 15px;
                      font-weight: 500; display: block; border-right: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:first-child { border-left: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:hover, .main-nav a.active { background: #0D47A1; }

        .page-header { background: linear-gradient(135deg, #1565C0, #0D47A1); color: white; padding: 30px 0; }
        .page-header-inner { max-width: 1000px; margin: 0 auto; padding: 0 20px;
                             display: flex; align-items: center; gap: 20px; }
        .page-icon { width: 70px; height: 70px; background: rgba(255,255,255,0.2);
                     border-radius: 50%; display: flex; align-items: center;
                     justify-content: center; font-size: 32px; }
        .page-header h1 { font-size: 24px; font-weight: 800; }
        .page-header p { font-size: 14px; opacity: 0.9; margin-top: 5px; }

        .container { max-width: 1000px; margin: 30px auto; padding: 0 20px; }
        .card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); overflow: hidden; margin-bottom: 24px; }
        .card-title { background: linear-gradient(135deg, #1565C0, #0D47A1); color: white; padding: 16px 24px;
                      font-size: 16px; font-weight: 700; display: flex; align-items: center; gap: 10px; }
        .card-body { padding: 24px; }

        .room-highlight { background: linear-gradient(135deg, #f8f9ff, #E3F2FD); border-radius: 16px; padding: 24px;
                          text-align: center; margin-bottom: 20px; }
        .room-name { font-size: 36px; font-weight: 800; color: #1565C0; }
        .room-building { font-size: 15px; color: #666; margin-top: 8px; }

        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
        .info-item { background: #f8f9ff; padding: 14px 18px; border-radius: 12px; border-left: 4px solid #1565C0; }
        .info-label { font-size: 12px; color: #888; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 6px; }
        .info-value { font-size: 16px; font-weight: 700; color: #333; }
        .info-value.price { color: #e53935; }
        .status-badge { display: inline-block; padding: 6px 16px; border-radius: 30px; font-size: 13px; font-weight: 700; }
        .status-trong { background: #e8f5e9; color: #2e7d32; }
        .status-day { background: #ffebee; color: #c62828; }
        .status-dang { background: #E3F2FD; color: #1565C0; }

        .member-list { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 12px; }
        .member-item { background: #f8f9ff; border: 1px solid #e3eaf5; border-radius: 12px; padding: 14px 18px; display: flex; align-items: center; gap: 14px; }
        .member-avatar { width: 45px; height: 45px; border-radius: 50%; background: #1565C0; display: flex; align-items: center; justify-content: center; font-size: 18px; color: white; font-weight: 700; }
        .member-name { font-size: 15px; font-weight: 700; color: #1a2b4a; }

        .equipment-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 14px; }
        .equipment-item { background: #f8f9ff; border: 1px solid #e3eaf5; border-radius: 12px; padding: 14px 16px; display: flex; align-items: center; gap: 12px; }
        .equipment-icon { font-size: 28px; }
        .equipment-name { font-size: 14px; font-weight: 700; color: #333; }
        .status-ok { background: #e8f5e9; color: #2e7d32; padding: 2px 10px; border-radius: 20px; font-size: 11px; display: inline-block; margin-top: 5px; }
        .status-bad { background: #ffebee; color: #c62828; padding: 2px 10px; border-radius: 20px; font-size: 11px; display: inline-block; margin-top: 5px; }

        .no-data { text-align: center; padding: 50px; color: #999; }
        .no-data-icon { font-size: 64px; margin-bottom: 16px; opacity: 0.5; }
        .alert-warning { background: #FFF8E1; border-left: 4px solid #f57f17; padding: 16px 20px; border-radius: 12px; margin-bottom: 24px; display: flex; gap: 12px; }

        .footer { background: #1565C0; color: rgba(255,255,255,0.85); text-align: center; padding: 20px; margin-top: 40px; }
    </style>
</head>
<body>

    <div class="header">
        <img src="${pageContext.request.contextPath}/resources/image/logo_ute.png" alt="Logo">
        <div>
            <div class="header-university">Đại học Đà Nẵng</div>
            <div class="header-school">Trường Đại học Sư phạm Kỹ thuật</div>
            <div class="header-system">Hệ thống Quản lý Ký túc xá</div>
        </div>
    </div>

    <div class="top-bar">
        <div class="top-bar-inner">
            <a href="${pageContext.request.contextPath}/baiviet/tin-tuc">📰 Tin tức</a>
            <a href="${pageContext.request.contextPath}/baiviet/thong-bao">🔔 Thông báo</a>
            <a href="${pageContext.request.contextPath}/baiviet/noi-quy">📋 Nội quy</a>
            <a href="${pageContext.request.contextPath}/logout" style="margin-left:auto; background:#e53935; padding:4px 14px; border-radius:6px;">🔓 Đăng xuất</a>
        </div>
    </div>

    <nav class="main-nav">
        <div class="nav-inner">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/sinhvien/profile">👤 Sinh viên</a>
            <a href="${pageContext.request.contextPath}/phong/phong-cua-toi" class="active">🏠 Phòng</a>
            <a href="${pageContext.request.contextPath}/hopdong/hopdong-cua-toi">📄 Hợp đồng</a>
            <a href="${pageContext.request.contextPath}/baotri/list">🔧 Bảo trì</a>
            <a href="${pageContext.request.contextPath}/danhgia/list">⭐ Đánh giá</a>
            <a href="${pageContext.request.contextPath}/thuvien/list">📚 Thư viện</a>
        </div>
    </nav>

    <div class="page-header">
        <div class="page-header-inner">
            <div class="page-icon">🏠</div>
            <div>
                <h1>Phòng của tôi</h1>
                <p>Xem thông tin phòng, thiết bị và bạn cùng phòng</p>
            </div>
        </div>
    </div>

    <div class="container">
        <c:choose>
            <c:when test="${empty phong}">
                <div class="card">
                    <div class="no-data">
                        <div class="no-data-icon">🏠</div>
                        <h3>Bạn chưa được phân phòng</h3>
                        <p>Vui lòng liên hệ ban quản lý KTX để được hỗ trợ</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- THÔNG TIN PHÒNG -->
                <div class="card">
                    <div class="card-title">🏠 Thông tin phòng</div>
                    <div class="card-body">
                        <div class="room-highlight">
                            <div class="room-name">${phong.tenPhong}</div>
                            <div class="room-building">🏢 Tòa ${phong.tenToaNha}</div>
                        </div>
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-label">Loại phòng</div>
                                <div class="info-value">${phong.tenLoaiPhong}</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Giá phòng / tháng</div>
                                <div class="info-value price"><fmt:formatNumber value="${phong.giaPhong}" type="number" groupingUsed="true"/> đ</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Sức chứa</div>
                                <div class="info-value">${phong.soNguoiHienTai} / ${phong.sucChua} người</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Trạng thái</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${phong.trangThai == 'Trống'}"><span class="status-badge status-trong">🟢 Trống</span></c:when>
                                        <c:when test="${phong.trangThai == 'Đầy'}"><span class="status-badge status-day">🔴 Đầy</span></c:when>
                                        <c:otherwise><span class="status-badge status-dang">🟡 ${phong.trangThai}</span></c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- THÀNH VIÊN -->
                <div class="card">
                    <div class="card-title">👥 Các thành viên trong phòng</div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty thanhVienList}">
                                <div class="no-data" style="padding: 30px;">👤 Hiện tại bạn đang ở một mình</div>
                            </c:when>
                            <c:otherwise>
                                <div class="member-list">
                                    <c:forEach var="tv" items="${thanhVienList}">
                                        <div class="member-item">
                                            <div class="member-avatar">${fn:substring(tv.hoTen, 0, 1)}</div>
                                            <div class="member-name">${tv.hoTen}</div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- THIẾT BỊ -->
                <div class="card">
                    <div class="card-title">🔧 Thiết bị trong phòng</div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty thietBiList}">
                                <div class="no-data" style="padding: 30px;">🔧 Chưa có thông tin thiết bị</div>
                            </c:when>
                            <c:otherwise>
                                <div class="equipment-grid">
                                    <c:forEach var="tb" items="${thietBiList}">
                                        <div class="equipment-item">
                                            <div class="equipment-icon">
                                                <c:choose>
                                                    <c:when test="${tb.tenThietBi == 'Điều hòa'}">❄️</c:when>
                                                    <c:when test="${tb.tenThietBi == 'Quạt trần'}">🌀</c:when>
                                                    <c:when test="${tb.tenThietBi == 'Giường'}">🛏️</c:when>
                                                    <c:when test="${tb.tenThietBi == 'Tủ'}">🗄️</c:when>
                                                    <c:otherwise>🔧</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <div class="equipment-name">${tb.tenThietBi}</div>
                                                <div>Số lượng: ${tb.soLuong}</div>
                                                <span class="${tb.tinhTrang == 'Bình thường' ? 'status-ok' : 'status-bad'}">${tb.tinhTrang}</span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="alert-warning">
                    <span>💡</span>
                    <span>Nếu có vấn đề về thiết bị, vui lòng gửi yêu cầu bảo trì tại mục <strong>🔧 Bảo trì</strong>.</span>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="footer">
        &copy; 2026 — <strong>Hệ thống Quản lý Ký túc xá</strong> — Trường Đại học Sư phạm Kỹ thuật Đà Nẵng
    </div>
</body>
</html>