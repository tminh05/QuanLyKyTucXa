<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký Chính sách hỗ trợ</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f4f8; }

        .header { background: white; border-bottom: 3px solid #1565C0; padding: 12px 30px;
                  display: flex; align-items: center; gap: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .header img { height: 65px; }
        .header-university { font-size: 13px; color: #1565C0; font-weight: 600; text-transform: uppercase; }
        .header-school { font-size: 20px; font-weight: 800; color: #1565C0; text-transform: uppercase; }
        .header-system { font-size: 15px; font-weight: 700; color: #e53935; text-transform: uppercase; }

        .breadcrumb { max-width: 800px; margin: 12px auto 0; padding: 0 12px;
                      font-size: 18px; color: #888; }
        .breadcrumb a { color: #1565C0; text-decoration: none; }
        .breadcrumb a:hover { text-decoration: underline; }

        .form-container { max-width: 800px; margin: 20px auto 40px;
                          background: white; border-radius: 10px;
                          box-shadow: 0 2px 15px rgba(0,0,0,0.08); overflow: hidden; }

        .form-header { background: #1565C0; color: white; padding: 16px 24px;
                       font-size: 16px; font-weight: 700; text-transform: uppercase;
                       letter-spacing: 0.5px; display: flex; align-items: center; gap: 8px; }

        .policy-badge { background: #E3F2FD; border-left: 4px solid #1565C0;
                        padding: 14px 18px; margin: 20px 24px 0;
                        border-radius: 6px; display: flex; justify-content: space-between;
                        align-items: center; flex-wrap: wrap; gap: 10px; }
        .policy-name { font-size: 15px; color: #1565C0; font-weight: 700; }
        .policy-discount { background: #1565C0; color: white; padding: 5px 14px;
                           border-radius: 20px; font-size: 13px; font-weight: 700; }

        .section-title { font-size: 13px; font-weight: 700; color: #1565C0;
                         text-transform: uppercase; letter-spacing: 0.5px;
                         margin: 20px 0 12px; padding-bottom: 6px;
                         border-bottom: 2px solid #E3F2FD; }

        .form-body { padding: 20px 24px; }

        .form-group { margin-bottom: 16px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600;
                            color: #333; margin-bottom: 6px; }
        .required { color: red; }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%; padding: 10px 13px; border: 1.5px solid #ddd;
            border-radius: 6px; font-size: 14px; outline: none;
            transition: border-color 0.2s; font-family: inherit; background: white; }
        .form-group input:focus, .form-group textarea:focus,
        .form-group select:focus { border-color: #1565C0; }
        .form-group textarea { height: 110px; resize: vertical; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
        .form-row-3 { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 16px; }

        .info-box { background: #FFF8E1; border: 1px solid #FFD54F; border-radius: 6px;
                    padding: 14px 18px; margin-bottom: 18px; font-size: 13px; color: #5D4037; }
        .info-box strong { display: block; margin-bottom: 8px; color: #E65100; font-size: 13px; }
        .info-box ul { padding-left: 18px; }
        .info-box ul li { margin-bottom: 5px; line-height: 1.5; }

        .discount-table { width: 100%; border-collapse: collapse; margin-bottom: 18px;
                          font-size: 13px; border-radius: 6px; overflow: hidden;
                          box-shadow: 0 1px 4px rgba(0,0,0,0.08); }
        .discount-table th { background: #1565C0; color: white; padding: 10px 14px;
                             text-align: left; font-weight: 600; }
        .discount-table td { padding: 9px 14px; border-bottom: 1px solid #f0f0f0; }
        .discount-table tr:last-child td { border-bottom: none; }
        .discount-table tr:nth-child(even) td { background: #f8f9ff; }
        .discount-table tr.active-row td { background: #E3F2FD; font-weight: 600; color: #1565C0; }
        .badge-discount { background: #e8f5e9; color: #2e7d32; padding: 2px 10px;
                          border-radius: 12px; font-weight: 700; font-size: 12px; }
        .badge-discount-high { background: #e3f2fd; color: #1565C0; }
        .badge-discount-full { background: #fce4ec; color: #c62828; }

        .btn-submit { width: 100%; padding: 13px; background: #1565C0; color: white;
                      border: none; border-radius: 6px; font-size: 15px; font-weight: 700;
                      cursor: pointer; text-transform: uppercase; letter-spacing: 1px;
                      transition: background 0.2s; margin-top: 8px; }
        .btn-submit:hover { background: #0D47A1; }

        .btn-back { display: inline-block; margin-top: 12px; padding: 9px 22px;
                    background: #f0f4f8; color: #333; border-radius: 6px;
                    text-decoration: none; font-size: 13px; border: 1px solid #ddd; }
        .btn-back:hover { background: #e0e8f0; }

        .alert-success { background: #e8f5e9; border: 1px solid #a5d6a7; color: #2e7d32;
                         padding: 12px 16px; border-radius: 6px; margin-bottom: 16px;
                         font-size: 14px; text-align: center; }
        .alert-error { background: #ffebee; border: 1px solid #ef9a9a; color: #c62828;
                       padding: 12px 16px; border-radius: 6px; margin-bottom: 16px;
                       font-size: 14px; text-align: center; }

        .note-text { font-size: 12px; color: #888; margin-top: 4px; font-style: italic; }
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

    <!-- BREADCRUMB -->
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a> &rsaquo;
        <strong>Đăng ký Chính sách hỗ trợ</strong>
    </div>

    <!-- FORM -->
    <div class="form-container">
        <div class="form-header">🎖️ Đăng ký Chính sách hỗ trợ</div>

        <!-- CHÍNH SÁCH + % GIẢM -->
        <div class="policy-badge">
            <div class="policy-name">📋 Chính sách đăng ký: <strong>${loaiChinhSach}</strong></div>
            <div class="policy-discount" id="discountBadge">Đang tính...</div>
        </div>

        <div class="form-body">

            <!-- Thông báo -->
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert-success">✅ ${success}</div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-error">⚠️ ${error}</div>
            <% } %>

            <!-- BẢNG % GIẢM -->
            <div class="section-title">📊 Bảng mức hỗ trợ giảm tiền phòng</div>
            <table class="discount-table">
                <tr>
                    <th>Đối tượng chính sách</th>
                    <th>Mức giảm</th>
                    <th>Điều kiện</th>
                </tr>
                <tr id="row1">
                    <td>Con thương binh, liệt sĩ</td>
                    <td><span class="badge-discount badge-discount-full">Miễn 100%</span></td>
                    <td>Có xác nhận của Sở LĐ-TB&XH</td>
                </tr>
                <tr id="row2">
                    <td>Gia đình có công cách mạng</td>
                    <td><span class="badge-discount badge-discount-high">Giảm 75%</span></td>
                    <td>Có giấy xác nhận gia đình chính sách</td>
                </tr>
                <tr id="row3">
                    <td>Hộ nghèo - Đặc biệt khó khăn</td>
                    <td><span class="badge-discount badge-discount-full">Miễn 100%</span></td>
                    <td>Sổ hộ nghèo còn hiệu lực</td>
                </tr>
                <tr id="row4">
                    <td>Hộ cận nghèo - Khó khăn</td>
                    <td><span class="badge-discount">Giảm 50%</span></td>
                    <td>Sổ hộ cận nghèo còn hiệu lực</td>
                </tr>
                <tr id="row5">
                    <td>Khu vực hải đảo, vùng núi</td>
                    <td><span class="badge-discount">Giảm 30%</span></td>
                    <td>Hộ khẩu thường trú tại vùng đặc biệt</td>
                </tr>
            </table>

            <!-- MINH CHỨNG -->
            <div class="info-box">
                <strong>📎 Minh chứng cần chuẩn bị (nộp trực tiếp tại Ban quản lý KTX):</strong>
                <ul>
                    <li>Giấy xác nhận của UBND xã/phường nơi cư trú (bản gốc)</li>
                    <li>Bản sao CCCD/CMND có công chứng</li>
                    <li>Giấy tờ liên quan đến đối tượng chính sách (sổ hộ nghèo, giấy xác nhận...)</li>
                    <li>Ảnh thẻ 3x4 (2 ảnh)</li>
                    <li>Đơn đăng ký có chữ ký của sinh viên</li>
                </ul>
            </div>

            <!-- FORM -->
            <form action="${pageContext.request.contextPath}/chinhsach/guiyeucau" method="post">
                <input type="hidden" name="loaiChinhSach" value="${loaiChinhSach}"/>

                <!-- THÔNG TIN CÁ NHÂN -->
                <div class="section-title">👤 Thông tin cá nhân</div>

                <div class="form-row">
                    <div class="form-group">
                        <label>MSSV <span class="required">*</span></label>
                        <input type="text" name="mssv" placeholder="Ví dụ: SV001" required/>
                    </div>
                    <div class="form-group">
                        <label>Họ và tên <span class="required">*</span></label>
                        <input type="text" name="hoTen" placeholder="Nguyễn Văn A" required/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Ngày sinh</label>
                        <input type="date" name="ngaySinh"/>
                    </div>
                    <div class="form-group">
                        <label>Giới tính</label>
                        <select name="gioiTinh">
                            <option value="Nam">Nam</option>
                            <option value="Nữ">Nữ</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>CCCD/CMND <span class="required">*</span></label>
                        <input type="text" name="cccd" placeholder="012345678901" maxlength="12" required/>
                    </div>
                    <div class="form-group">
                        <label>Lớp</label>
                        <input type="text" name="lop" placeholder="CNTT-K18"/>
                    </div>
                </div>

                <!-- THÔNG TIN LIÊN HỆ -->
                <div class="section-title">📞 Thông tin liên hệ</div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Số điện thoại <span class="required">*</span></label>
                        <input type="tel" name="sdt" placeholder="0901234567" required/>
                    </div>
                    <div class="form-group">
                        <label>Email liên hệ <span class="required">*</span></label>
                        <input type="email" name="email" placeholder="sv@gmail.com" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label>Địa chỉ thường trú <span class="required">*</span></label>
                    <input type="text" name="diaChi" placeholder="Số nhà, thôn/xóm, xã/phường, huyện/quận, tỉnh/thành phố" required/>
                    <div class="note-text">* Ghi đầy đủ địa chỉ để xác minh khu vực chính sách</div>
                </div>

                <!-- THÔNG TIN CHÍNH SÁCH -->
                <div class="section-title">📄 Thông tin chính sách</div>

                <div class="form-group">
                    <label>Loại giấy tờ minh chứng <span class="required">*</span></label>
                    <select name="loaiGiayTo" required>
                        <option value="">-- Chọn loại giấy tờ --</option>
                        <option value="So ho ngheo">Sổ hộ nghèo</option>
                        <option value="So ho can ngheo">Sổ hộ cận nghèo</option>
                        <option value="Giay xac nhan thuong binh">Giấy xác nhận thương binh/liệt sĩ</option>
                        <option value="Giay xac nhan gia dinh chinh sach">Giấy xác nhận gia đình chính sách</option>
                        <option value="Ho khau vung nui hai dao">Hộ khẩu vùng núi/hải đảo</option>
                        <option value="Khac">Loại khác</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Mô tả hoàn cảnh <span class="required">*</span></label>
                    <textarea name="moTa"
                        placeholder="Mô tả chi tiết hoàn cảnh gia đình và lý do đăng ký chính sách hỗ trợ..." required></textarea>
                </div>

                <button type="submit" class="btn-submit">📤 Gửi yêu cầu hỗ trợ</button>
            </form>

            <a href="${pageContext.request.contextPath}/home" class="btn-back">← Quay lại trang chủ</a>
        </div>
    </div>

    <!-- Script tự động highlight dòng và hiện % giảm -->
    <script>
        const loai = "${loaiChinhSach}";
        const map = {
            "Con thương binh, liệt sĩ":        { row: "row1", text: "Miễn 100% tiền phòng" },
            "Gia đình có công cách mạng":       { row: "row2", text: "Giảm 75% tiền phòng" },
            "Hộ nghèo - Đặc biệt khó khăn":    { row: "row3", text: "Miễn 100% tiền phòng" },
            "Hộ cận nghèo - Khó khăn":         { row: "row4", text: "Giảm 50% tiền phòng" },
            "Khu vực hải đảo, vùng núi":        { row: "row5", text: "Giảm 30% tiền phòng" }
        };

        if (map[loai]) {
            // Highlight dòng tương ứng trong bảng
            document.getElementById(map[loai].row).classList.add("active-row");
            // Hiện % giảm trên badge
            document.getElementById("discountBadge").textContent = map[loai].text;
        } else {
            document.getElementById("discountBadge").textContent = "Xem bảng bên dưới";
        }
    </script>

</body>
</html>