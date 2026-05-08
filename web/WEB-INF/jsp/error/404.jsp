<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>404 - Không tìm thấy trang</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a2a4a, #0d1b2a);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }
        .error-container {
            text-align: center;
            background: white;
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            max-width: 500px;
        }
        .error-code { font-size: 80px; font-weight: 800; color: #e53935; }
        .error-title { font-size: 24px; font-weight: 700; color: #333; margin: 20px 0; }
        .error-message { color: #666; margin-bottom: 30px; }
        .btn-home {
            background: #1565C0;
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 8px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">404</div>
        <div class="error-title">Không tìm thấy trang</div>
        <div class="error-message">Trang bạn đang tìm kiếm không tồn tại hoặc đã được di chuyển.</div>
        <a href="${pageContext.request.contextPath}/home" class="btn-home">🏠 Về trang chủ</a>
    </div>
</body>
</html>