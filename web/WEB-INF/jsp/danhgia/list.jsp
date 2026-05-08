<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đánh giá - KTX UTE</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }

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

        .page-wrap { max-width: 1000px; margin: 28px auto; padding: 0 20px;
                     display: grid; grid-template-columns: 1fr 340px; gap: 24px; }

        /* STATS */
        .stats-bar { max-width: 1000px; margin: 20px auto 0; padding: 0 20px;
                     display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; }
        .stat-card { background: #FFF2DE; border-radius: 8px; padding: 16px 20px;
                     box-shadow: 0 2px 8px rgba(0,0,0,0.07); text-align: center; }
        .stat-card .num { font-size: 32px; font-weight: 800; color: #1565C0; }
        .stat-card .lbl { font-size: 13px; color: #888; margin-top: 4px; }
        .stars-display { color: #FFC107; font-size: 22px; }

        /* FORM GỬI ĐÁNH GIÁ */
        .form-card { background: #FFFFF0; border-radius: 10px;
                     box-shadow: 0 2px 10px rgba(0,0,0,0.07); overflow: hidden; }
        .card-title { background: #1565C0; color: white; padding: 12px 18px;
                      font-size: 14px; font-weight: 700; text-transform: uppercase; }
        .form-body { padding: 18px; }
        .form-group { margin-bottom: 14px; }
        .form-group label { display: block; font-size: 12px; font-weight: 600;
                            color: #555; margin-bottom: 5px; }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%; padding: 9px 12px; border: 1.5px solid #ddd;
            border-radius: 6px; font-size: 13px; outline: none; font-family: inherit;
            transition: border-color 0.2s; background: white; }
        .form-group input:focus, .form-group textarea:focus,
        .form-group select:focus { border-color: #1565C0; }
        .form-group textarea { height: 90px; resize: vertical; }

        /* CHỌN SAO */
        .star-select { display: flex; gap: 6px; flex-direction: row-reverse;
                       justify-content: flex-end; }
        .star-select input { display: none; }
        .star-select label { font-size: 28px; color: #ddd; cursor: pointer;
                             transition: color 0.2s; }
        .star-select label:hover,
        .star-select label:hover ~ label,
        .star-select input:checked ~ label { color: #FFC107; }

        .btn-submit { width: 100%; padding: 11px; background: #1565C0; color: white;
                      border: none; border-radius: 6px; font-size: 14px; font-weight: 700;
                      cursor: pointer; transition: background 0.2s; }
        .btn-submit:hover { background: #0D47A1; }

        /* DANH SÁCH ĐÁNH GIÁ */
        .reviews-list { display: flex; flex-direction: column; gap: 14px; }
        .review-card { background: white; border-radius: 10px; padding: 16px 18px;
                       box-shadow: 0 2px 8px rgba(0,0,0,0.07); }
        .review-top { display: flex; justify-content: space-between;
                      align-items: flex-start; margin-bottom: 8px; }
        .reviewer-name { font-weight: 700; font-size: 14px; color: #1565C0; }
        .review-date { font-size: 12px; color: #aaa; }
        .review-stars { color: #FFC107; font-size: 16px; margin-bottom: 6px; }
        .review-tag { display: inline-block; background: #E3F2FD; color: #1565C0;
                      padding: 2px 10px; border-radius: 12px; font-size: 11px;
                      font-weight: 600; margin-bottom: 8px; }
        .review-content { font-size: 13px; color: #444; line-height: 1.6;
                          margin-bottom: 10px; }
        .review-actions { display: flex; gap: 10px; }
        .btn-like { background: none; border: 1.5px solid #ddd; border-radius: 20px;
                    padding: 4px 14px; font-size: 12px; cursor: pointer;
                    color: #555; transition: all 0.2s; display: flex;
                    align-items: center; gap: 5px; }
        .btn-like:hover { background: #E3F2FD; border-color: #1565C0; color: #1565C0; }

        .empty-msg { text-align: center; padding: 40px; color: #aaa;
                     background: white; border-radius: 10px; font-size: 14px; }

        .site-footer { background: #1565C0; color: rgba(255,255,255,0.85);
                       text-align: center; padding: 14px; font-size: 13px; margin-top: 30px; }
        .site-footer strong { color: white; }
    </style>
</head>
<body>

    <!-- HEADER -->
    <div class="header">
        <img src="${pageContext.request.contextPath}/resources/image/logo_ute.png" alt="Logo UTE">
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
            <a href="${pageContext.request.contextPath}/danhgia/list" class="active">Đánh giá</a>
            <a href="${pageContext.request.contextPath}/thuvien/list">Thư viện</a>
        </div>
    </nav>

    <!-- STATS -->
    <div class="stats-bar">
        <div class="stat-card">
            <div class="num">${tongDanhGia}</div>
            <div class="lbl">Tổng đánh giá</div>
        </div>
        <div class="stat-card">
            <div class="num" style="color:#FFC107">
                <fmt:formatNumber value="${diemTrungBinh}" maxFractionDigits="1"/>
                <span style="font-size:18px">/5</span>
            </div>
            <div class="lbl">Điểm trung bình</div>
        </div>
        <div class="stat-card">
            <div class="stars-display">
                <c:forEach begin="1" end="5" var="i">
                    <c:choose>
                        <c:when test="${i <= diemTrungBinh}">⭐</c:when>
                        <c:otherwise>☆</c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
            <div class="lbl">Xếp hạng KTX</div>
        </div>
    </div>

    <!-- CONTENT -->
    <div class="page-wrap">

        <!-- DANH SÁCH ĐÁNH GIÁ -->
        <div class="reviews-list">
            <c:choose>
                <c:when test="${empty danhSachDanhGia}">
                    <div class="empty-msg">
                        💬 Chưa có đánh giá nào. Hãy là người đầu tiên đánh giá!
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="dg" items="${danhSachDanhGia}">
                        <div class="review-card">
                            <div class="review-top">
                                <div>
                                    <div class="reviewer-name">👤 ${dg.hoTen}
                                        <span style="font-weight:400; color:#888; font-size:12px">
                                            (${dg.mssv})
                                        </span>
                                    </div>
                                    <div class="review-stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= dg.soSao}">⭐</c:when>
                                                <c:otherwise>☆</c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="review-date">
                                    <fmt:formatDate value="${dg.ngayDang}" pattern="dd/MM/yyyy HH:mm"/>
                                </div>
                            </div>
                            <c:if test="${not empty dg.tag}">
                                <span class="review-tag">🏷️ ${dg.tag}</span>
                            </c:if>
                            <div class="review-content">${dg.noiDung}</div>
                            <div class="review-actions">
                                <form action="${pageContext.request.contextPath}/danhgia/like/${dg.idDanhGia}"
                                      method="post" style="margin:0">
                                    <button type="submit" class="btn-like">
                                        👍 Hữu ích (${dg.soLike})
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- FORM GỬI ĐÁNH GIÁ -->
        <div>
            <div class="form-card">
                <div class="card-title">✍️ Viết đánh giá của bạn</div>
                <div class="form-body">
                    <form action="${pageContext.request.contextPath}/danhgia/add" method="post">

                        <div class="form-group">
                            <label>MSSV *</label>
                            <input type="text" name="mssv" placeholder="SV001" required/>
                        </div>

                        <div class="form-group">
                            <label>Tên hiển thị *</label>
                            <input type="text" name="hoTen" placeholder="Nguyễn Văn A hoặc tên bất kỳ" required/>
                            <div style="font-size:11px; 
                                 color:#888; 
                                 margin-top:4px; 
                                 font-style:italic;">
                            💡 Bạn có thể nhập tên bất kỳ để ẩn danh. Ví dụ: "Sinh viên K18", "Ẩn danh"...
                            </div>
                        </div>
                        
                        <button type="button" onclick="anDanh()" 
                            style="margin-top:6px; 
                            padding:5px 12px; 
                            background:#f0f4f8;
                            border:1px solid #ddd; 
                            border-radius:4px; 
                            font-size:12px;
                            cursor:pointer; 
                            color:#555;">
                            🙈 Dùng tên ẩn danh
                        </button>

                        <div class="form-group">
                            <label>Đánh giá sao *</label>
                            <div class="star-select">
                                <input type="radio" name="soSao" id="s5" value="5" required/>
                                <label for="s5">★</label>
                                <input type="radio" name="soSao" id="s4" value="4"/>
                                <label for="s4">★</label>
                                <input type="radio" name="soSao" id="s3" value="3"/>
                                <label for="s3">★</label>
                                <input type="radio" name="soSao" id="s2" value="2"/>
                                <label for="s2">★</label>
                                <input type="radio" name="soSao" id="s1" value="1"/>
                                <label for="s1">★</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Chủ đề (Tag)</label>
                            <select name="tag">
                                <option value="">-- Chọn chủ đề --</option>
                                <option value="Phòng ốc">🏠 Phòng ốc</option>
                                <option value="Vệ sinh">🧹 Vệ sinh</option>
                                <option value="Bảo vệ">🔐 Bảo vệ</option>
                                <option value="Căng tin">🍽️ Căng tin</option>
                                <option value="Wi-Fi">📶 Wi-Fi</option>
                                <option value="Nhân viên">👨‍💼 Nhân viên</option>
                                <option value="Cơ sở vật chất">🏢 Cơ sở vật chất</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Nội dung đánh giá *</label>
                            <textarea name="noiDung"
                                placeholder="Chia sẻ trải nghiệm của bạn về ký túc xá..."
                                required></textarea>
                        </div>

                        <button type="submit" class="btn-submit">📤 Gửi đánh giá</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <div class="site-footer">
        &copy; 2026 &mdash; <strong>Hệ thống Quản lý Ký túc xá</strong>
        &mdash; Trường Đại học Sư phạm Kỹ thuật Đà Nẵng
    </div>

</body>
<script>
function anDanh() {
    const tenAnDanh = ["Sinh viên ẩn danh", "Người dùng KTX", 
                       "Sinh viên K" + Math.floor(Math.random()*5+18),
                       "Bạn sinh viên", "Người ở KTX"];
    const tenNgauNhien = tenAnDanh[Math.floor(Math.random() * tenAnDanh.length)];
    document.querySelector('input[name="hoTen"]').value = tenNgauNhien;
}
</script>
</html>