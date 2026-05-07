package com.ktx.service;

import com.ktx.dao.NhanVienDAO;
import com.ktx.model.NhanVien;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.regex.Pattern;

@Service
@Transactional
public class NhanVienService {
    
    @Autowired
    private NhanVienDAO nhanVienDAO;
    
    public List<NhanVien> getAllNhanVien() {
        return nhanVienDAO.getAll();
    }
    
    public NhanVien getNhanVienById(int id) {
        return nhanVienDAO.getById(id);
    }
    
    public boolean addNhanVien(NhanVien nv) {
        if (!validateNhanVien(nv)) {
            return false;
        }
        
        if (nhanVienDAO.isEmailExists(nv.getEmail())) {
            return false;
        }
        
        return nhanVienDAO.add(nv) > 0;
    }
    
    public boolean updateNhanVien(NhanVien nv) {
        if (!validateNhanVien(nv)) {
            return false;
        }
        
        NhanVien existing = nhanVienDAO.getById(nv.getIdNhanVien());
        if (existing == null) {
            return false;
        }
        
        if (!existing.getEmail().equals(nv.getEmail()) && nhanVienDAO.isEmailExists(nv.getEmail())) {
            return false;
        }
        
        return nhanVienDAO.update(nv) > 0;
    }
    
    public boolean deleteNhanVien(int id) {
        return nhanVienDAO.delete(id) > 0;
    }
    
    public List<NhanVien> searchNhanVien(String keyword) {
        return nhanVienDAO.search(keyword);
    }
    
    public boolean login(String email, String matKhau) {
        return nhanVienDAO.checkLogin(email, matKhau);
    }
    
    public List<NhanVien> getManagers() {
        return nhanVienDAO.getManagers();
    }
    
    public List<NhanVien> getTechnicians() {
        return nhanVienDAO.getTechnicians();
    }
    
    private boolean validateNhanVien(NhanVien nv) {
        if (nv == null) return false;
        if (nv.getHoTen() == null || nv.getHoTen().trim().isEmpty()) return false;
        if (nv.getEmail() == null || nv.getEmail().trim().isEmpty()) return false;
        if (!isValidEmail(nv.getEmail())) return false;
        return true;
    }
    
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }
}