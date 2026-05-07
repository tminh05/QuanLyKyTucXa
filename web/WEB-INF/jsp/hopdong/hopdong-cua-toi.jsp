<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hợp đồng của tôi - KTX UTE</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f0f4f8; }

        .header { background: white; border-bottom: 3px solid #1565C0; padding: 12px 30px;
                  display: flex; align-items: center; gap: 15px;
                  box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .header img { height: 65px; }
        .header-university { font-size: 13px; color: #1565C0; font-weight: 600; text-transform: uppercase; }
        .header-school { font-size: 20px; font-weight: 800; color: #1565C0; text-transform: uppercase; }
        .header-system { font-size: 15px; font-weight: 700; color: #e53935; text-transform: uppercase; }

        .main-nav { background: #1976D2; }
        .nav-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; }
        .main-nav a { color: white; text-decoration: none; padding: 12px 22px; font-size: 16px;
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
        .page-header p { font-size: 14px; opacity: 0.85; margin-top: 3px; }

        .wrap { max-width: 1000px; margin: 24px auto; padding: 0 20px 40px; }

        .card { background: white; border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.07); overflow: hidden;
                margin-bottom: 20px; }
        .card-title { background: #1565C0; color: white; padding: 12px 18px;
                      font-size: 14px; font-weight: 700; text-transform: uppercase;
                      display: flex; align-items: center; gap: 8px; }
        .card-body { padding: 20px; }

        /* HỢP ĐỒNG CARD */
        .hopdong-card { background: white; border: 1px solid #e3eaf5; border-radius: 10px;
                        overflow: hidden; margin-bottom: 16px;
                        box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
        .hopdong-card:last-child { margin-bottom: 0; }

        .hopdong-header { background: #f8f9ff; padding: 14px 18px;
                          border-bottom: 1px solid #e3eaf5;
                          display: flex; justify-content: space-between; align-items: center; }
        .hopdong-id { font-size: 13px; color: #888; }
        .hopdong-room { font-size: 18px; font-weight: 800; color: #1565C0; }

        .hopdong-body { padding: 18px; }

        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 0;
                     border: 1px solid #e8eaf0; border-radius: 8px; overflow: hidden; }

        .info-cell { padding: 10px 14px; border-right: 1px solid #e8eaf0;
                     border-bottom: 1px solid #e8eaf0; }
        .info-cell:nth-child(2n) { border-right: none; }
        .info-cell:nth-last-child(-n+2) { border-bottom: none; }
        .info-cell-label { font-size: 13px; color: #aaa; text-transform: uppercase;
                           letter-spacing: 0.5px; margin-bottom: 5px; }
        .info-cell-value { font-size: 14px; color: #333; font-weight: 600; }
        .info-cell-value.blue { color: #1565C0; }
        .info-cell-value.red { color: #e53935; }

        /* TIMELINE TRẠNG THÁI */
        .status-timeline { display: flex; align-items: center; gap: 8px;
                           padding: 14px 18px; background: #f8f9ff;
                           border-top: 1px solid #e3eaf5; flex-wrap: wrap; }
        .timeline-label { font-size: 12px; color: #888; font-weight: 500; }
        .timeline-bar { flex: 1; height: 6px; background: #e3eaf5;
                        border-radius: 3px; min-width: 100px; overflow: hidden; }
        .timeline-fill { height: 100%; border-radius: 3px; background: #1565C0; }

        /* BADGES */
        .badge-hieuluc { background: #e8f5e9; color: #2e7d32; padding: 4px 12px;
                         border-radius: 12px; font-size: 12px; font-weight: 700; }
        .badge-hethan  { background: #ffebee; color: #c62828; padding: 4px 12px;
                         border-radius: 12px; font-size: 12px; font-weight: 700; }
        .badge-saphet  { background: #FFF8E1; color: #f57f17; padding: 4px 12px;
                         border-radius: 12px; font-size: 12px; font-weight: 700; }

        /* CẢNH BÁO SẮP HẾT HẠN */
        .warning-box { background: #FFF8E1; border: 1px solid #FFD54F;
                       border-radius: 8px; padding: 12px 16px; margin-bottom: 16px;
                       font-size: 13px; color: #5D4037;
                       display: flex; align-items: center; gap: 10px; }

        /* KHÔNG CÓ HỢP ĐỒNG */
        .no-data { text-align: center; padding: 60px 20px; }
        .no-data-icon { font-size: 64px; margin-bottom: 16px; }
        .no-data h3 { font-size: 18px; color: #555; margin-bottom: 8px; }
        .no-data p  { font-size: 13px; color: #aaa; line-height: 1.6; }

        .site-footer { background: #1565C0; color: rgba(255,255,255,0.85);
                       text-align: center; padding: 14px; font-size: 13px; }
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
            <a href="${pageContext.request.contextPath}/phong/phong-cua-toi">🏠 Phòng</a>
            <a href="${pageContext.request.contextPath}/hopdong/hopdong-cua-toi" class="active">📄 Hợp đồng</a>
            <a href="${pageContext.request.contextPath}/baotri/baotri-cua-toi">🔧 Bảo trì</a>
            <a href="${pageContext.request.contextPath}/danhgia/list">⭐ Đánh giá</a>
            <a href="${pageContext.request.contextPath}/thuvien/list">📚 Thư viện</a>
        </div>
    </nav>

    <!-- PAGE HEADER -->
    <div class="page-header">
        <div class="page-header-inner">
            <div class="page-icon">📄</div>
            <div>
                <h1>Hợp đồng của tôi</h1>
                <p>Xem thông tin hợp đồng thuê phòng ký túc xá của bạn</p>
            </div>
        </div>
    </div>

    <div class="wrap">
        <c:choose>
            <c:when test="${empty hopDongList}">
                <!-- CHƯA CÓ HỢP ĐỒNG -->
                <div class="card">
                    <div class="no-data">
                        <div class="no-data-icon">📄</div>
                        <h3>Bạn chưa có hợp đồng nào</h3>
                        <p>Vui lòng liên hệ ban quản lý KTX để được hỗ trợ<br>
                           Hotline: 0236.xxx.xxx &nbsp;|&nbsp; Email: ktx@ute.udn.vn</p>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <c:forEach var="hd" items="${hopDongList}">
                    <div class="hopdong-card">

                        <!-- HEADER HỢP ĐỒNG -->
                        <div class="hopdong-header">
                            <div>
                                <div class="hopdong-id">Mã hợp đồng #${hd.idHopDong}</div>
                                <div class="hopdong-room">🏠 Phòng ${hd.tenPhong}</div>
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${hd.trangThai == 'Hiệu lực'}">
                                        <span class="badge-hieuluc">✅ Đang hiệu lực</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-hethan">❌ ${hd.trangThai}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- CHI TIẾT HỢP ĐỒNG -->
                        <div class="hopdong-body">
    <div class="info-grid">
        <div class="info-cell">
            <div class="info-cell-label">Sinh viên</div>
            <div class="info-cell-value blue">${hd.hoTenSinhVien}</div>
        </div>
        <div class="info-cell">
            <div class="info-cell-label">MSSV</div>
            <div class="info-cell-value">${hd.mssv}</div>
        </div>
        <div class="info-cell">
            <div class="info-cell-label">Phòng</div>
            <div class="info-cell-value blue">${hd.tenPhong}</div>
        </div>
        <div class="info-cell">
            <div class="info-cell-label">Trạng thái</div>
            <div class="info-cell-value">
                <span class="${hd.trangThai == 'Hiệu lực' ? 'badge-hieuluc' : 'badge-hethan'}">${hd.trangThai}</span>
            </div>
        </div>
        <div class="info-cell">
            <div class="info-cell-label">Ngày bắt đầu</div>
            <div class="info-cell-value">📅 <fmt:formatDate value="${hd.ngayBatDau}" pattern="dd/MM/yyyy"/></div>
        </div>
        <div class="info-cell">
            <div class="info-cell-label">Ngày kết thúc</div>
            <div class="info-cell-value red">📅 <fmt:formatDate value="${hd.ngayKetThuc}" pattern="dd/MM/yyyy"/></div>
        </div>
    </div>

    <div style="margin-top: 15px; display: flex; justify-content: flex-end;">
        <a href="${pageContext.request.contextPath}/hoadon/danh-sach?idPhong=${hd.idPhong}" 
           style="background: #2e7d32; color: white; padding: 10px 18px; border-radius: 6px; 
                  text-decoration: none; font-size: 13px; font-weight: 700; display: flex; 
                  align-items: center; gap: 8px; transition: 0.3s; box-shadow: 0 3px 6px rgba(46,125,50,0.2);">
            <span>📑 XEM HÓA ĐƠN PHÒNG</span>
        </a>
    </div>
</div>

                        <!-- TIMELINE -->
                        <div class="status-timeline">
                            <span class="timeline-label">
                                <fmt:formatDate value="${hd.ngayBatDau}" pattern="dd/MM/yyyy"/>
                            </span>
                            <div class="timeline-bar">
                                <div class="timeline-fill"
                                     style="width: ${hd.trangThai == 'Hiệu lực' ? '60' : '100'}%;">
                                </div>
                            </div>
                            <span class="timeline-label">
                                <fmt:formatDate value="${hd.ngayKetThuc}" pattern="dd/MM/yyyy"/>
                            </span>
                        </div>

                    </div>
                </c:forEach>

                <!-- LƯU Ý -->
                <div class="warning-box">
                    ⚠️ <span>Nếu cần gia hạn hoặc có thắc mắc về hợp đồng, vui lòng liên hệ
                    ban quản lý KTX. <strong>Hotline: 0236.xxx.xxx</strong></span>
                </div>

            </c:otherwise>
        </c:choose>
    </div>

    <!-- FOOTER -->
    <div class="site-footer">
        &copy; 2026 &mdash; <strong>Hệ thống Quản lý Ký túc xá</strong>
        &mdash; Trường Đại học Sư phạm Kỹ thuật Đà Nẵng
    </div>

</body>
</html>
