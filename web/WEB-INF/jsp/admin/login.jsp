<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Đăng nhập hệ thống</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a2a4a, #0d1b2a);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            width: 100%;
            max-width: 420px;
            margin: 20px;
        }
        .login-box {
            background: white;
            border-radius: 12px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        .login-header {
            background: linear-gradient(135deg, #1565C0, #0D47A1);
            padding: 30px;
            text-align: center;
            color: white;
        }
        .login-header h1 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }
        .login-header p {
            font-size: 13px;
            opacity: 0.8;
        }
        .login-body {
            padding: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
        }
        .form-group input {
            width: 100%;
            padding: 12px 14px;
            border: 1.5px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }
        .form-group input:focus {
            border-color: #1565C0;
        }
        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #1565C0, #0D47A1);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(21,101,192,0.4);
        }
        .alert-error {
            background: #ffebee;
            border: 1px solid #ef9a9a;
            color: #c62828;
            padding: 12px 16px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 20px;
            text-align: center;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 12px;
            color: #999;
        }
        .footer a {
            color: #1565C0;
            text-decoration: none;
        }
        .icon-shield {
            font-size: 48px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <div class="icon-shield">🛡️</div>
                <h1>Quản trị hệ thống</h1>
                <p>Đại học Sư phạm Kỹ thuật Đà Nẵng</p>
            </div>
            <div class="login-body">
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert-error">⚠️ <%= request.getAttribute("error") %></div>
                <% } %>

                <form action="${pageContext.request.contextPath}/admin/login" method="post">
                    <div class="form-group">
                        <label>📧 Email</label>
                        <input type="email" name="email" placeholder="" required autofocus>
                    </div>
                    <div class="form-group">
                        <label>🔒 Mật khẩu</label>
                        <input type="password" name="matKhau" placeholder="" required>
                    </div>
                    <button type="submit" class="btn-login">Đăng nhập</button>
                </form>
                <div class="footer">
                    <a href="${pageContext.request.contextPath}/login">← Về trang đăng nhập sinh viên</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>