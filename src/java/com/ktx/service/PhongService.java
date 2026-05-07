package com.ktx.service;

import com.ktx.dao.PhongDAO;
import com.ktx.dao.ToaNhaDAO;
import com.ktx.dao.LoaiPhongDAO;
import com.ktx.model.Phong;
import com.ktx.model.SinhVien;
import com.ktx.model.ThietBi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class PhongService {
    
    @Autowired
    private PhongDAO phongDAO;
    
    @Autowired
    private ToaNhaDAO toaNhaDAO;
    
    @Autowired
    private LoaiPhongDAO loaiPhongDAO;
    
    // Lấy tất cả phòng
    public List<Phong> getAllPhong() {
        return phongDAO.getAll();
    }
    
    // Lấy phòng theo ID
    public Phong getPhongById(int id) {
        return phongDAO.getById(id);
    }
    
    // Thêm phòng mới
    public boolean addPhong(Phong phong) {
        if (!validatePhong(phong)) {
            return false;
        }
        
        // Kiểm tra tên phòng đã tồn tại trong tòa nhà
        if (phongDAO.isPhongExists(phong.getTenPhong(), phong.getIdToaNha())) {
            return false;
        }
        
        // Kiểm tra tòa nhà tồn tại
        if (toaNhaDAO.getById(phong.getIdToaNha()) == null) {
            return false;
        }
        
        // Kiểm tra loại phòng tồn tại
        if (loaiPhongDAO.getById(phong.getIdLoaiPhong()) == null) {
            return false;
        }
        
        return phongDAO.add(phong) > 0;
    }
    
    // Cập nhật phòng
    public boolean updatePhong(Phong phong) {
        if (!validatePhong(phong)) {
            return false;
        }
        
        Phong existing = phongDAO.getById(phong.getIdPhong());
        if (existing == null) {
            return false;
        }
        
        // Nếu đổi tên phòng, kiểm tra trùng
        if (!existing.getTenPhong().equals(phong.getTenPhong()) &&
            phongDAO.isPhongExists(phong.getTenPhong(), phong.getIdToaNha())) {
            return false;
        }
        
        return phongDAO.update(phong) > 0;
    }
    
    // Xóa phòng
    public boolean deletePhong(int id) {
        // Kiểm tra phòng có sinh viên đang ở không
        if (phongDAO.hasStudents(id)) {
            return false;
        }
        return phongDAO.delete(id) > 0;
    }
    
    // Tìm kiếm phòng
    public List<Phong> searchPhong(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllPhong();
        }
        return phongDAO.search(keyword);
    }
    
    // Lấy phòng theo trạng thái
    public List<Phong> getByStatus(String status) {
        return phongDAO.getByStatus(status);
    }
    
    // Lấy phòng theo tòa nhà
    public List<Phong> getByBuilding(int toaNhaId) {
        return phongDAO.getByBuilding(toaNhaId);
    }
    
    // Lấy danh sách phòng còn trống
    public List<Phong> getAvailableRooms() {
        return phongDAO.getAvailableRooms();
    }
    
    // Lấy danh sách sinh viên trong phòng
    public List<SinhVien> getStudentsInRoom(int phongId) {
        return phongDAO.getStudentsInRoom(phongId);
    }
    
    // Lấy danh sách thiết bị trong phòng
    public List<ThietBi> getEquipment(int phongId) {
        return phongDAO.getEquipment(phongId);
    }
    
    // Đếm tổng số phòng
    public int countPhong() {
        return phongDAO.count();
    }
    
    // Đếm số phòng còn trống
    public int countAvailableRooms() {
        return phongDAO.countAvailableRooms();
    }
    
    // Kiểm tra phòng còn chỗ không
    public boolean hasAvailableSlot(int phongId) {
        return phongDAO.hasAvailableSlot(phongId);
    }
    
    // Validate phòng
    private boolean validatePhong(Phong phong) {
        if (phong == null) return false;
        
        if (phong.getTenPhong() == null || phong.getTenPhong().trim().isEmpty()) {
            return false;
        }
        
        if (phong.getSucChua() <= 0) {
            return false;
        }
        
        return true;
    }
    
    // Thống kê số lượng phòng theo trạng thái
    public java.util.Map<String, Integer> countByStatus() {
        List<Phong> list = phongDAO.getAll();
        java.util.Map<String, Integer> stats = new java.util.HashMap<>();
        for (Phong p : list) {
            String status = p.getTrangThai();
            stats.put(status, stats.getOrDefault(status, 0) + 1);
        }
        return stats;
    }
    
    // Thống kê số lượng phòng theo tòa nhà
    public java.util.Map<String, Integer> countByBuilding() {
        List<Phong> list = phongDAO.getAll();
        java.util.Map<String, Integer> stats = new java.util.HashMap<>();
        for (Phong p : list) {
            String building = p.getTenToaNha();
            stats.put(building, stats.getOrDefault(building, 0) + 1);
        }
        return stats;
    }
    
    // Tính tỷ lệ lấp đầy phòng
    public double getOccupancyRate() {
        int totalRooms = countPhong();
        if (totalRooms == 0) return 0;
        
        int fullRooms = (int) phongDAO.getAll().stream()
                .filter(p -> "Đầy".equals(p.getTrangThai()))
                .count();
        
        return (double) fullRooms / totalRooms * 100;
    }
    
    // Lấy top phòng có số lượng sinh viên đông nhất
    public List<Phong> getTopCrowdedRooms(int limit) {
        List<Phong> list = phongDAO.getAll();
        list.sort((p1, p2) -> Integer.compare(p2.getSoNguoiHienTai(), p1.getSoNguoiHienTai()));
        return list.size() > limit ? list.subList(0, limit) : list;
    }
}