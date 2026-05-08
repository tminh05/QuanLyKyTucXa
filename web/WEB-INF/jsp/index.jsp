<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Quản lý Ký túc xá</title>
    <style>
        * { 
            margin: 0; 
            padding: 0; 
            box-sizing: border-box; 
        }
        
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: #f0f4f8; 
        }
        
        /*Phần trên cùng*/
        .top-bar { 
        /* Màu xanh đậm ở trên chuyển dần sang xanh nhạt ở dưới */
        background: linear-gradient(to bottom, #0D47A1, #66D9FF); 
        color: white; 
        padding: 16px 0; 
        font-size: 18px;
        /* Thêm đổ bóng để tạo hiệu ứng nổi 3D */
        box-shadow: 0 2px 5px rgba(0,0,0,0.2); 
        }

        .top-bar-inner { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 0 20px; 
            display: flex; 
            gap: 30px; 
            align-items: center; 
        }
        
        .top-bar a { 
            color: white; 
            text-decoration: none; 
            display: flex; 
            align-items: center; 
            gap: 5px; 
            transition: opacity 0.2s; 
        }
        
        .top-bar a:hover {
            color: #FFD700;
            opacity: 0.8; 
        }
        
        /*Phần Logo */
        .site-header { 
            background: white; 
            border-bottom: 3px solid #1565C0; 
            padding: 12px 0; 
            box-shadow: 0 2px 8px rgba(0,0,0,0.08); 
        }
        
        .header-inner { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 0 20px; 
            display: flex; 
            align-items: center; 
            gap: 18px; 
        }
        
        .header-logo { height: 110px; width: auto; }
        .header-university { font-size: 20px; color: #1565C0; font-weight: 600; text-transform: uppercase; }
        .header-school { font-size: 32px; font-weight: 800; color: #1565C0; text-transform: uppercase; line-height: 1.2; }
        .header-system { font-size: 25px; font-weight: 700; color: #e53935; text-transform: uppercase; margin-top: 2px; }
        
        /*Thanh chọn*/
        .main-nav { background: #1976D2; }
        .nav-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; }
        .main-nav a { color: white; text-decoration: none; padding: 12px 22px; font-size: 15px; font-weight: 500; display: block; transition: background 0.2s; border-right: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:first-child { border-left: 1px solid rgba(255,255,255,0.15); }
        .main-nav a:hover, .main-nav a.active { background: #0D47A1; }

        /*Hero Banner (ảnh nền + chữ):*/
        /* Khung ảnh */
        .hero { position: relative; height: 320px; overflow: hidden; }
        .hero img { width: 100%; height: 100%; object-fit: cover; }
        
        /* Lớp màu xanh phủ lên ảnh */
        .hero-overlay { position: absolute; inset: 0; background: linear-gradient(to right, rgba(13,71,161,0.75) 0%, rgba(13,71,161,0.2) 100%); display: flex; align-items: center; padding: 0 60px; }
        
        /* Chữ "KÝ TÚC XÁ SƯ PHẠM KỸ THUẬT" */
        .hero-text h2 { font-size: 34px; color: white; font-weight: 800; text-shadow: 0 2px 8px rgba(0,0,0,0.4); margin-bottom: 10px; text-transform: uppercase; }
        
        /* Chữ mô tả nhỏ bên dưới */
        .hero-text p { font-size: 16px; color: rgba(255,255,255,0.92); max-width: 500px; line-height: 1.6; }

        /* Nền trắng toàn bộ phần stats */
        .stats-section { background: white; border-bottom: 2px solid #e3eaf5; }

        /* Chia 4 cột đều nhau */
        .stats-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: grid; grid-template-columns: repeat(4, 1fr); }

        /* Mỗi ô */
        .stat-item { text-align: center; padding: 22px 10px; border-right: 1px solid #e3eaf5; }
        .stat-item:last-child { border-right: none; }
        .stat-item:hover { background: #f0f4ff; }
        
        /* Số lớn màu xanh */
        .stat-number { font-size: 36px; font-weight: 800; color: #1565C0; line-height: 1; }

        /* Chữ nhỏ bên dưới Sinh viên-Phòng-Hợp đồng-Yêu cầu bảo trì */
        .stat-label { font-size: 15px; color: red; margin-top: 6px; font-weight: 500; }

        .content-area { max-width: 1200px; margin: 28px auto; padding: 0 20px; display: grid; grid-template-columns: 1fr 320px; gap: 24px; }

        .intro-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.07); }
        .card-title-bar { background: #1565C0; color: white; padding: 10px 18px; font-size: 14px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; display: flex; align-items: center; gap: 8px; }
        .intro-body { padding: 20px; }
        .intro-body p { font-size: 14px; color: #444; line-height: 1.8; text-align: justify; }

        .features-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; margin-top: 20px; }
        .feature-item { border-radius: 8px; padding: 18px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); transition: transform 0.2s, box-shadow 0.2s; text-decoration: none; display: block; color: inherit; }
        .feature-item:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0,0,0,0.12); }
        .feature-icon { font-size: 26px; margin-bottom: 8px; }
        .feature-item h3 { font-size: 14px; font-weight: 700; color: #1565C0; margin-bottom: 5px; }
        .feature-item p { font-size: 12px; color: #666; line-height: 1.5; }
        
        .feature-item:nth-child(1) { border-left: 4px solid #1565C0; background: #E3F2FD; }
        .feature-item:nth-child(2) { border-left: 4px solid #2E7D32; background: #E8F5E9; }
        .feature-item:nth-child(3) { border-left: 4px solid #E65100; background: #FFF3E0; }
        .feature-item:nth-child(4) { border-left: 4px solid #6A1B9A; background: #F3E5F5; }

        .sidebar { display: flex; flex-direction: column; gap: 16px; }
        .sidebar-card { background: white; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); overflow: hidden; }
        .sidebar-links { padding: 8px 0; }
        .sidebar-link { display: flex; align-items: center; gap: 10px; padding: 10px 16px; font-size: 13px; color: #333; text-decoration: none; border-bottom: 1px solid #f0f0f0; transition: background 0.2s; }
        .sidebar-link:last-child { border-bottom: none; }
        .sidebar-link:hover { background: #f0f4ff; color: #1565C0; }
        .sidebar-dot { width: 7px; height: 7px; background: #1565C0; border-radius: 50%; flex-shrink: 0; }

        /* Hiệu ứng dải ảnh chạy chuyển động */
        .slide {
            width: 350px;
            height: 100px;
            display: flex;
            align-items: center;
            background: white;
            margin: 0 15px;
            padding: 10px 15px;
            border-radius: 12px;
            flex-shrink: 0;
            
            /* --- VIỀN VÀ BÓNG ĐỎ HỒNG --- */
            border: 2px solid #FF4D6D; /* Viền đỏ hồng */
            box-shadow: 0 0 12px rgba(255, 77, 109, 0.5), 
                        0 4px 10px rgba(0, 0, 0, 0.1); /* Bóng glow bên ngoài */
            
            transition: all 0.3s ease; /* Hiệu ứng mượt mà */
        }

        /* Hiệu ứng khi di chuột vào giúp ô sáng rực lên */
        .slide:hover {
            border-color: #FF0054;
            box-shadow: 0 0 20px rgba(255, 0, 84, 0.7);
            transform: translateY(-5px); /* Nhấc nhẹ ô lên */
        }

        /* Phần chứa Logo bên trái */
        .slide-logo {
            width: 70px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-right: 1px solid #eee;
            padding-right: 15px;
            margin-right: 15px;
        }

        .slide-logo img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }

        /* Phần chứa chữ bên phải */
        .slide-text {
            flex: 1;
            font-size: 14px;
            font-weight: 600;
            color: #1565C0;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* --- ĐIỀU CHỈNH CHO 10 ẢNH (20 THẺ) --- */
        .slider-track {
            display: flex;
            /* (350px + 30px margin) * 20 thẻ = 7600px */
            width: calc(380px * 20); 
            animation: scroll-left 45s linear infinite;
        }

        @keyframes scroll-left {
            0% { transform: translateX(0); }
            100% { 
                /* Chạy hết 10 thẻ đầu tiên (380px * 10) */
                transform: translateX(calc(-380px * 10)); 
            }
        }
        
        
        /* FOOTER ĐẲNG CẤP RE-DESIGN */
        .site-footer {
            background: #0D47A1; /* Màu xanh đậm thương hiệu */
            color: white;
            padding: 30px 0 0 0;
            margin-top: 50px;
            font-size: 14px;
        }

        .footer-inner {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px 30px 20px;
            display: grid;
            grid-template-columns: 1.5fr 1fr 1fr; /* Chia 3 cột tỷ lệ 1.5 - 1 - 1 */
            gap: 40px;
        }

        .footer-column h4 {
            color: #FFD700; /* Màu vàng nhấn mạnh */
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 16px;
            text-transform: uppercase;
            position: relative;
            padding-bottom: 10px;
        }

        /* Gạch chân dưới tiêu đề cột */
        .footer-column h4::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 2px;
            background: #FFD700;
        }

        .footer-column p {
            line-height: 1.8;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 15px;
        }

        .footer-info-list {
            list-style: none;
        }

        .footer-info-list li {
            margin-bottom: 12px;
            display: flex;
            align-items: flex-start;
            gap: 10px;
            color: rgba(255, 255, 255, 0.8);
        }

        .footer-info-list i {
            color: #FFD700;
            width: 20px;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 10px;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s;
            display: inline-block;
        }

        .footer-links a:hover {
            color: white;
            transform: translateX(5px);
        }

        /* Phần bản quyền ở dưới cùng */
        .footer-bottom {
            background: #0A3D8A;
            padding: 20px;
            text-align: center;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.6);
            font-size: 13px;
        }

        /* Responsive cho di động */
        @media (max-width: 768px) {
            .footer-inner {
                grid-template-columns: 1fr;
                gap: 30px;
            }
        }
    </style>
</head>
<body>

        <!-- TOP BAR -->
    <div class="top-bar">
        <div class="top-bar-inner">
        <a href="${pageContext.request.contextPath}/baiviet/tin-tuc">
            <span>📰</span> Tin tức &amp; Sự kiện
        </a>
        <a href="${pageContext.request.contextPath}/baiviet/thong-bao">
            <span>🔔</span> Thông báo
        </a>
        <a href="${pageContext.request.contextPath}/baiviet/noi-quy">
            <span>📋</span> Nội quy &amp; Quy định
        </a>
        <a href="${pageContext.request.contextPath}/logout" 
            style="margin-left:auto; 
                   background:#e53935; 
                   border-left: 1px solid rgba(255,255,255,0.15);
                   padding: 4px 14px;"
            onclick="return confirm('Bạn có chắc chắn muốn đăng xuất không?')">
            🔓 Đăng xuất
        </a>
        </div>
    </div>
            
    <!-- HEADER -->
    <div class="site-header">
        <div class="header-inner">
            <img src="${pageContext.request.contextPath}/resources/image/logo_ute.png"
                 alt="Logo UTE" class="header-logo"
                 onerror="this.src='${pageContext.request.contextPath}/resources/image/Logo_%C4%90ai_hoc_Su_pham_Ky_thuat_Da_Nang.png'">
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
            <a href="${pageContext.request.contextPath}/home" class="active">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/sinhvien/profile">👤 Sinh viên</a>
            <a href="${pageContext.request.contextPath}/phong/list">🏠 Phòng</a>
            <a href="${pageContext.request.contextPath}/hopdong/hopdong-cua-toi">📄 Hợp đồng</a>
            <a href="${pageContext.request.contextPath}/baotri/list">🔧 Bảo trì</a>
            <a href="${pageContext.request.contextPath}/danhgia/list">⭐ Đánh giá</a>
            <a href="${pageContext.request.contextPath}/thuvien/list">📚 Thư viện</a>
        </div>
    </nav>

    <!-- HERO -->
    <div class="hero">
        <img src="${pageContext.request.contextPath}/resources/image/488432.jpg" alt="Ký túc xá">
        <div class="hero-overlay">
            <div class="hero-text">
                <h2>Ký túc xá Sư phạm Kỹ thuật</h2>
                <p>Môi trường sống an toàn, hiện đại và thân thiện dành cho sinh viên trường Đại học Sư phạm Kỹ thuật Đà Nẵng.</p>
            </div>
        </div>
    </div>

    <!-- STATS -->
    <div class="stats-section">
        <div class="stats-inner">
            <div class="stat-item">
                <div class="stat-number">${soSinhVien != null ? soSinhVien : 0}</div>
                <div class="stat-label">Sinh viên</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">${soPhong != null ? soPhong : 0}</div>
                <div class="stat-label">Phòng</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">${soHopDong != null ? soHopDong : 0}</div>
                <div class="stat-label">Hợp đồng</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">${soYeuCauBaoTri != null ? soYeuCauBaoTri : 0}</div>
                <div class="stat-label">Yêu cầu bảo trì</div>
            </div>
        </div>
    </div>

    <!-- CONTENT -->
    <div class="content-area">
        <div>
            <div class="intro-body">
            <img src="${pageContext.request.contextPath}/resources/image/sinh-vien-doan.jpg" 
                alt="Sinh viên ký túc xá"
                style="float: left; 
                width: 280px; 
                height: 185px; 
                object-fit: cover;
                border-radius: 8px; 
                margin: 0 18px 12px 0;
                box-shadow: 0 2px 10px rgba(0,0,0,0.15);">
                    <p>Ký túc xá nhà trường là không gian sinh hoạt và học tập tập trung của hàng ngàn sinh viên 
                    từ khắp mọi miền Tổ quốc. Với hệ thống cơ sở hạ tầng hiện đại và tiện nghi đồng bộ, chúng tôi 
                    cam kết thiết lập một môi trường sống An toàn – Sạch sẽ – Văn minh.
       
                    Mỗi phòng nghỉ đều được trang bị đầy đủ nội thất thiết yếu gồm giường, tủ, bàn học cùng hệ thống Wi-Fi tốc độ cao, 
                    đảm bảo tối ưu hóa trải nghiệm học tập và nghỉ ngơi. Bên cạnh đó, hệ sinh thái tiện ích tích hợp như căng tin, 
                    phòng tự học, khu thể thao và dịch vụ hỗ trợ 24/7 luôn sẵn sàng đáp ứng mọi nhu cầu của sinh viên.
       
                    Không chỉ dừng lại ở việc cung cấp nơi ở, ký túc xá còn là nơi vun đắp tinh thần cộng đồng và kỹ năng sống 
                    cho thế hệ sinh viên tương lai. Các hoạt động ngoại khóa, câu lạc bộ học thuật và sự kiện văn hóa được tổ chức 
                    thường xuyên, tạo cơ hội để sinh viên giao lưu, kết nối và phát triển toàn diện cả về trí tuệ lẫn nhân cách.
       
                    Hệ thống quản lý ký túc xá được vận hành chuyên nghiệp với đội ngũ nhân viên tận tâm, luôn lắng nghe và giải quyết 
                    kịp thời mọi phản ánh của sinh viên. Hệ thống camera an ninh hoạt động liên tục, kiểm soát ra vào nghiêm ngặt và đội bảo vệ 
                    túc trực 24/24 giờ, mang lại sự an tâm tuyệt đối cho sinh viên và phụ huynh.
       
                    Chúng tôi tin rằng một môi trường sống chất lượng chính là nền tảng vững chắc để mỗi sinh viên tự tin bước vào hành trình 
                    chinh phục tri thức và xây dựng tương lai của mình.</p>
            </div>

            <div class="features-grid">
                <a href="${pageContext.request.contextPath}/sinhvien/list" class="feature-item">
                    <div class="feature-icon">📚</div>
                    <h3>Quản lý Sinh viên</h3>
                    <p>Thêm, sửa, xóa và tra cứu thông tin sinh viên đang ở ký túc xá</p>
                </a>
                <a href="${pageContext.request.contextPath}/phong/list" class="feature-item">
                    <div class="feature-icon">🏢</div>
                    <h3>Quản lý Phòng</h3>
                    <p>Quản lý thông tin phòng, tòa nhà và tình trạng phòng hiện tại</p>
                </a>
                <a href="${pageContext.request.contextPath}/hopdong/list" class="feature-item">
                    <div class="feature-icon">📄</div>
                    <h3>Quản lý Hợp đồng</h3>
                    <p>Quản lý hợp đồng thuê phòng của sinh viên theo từng học kỳ</p>
                </a>
                <a href="${pageContext.request.contextPath}/baotri/list" class="feature-item">
                    <div class="feature-icon">🔧</div>
                    <h3>Quản lý Bảo trì</h3>
                    <p>Tiếp nhận và xử lý yêu cầu sửa chữa, bảo trì cơ sở vật chất</p>
                </a>
            </div>
        </div>

        <!-- Liên kết nhanh -->
        <div class="sidebar">
            <div class="sidebar-card">
                <div class="card-title-bar">📌 Liên kết nhanh</div>
                <div class="sidebar-links">
                    <a href="${pageContext.request.contextPath}/sinhvien/add" class="sidebar-link"><span class="sidebar-dot"></span> Đăng ký phòng mới</a>
                    <a href="${pageContext.request.contextPath}/hopdong/add" class="sidebar-link"><span class="sidebar-dot"></span> Tạo hợp đồng</a>
                    <a href="${pageContext.request.contextPath}/baotri/add" class="sidebar-link"><span class="sidebar-dot"></span> Gửi yêu cầu bảo trì</a>
                    <a href="${pageContext.request.contextPath}/phong/list" class="sidebar-link"><span class="sidebar-dot"></span> Xem phòng còn trống</a>
                    <a href="${pageContext.request.contextPath}/hopdong/list" class="sidebar-link"><span class="sidebar-dot"></span> Danh sách hợp đồng</a>
                </div>
            </div>
                
            <!-- CHÍNH SÁCH HỖ TRỢ -->
            <div class="sidebar-card">
                <div class="card-title-bar">🎖️ Chính sách hỗ trợ</div>
                <div class="sidebar-links">
                    <a href="${pageContext.request.contextPath}/chinhsach/form?loai=Con+thương+binh,+liệt+sĩ" class="sidebar-link">
                        <span class="sidebar-dot"></span> Con thương binh, liệt sĩ
                    </a>
                    <a href="${pageContext.request.contextPath}/chinhsach/form?loai=Gia+đình+có+công+cách+mạng" class="sidebar-link">
                    <span class="sidebar-dot"></span> Gia đình có công cách mạng
                    </a>
                    <a href="${pageContext.request.contextPath}/chinhsach/form?loai=Hộ+nghèo+đặc+biệt+khó+khăn" class="sidebar-link">
                        <span class="sidebar-dot"></span> Hộ nghèo - Đặc biệt khó khăn
                    </a>
                    <a href="${pageContext.request.contextPath}/chinhsach/form?loai=Hộ+cận+nghèo+khó+khăn" class="sidebar-link">
                        <span class="sidebar-dot"></span> Hộ cận nghèo - Khó khăn
                    </a>
                    <a href="${pageContext.request.contextPath}/chinhsach/form?loai=Khu+vực+hải+đảo,+vùng+núi" class="sidebar-link">
                        <span class="sidebar-dot"></span> Khu vực hải đảo, vùng núi
                    </a>
                </div>
            </div>

            <!-- Liên hệ hỗ trợ -->
            <div class="sidebar-card">
                <div class="card-title-bar">📞 Liên hệ hỗ trợ</div>
                <div class="sidebar-links">
                    <a href="#" class="sidebar-link"><span class="sidebar-dot"></span> Ban quản lý KTX</a>
                    <a href="#" class="sidebar-link"><span class="sidebar-dot"></span> Hotline: 0236.xxx.xxx</a>
                    <a href="#" class="sidebar-link"><span class="sidebar-dot"></span> Email: ktx@ute.udn.vn</a>
                    <a href="#" class="sidebar-link"><span class="sidebar-dot"></span> Website trường</a>
                </div>
            </div>
                
                
        </div>
    </div>

                        
    <!-- IMAGE SLIDER SECTION -->
<div class="image-slider-container">
    <div class="slider-track">
        <!-- 8 THẺ CHÍNH -->
        <div class="slide">
            <div class="slide-logo"><img src="${pageContext.request.contextPath}/resources/image/anh-chay-nen1.jpg"></div>
            <div class="slide-text">Mùa hoa phượng tại mái trường và ngôi nhà chung kí túc</div>
        </div>
        <div class="slide">
            <div class="slide-logo"><img src="${pageContext.request.contextPath}/resources/image/anh-chay-nen2.jpg"></div>
            <div class="slide-text">Khung cảnh yên bình tại khu kí túc</div>
        </div>
        <div class="slide">
            <div class="slide-logo"><img src="${pageContext.request.contextPath}/resources/image/anh-chay-nen3.jpg"></div>
            <div class="slide-text">Sinh hoạt thường ngày của sinh viên tại đây</div>
        </div>
        <div class="slide">
            <div class="slide-logo"><img src="${pageContext.request.contextPath}/resources/image/anh-chay-nen4.jpg"></div>
            <div class="slide-text">Khát vọng tuổi trẻ - Tiến bước theo lý tưởng của Đảng</div>
        </div>
        <div class="slide">
            <div class="slide-logo"><img src="${pageContext.request.contextPath}/resources/image/anh-chay-nen5.png"></div>
            <div class="slide-text">Trường Đại học Bách khoa - Đại học Đà Nẵng</div>
        </div>
        <div class="slide">
            <div class="slide-logo"><img src="${pageContext.request.contextPath}/resources/image/anh-chay-nen6.jpg"></div>
            <div class="slide-text">Trường Đại học Sư phạm - Đại học Đà Nẵng</div>
        </div>
        <div class="slide">
            <div class="slide-logo"><img src="${pageContext.request.contextPath}/resources/image/anh-chay-nen7.png"></div>
            <div class="slide-text">Trường Đại học Kinh tế - Đại học Đà Nẵng</div>
        </div>
        <div class="slide">
            <div class="slide-logo"><img src="${pageContext.request.contextPath}/resources/image/anh-chay-nen8.png"></div>
            <div class="slide-text">Trường Đại học Sư phạm Kỹ thuật - Đại học Đà Nẵng</div>
        </div>
        <!-- Thẻ 9 -->
        <div class="slide">
            <div class="slide-logo">
                <img src="${pageContext.request.contextPath}/resources/image/anh-chay-nen9.jpg">
            </div>
            <div class="slide-text">Dòng lưu bút ngày còn thời sinh viên </div>
        </div>

        <!-- Thẻ 10 -->
        <div class="slide">
            <div class="slide-logo">
                <img src="${pageContext.request.contextPath}/resources/image/anh-chay-nen10.jpg">
            </div>
            <div class="slide-text">Nhật ký thanh xuân của tuổi trẻ</div>
        </div>

        <!-- NHÂN BẢN 8 THẺ ĐỂ CHẠY LIÊN TỤC (Lặp lại y hệt như trên) -->
        <div class="slide">
            <div class="slide-logo"><img src="${pageContext.request.contextPath}/resources/image/anh-chay-nen1.jpg"></div>
            <div class="slide-text">Mùa hoa phượng tại mái trường và ngôi nhà chung kí túc</div>
        </div>
        <!-- ... (Tiếp tục lặp lại các thẻ 2 đến 8 để hoàn tất vòng lặp) ... -->
    </div>
</div>
                        
    <!-- FOOTER -->
    <footer class="site-footer">
        <div class="footer-inner">
            <div class="footer-column">
                <h4>Về chúng tôi</h4>
                <p>
                    <strong>Hệ thống Quản lý Ký túc xá</strong><br>
                    Trường Đại học Sư phạm Kỹ thuật Đà Nẵng là đơn vị quản lý nội trú, 
                    cam kết mang lại không gian sống an toàn, văn minh và tiện nghi nhất cho sinh viên.
                </p>
                <div style="margin-top: 20px;">
                    <span style="font-size: 20px; margin-right: 15px; cursor: pointer;">🌐</span>
                    <span style="font-size: 20px; margin-right: 15px; cursor: pointer;">🔵</span>
                    <span style="font-size: 20px; margin-right: 15px; cursor: pointer;">🔴</span>
                </div>
            </div>

            <div class="footer-column">
                <h4>Thông tin liên hệ</h4>
                <ul class="footer-info-list">
                    <li><span>📍</span> 48 Cao Thắng, Phường Thanh Bình, Quận Hải Châu, TP. Đà Nẵng</li>
                    <li><span>📞</span> Hotline: 0236.xxx.xxx</li>
                    <li><span>📧</span> Email: ktx@ute.udn.vn</li>
                    <li><span>⏰</span> Giờ làm việc: 7:30 - 17:30 (Thứ 2 - Thứ 6)</li>
                </ul>
            </div>

            <div class="footer-column">
                <h4>Liên kết nhanh</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/baiviet/noi-quy">Nội quy ký túc xá</a></li>
                    <li><a href="${pageContext.request.contextPath}/baiviet/thong-bao">Thông báo mới nhất</a></li>
                    <li><a href="https://ute.udn.vn" target="_blank">Website nhà trường</a></li>
                    <li><a href="#">Cổng thông tin sinh viên</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            &copy; 2026 — <strong>Trường Đại học Sư phạm Kỹ thuật - ĐHĐN</strong>. Bảo lưu mọi quyền.
            <br>Ban quản lý ký túc xá - UTE.udn
        </div>
    </footer>

</body>
</html>