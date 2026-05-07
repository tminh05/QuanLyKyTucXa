<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Ký túc xá</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0072ff 0%, #00c6ff 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .redirect-container {
            text-align: center;
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            animation: fadeIn 0.5s ease-out;
        }
        .spinner {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #667eea;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }
        h1 { color: #667eea; margin-bottom: 10px; }
        p { color: #666; margin-top: 20px; }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 25px;
            background: linear-gradient(135deg, #0072ff 0%, #00c6ff 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            transition: transform 0.3s;
        }
        .btn:hover { transform: translateY(-2px); }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
    <script>
        setTimeout(function() {
            window.location.href = "${pageContext.request.contextPath}/login";
        }, 2000);
    </script>
</head>
<body>
    <div class="redirect-container">
        <h1>
            🏠 Hệ thống Quản lý Ký túc xá</h1>
        <div class="spinner"></div>
        <p>Đang chuyển hướng đến trang chủ...</p>
        <a href="${pageContext.request.contextPath}/home" class="btn">Nhấn vào đây nếu không tự động chuyển</a>
    </div>
</body>
</html>