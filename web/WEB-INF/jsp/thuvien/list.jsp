<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thư viện xã hội - KTX UTE</title>
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

        .page-header { background: linear-gradient(135deg, #1565C0, #42A5F5);
                       color: white; padding: 30px 0; text-align: center; }
        .page-header h1 { font-size: 28px; font-weight: 800; margin-bottom: 6px; }
        .page-header p { font-size: 14px; opacity: 0.9; }

        .wrap { max-width: 1200px; margin: 24px auto; padding: 0 20px;
                display: grid; grid-template-columns: 300px 1fr; gap: 24px; }

        .sidebar { display: flex; flex-direction: column; gap: 16px; }
        .filter-card { background: white; border-radius: 10px;
                       box-shadow: 0 2px 8px rgba(0,0,0,0.07); overflow: hidden; }
        .filter-title { background: #1565C0; color: white; padding: 11px 16px;
                        font-size: 13px; font-weight: 700; text-transform: uppercase; }
        .filter-links { padding: 8px 0; }
        .filter-link { display: block; padding: 9px 16px; font-size: 13px;
                       color: #333; text-decoration: none; border-bottom: 1px solid #f5f5f5;
                       transition: background 0.2s; }
        .filter-link:hover, .filter-link.active { background: #E3F2FD; color: #1565C0; font-weight: 600; }
        .filter-link:last-child { border-bottom: none; }

        .search-box { display: flex; gap: 8px; padding: 12px 16px; }
        .search-box input { flex: 1; padding: 8px 12px; border: 1.5px solid #ddd;
                            border-radius: 6px; font-size: 13px; outline: none; }
        .search-box input:focus { border-color: #1565C0; }
        .search-box button { padding: 8px 14px; background: #1565C0; color: white;
                             border: none; border-radius: 6px; cursor: pointer; font-size: 13px; }

        .books-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 18px; }
        .book-card { background: white; border-radius: 10px;
                     box-shadow: 0 2px 8px rgba(0,0,0,0.07);
                     overflow: hidden; transition: transform 0.2s, box-shadow 0.2s; }
        .book-card:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0,0,0,0.12); }

        .book-cover { height: 130px; display: flex; align-items: center;
                      justify-content: center; font-size: 60px; }
        .cover-lichsu    { background: linear-gradient(135deg, #5C6BC0, #9FA8DA); }
        .cover-kinhdoanh { background: linear-gradient(135deg, #26A69A, #80CBC4); }
        .cover-buochan   { background: linear-gradient(135deg, #FFA726, #FFCC80); }
        .cover-thuctap   { background: linear-gradient(135deg, #42A5F5, #90CAF9); }
        .cover-chiase    { background: linear-gradient(135deg, #EC407A, #F48FB1); }
        .cover-amnhac    { background: linear-gradient(135deg, #AB47BC, #CE93D8); }
        .cover-phim      { background: linear-gradient(135deg, #EF5350, #EF9A9A); }
        .cover-ai        { background: linear-gradient(135deg, #00ACC1, #80DEEA); }
        .cover-khoahoc   { background: linear-gradient(135deg, #66BB6A, #A5D6A7); }
        .cover-default   { background: linear-gradient(135deg, #1565C0, #42A5F5); }

        .book-info { padding: 14px; }
        .book-title { font-size: 14px; font-weight: 700; color: #1565C0;
                      margin-bottom: 4px; line-height: 1.4; }
        .book-author { font-size: 12px; color: #888; margin-bottom: 6px; }
        .book-tag { display: inline-block; background: #E3F2FD; color: #1565C0;
                    padding: 2px 8px; border-radius: 10px; font-size: 11px;
                    font-weight: 600; margin-bottom: 8px; }
        .book-desc { font-size: 12px; color: #666; line-height: 1.5; margin-bottom: 10px;
                     display: -webkit-box; -webkit-line-clamp: 2;
                     -webkit-box-orient: vertical; overflow: hidden; }
        .book-footer { display: flex; justify-content: space-between;
                       align-items: center; padding-top: 8px; border-top: 1px solid #f0f0f0; }
        .book-count { font-size: 12px; color: #666; }
        .book-count span { font-weight: 700; color: #2e7d32; }
        .badge-het { color: #c62828 !important; }
        .btn-muon { padding: 6px 14px; background: #1565C0; color: white;
                    border: none; border-radius: 6px; font-size: 12px;
                    cursor: pointer; transition: background 0.2s; }
        .btn-muon:hover { background: #0D47A1; }
        .btn-muon:disabled { background: #ccc; cursor: not-allowed; }

        .modal-overlay { display: none; position: fixed; inset: 0;
                         background: rgba(0,0,0,0.5); z-index: 100;
                         justify-content: center; align-items: center; }
        .modal-overlay.show { display: flex; }
        .modal-box { background: white; border-radius: 12px; width: 420px;
                     overflow: hidden; box-shadow: 0 20px 60px rgba(0,0,0,0.3);
                     animation: slideIn 0.3s ease; }
        @keyframes slideIn {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        .modal-title { background: #1565C0; color: white; padding: 16px 20px;
                       font-size: 15px; font-weight: 700; }
        .modal-body { padding: 20px; }
        .modal-sach-name { background: #E3F2FD; border-radius: 6px; padding: 10px 14px;
                           font-size: 14px; font-weight: 600; color: #1565C0; margin-bottom: 16px; }
        .form-group { margin-bottom: 14px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600;
                            color: #333; margin-bottom: 5px; }
        .form-group input { width: 100%; padding: 9px 12px; border: 1.5px solid #ddd;
                            border-radius: 6px; font-size: 13px; outline: none; }
        .form-group input:focus { border-color: #1565C0; }
        .note-muon { background: #FFF8E1; border: 1px solid #FFD54F; border-radius: 6px;
                     padding: 10px 14px; font-size: 12px; color: #5D4037; margin-bottom: 14px; }
        .modal-btns { display: flex; gap: 10px; }
        .btn-confirm { flex: 1; padding: 11px; background: #1565C0; color: white;
                       border: none; border-radius: 6px; font-size: 14px; font-weight: 700; cursor: pointer; }
        .btn-cancel { flex: 1; padding: 11px; background: #f0f4f8; color: #333;
                      border: 1px solid #ddd; border-radius: 6px; font-size: 14px; cursor: pointer; }

        .alert-success { background: #e8f5e9; border: 1px solid #a5d6a7; color: #2e7d32;
                         padding: 12px 16px; border-radius: 6px; margin-bottom: 16px;
                         font-size: 14px; text-align: center; }
        .alert-error { background: #ffebee; border: 1px solid #ef9a9a; color: #c62828;
                       padding: 12px 16px; border-radius: 6px; margin-bottom: 16px;
                       font-size: 14px; text-align: center; }

        .check-muon { background: white; border-radius: 10px; padding: 16px;
                      box-shadow: 0 2px 8px rgba(0,0,0,0.07); }
        .check-muon-title { font-size: 13px; font-weight: 700; color: #1565C0;
                            text-transform: uppercase; margin-bottom: 12px; }
        .check-muon-form { display: flex; gap: 8px; }
        .check-muon-form input { flex: 1; padding: 8px 12px; border: 1.5px solid #ddd;
                                 border-radius: 6px; font-size: 13px; outline: none; }
        .check-muon-form button { padding: 8px 14px; background: #2e7d32; color: white;
                                  border: none; border-radius: 6px; cursor: pointer;
                                  font-size: 13px; white-space: nowrap; }

        .site-footer { background: #1565C0; color: rgba(255,255,255,0.85);
                       text-align: center; padding: 14px; font-size: 13px; margin-top: 30px; }
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
            <a href="${pageContext.request.contextPath}/sinhvien/list">Sinh viên</a>
            <a href="${pageContext.request.contextPath}/phong/phong-cua-toi">Phòng</a>
            <a href="${pageContext.request.contextPath}/hopdong/list">Hợp đồng</a>
            <a href="${pageContext.request.contextPath}/baotri/list">Bảo trì</a>
            <a href="${pageContext.request.contextPath}/danhgia/list">⭐ Đánh giá</a>
            <a href="${pageContext.request.contextPath}/thuvien/list" class="active">📚 Thư viện</a>
        </div>
    </nav>

    <!-- PAGE HEADER -->
    <div class="page-header">
        <h1>📚 Thư viện xã hội - Thư viện số Ký Túc Xá UTE</h1>
        <p>Kho sách dùng chung — Đọc sách, mở rộng tri thức, kết nối cộng đồng</p>
    </div>

    <!-- CONTENT -->
    <div class="wrap">

        <!-- SIDEBAR -->
        <div class="sidebar">
            <div class="filter-card">
                <div class="filter-title">🔍 Tìm kiếm</div>
                <form action="${pageContext.request.contextPath}/thuvien/list" method="get">
                    <div class="search-box">
                        <input type="text" name="keyword" value="${keyword}" placeholder="Tên sách, tác giả..."/>
                        <button type="submit">🔍</button>
                    </div>
                </form>
            </div>

            <div class="filter-card">
                <div class="filter-title">📂 Thể loại</div>
                <div class="filter-links">
                    <a href="${pageContext.request.contextPath}/thuvien/list"
                       class="filter-link ${empty theLoaiChon ? 'active' : ''}">
                        📚 Tất cả sách
                    </a>
                    <c:forEach var="tl" items="${danhSachTheLoai}">
                        <a href="${pageContext.request.contextPath}/thuvien/list?theLoai=${tl}"
                           class="filter-link ${theLoaiChon == tl ? 'active' : ''}">
                            <c:choose>
    <c:when test="${fn:contains(fn:toLowerCase(tl), 'lịch sử') or fn:contains(fn:toLowerCase(tl), 'văn hóa')}">&#127963; </c:when>
    <c:when test="${fn:contains(fn:toLowerCase(tl), 'kinh doanh')}">&#128188; </c:when>
    <c:when test="${fn:contains(fn:toLowerCase(tl), 'bước chân')}">&#128095; </c:when>
    <c:when test="${fn:contains(fn:toLowerCase(tl), 'thực tập')}">&#127891; </c:when>
    <c:when test="${fn:contains(fn:toLowerCase(tl), 'chia sẻ')}">&#129309; </c:when>
    <c:when test="${fn:contains(fn:toLowerCase(tl), 'âm nhạc')}">&#127925; </c:when>
    <c:when test="${fn:contains(fn:toLowerCase(tl), 'phim')}">&#127916; </c:when>
    <c:when test="${fn:contains(fn:toLowerCase(tl), 'ai')}">&#129302; </c:when>
    <c:when test="${fn:contains(fn:toLowerCase(tl), 'khoa học')}">&#128300; </c:when>
    <c:otherwise>&#128214; </c:otherwise>
</c:choose>
                            ${tl}
                        </a>
                    </c:forEach>
                </div>
            </div>

            <div class="check-muon">
                <div class="check-muon-title">📋 Sách đang mượn</div>
                <form action="${pageContext.request.contextPath}/thuvien/dangmuon" method="get">
                    <div class="check-muon-form">
                        <input type="text" name="mssv" placeholder="Nhập MSSV..."/>
                        <button type="submit">Xem</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- DANH SÁCH SÁCH -->
        <div>
            <c:if test="${not empty success}">
                <div class="alert-success">✅ ${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert-error">⚠️ ${error}</div>
            </c:if>

            <div class="books-grid">
                <c:forEach var="sach" items="${danhSachSach}">

                    <%-- Xác định class màu và icon theo thể loại --%>
                    <c:set var="coverClass" value="cover-default"/>
                    <c:set var="coverIcon" value="📖"/>

                    <c:if test="${fn:contains(sach.theLoai, 'Lịch sử') or fn:contains(sach.theLoai, 'Văn hóa')}">
                        <c:set var="coverClass" value="cover-lichsu"/>
                        <c:set var="coverIcon" value="🏛️"/>
                    </c:if>
                    <c:if test="${fn:contains(sach.theLoai, 'inh doanh')}">
                        <c:set var="coverClass" value="cover-kinhdoanh"/>
                        <c:set var="coverIcon" value="💼"/>
                    </c:if>
                    <c:if test="${fn:contains(sach.theLoai, 'Bước chân')}">
                        <c:set var="coverClass" value="cover-buochan"/>
                        <c:set var="coverIcon" value="👟"/>
                    </c:if>
                    <c:if test="${fn:contains(sach.theLoai, 'Thực tập')}">
                        <c:set var="coverClass" value="cover-thuctap"/>
                        <c:set var="coverIcon" value="🎓"/>
                    </c:if>
                    <c:if test="${fn:contains(sach.theLoai, 'Chia sẻ') or fn:contains(sach.theLoai, 'Cộng hưởng')}">
                        <c:set var="coverClass" value="cover-chiase"/>
                        <c:set var="coverIcon" value="🤝"/>
                    </c:if>
                    <c:if test="${fn:contains(sach.theLoai, 'Âm nhạc')}">
                        <c:set var="coverClass" value="cover-amnhac"/>
                        <c:set var="coverIcon" value="🎵"/>
                    </c:if>
                    <c:if test="${fn:contains(sach.theLoai, 'Phim')}">
                        <c:set var="coverClass" value="cover-phim"/>
                        <c:set var="coverIcon" value="🎬"/>
                    </c:if>
                    <c:if test="${fn:contains(sach.theLoai, 'AI')}">
                        <c:set var="coverClass" value="cover-ai"/>
                        <c:set var="coverIcon" value="🤖"/>
                    </c:if>
                    <c:if test="${fn:contains(sach.theLoai, 'Khoa học') or fn:contains(sach.theLoai, 'Kỹ thuật')}">
                        <c:set var="coverClass" value="cover-khoahoc"/>
                        <c:set var="coverIcon" value="🔬"/>
                    </c:if>

                    <div class="book-card">
                        <div class="book-cover ${coverClass}">
                            ${coverIcon}
                        </div>
                        <div class="book-info">
                            <div class="book-title">${sach.tenSach}</div>
                            <div class="book-author">✍️ ${sach.tacGia} • ${sach.namXuatBan}</div>
                            <span class="book-tag">${sach.theLoai}</span>
                            <div class="book-desc">${sach.moTa}</div>
                            <div class="book-footer">
                                <div class="book-count">
                                    Còn: <span class="${sach.soLuongConLai <= 0 ? 'badge-het' : ''}">
                                        ${sach.soLuongConLai}/${sach.soLuong}
                                    </span>
                                </div>
                                <button class="btn-muon"
                                        onclick="openMuon(${sach.idSach}, '${sach.tenSach}')"
                                        ${sach.soLuongConLai <= 0 ? 'disabled' : ''}>
                                    ${sach.soLuongConLai <= 0 ? 'Hết sách' : '📖 Mượn'}
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- MODAL MƯỢN SÁCH -->
    <div class="modal-overlay" id="modal-muon">
        <div class="modal-box">
            <div class="modal-title">📖 Đăng ký mượn sách</div>
            <div class="modal-body">
                <div class="modal-sach-name" id="modal-ten-sach"></div>
                <div class="note-muon">
                    📌 Sau khi đăng ký, đến <strong>phòng quản lý KTX</strong> để nhận sách.
                    Hạn trả sách: <strong>14 ngày</strong>.
                </div>
                <form action="${pageContext.request.contextPath}/thuvien/muon" method="post">
                    <input type="hidden" name="idSach" id="input-id-sach"/>
                    <div class="form-group">
                        <label>MSSV *</label>
                        <input type="text" name="mssv" placeholder="SV001" required/>
                    </div>
                    <div class="form-group">
                        <label>Họ và tên *</label>
                        <input type="text" name="hoTen" placeholder="Nguyễn Văn A" required/>
                    </div>
                    <div class="modal-btns">
                        <button type="submit" class="btn-confirm">✅ Xác nhận mượn</button>
                        <button type="button" class="btn-cancel" onclick="closeModal()">❌ Hủy</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <div class="site-footer">
        &copy; 2026 &mdash; <strong>Hệ thống Quản lý Ký túc xá</strong>
        &mdash; Trường Đại học Sư phạm Kỹ thuật Đà Nẵng
    </div>

    <script>
        function openMuon(idSach, tenSach) {
            document.getElementById('input-id-sach').value = idSach;
            document.getElementById('modal-ten-sach').textContent = '📚 ' + tenSach;
            document.getElementById('modal-muon').classList.add('show');
        }
        function closeModal() {
            document.getElementById('modal-muon').classList.remove('show');
        }
    </script>

</body>
</html>