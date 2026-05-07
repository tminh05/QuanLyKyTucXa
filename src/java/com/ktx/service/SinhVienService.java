package com.ktx.service;

import com.ktx.dao.SinhVienDAO;
import com.ktx.model.SinhVien;
import com.ktx.model.HopDong;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.regex.Pattern;

@Service
@Transactional
public class SinhVienService {
    
    @Autowired
    private SinhVienDAO sinhVienDAO;
    
    // Lấy tất cả sinh viên
    public List<SinhVien> getAllSinhVien() {
        return sinhVienDAO.getAll();
    }
    
    // Lấy sinh viên theo MSSV
    public SinhVien getSinhVienById(String mssv) {
        if (mssv == null || mssv.trim().isEmpty()) {
            return null;
        }
        return sinhVienDAO.getById(mssv);
    }
    
    // Thêm sinh viên mới
    public boolean addSinhVien(SinhVien sinhVien) {
        // Validate dữ liệu
        if (!validateSinhVien(sinhVien)) {
            return false;
        }
        
        // Kiểm tra MSSV đã tồn tại
        if (sinhVienDAO.getById(sinhVien.getMssv()) != null) {
            return false;
        }
        
        // Kiểm tra email đã tồn tại
        if (isEmailExists(sinhVien.getEmail())) {
            return false;
        }
        
        // Kiểm tra CCCD đã tồn tại
        if (isCccdExists(sinhVien.getCccd())) {
            return false;
        }
        
        return sinhVienDAO.add(sinhVien) > 0;
    }
    
    // Cập nhật sinh viên
    public boolean updateSinhVien(SinhVien sinhVien) {
        if (!validateSinhVien(sinhVien)) {
            return false;
        }
        
        SinhVien existing = sinhVienDAO.getById(sinhVien.getMssv());
        if (existing == null) {
            return false;
        }
        
        // Kiểm tra email đã tồn tại (trừ chính nó)
        if (!existing.getEmail().equals(sinhVien.getEmail()) && isEmailExists(sinhVien.getEmail())) {
            return false;
        }
        
        // Kiểm tra CCCD đã tồn tại (trừ chính nó)
        if (!existing.getCccd().equals(sinhVien.getCccd()) && isCccdExists(sinhVien.getCccd())) {
            return false;
        }
        
        return sinhVienDAO.update(sinhVien) > 0;
    }
    
    // Xóa sinh viên
    public boolean deleteSinhVien(String mssv) {
        // Kiểm tra sinh viên có hợp đồng đang hiệu lực không
        if (sinhVienDAO.hasActiveContract(mssv)) {
            return false;
        }
        return sinhVienDAO.delete(mssv) > 0;
    }
    
    // Tìm kiếm sinh viên
    public List<SinhVien> searchSinhVien(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllSinhVien();
        }
        return sinhVienDAO.search(keyword);
    }
    
    // Lấy danh sách hợp đồng của sinh viên
    public List<HopDong> getContracts(String mssv) {
        return sinhVienDAO.getContracts(mssv);
    }
    
    // Lấy sinh viên chưa có hợp đồng
    public List<SinhVien> getStudentsWithoutContract() {
        return sinhVienDAO.getStudentsWithoutContract();
    }
    
    // Lấy sinh viên theo lớp
    public List<SinhVien> getByClass(String lop) {
        return sinhVienDAO.getByClass(lop);
    }
    
    // Lấy sinh viên theo khoa
    public List<SinhVien> getByFaculty(String khoa) {
        return sinhVienDAO.getByFaculty(khoa);
    }
    
    // Đếm tổng số sinh viên
    public int countSinhVien() {
        return sinhVienDAO.count();
    }
    
    // Kiểm tra đăng nhập
    public boolean login(String mssv, String matKhau) {
        return sinhVienDAO.checkLogin(mssv, matKhau);
    }
    
    // Validate sinh viên
    private boolean validateSinhVien(SinhVien sv) {
        if (sv == null) return false;
        
        // Kiểm tra MSSV
        if (sv.getMssv() == null || sv.getMssv().trim().isEmpty()) {
            return false;
        }
        
        // Kiểm tra họ tên
        if (sv.getHoTen() == null || sv.getHoTen().trim().isEmpty()) {
            return false;
        }
        
        // Kiểm tra email
        if (sv.getEmail() != null && !sv.getEmail().trim().isEmpty()) {
            if (!isValidEmail(sv.getEmail())) {
                return false;
            }
        }
        
        // Kiểm tra số điện thoại
        if (sv.getSdt() != null && !sv.getSdt().trim().isEmpty()) {
            if (!isValidPhone(sv.getSdt())) {
                return false;
            }
        }
        
        return true;
    }
    
    // Kiểm tra email hợp lệ
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }
    
    // Kiểm tra số điện thoại hợp lệ
    private boolean isValidPhone(String phone) {
        String phoneRegex = "^[0-9]{10,11}$";
        Pattern pattern = Pattern.compile(phoneRegex);
        return pattern.matcher(phone).matches();
    }
    
    // Kiểm tra email đã tồn tại
    public boolean isEmailExists(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        List<SinhVien> list = sinhVienDAO.getAll();
        return list.stream().anyMatch(sv -> email.equals(sv.getEmail()));
    }
    
    // Kiểm tra CCCD đã tồn tại
    public boolean isCccdExists(String cccd) {
        if (cccd == null || cccd.trim().isEmpty()) {
            return false;
        }
        List<SinhVien> list = sinhVienDAO.getAll();
        return list.stream().anyMatch(sv -> cccd.equals(sv.getCccd()));
    }
    
    // Thống kê số lượng sinh viên theo giới tính
    public int countByGender(String gender) {
        List<SinhVien> list = sinhVienDAO.getAll();
        return (int) list.stream().filter(sv -> gender.equals(sv.getGioiTinh())).count();
    }
    
    // Thống kê số lượng sinh viên theo khoa
    public java.util.Map<String, Integer> countByFaculty() {
        List<SinhVien> list = sinhVienDAO.getAll();
        java.util.Map<String, Integer> stats = new java.util.HashMap<>();
        for (SinhVien sv : list) {
            String khoa = sv.getKhoa();
            stats.put(khoa, stats.getOrDefault(khoa, 0) + 1);
        }
        return stats;
    }
}