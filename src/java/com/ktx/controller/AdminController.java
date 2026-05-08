package com.ktx.controller;

import com.ktx.dao.*;
import com.ktx.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    // DAO declarations
    @Autowired private SinhVienDAO sinhVienDAO;
    @Autowired private PhongDAO phongDAO;
    @Autowired private HopDongDAO hopDongDAO;
    @Autowired private BaoTriDAO baoTriDAO;
    @Autowired private NhanVienDAO nhanVienDAO;
    @Autowired private HoaDonDAO hoaDonDAO;
    @Autowired private SachDAO sachDAO;
    @Autowired private BaiVietDAO baiVietDAO;
    @Autowired private KhaoSatDAO khaoSatDAO;
    @Autowired private YeuCauHoTroDAO yeuCauHoTroDAO;
    @Autowired private ToaNhaDAO toaNhaDAO;
    @Autowired private LoaiPhongDAO loaiPhongDAO;

    // ==================== AUTHENTICATION ====================
    
    @GetMapping("/login")
    public String showLogin() {
        return "admin/login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String email,
                          @RequestParam String matKhau,
                          HttpSession session,
                          Model model) {
        try {
            if (nhanVienDAO.checkLogin(email, matKhau)) {
                NhanVien nv = nhanVienDAO.getByEmail(email);
                session.setAttribute("admin", nv);
                return "redirect:/admin/dashboard";
            } else {
                model.addAttribute("error", "Email hoặc mật khẩu không đúng!");
            }
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }
        return "admin/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("admin");
        return "redirect:/admin/login";
    }

    // ==================== DASHBOARD ====================
    
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        // Thống kê cơ bản
        model.addAttribute("tongSinhVien", sinhVienDAO.count());
        model.addAttribute("tongPhong", phongDAO.count());
        model.addAttribute("phongTrong", phongDAO.countAvailableRooms());
        model.addAttribute("phongDay", phongDAO.count() - phongDAO.countAvailableRooms());
        model.addAttribute("hopDongHieuLuc", hopDongDAO.countActiveContracts());
        model.addAttribute("yeuCauBaoTri", baoTriDAO.count());
        model.addAttribute("yeuCauChuaXuLy", baoTriDAO.countPendingRequests());
        model.addAttribute("yeuCauDangXuLy", baoTriDAO.countProcessingRequests());
        model.addAttribute("yeuCauHoanThanh", baoTriDAO.countCompletedRequests());
        
        // Hợp đồng sắp hết hạn
        model.addAttribute("hopDongSapHetHan", hopDongDAO.getExpiringContracts());
        
        // Top phòng có nhiều yêu cầu bảo trì
        model.addAttribute("topPhongBaoTri", baoTriDAO.getTopRoomsWithIssues(5));
        
        // Thống kê theo tháng (5 tháng gần nhất)
        Map<String, Integer> thongKeThang = new LinkedHashMap<>();
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("MM/yyyy");
        for (int i = 0; i < 6; i++) {
            String thang = sdf.format(cal.getTime());
            thongKeThang.put(thang, hopDongDAO.getCountByMonth(cal.get(Calendar.MONTH) + 1, cal.get(Calendar.YEAR)));
            cal.add(Calendar.MONTH, -1);
        }
        model.addAttribute("thongKeThang", thongKeThang);
        
        return "admin/dashboard";
    }

    // ==================== QUẢN LÝ SINH VIÊN ====================
    
    @GetMapping("/sinhvien")
    public String quanLySinhVien(@RequestParam(required = false) String keyword, Model model) {
        if (keyword != null && !keyword.trim().isEmpty()) {
            model.addAttribute("sinhVienList", sinhVienDAO.search(keyword));
            model.addAttribute("keyword", keyword);
        } else {
            model.addAttribute("sinhVienList", sinhVienDAO.getAll());
        }
        return "admin/sinhvien-list";
    }

    @GetMapping("/sinhvien/add")
    public String themSinhVienForm(Model model) {
        model.addAttribute("sinhVien", new SinhVien());
        return "admin/sinhvien-add";
    }

    @PostMapping("/sinhvien/add")
    public String themSinhVien(@ModelAttribute SinhVien sv, RedirectAttributes ra) {
        try {
            if (sinhVienDAO.getById(sv.getMssv()) != null) {
                ra.addFlashAttribute("error", "MSSV đã tồn tại!");
                return "redirect:/admin/sinhvien/add";
            }
            sinhVienDAO.add(sv);
            ra.addFlashAttribute("success", "Thêm sinh viên " + sv.getHoTen() + " thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/sinhvien";
    }

    @GetMapping("/sinhvien/edit/{mssv}")
    public String suaSinhVienForm(@PathVariable String mssv, Model model) {
        SinhVien sv = sinhVienDAO.getById(mssv);
        if (sv == null) return "redirect:/admin/sinhvien";
        model.addAttribute("sinhVien", sv);
        return "admin/sinhvien-edit";
    }

    @PostMapping("/sinhvien/edit")
    public String suaSinhVien(@ModelAttribute SinhVien sv, RedirectAttributes ra) {
        try {
            sinhVienDAO.update(sv);
            ra.addFlashAttribute("success", "Cập nhật sinh viên " + sv.getHoTen() + " thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/sinhvien";
    }

    @GetMapping("/sinhvien/delete/{mssv}")
    public String xoaSinhVien(@PathVariable String mssv, RedirectAttributes ra) {
        try {
            if (sinhVienDAO.hasActiveContract(mssv)) {
                ra.addFlashAttribute("error", "Sinh viên đang có hợp đồng hiệu lực, không thể xóa!");
            } else {
                sinhVienDAO.delete(mssv);
                ra.addFlashAttribute("success", "Xóa sinh viên thành công!");
            }
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/sinhvien";
    }
    
    @GetMapping("/sinhvien/detail/{mssv}")
    public String chiTietSinhVien(@PathVariable String mssv, Model model) {
        SinhVien sv = sinhVienDAO.getById(mssv);
        if (sv == null) return "redirect:/admin/sinhvien";
        model.addAttribute("sinhVien", sv);
        model.addAttribute("hopDongList", sinhVienDAO.getContracts(mssv));
        return "admin/sinhvien-detail";
    }

    // ==================== QUẢN LÝ PHÒNG ====================
    
    @GetMapping("/phong")
    public String quanLyPhong(@RequestParam(required = false) String trangThai, Model model) {
        if (trangThai != null && !trangThai.isEmpty()) {
            model.addAttribute("phongList", phongDAO.getByStatus(trangThai));
            model.addAttribute("trangThaiChon", trangThai);
        } else {
            model.addAttribute("phongList", phongDAO.getAll());
        }
        return "admin/phong-list";
    }

    @GetMapping("/phong/add")
    public String themPhongForm(Model model) {
        model.addAttribute("phong", new Phong());
        model.addAttribute("toaNhaList", toaNhaDAO.getAll());
        model.addAttribute("loaiPhongList", loaiPhongDAO.getAll());
        return "admin/phong-add";
    }

    @PostMapping("/phong/add")
    public String themPhong(@ModelAttribute Phong phong, RedirectAttributes ra) {
        try {
            if (phongDAO.isPhongExists(phong.getTenPhong(), phong.getIdToaNha())) {
                ra.addFlashAttribute("error", "Tên phòng đã tồn tại trong tòa nhà này!");
                return "redirect:/admin/phong/add";
            }
            phongDAO.add(phong);
            ra.addFlashAttribute("success", "Thêm phòng " + phong.getTenPhong() + " thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/phong";
    }

    @GetMapping("/phong/edit/{id}")
    public String suaPhongForm(@PathVariable int id, Model model) {
        Phong phong = phongDAO.getById(id);
        if (phong == null) return "redirect:/admin/phong";
        model.addAttribute("phong", phong);
        model.addAttribute("toaNhaList", toaNhaDAO.getAll());
        model.addAttribute("loaiPhongList", loaiPhongDAO.getAll());
        return "admin/phong-edit";
    }

    @PostMapping("/phong/edit")
    public String suaPhong(@ModelAttribute Phong phong, RedirectAttributes ra) {
        try {
            phongDAO.update(phong);
            ra.addFlashAttribute("success", "Cập nhật phòng " + phong.getTenPhong() + " thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/phong";
    }

    @GetMapping("/phong/delete/{id}")
    public String xoaPhong(@PathVariable int id, RedirectAttributes ra) {
        try {
            if (phongDAO.hasStudents(id)) {
                ra.addFlashAttribute("error", "Phòng đang có sinh viên ở, không thể xóa!");
            } else {
                phongDAO.delete(id);
                ra.addFlashAttribute("success", "Xóa phòng thành công!");
            }
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/phong";
    }
    
    @GetMapping("/phong/detail/{id}")
    public String chiTietPhong(@PathVariable int id, Model model) {
        Phong phong = phongDAO.getById(id);
        if (phong == null) return "redirect:/admin/phong";
        model.addAttribute("phong", phong);
        model.addAttribute("sinhVienList", phongDAO.getStudentsInRoom(id));
        model.addAttribute("thietBiList", phongDAO.getEquipment(id));
        model.addAttribute("hopDongList", hopDongDAO.getByRoom(id));
        return "admin/phong-detail";
    }

    // ==================== QUẢN LÝ HỢP ĐỒNG ====================
    
    @GetMapping("/hopdong")
    public String quanLyHopDong(@RequestParam(required = false) String trangThai,
                                @RequestParam(required = false) String keyword,
                                Model model) {
        List<HopDong> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = hopDongDAO.search(keyword);
            model.addAttribute("keyword", keyword);
        } else if (trangThai != null && !trangThai.isEmpty()) {
            list = hopDongDAO.getByStatus(trangThai);
            model.addAttribute("trangThaiChon", trangThai);
        } else {
            list = hopDongDAO.getAll();
        }
        model.addAttribute("hopDongList", list);
        return "admin/hopdong-list";
    }

    @GetMapping("/hopdong/add")
    public String themHopDongForm(Model model) {
        model.addAttribute("hopDong", new HopDong());
        model.addAttribute("sinhVienList", sinhVienDAO.getStudentsWithoutContract());
        model.addAttribute("phongList", phongDAO.getAvailableRooms());
        return "admin/hopdong-add";
    }

    @PostMapping("/hopdong/add")
    public String themHopDong(@ModelAttribute HopDong hopDong, RedirectAttributes ra) {
        try {
            if (hopDongDAO.hasActiveContract(hopDong.getMssv())) {
                ra.addFlashAttribute("error", "Sinh viên đã có hợp đồng hiệu lực!");
                return "redirect:/admin/hopdong/add";
            }
            if (!phongDAO.hasAvailableSlot(hopDong.getIdPhong())) {
                ra.addFlashAttribute("error", "Phòng đã đầy, không thể thêm hợp đồng!");
                return "redirect:/admin/hopdong/add";
            }
            hopDongDAO.add(hopDong);
            ra.addFlashAttribute("success", "Tạo hợp đồng thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/hopdong";
    }

    @GetMapping("/hopdong/edit/{id}")
    public String suaHopDongForm(@PathVariable int id, Model model) {
        HopDong hopDong = hopDongDAO.getById(id);
        if (hopDong == null) return "redirect:/admin/hopdong";
        model.addAttribute("hopDong", hopDong);
        model.addAttribute("phongList", phongDAO.getAvailableRooms());
        return "admin/hopdong-edit";
    }

    @PostMapping("/hopdong/edit")
    public String suaHopDong(@ModelAttribute HopDong hopDong, RedirectAttributes ra) {
        try {
            hopDongDAO.update(hopDong);
            ra.addFlashAttribute("success", "Cập nhật hợp đồng thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/hopdong";
    }

    @GetMapping("/hopdong/delete/{id}")
    public String xoaHopDong(@PathVariable int id, RedirectAttributes ra) {
        try {
            hopDongDAO.delete(id);
            ra.addFlashAttribute("success", "Xóa hợp đồng thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/hopdong";
    }
    
    @GetMapping("/hopdong/renew/{id}")
    public String giaHanHopDong(@PathVariable int id, 
                                @RequestParam String ngayKetThucMoi,
                                RedirectAttributes ra) {
        try {
            hopDongDAO.renewContract(id, ngayKetThucMoi);
            ra.addFlashAttribute("success", "Gia hạn hợp đồng thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/hopdong";
    }

    // ==================== QUẢN LÝ BẢO TRÌ ====================
    
    @GetMapping("/baotri")
    public String quanLyBaoTri(@RequestParam(required = false) String trangThai, Model model) {
        if (trangThai != null && !trangThai.isEmpty()) {
            model.addAttribute("yeuCauList", baoTriDAO.getByStatus(trangThai));
            model.addAttribute("trangThaiChon", trangThai);
        } else {
            model.addAttribute("yeuCauList", baoTriDAO.getAll());
        }
        return "admin/baotri-list";
    }

    @GetMapping("/baotri/process/{id}")
    public String xuLyBaoTriForm(@PathVariable int id, Model model) {
        YeuCauBaoTri yeuCau = baoTriDAO.getById(id);
        if (yeuCau == null) return "redirect:/admin/baotri";
        model.addAttribute("yeuCau", yeuCau);
        model.addAttribute("nhanVienList", nhanVienDAO.getActiveStaff());
        return "admin/baotri-process";
    }

    @PostMapping("/baotri/process")
    public String xuLyBaoTri(@ModelAttribute YeuCauBaoTri yeuCau, RedirectAttributes ra) {
        try {
            baoTriDAO.update(yeuCau);
            ra.addFlashAttribute("success", "Cập nhật yêu cầu bảo trì #" + yeuCau.getIdYeuCau() + " thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/baotri";
    }

    @GetMapping("/baotri/delete/{id}")
    public String xoaBaoTri(@PathVariable int id, RedirectAttributes ra) {
        try {
            baoTriDAO.delete(id);
            ra.addFlashAttribute("success", "Xóa yêu cầu bảo trì thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/baotri";
    }
    
    @GetMapping("/baotri/assign/{id}")
    public String phanCongNhanVien(@PathVariable int id,
                                   @RequestParam int nhanVienId,
                                   RedirectAttributes ra) {
        try {
            baoTriDAO.assignStaff(id, nhanVienId);
            ra.addFlashAttribute("success", "Đã phân công nhân viên xử lý!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/baotri";
    }

    // ==================== QUẢN LÝ NHÂN VIÊN ====================
    
    @GetMapping("/nhanvien")
    public String quanLyNhanVien(@RequestParam(required = false) String keyword, Model model) {
        if (keyword != null && !keyword.trim().isEmpty()) {
            model.addAttribute("nhanVienList", nhanVienDAO.search(keyword));
            model.addAttribute("keyword", keyword);
        } else {
            model.addAttribute("nhanVienList", nhanVienDAO.getAll());
        }
        return "admin/nhanvien-list";
    }

    @GetMapping("/nhanvien/add")
    public String themNhanVienForm(Model model) {
        model.addAttribute("nhanVien", new NhanVien());
        return "admin/nhanvien-add";
    }

    @PostMapping("/nhanvien/add")
    public String themNhanVien(@ModelAttribute NhanVien nv, RedirectAttributes ra) {
        try {
            if (nhanVienDAO.isEmailExists(nv.getEmail())) {
                ra.addFlashAttribute("error", "Email đã tồn tại!");
                return "redirect:/admin/nhanvien/add";
            }
            nhanVienDAO.add(nv);
            ra.addFlashAttribute("success", "Thêm nhân viên " + nv.getHoTen() + " thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/nhanvien";
    }

    @GetMapping("/nhanvien/edit/{id}")
    public String suaNhanVienForm(@PathVariable int id, Model model) {
        NhanVien nv = nhanVienDAO.getById(id);
        if (nv == null) return "redirect:/admin/nhanvien";
        model.addAttribute("nhanVien", nv);
        return "admin/nhanvien-edit";
    }

    @PostMapping("/nhanvien/edit")
    public String suaNhanVien(@ModelAttribute NhanVien nv, RedirectAttributes ra) {
        try {
            nhanVienDAO.update(nv);
            ra.addFlashAttribute("success", "Cập nhật nhân viên " + nv.getHoTen() + " thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/nhanvien";
    }

    @GetMapping("/nhanvien/delete/{id}")
    public String xoaNhanVien(@PathVariable int id, RedirectAttributes ra) {
        try {
            NhanVien nv = nhanVienDAO.getById(id);
            if (nv != null && nv.isAdmin()) {
                ra.addFlashAttribute("error", "Không thể xóa tài khoản Admin!");
            } else {
                nhanVienDAO.delete(id);
                ra.addFlashAttribute("success", "Xóa nhân viên thành công!");
            }
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/nhanvien";
    }
    
    @PostMapping("/nhanvien/changepassword")
    public String doiMatKhauNhanVien(@RequestParam int id,
                                     @RequestParam String matKhauMoi,
                                     HttpSession session,
                                     RedirectAttributes ra) {
        try {
            nhanVienDAO.updatePassword(id, matKhauMoi);
            ra.addFlashAttribute("success", "Đổi mật khẩu thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/nhanvien";
    }

    // ==================== QUẢN LÝ BÀI VIẾT ====================
    
    @GetMapping("/baiviet")
    public String quanLyBaiViet(Model model) {
        model.addAttribute("baivietList", baiVietDAO.getDanhSachTheoLoai("tin-tuc"));
        model.addAttribute("thongbaoList", baiVietDAO.getDanhSachTheoLoai("thong-bao"));
        model.addAttribute("noiquyList", baiVietDAO.getDanhSachTheoLoai("noi-quy"));
        return "admin/baiviet-list";
    }

    @GetMapping("/baiviet/add")
    public String themBaiVietForm(@RequestParam String loai, Model model) {
        BaiViet bv = new BaiViet();
        bv.setLoaiBaiViet(loai);
        model.addAttribute("baiViet", bv);
        model.addAttribute("loaiBaiViet", loai);
        return "admin/baiviet-add";
    }

    @PostMapping("/baiviet/add")
    public String themBaiViet(@ModelAttribute BaiViet bv,
                              @RequestParam String loaiBaiViet,
                              HttpSession session,
                              RedirectAttributes ra) {
        try {
            bv.setLoaiBaiViet(loaiBaiViet);
            bv.setNgayDang(java.time.LocalDate.now());
            bv.setLuotXem(0);
            baiVietDAO.add(bv);
            ra.addFlashAttribute("success", "Thêm bài viết thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/baiviet";
    }

    @GetMapping("/baiviet/edit/{id}")
    public String suaBaiVietForm(@PathVariable int id, Model model) {
        BaiViet bv = baiVietDAO.getBaiVietById(id);
        if (bv == null) return "redirect:/admin/baiviet";
        model.addAttribute("baiViet", bv);
        return "admin/baiviet-edit";
    }

    @PostMapping("/baiviet/edit")
    public String suaBaiViet(@ModelAttribute BaiViet bv, RedirectAttributes ra) {
        try {
            baiVietDAO.update(bv);
            ra.addFlashAttribute("success", "Cập nhật bài viết thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/baiviet";
    }

    @GetMapping("/baiviet/delete/{id}")
    public String xoaBaiViet(@PathVariable int id, RedirectAttributes ra) {
        try {
            baiVietDAO.delete(id);
            ra.addFlashAttribute("success", "Xóa bài viết thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/baiviet";
    }

    // ==================== QUẢN LÝ HÓA ĐƠN ====================
    
    @GetMapping("/hoadon")
    public String quanLyHoaDon(@RequestParam(required = false) String trangThai,
                               @RequestParam(required = false) String kyHoaDon,
                               Model model) {
        if (kyHoaDon != null && !kyHoaDon.isEmpty()) {
            model.addAttribute("hoaDonList", hoaDonDAO.getByPeriod(kyHoaDon));
            model.addAttribute("kyChon", kyHoaDon);
        } else if ("chua-thanh-toan".equals(trangThai)) {
            model.addAttribute("hoaDonList", hoaDonDAO.getUnpaidInvoices());
            model.addAttribute("trangThaiChon", "chua-thanh-toan");
        } else {
            model.addAttribute("hoaDonList", hoaDonDAO.getAll());
        }
        model.addAttribute("phongList", phongDAO.getAll());
        return "admin/hoadon-list";
    }

    @GetMapping("/hoadon/add")
    public String themHoaDonForm(Model model) {
        model.addAttribute("hoaDon", new HoaDon());
        model.addAttribute("phongList", phongDAO.getAll());
        return "admin/hoadon-add";
    }

    @PostMapping("/hoadon/add")
    public String themHoaDon(@ModelAttribute HoaDon hoaDon, RedirectAttributes ra) {
        try {
            hoaDon.setTongTien(hoaDon.tinhTongTien());
            hoaDon.setTrangThai("Chưa thanh toán");
            hoaDonDAO.add(hoaDon);
            ra.addFlashAttribute("success", "Tạo hóa đơn thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/hoadon";
    }

    @GetMapping("/hoadon/pay/{id}")
    public String thanhToanHoaDon(@PathVariable int id,
                                  @RequestParam String phuongThuc,
                                  RedirectAttributes ra) {
        try {
            HoaDon hd = hoaDonDAO.getById(id);
            if (hd == null) {
                ra.addFlashAttribute("error", "Không tìm thấy hóa đơn!");
            } else if (hd.isPaid()) {
                ra.addFlashAttribute("error", "Hóa đơn đã được thanh toán!");
            } else {
                hoaDonDAO.payInvoice(id, hd.getTongTien(), phuongThuc);
                ra.addFlashAttribute("success", "Thanh toán hóa đơn thành công!");
            }
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/hoadon";
    }

    @GetMapping("/hoadon/delete/{id}")
    public String xoaHoaDon(@PathVariable int id, RedirectAttributes ra) {
        try {
            hoaDonDAO.delete(id);
            ra.addFlashAttribute("success", "Xóa hóa đơn thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/hoadon";
    }

    // ==================== QUẢN LÝ THƯ VIỆN ====================
    
    @GetMapping("/thuvien")
    public String quanLyThuVien(Model model) {
        model.addAttribute("sachList", sachDAO.getAll());
        model.addAttribute("danhSachTheLoai", sachDAO.getTheLoaiList());
        return "admin/thuvien-list";
    }

    @GetMapping("/thuvien/add")
    public String themSachForm(Model model) {
        model.addAttribute("sach", new Sach());
        return "admin/thuvien-add";
    }

    @PostMapping("/thuvien/add")
    public String themSach(@ModelAttribute Sach sach, RedirectAttributes ra) {
        try {
            sach.setSoLuongConLai(sach.getSoLuong());
            sach.setTrangThai(sach.getSoLuong() > 0 ? "Còn sách" : "Hết sách");
            sachDAO.add(sach);
            ra.addFlashAttribute("success", "Thêm sách thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/thuvien";
    }

    @GetMapping("/thuvien/edit/{id}")
    public String suaSachForm(@PathVariable int id, Model model) {
        Sach sach = sachDAO.getById(id);
        if (sach == null) return "redirect:/admin/thuvien";
        model.addAttribute("sach", sach);
        return "admin/thuvien-edit";
    }

    @PostMapping("/thuvien/edit")
    public String suaSach(@ModelAttribute Sach sach, RedirectAttributes ra) {
        try {
            sachDAO.update(sach);
            ra.addFlashAttribute("success", "Cập nhật sách thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/thuvien";
    }

    @GetMapping("/thuvien/delete/{id}")
    public String xoaSach(@PathVariable int id, RedirectAttributes ra) {
        try {
            sachDAO.delete(id);
            ra.addFlashAttribute("success", "Xóa sách thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/thuvien";
    }
    
    @GetMapping("/thuvien/muon")
    public String quanLyMuonSach(Model model) {
        model.addAttribute("muonSachList", sachDAO.getAllMuonSach());
        return "admin/thuvien-muon";
    }

    // ==================== QUẢN LÝ CHÍNH SÁCH HỖ TRỢ ====================
    
    @GetMapping("/chinhsach")
    public String quanLyChinhSach(@RequestParam(required = false) String trangThai, Model model) {
        if (trangThai != null && !trangThai.isEmpty()) {
            model.addAttribute("yeuCauList", yeuCauHoTroDAO.getByStatus(trangThai));
            model.addAttribute("trangThaiChon", trangThai);
        } else {
            model.addAttribute("yeuCauList", yeuCauHoTroDAO.getAll());
        }
        return "admin/chinhsach-list";
    }
    
    @PostMapping("/chinhsach/duyet/{id}")
    public String duyetChinhSach(@PathVariable int id, 
                                  @RequestParam String trangThai,
                                  RedirectAttributes ra) {
        try {
            yeuCauHoTroDAO.updateStatus(id, trangThai);
            ra.addFlashAttribute("success", "Cập nhật trạng thái yêu cầu thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/chinhsach";
    }

    // ==================== KHẢO SÁT ====================
    
    @GetMapping("/khaosat")
    public String quanLyKhaoSat(Model model) {
        model.addAttribute("khaoSatList", khaoSatDAO.getAll());
        model.addAttribute("tongKhaoSat", khaoSatDAO.count());
        model.addAttribute("diemTrungBinh", khaoSatDAO.avgSao());
        return "admin/khaosat-list";
    }

    // ==================== THỐNG KÊ NÂNG CAO ====================
    
    @GetMapping("/thongke")
    public String thongKe(Model model) {
        // Thống kê cơ bản
        model.addAttribute("tongSinhVien", sinhVienDAO.count());
        model.addAttribute("tongPhong", phongDAO.count());
        model.addAttribute("phongTrong", phongDAO.countAvailableRooms());
        model.addAttribute("phongDay", phongDAO.count() - phongDAO.countAvailableRooms());
        model.addAttribute("hopDongHieuLuc", hopDongDAO.countActiveContracts());
        model.addAttribute("yeuCauBaoTri", baoTriDAO.count());
        model.addAttribute("yeuCauChuaXuLy", baoTriDAO.countPendingRequests());
        model.addAttribute("yeuCauHoanThanh", baoTriDAO.countCompletedRequests());
        
        // Thống kê sinh viên theo khoa
        model.addAttribute("thongKeTheoKhoa", sinhVienDAO.countByFaculty());
        
        // Thống kê phòng theo tòa nhà
        model.addAttribute("thongKePhongTheoToa", phongDAO.countByBuilding());
        
        // Thống kê hợp đồng theo tháng (12 tháng)
        Map<String, Integer> thongKeHopDongThang = new LinkedHashMap<>();
        Calendar cal = Calendar.getInstance();
        for (int i = 0; i < 12; i++) {
            int thang = cal.get(Calendar.MONTH) + 1;
            int nam = cal.get(Calendar.YEAR);
            thongKeHopDongThang.put(thang + "/" + nam, hopDongDAO.getCountByMonth(thang, nam));
            cal.add(Calendar.MONTH, -1);
        }
        model.addAttribute("thongKeHopDongThang", thongKeHopDongThang);
        
        // Doanh thu theo tháng
        Map<String, Double> doanhThuThang = new LinkedHashMap<>();
        cal = Calendar.getInstance();
        for (int i = 0; i < 6; i++) {
            String ky = new SimpleDateFormat("MM/yyyy").format(cal.getTime());
            doanhThuThang.put(ky, hoaDonDAO.getRevenueByMonth(ky));
            cal.add(Calendar.MONTH, -1);
        }
        model.addAttribute("doanhThuThang", doanhThuThang);
        
        return "admin/thongke";
    }
    
    @GetMapping("/thongke/export")
    public String exportThongKe() {
        // TODO: Xuất báo cáo Excel
        return "redirect:/admin/thongke";
    }

    // ==================== CÀI ĐẶT HỆ THỐNG ====================
    
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        NhanVien admin = (NhanVien) session.getAttribute("admin");
        if (admin == null) return "redirect:/admin/login";
        model.addAttribute("admin", nhanVienDAO.getById(admin.getIdNhanVien()));
        return "admin/profile";
    }
    
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam int id,
                                @RequestParam String hoTen,
                                @RequestParam String sdt,
                                @RequestParam String email,
                                HttpSession session,
                                RedirectAttributes ra) {
        try {
            NhanVien nv = nhanVienDAO.getById(id);
            nv.setHoTen(hoTen);
            nv.setSdt(sdt);
            nv.setEmail(email);
            nhanVienDAO.update(nv);
            session.setAttribute("admin", nv);
            ra.addFlashAttribute("success", "Cập nhật thông tin thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/profile";
    }
    
    @PostMapping("/profile/changepassword")
    public String changePassword(@RequestParam int id,
                                 @RequestParam String matKhauCu,
                                 @RequestParam String matKhauMoi,
                                 HttpSession session,
                                 RedirectAttributes ra) {
        try {
            NhanVien nv = nhanVienDAO.getById(id);
            if (!nv.getMatKhau().equals(matKhauCu)) {
                ra.addFlashAttribute("errorPass", "Mật khẩu cũ không đúng!");
                return "redirect:/admin/profile";
            }
            nhanVienDAO.updatePassword(id, matKhauMoi);
            ra.addFlashAttribute("successPass", "Đổi mật khẩu thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("errorPass", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/profile";
    }

    // ==================== LOG HỆ THỐNG ====================
    
    @GetMapping("/logs")
    public String xemLogs(Model model) {
        // TODO: Lấy log từ database
        return "admin/logs";
    }
}