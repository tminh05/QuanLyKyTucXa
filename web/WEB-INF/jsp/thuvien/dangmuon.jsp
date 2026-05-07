<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sách đang mượn</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f0f4f8; }
        .header { background: white; border-bottom: 3px solid #1565C0; padding: 12px 30px;
                  display: flex; align-items: center; gap: 15px; }
        .header img { height: 65px; }
        .header-university { font-size: 13px; color: #1565C0; font-weight: 600; text-transform: uppercase; }
        .header-school { font-size: 20px; font-weight: 800; color: #1565C0; text-transform: uppercase; }
        .header-system { font-size: 15px; font-weight: 700; color: #e53935; text-transform: uppercase; }

        .wrap { max-width: 800px; margin: 28px auto; padding: 0 20px; }
        .card { background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); overflow: hidden; }
        .card-title { background: #1565C0; color: white; padding: 14px 20px;
                      font-size: 15px; font-weight: 700; }
        .table { width: 100%; border-collapse: collapse; }
        .table th { background: #f8f9ff; padding: 11px 16px; text-align: left;
                    font-size: 13px; font-weight: 600; color: #555;
                    border-bottom: 2px solid #e3eaf5; }
        .table td { padding: 11px 16px; font-size: 13px; color: #333;
                    border-bottom: 1px solid #f0f0f0; }
        .badge-dang { background: #E3F2FD; color: #1565C0; padding: 3px 10px;
                      border-radius: 12px; font-size: 11px; font-weight: 700; }
        .badge-tra { background: #e8f5e9; color: #2e7d32; padding: 3px 10px;
                     border-radius: 12px; font-size: 11px; font-weight: 700; }
        .badge-tre { background: #ffebee; color: #c62828; padding: 3px 10px;
                     border-radius: 12px; font-size: 11px; font-weight: 700; }
        .empty { text-align: center; padding: 40px; color: #aaa; font-size: 14px; }
        .btn-back { display: inline-block; margin-top: 16px; padding: 9px 22px;
                    background: #1565C0; color: white; border-radius: 6px;
                    text-decoration: none; font-size: 13px; font-weight: 600; }
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

    <div class="wrap">
        <div class="card">
            <div class="card-title">📋 Sách đang mượn - MSSV: ${mssv}</div>
            <c:choose>
                <c:when test="${empty sachDangMuon}">
                    <div class="empty">📭 Không có sách nào đang mượn</div>
                </c:when>
                <c:otherwise>
                    <table class="table">
                        <tr>
                            <th>#</th>
                            <th>Tên sách</th>
                            <th>Ngày mượn</th>
                            <th>Hạn trả</th>
                            <th>Trạng thái</th>
                        </tr>
                        <c:forEach var="ms" items="${sachDangMuon}" varStatus="st">
                            <tr>
                                <td>${st.count}</td>
                                <td><strong>${ms.tenSach}</strong></td>
                                <td><fmt:formatDate value="${ms.ngayMuon}" pattern="dd/MM/yyyy"/></td>
                                <td><fmt:formatDate value="${ms.ngayHenTra}" pattern="dd/MM/yyyy"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${ms.trangThai == 'Đang mượn'}">
                                            <span class="badge-dang">📖 Đang mượn</span>
                                        </c:when>
                                        <c:when test="${ms.trangThai == 'Đã trả'}">
                                            <span class="badge-tra">✅ Đã trả</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-tre">⚠️ ${ms.trangThai}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
        <a href="${pageContext.request.contextPath}/thuvien/list" class="btn-back">← Quay lại thư viện</a>
    </div>
</body>
</html>