<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Phòng của tôi - KTX UTE</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f0f4f8; }

        .header { background: white; border-bottom: 3px solid #1565C0; padding: 12px 30px;
                  display: flex; align-items: center; gap: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .header img { height: 65px; }
        .header-university { font-size: 13px; color: #1565C0; font-weight: 600; text-transform: uppercase; }
        .header-school { font-size: 20px; font-weight: 800; color: #1565C0; text-transform: uppercase; }
        .header-system { font-size: 15px; font-weight: 700; color: #e53935; text-transform: uppercase; }

        .main-nav { background: #1976D2; }
        .nav-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; }
        .main-nav a { color: white; text-decoration: none; padding: 12px 22px; font-size: 15px;
                      font-weight: 500; display: block; transition: background 0.2s;
                      border-right: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:first-child { border-left: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:hover, .main-nav a.active { background: #0D47A1; }

        .page-header { background: #1565C0; color: white; padding: 24px 0; }
        .page-header-inner { max-width: 1000px; margin: 0 auto; padding: 0 20px;
                             display: flex; align-items: center; gap: 16px; }
        .page-icon { width: 56px; height: 56px; background: rgba(255,255,255,0.2);
                     border-radius: 50%; display: flex; align-items: center;
                     justify-content: center; font-size: 26px;
                     border: 2px solid rgba(255,255,255,0.5); }
        .page-header h1 { font-size: 22px; font-weight: 800; }
        .page-header p  { font-size: 13px; opacity: 0.85; margin-top: 3px; }

        .wrap { max-width: 1000px; margin: 24px auto; padding: 0 20px;
                display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .wrap-full { max-width: 1000px; margin: 0 auto; padding: 0 20px 24px; }

        .card { background: white; border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.07); overflow: hidden; }
        .card-title { background: #1565C0; color: white; padding: 12px 18px;
                      font-size: 14px; font-weight: 700; text-transform: uppercase;
                      display: flex; align-items: center; gap: 8px; }
        .card-body { padding: 18px; }

        /* THÔNG TIN PHÒNG */
        .room-highlight { background: #f8f9ff; border: 1px solid #e3eaf5;
                          border-radius: 8px; padding: 16px; margin-bottom: 16px;
                          text-align: center; }
        .room-name     { font-size: 32px; font-weight: 800; color: #1565C0; }
        .room-building { font-size: 14px; color: #888; margin-top: 4px; }

        .info-row { display: flex; justify-content: space-between; align-items: center;
                    padding: 10px 0; border-bottom: 1px solid #f5f5f5; font-size: 13px; }
        .info-row:last-child { border-bottom: none; }
        .info-label { color: #888; font-weight: 500; }
        .info-value { color: #333; font-weight: 600; }
        .info-value.price { color: #e53935; }

        .progress-bar { height: 8px; background: #e3eaf5; border-radius: 4px;
                        overflow: hidden; margin-top: 4px; }
        .progress-fill { height: 100%; border-radius: 4px; transition: width 0.3s; }

        .badge-trong { background: #e8f5e9; color: #2e7d32; padding: 3px 10px;
                       border-radius: 12px; font-size: 12px; font-weight: 700; }
        .badge-day   { background: #ffebee; color: #c62828; padding: 3px 10px;
                       border-radius: 12px; font-size: 12px; font-weight: 700; }
        .badge-dangO { background: #E3F2FD; color: #1565C0; padding: 3px 10px;
                       border-radius: 12px; font-size: 12px; font-weight: 700; }

        /* THÀNH VIÊN */
        .member-list { display: flex; flex-direction: column; gap: 8px; }
        .member-item { display: flex; align-items: center; gap: 12px;
                       padding: 10px 12px; background: #f8f9ff;
                       border: 1px solid #e3eaf5; border-radius: 8px; }
        .member-avatar { width: 38px; height: 38px; border-radius: 50%;
                         background: #1565C0; display: flex; align-items: center;
                         justify-content: center; font-size: 15px; color: white;
                         font-weight: 700; flex-shrink: 0; }
        .member-name { font-size: 13px; font-weight: 600; color: #333; }
        .member-info { font-size: 12px; color: #888; margin-top: 2px; }

        /* THIẾT BỊ */
        .thietbi-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
        .thietbi-item { background: #f8f9ff; border: 1px solid #e3eaf5;
                        border-radius: 8px; padding: 12px 14px;
                        display: flex; align-items: center; gap: 10px; }
        .thietbi-icon { font-size: 24px; flex-shrink: 0; }
        .thietbi-name { font-size: 13px; font-weight: 600; color: #333; }
        .thietbi-sl   { font-size: 12px; color: #888; margin-top: 2px; }
        .thietbi-status { font-size: 11px; padding: 2px 8px; border-radius: 10px;
                          font-weight: 600; margin-top: 4px; display: inline-block; }
        .status-ok   { background: #e8f5e9; color: #2e7d32; }
        .status-bad  { background: #ffebee; color: #c62828; }
        .status-warn { background: #FFF8E1; color: #f57f17; }

        /* KHÔNG CÓ PHÒNG */
        .no-room { text-align: center; padding: 60px 20px; }
        .no-room-icon { font-size: 64px; margin-bottom: 16px; }
        .no-room h3 { font-size: 18px; color: #555; margin-bottom: 8px; }
        .no-room p  { font-size: 13px; color: #aaa; line-height: 1.6; }

        .site-footer { background: #1565C0; color: rgba(255,255,255,0.85);
                       text-align: center; padding: 14px; font-size: 13px; margin-top: 10px; }
        .site-footer strong { color: white; }
    </style>
</head>
<body>

    <!-- HEADER -->
    <div class="header">
        <img src="${pageContext.request.contextPath}/resources/image/logo_ute.png" alt="Logo">
        <div>
            <div class="header-university">Đại học Đà Nẵng</div>
            <div class="header-school">Trường Đại học Sư phạm Kỹ thuật</div>
            <div class="header-system">Hệ thống Quản lý Ký túc xá</div>
        </div>
    </div>

    <!-- NAV -->
    <nav class="main-nav">
        <div class="nav-inner">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/sinhvien/profile">👤 Sinh viên</a>
            <a href="${pageContext.request.contextPath}/phong/phong-cua-toi" class="active">🏠 Phòng</a>
            <a href="${pageContext.request.contextPath}/hopdong/hopdong-cua-toi">📄 Hợp đồng</a>
            <a href="${pageContext.request.contextPath}/baotri/baotri-cua-toi">🔧 Bảo trì</a>
            <a href="${pageContext.request.contextPath}/danhgia/list">⭐ Đánh giá</a>
            <a href="${pageContext.request.contextPath}/thuvien/list">📚 Thư viện</a>
        </div>
    </nav>

    <!-- PAGE HEADER -->
    <div class="page-header">
        <div class="page-header-inner">
            <div class="page-icon">🏠</div>
            <div>
                <h1>Thông tin phòng của tôi</h1>
                <p>Xem chi tiết phòng, thiết bị và thành viên cùng phòng</p>
            </div>
        </div>
    </div>

    <c:choose>
        <c:when test="${empty phong}">
            <!-- CHƯA CÓ PHÒNG -->
            <div style="max-width:1000px; margin:40px auto; padding:0 20px;">
                <div class="card">
                    <div class="no-room">
                        <div class="no-room-icon">🏠</div>
                        <h3>Bạn chưa được phân phòng</h3>
                        <p>Vui lòng liên hệ ban quản lý KTX để được hỗ trợ<br>
                           Hotline: 0236.xxx.xxx &nbsp;|&nbsp; Email: ktx@ute.udn.vn</p>
                    </div>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <!-- CÓ PHÒNG -->
            <div class="wrap">

                <!-- THÔNG TIN PHÒNG -->
                <div class="card">
                    <div class="card-title">🏠 Thông tin phòng</div>
                    <div class="card-body">

                        <div class="room-highlight">
                            <div class="room-name">${phong.tenPhong}</div>
                            <div class="room-building">🏢 ${phong.tenToaNha}</div>
                        </div>

                        <div class="info-row">
                            <span class="info-label">Loại phòng</span>
                            <span class="info-value">${phong.tenLoaiPhong}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Giá phòng</span>
                            <span class="info-value price">
                                <fmt:formatNumber value="${phong.giaPhong}"
                                    type="number" groupingUsed="true"/> đ/tháng
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Sức chứa</span>
                            <span class="info-value">
                                ${phong.soNguoiHienTai} / ${phong.sucChua} người
                            </span>
                        </div>
                        <div style="padding: 4px 0 10px;">
                            <div class="progress-bar">
                                <div class="progress-fill"
                                     style="width: ${phong.soNguoiHienTai * 100 / phong.sucChua}%;
                                            background: ${phong.soNguoiHienTai >= phong.sucChua ?
                                                '#c62828' : '#1565C0'};">
                                </div>
                            </div>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Trạng thái</span>
                            <span>
                                <c:choose>
                                    <c:when test="${phong.trangThai == 'Trống'}">
                                        <span class="badge-trong">Trống</span>
                                    </c:when>
                                    <c:when test="${phong.trangThai == 'Đầy'}">
                                        <span class="badge-day">Đầy</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-dangO">${phong.trangThai}</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>

                    </div>
                </div>

                <!-- THÀNH VIÊN CÙNG PHÒNG -->
                <div class="card">
                    <div class="card-title">👥 Thành viên cùng phòng</div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty thanhVienList}">
                                <div style="text-align:center; padding:30px; color:#aaa; font-size:14px;">
                                    📭 Chưa có thành viên nào
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="member-list">
                                    <c:forEach var="tv" items="${thanhVienList}">
                                        <div class="member-item">
                                            <div class="member-avatar">
                                                ${tv.hoTen[0]}
                                            </div>
                                            <div>
                                                <div class="member-name">${tv.hoTen}</div>
                                                <div class="member-info">
                                                    🎂 <fmt:formatDate value="${tv.ngaySinh}"
                                                        pattern="dd/MM/yyyy"/>
                                                    &nbsp;•&nbsp;
                                                    <c:choose>
                                                        <c:when test="${tv.gioiTinh == 'Nam'}">👦</c:when>
                                                        <c:otherwise>👧</c:otherwise>
                                                    </c:choose>
                                                    ${tv.gioiTinh}
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

            </div>

            <!-- THIẾT BỊ TRONG PHÒNG -->
            <div class="wrap-full">
                <div class="card">
                    <div class="card-title">🔧 Thiết bị trong phòng</div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty thietBiList}">
                                <div style="text-align:center; padding:30px; color:#aaa; font-size:14px;">
                                    📭 Chưa có thông tin thiết bị
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="thietbi-grid">
                                    <c:forEach var="tb" items="${thietBiList}">
                                        <div class="thietbi-item">
                                            <div class="thietbi-icon">
                                                <c:choose>
                                                    <c:when test="${tb.tenThietBi == 'Điều hòa'}">❄️</c:when>
                                                    <c:when test="${tb.tenThietBi == 'Quạt trần'}">🌀</c:when>
                                                    <c:when test="${tb.tenThietBi == 'Giường'}">🛏️</c:when>
                                                    <c:when test="${tb.tenThietBi == 'Tủ'}">🗄️</c:when>
                                                    <c:when test="${tb.tenThietBi == 'Bàn học'}">🪑</c:when>
                                                    <c:when test="${tb.tenThietBi == 'Đèn'}">💡</c:when>
                                                    <c:otherwise>🔧</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <div class="thietbi-name">${tb.tenThietBi}</div>
                                                <div class="thietbi-sl">
                                                    Số lượng: <strong>${tb.soLuong}</strong>
                                                </div>
                                                <span class="thietbi-status
                                                    ${tb.tinhTrang == 'Bình thường' ? 'status-ok' :
                                                      tb.tinhTrang == 'Hỏng' ? 'status-bad' : 'status-warn'}">
                                                    ${tb.tinhTrang}
                                                </span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

        </c:otherwise>
    </c:choose>

    <!-- FOOTER -->
    <div class="site-footer">
        &copy; 2026 &mdash; <strong>Hệ thống Quản lý Ký túc xá</strong>
        &mdash; Trường Đại học Sư phạm Kỹ thuật Đà Nẵng
    </div>

</body>
</html>