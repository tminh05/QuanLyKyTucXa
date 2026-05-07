<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Khảo sát định kỳ 2025-2026</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f4f8; }

        .top-bar { background: #1565C0; color: white; padding: 14px 0; }
        .top-bar-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px;
                         display: flex; gap: 30px; }
        .top-bar a { color: white; text-decoration: none; opacity: 0.85;
                     display: flex; align-items: center; gap: 5px; }
        .top-bar a:hover { opacity: 1; }

        .site-header { background: white; border-bottom: 3px solid #1565C0; padding: 12px 0; }
        .header-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px;
                        display: flex; align-items: center; gap: 18px; }
        .header-logo { height: 110px; }
        .header-university { font-size: 20px; color: #1565C0; font-weight: 600; text-transform: uppercase; }
        .header-school { font-size: 32px; font-weight: 800; color: #1565C0; text-transform: uppercase; }
        .header-system { font-size: 25px; font-weight: 700; color: #e53935; text-transform: uppercase; }

        .main-nav { background: #1565C0; }
        .nav-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; }
        .main-nav a { color: white; text-decoration: none; padding: 12px 22px; font-size: 14px;
                      font-weight: 500; display: block; transition: background 0.2s;
                      border-right: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:first-child { border-left: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:hover { background: #0D47A1; }

        .breadcrumb { background: white; border-bottom: 1px solid #e0e7f0; padding: 10px 0; }
        .breadcrumb-inner { max-width: 900px; margin: 0 auto; padding: 0 20px;
                            font-size: 13px; color: #666; display: flex; gap: 6px; align-items: center; }
        .breadcrumb-inner a { color: #1565C0; text-decoration: none; }

        .wrapper { max-width: 900px; margin: 30px auto; padding: 0 20px; }

        .survey-card { background: white; border-radius: 12px;
                       box-shadow: 0 4px 20px rgba(0,0,0,0.08); overflow: hidden; }

        .survey-header { background: linear-gradient(135deg, #1565C0, #0D47A1);
                         padding: 30px; color: white; text-align: center; }
        .survey-header h1 { font-size: 24px; font-weight: 800; margin-bottom: 8px; }
        .survey-header p { font-size: 14px; opacity: 0.9; }

        .survey-body { padding: 30px; }

        /* Thông tin cá nhân */
        .section-label { font-size: 18px; font-weight: 700; color: #1565C0;
                         margin-bottom: 16px; padding-bottom: 8px;
                         border-bottom: 2px solid #e3eaf5; }

        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 28px; }
        .form-group { display: flex; flex-direction: column; gap: 6px; }
        .form-group label { font-size: 13px; font-weight: 600; color: #444; }
        .form-group label .required { color: #e53935; }
        .form-group input { padding: 10px 14px; border: 1px solid #ddd; border-radius: 6px;
                            font-size: 14px; transition: border 0.2s; }
        .form-group input:focus { outline: none; border-color: #1565C0;
                                   box-shadow: 0 0 0 3px rgba(21,101,192,0.1); }

        /* Câu hỏi khảo sát */
        .question-list { display: flex; flex-direction: column; gap: 20px; margin-bottom: 28px; }
        .question-item { background: #f0f4f8; border-radius: 8px; padding: 6px 10px;
                         border-left: 4px solid #1565C0; }
        .question-text { font-size: 14.5px; font-weight: 600; color: #1a2b4a;
                         margin-bottom: 12px; line-height: 1.5; }
        .question-text .required { color: #e53935; }

        /* Star rating */
        .star-group { display: flex; gap: 8px; align-items: center; flex-wrap: wrap; }
        .star-group input[type="radio"] { display: none; }
        .star-group label { cursor: pointer; font-size: 28px; color: #ddd;
                            transition: color 0.15s; user-select: none; }
        .star-group label:hover,
        .star-group label:hover ~ label { color: #FFB300; }
        .star-group input[type="radio"]:checked ~ label { color: #ddd; }
        .star-group input[type="radio"]:checked + label,
        .star-group label:has(~ input[type="radio"]:checked) { color: #FFB300; }

        /* Dùng cách đơn giản hơn - reverse order */
        .stars { display: flex; flex-direction: row-reverse; gap: 4px; }
        .stars input { display: none; }
        .stars label { font-size: 32px; color: #ddd; cursor: pointer; transition: color 0.2s; }
        .stars input:checked ~ label,
        .stars label:hover,
        .stars label:hover ~ label { color: #FFB300; }

        .star-hint { display: flex; justify-content: space-between;
                     font-size: 12px; color: #ff6666; margin-top: 6px; }

        /* Ý kiến */
        .form-group textarea { padding: 12px 14px; border: 1px solid #ddd; border-radius: 6px;
                               font-size: 14px; resize: vertical; min-height: 100px;
                               font-family: inherit; transition: border 0.2s; }
        .form-group textarea:focus { outline: none; border-color: #1565C0;
                                      box-shadow: 0 0 0 3px rgba(21,101,192,0.1); }

        .btn-submit { width: 100%; padding: 14px; background: #1565C0; color: white;
                      border: none; border-radius: 8px; font-size: 16px; font-weight: 700;
                      cursor: pointer; transition: background 0.2s; margin-top: 10px; }
        .btn-submit:hover { background: #0D47A1; }

        .note { font-size: 12px; color: #999; text-align: center; margin-top: 12px; }

        .site-footer { background: #1565C0; color: rgba(255,255,255,0.85);
                       text-align: center; padding: 14px; font-size: 13px; margin-top: 30px; }
        .site-footer strong { color: white; }
    </style>
</head>
<body>

<!-- TOP BAR -->
<div class="top-bar">
    <div class="top-bar-inner">
        <a href="${pageContext.request.contextPath}/baiviet/tin-tuc">&#128240; Tin tức &amp; Sự kiện</a>
        <a href="${pageContext.request.contextPath}/baiviet/thong-bao">&#128276; Thông báo</a>
        <a href="${pageContext.request.contextPath}/baiviet/noi-quy">&#128203; Nội quy &amp; Quy định</a>
    </div>
</div>

<!-- HEADER -->
<div class="site-header">
    <div class="header-inner">
        <img src="${pageContext.request.contextPath}/resources/image/logo_ute.png"
             alt="Logo" class="header-logo">
        <div>
            <div class="header-university">Đại học Đà Nẵng</div>
            <div class="header-school">Trường Đại học Sư phạm Kỹ thuật</div>
            <div class="header-system">Hệ thống Quản lý Ký túc xá</div>
        </div>
    </div>
</div>

<!-- NAV -->
<nav class="main-nav">
    <div class="nav-inner">
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/sinhvien/list">Sinh viên</a>
        <a href="${pageContext.request.contextPath}/phong/list">Phòng</a>
        <a href="${pageContext.request.contextPath}/hopdong/list">Hợp đồng</a>
        <a href="${pageContext.request.contextPath}/baotri/list">Bảo trì</a>
    </div>
</nav>

<!-- BREADCRUMB -->
<div class="breadcrumb">
    <div class="breadcrumb-inner">
        <a href="${pageContext.request.contextPath}/home">&#127968; Trang chủ</a>
        <span>›</span>
        <a href="${pageContext.request.contextPath}/baiviet/thong-bao">Thông báo</a>
        <span>›</span>
        <span>Khảo sát định kỳ 2025-2026</span>
    </div>
</div>

<!-- FORM KHẢO SÁT -->
<div class="wrapper">
    <div class="survey-card">
        <div class="survey-header">
            <h1>&#128203; Khảo sát định kỳ 2025-2026</h1>
            <p>Ý kiến của bạn giúp chúng tôi cải thiện chất lượng dịch vụ ký túc xá tốt hơn!</p>
        </div>

        <div class="survey-body">
            <form action="${pageContext.request.contextPath}/khaosat/gui" method="post"
      onsubmit="return validateForm()">

                <!-- THÔNG TIN CÁ NHÂN -->
                <div class="section-label">&#128100; Thông tin cá nhân</div>
                <div class="info-grid">
                    <div class="form-group">
                        <label>Họ và tên <span class="required">*</span>
                            <small style="color:#888;font-weight:400">(có thể dùng tên bất kỳ)</small>
                        </label>
                        <input type="text" name="hoTen" id="hoTen"
                               placeholder="VD: Sinh viên ẩn danh" maxlength="100">
                    </div>
                    <div class="form-group">
                        <label>Lớp <small style="color:#888;font-weight:400">(không bắt buộc)</small></label>
                        <input type="text" name="lop" placeholder="VD: CNTT-K18" maxlength="50">
                    </div>
                    <div class="form-group">
                        <label>MSSV <small style="color:#888;font-weight:400">(không bắt buộc)</small></label>
                        <input type="text" name="mssv" placeholder="VD: 123456789" maxlength="20">
                    </div>
                    <div class="form-group">
                        <label>Gmail <small style="color:#888;font-weight:400">(không bắt buộc)</small></label>
                        <input type="email" name="gmail" placeholder="VD: example@gmail.com" maxlength="100">
                    </div>
                </div>

                <!-- 10 CÂU HỎI -->
                <div class="section-label">&#11088; Đánh giá chất lượng (1 = Rất kém, 5 = Xuất sắc)</div>
                <div class="question-list">

                    <!-- Câu 1 -->
                    <div class="question-item">
                        <div class="question-text">1. Bạn đánh giá chất lượng phòng ở tại ký túc xá như thế nào? <span class="required">*</span></div>
                        <div class="stars">
                            <input type="radio" name="cau1" id="c1s5" value="5" required><label for="c1s5">&#9733;</label>
                            <input type="radio" name="cau1" id="c1s4" value="4"><label for="c1s4">&#9733;</label>
                            <input type="radio" name="cau1" id="c1s3" value="3"><label for="c1s3">&#9733;</label>
                            <input type="radio" name="cau1" id="c1s2" value="2"><label for="c1s2">&#9733;</label>
                            <input type="radio" name="cau1" id="c1s1" value="1"><label for="c1s1">&#9733;</label>
                        </div>
                        <div class="star-hint"><span>Rất kém</span><span>Xuất sắc</span></div>
                    </div>

                    <!-- Câu 2 -->
                    <div class="question-item">
                        <div class="question-text">2. Vệ sinh khu vực chung (hành lang, nhà vệ sinh, sân) được duy trì tốt không? <span class="required">*</span></div>
                        <div class="stars">
                            <input type="radio" name="cau2" id="c2s5" value="5" required><label for="c2s5">&#9733;</label>
                            <input type="radio" name="cau2" id="c2s4" value="4"><label for="c2s4">&#9733;</label>
                            <input type="radio" name="cau2" id="c2s3" value="3"><label for="c2s3">&#9733;</label>
                            <input type="radio" name="cau2" id="c2s2" value="2"><label for="c2s2">&#9733;</label>
                            <input type="radio" name="cau2" id="c2s1" value="1"><label for="c2s1">&#9733;</label>
                        </div>
                        <div class="star-hint"><span>Rất kém</span><span>Xuất sắc</span></div>
                    </div>

                    <!-- Câu 3 -->
                    <div class="question-item">
                        <div class="question-text">3. Chất lượng thiết bị trong phòng (giường, tủ, quạt, điều hòa) như thế nào? <span class="required">*</span></div>
                        <div class="stars">
                            <input type="radio" name="cau3" id="c3s5" value="5" required><label for="c3s5">&#9733;</label>
                            <input type="radio" name="cau3" id="c3s4" value="4"><label for="c3s4">&#9733;</label>
                            <input type="radio" name="cau3" id="c3s3" value="3"><label for="c3s3">&#9733;</label>
                            <input type="radio" name="cau3" id="c3s2" value="2"><label for="c3s2">&#9733;</label>
                            <input type="radio" name="cau3" id="c3s1" value="1"><label for="c3s1">&#9733;</label>
                        </div>
                        <div class="star-hint"><span>Rất kém</span><span>Xuất sắc</span></div>
                    </div>

                    <!-- Câu 4 -->
                    <div class="question-item">
                        <div class="question-text">4. Tốc độ xử lý yêu cầu bảo trì/sửa chữa có nhanh chóng không? <span class="required">*</span></div>
                        <div class="stars">
                            <input type="radio" name="cau4" id="c4s5" value="5" required><label for="c4s5">&#9733;</label>
                            <input type="radio" name="cau4" id="c4s4" value="4"><label for="c4s4">&#9733;</label>
                            <input type="radio" name="cau4" id="c4s3" value="3"><label for="c4s3">&#9733;</label>
                            <input type="radio" name="cau4" id="c4s2" value="2"><label for="c4s2">&#9733;</label>
                            <input type="radio" name="cau4" id="c4s1" value="1"><label for="c4s1">&#9733;</label>
                        </div>
                        <div class="star-hint"><span>Rất kém</span><span>Xuất sắc</span></div>
                    </div>

                    <!-- Câu 5 -->
                    <div class="question-item">
                        <div class="question-text">5. Ban quản lý ký túc xá có thái độ phục vụ tốt không? <span class="required">*</span></div>
                        <div class="stars">
                            <input type="radio" name="cau5" id="c5s5" value="5" required><label for="c5s5">&#9733;</label>
                            <input type="radio" name="cau5" id="c5s4" value="4"><label for="c5s4">&#9733;</label>
                            <input type="radio" name="cau5" id="c5s3" value="3"><label for="c5s3">&#9733;</label>
                            <input type="radio" name="cau5" id="c5s2" value="2"><label for="c5s2">&#9733;</label>
                            <input type="radio" name="cau5" id="c5s1" value="1"><label for="c5s1">&#9733;</label>
                        </div>
                        <div class="star-hint"><span>Rất kém</span><span>Xuất sắc</span></div>
                    </div>

                    <!-- Câu 6 -->
                    <div class="question-item">
                        <div class="question-text">6. Hệ thống WiFi tại ký túc xá có ổn định không? <span class="required">*</span></div>
                        <div class="stars">
                            <input type="radio" name="cau6" id="c6s5" value="5" required><label for="c6s5">&#9733;</label>
                            <input type="radio" name="cau6" id="c6s4" value="4"><label for="c6s4">&#9733;</label>
                            <input type="radio" name="cau6" id="c6s3" value="3"><label for="c6s3">&#9733;</label>
                            <input type="radio" name="cau6" id="c6s2" value="2"><label for="c6s2">&#9733;</label>
                            <input type="radio" name="cau6" id="c6s1" value="1"><label for="c6s1">&#9733;</label>
                        </div>
                        <div class="star-hint"><span>Rất kém</span><span>Xuất sắc</span></div>
                    </div>

                    <!-- Câu 7 -->
                    <div class="question-item">
                        <div class="question-text">7. Mức giá thuê phòng có phù hợp với chất lượng dịch vụ không? <span class="required">*</span></div>
                        <div class="stars">
                            <input type="radio" name="cau7" id="c7s5" value="5" required><label for="c7s5">&#9733;</label>
                            <input type="radio" name="cau7" id="c7s4" value="4"><label for="c7s4">&#9733;</label>
                            <input type="radio" name="cau7" id="c7s3" value="3"><label for="c7s3">&#9733;</label>
                            <input type="radio" name="cau7" id="c7s2" value="2"><label for="c7s2">&#9733;</label>
                            <input type="radio" name="cau7" id="c7s1" value="1"><label for="c7s1">&#9733;</label>
                        </div>
                        <div class="star-hint"><span>Rất kém</span><span>Xuất sắc</span></div>
                    </div>

                    <!-- Câu 8 -->
                    <div class="question-item">
                        <div class="question-text">8. An ninh, trật tự tại ký túc xá có được đảm bảo không? <span class="required">*</span></div>
                        <div class="stars">
                            <input type="radio" name="cau8" id="c8s5" value="5" required><label for="c8s5">&#9733;</label>
                            <input type="radio" name="cau8" id="c8s4" value="4"><label for="c8s4">&#9733;</label>
                            <input type="radio" name="cau8" id="c8s3" value="3"><label for="c8s3">&#9733;</label>
                            <input type="radio" name="cau8" id="c8s2" value="2"><label for="c8s2">&#9733;</label>
                            <input type="radio" name="cau8" id="c8s1" value="1"><label for="c8s1">&#9733;</label>
                        </div>
                        <div class="star-hint"><span>Rất kém</span><span>Xuất sắc</span></div>
                    </div>

                    <!-- Câu 9 -->
                    <div class="question-item">
                        <div class="question-text">9. Các tiện ích (căng tin, phòng tự học, khu thể thao) có đáp ứng nhu cầu không? <span class="required">*</span></div>
                        <div class="stars">
                            <input type="radio" name="cau9" id="c9s5" value="5" required><label for="c9s5">&#9733;</label>
                            <input type="radio" name="cau9" id="c9s4" value="4"><label for="c9s4">&#9733;</label>
                            <input type="radio" name="cau9" id="c9s3" value="3"><label for="c9s3">&#9733;</label>
                            <input type="radio" name="cau9" id="c9s2" value="2"><label for="c9s2">&#9733;</label>
                            <input type="radio" name="cau9" id="c9s1" value="1"><label for="c9s1">&#9733;</label>
                        </div>
                        <div class="star-hint"><span>Rất kém</span><span>Xuất sắc</span></div>
                    </div>

                    <!-- Câu 10 -->
                    <div class="question-item">
                        <div class="question-text">10. Bạn có hài lòng tổng thể và sẽ tiếp tục ở ký túc xá không? <span class="required">*</span></div>
                        <div class="stars">
                            <input type="radio" name="cau10" id="c10s5" value="5" required><label for="c10s5">&#9733;</label>
                            <input type="radio" name="cau10" id="c10s4" value="4"><label for="c10s4">&#9733;</label>
                            <input type="radio" name="cau10" id="c10s3" value="3"><label for="c10s3">&#9733;</label>
                            <input type="radio" name="cau10" id="c10s2" value="2"><label for="c10s2">&#9733;</label>
                            <input type="radio" name="cau10" id="c10s1" value="1"><label for="c10s1">&#9733;</label>
                        </div>
                        <div class="star-hint"><span>Rất kém</span><span>Xuất sắc</span></div>
                    </div>

                </div>

                <!-- Ý KIẾN -->
                <div class="section-label">&#128172; Ý kiến / Nguyện vọng cá nhân</div>
                <div class="form-group" style="margin-bottom:24px">
                    <label>Nêu lý do, ý kiến hoặc nguyện vọng của bạn <span class="required">*</span></label>
                    <textarea name="yKien" id="yKien"
                              placeholder="Ví dụ: Mong muốn cải thiện tốc độ WiFi, tăng cường vệ sinh nhà vệ sinh chung..."
                              maxlength="1000"></textarea>
                </div>

                <button type="submit" class="btn-submit">&#128229; Gửi khảo sát</button>
                <p class="note">* Thông tin của bạn được bảo mật và chỉ dùng để cải thiện chất lượng dịch vụ.</p>

            </form>
        </div>
    </div>
</div>

<!-- FOOTER -->
<div class="site-footer">
    &copy; 2026 &mdash; <strong>Hệ thống Quản lý Ký túc xá</strong> &mdash;
    Trường Đại học Sư phạm Kỹ thuật Đà Nẵng
</div>

<script>
function validateForm() {
    var hoTen = document.getElementById('hoTen').value.trim();
    if (!hoTen) {
        alert('Vui lòng nhập họ và tên!');
        document.getElementById('hoTen').focus();
        return false;
    }
    var cauHoi = ['cau1','cau2','cau3','cau4','cau5','cau6','cau7','cau8','cau9','cau10'];
    for (var i = 0; i < cauHoi.length; i++) {
        var radios = document.getElementsByName(cauHoi[i]);
        var checked = false;
        for (var j = 0; j < radios.length; j++) {
            if (radios[j].checked) { checked = true; break; }
        }
        if (!checked) {
            alert('Vui lòng trả lời câu hỏi số ' + (i+1) + '!');
            return false;
        }
    }
    var yKien = document.getElementById('yKien').value.trim();
    if (!yKien) {
        alert('Vui lòng nhập ý kiến/nguyện vọng của bạn!');
        document.getElementById('yKien').focus();
        return false;
    }
    return true;
}
</script>
</body>
</html>