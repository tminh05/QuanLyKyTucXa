<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách hóa đơn - KTX UTE</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f4f8; color: #333; }
        
        .header-blue { background: #1565C0; color: white; padding: 30px 20px; text-align: center; }
        .wrap { max-width: 1100px; margin: -30px auto 50px; padding: 0 20px; }
        
        .invoice-card { background: white; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); overflow: hidden; }
        .card-header { padding: 20px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        
        .invoice-table { width: 100%; border-collapse: collapse; }
        .invoice-table th { background: #f8f9fa; padding: 15px; text-align: left; font-size: 12px; text-transform: uppercase; color: #666; border-bottom: 2px solid #eee; }
        .invoice-table td { padding: 18px 15px; border-bottom: 1px solid #f0f0f0; font-size: 14px; }
        .invoice-table tr:hover { background: #fdfdfd; }

        /* Chỉ số điện nước */
        .meter-box { display: flex; align-items: center; gap: 10px; font-weight: 600; }
        .dien-text { color: #e65100; } /* Màu cam cho điện */
        .nuoc-text { color: #0277bd; } /* Màu xanh cho nước */
        .old-value { color: #999; font-size: 12px; font-weight: 400; }

        /* Tiền & Trạng thái */
        .price-tag { color: #1565C0; font-weight: 800; font-size: 16px; }
        .status-pill { padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 700; display: inline-flex; align-items: center; gap: 5px; }
        .unpaid { background: #fff5f5; color: #e53935; border: 1px solid #ffcdd2; }
        .paid { background: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9; }

        .btn-back { display: inline-block; margin-bottom: 15px; color: white; text-decoration: none; font-size: 14px; opacity: 0.8; }
        .btn-back:hover { opacity: 1; }
    </style>
</head>
<body>

    <div class="header-blue">
        <a href="javascript:history.back()" class="btn-back">← Quay lại trang hợp đồng</a>
        <h1>Hóa đơn Điện & Nước</h1>
        <p style="margin-top: 5px; opacity: 0.9;">Phòng: ${tenPhong} | Tra cứu lịch sử thanh toán</p>
    </div>

    <div class="wrap">
        <div class="invoice-card">
            <table class="invoice-table">
                <thead>
                    <tr>
                        <th>Kỳ hóa đơn</th>
                        <th>Chỉ số Điện (Cũ → Mới)</th>
                        <th>Chỉ số Nước (Cũ → Mới)</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="bill" items="${listHoaDon}">
                        <tr>
                            <td><strong>Tháng ${bill.kyHoaDon}</strong></td>
                            <td>
                                <div class="meter-box dien-text">
                                    <span class="old-value">${bill.chiSoDienCu}</span>
                                    <span>→</span>
                                    <span>${bill.chiSoDienMoi}</span>
                                </div>
                            </td>
                            <td>
                                <div class="meter-box nuoc-text">
                                    <span class="old-value">${bill.chiSoNuocCu}</span>
                                    <span>→</span>
                                    <span>${bill.chiSoNuocMoi}</span>
                                </div>
                            </td>
                            <td>
                                <span class="price-tag">
                                    <fmt:formatNumber value="${bill.tongTien}" type="currency" currencySymbol="đ"/>
                                </span>
                            </td>
                            <td>
                                <span class="status-pill ${bill.trangThai == 'Chưa thanh toán' ? 'unpaid' : 'paid'}">
                                    ${bill.trangThai == 'Chưa thanh toán' ? '⚠️' : '✅'} ${bill.trangThai}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>