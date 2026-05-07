package com.ktx.service;

import com.ktx.dao.HopDongDAO;
import com.ktx.dao.SinhVienDAO;
import com.ktx.dao.PhongDAO;
import com.ktx.model.HopDong;
import com.ktx.model.HoaDon;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
@Transactional
public class HopDongService {
    
    @Autowired
    private HopDongDAO hopDongDAO;
    
    @Autowired
    private SinhVienDAO sinhVienDAO;
    
    @Autowired
    private PhongDAO phongDAO;
    
    // Lấy tất cả hợp đồng
    public List<HopDong> getAllHopDong() {
        return hopDongDAO.getAll();
    }
    
    // Lấy hợp đồng theo ID
    public HopDong getHopDongById(int id) {
        return hopDongDAO.getById(id);
    }
    
    // Thêm hợp đồng mới
    public boolean addHopDong(HopDong hopDong) {
        if (!validateHopDong(hopDong)) {
            return false;
        }
        
        // Kiểm tra sinh viên tồn tại
        if (sinhVienDAO.getById(hopDong.getMssv()) == null) {
            return false;
        }
        
        // Kiểm tra phòng tồn tại
        if (phongDAO.getById(hopDong.getIdPhong()) == null) {
            return false;
        }
        
        // Kiểm tra sinh viên đã có hợp đồng hiệu lực chưa
        if (hopDongDAO.hasActiveContract(hopDong.getMssv())) {
            return false;
        }
        
        // Kiểm tra phòng còn chỗ không
        if (!phongDAO.hasAvailableSlot(hopDong.getIdPhong())) {
            return false;
        }
        
        // Kiểm tra ngày hợp lệ
        if (hopDong.getNgayBatDau().after(hopDong.getNgayKetThuc())) {
            return false;
        }
        
        return hopDongDAO.add(hopDong) > 0;
    }
    
    // Cập nhật hợp đồng
    public boolean updateHopDong(HopDong hopDong) {
        if (!validateHopDong(hopDong)) {
            return false;
        }
        
        HopDong existing = hopDongDAO.getById(hopDong.getIdHopDong());
        if (existing == null) {
            return false;
        }
        
        // Kiểm tra ngày hợp lệ
        if (hopDong.getNgayBatDau().after(hopDong.getNgayKetThuc())) {
            return false;
        }
        
        return hopDongDAO.update(hopDong) > 0;
    }
    
    // Xóa hợp đồng
    public boolean deleteHopDong(int id) {
        return hopDongDAO.delete(id) > 0;
    }
    
    // Tìm kiếm hợp đồng
    public List<HopDong> searchHopDong(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllHopDong();
        }
        return hopDongDAO.search(keyword);
    }
    
    // Lấy hợp đồng theo sinh viên
    public List<HopDong> getByStudent(String mssv) {
        return hopDongDAO.getByStudent(mssv);
    }
    
    // Lấy hợp đồng theo phòng
    public List<HopDong> getByRoom(int phongId) {
        return hopDongDAO.getByRoom(phongId);
    }
    
    // Lấy hợp đồng sắp hết hạn
    public List<HopDong> getExpiringContracts() {
        return hopDongDAO.getExpiringContracts();
    }
    
    // Lấy danh sách hóa đơn của hợp đồng
    public List<HoaDon> getInvoices(int hopDongId) {
        return hopDongDAO.getInvoices(hopDongId);
    }
    
    // Đếm tổng số hợp đồng
    public int countHopDong() {
        return hopDongDAO.count();
    }
    
    // Đếm số hợp đồng đang hiệu lực
    public int countActiveContracts() {
        return hopDongDAO.countActiveContracts();
    }
    
    // Gia hạn hợp đồng
    public boolean renewContract(int hopDongId, Date newEndDate) {
        HopDong hopDong = hopDongDAO.getById(hopDongId);
        if (hopDong == null) {
            return false;
        }
        
        if (newEndDate.before(hopDong.getNgayKetThuc())) {
            return false;
        }
        
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        return hopDongDAO.renewContract(hopDongId, sdf.format(newEndDate)) > 0;
    }
    
    // Kiểm tra sinh viên có hợp đồng hiệu lực không
    public boolean hasActiveContract(String mssv) {
        return hopDongDAO.hasActiveContract(mssv);
    }
    
    // Validate hợp đồng
    private boolean validateHopDong(HopDong hopDong) {
        if (hopDong == null) return false;
        
        if (hopDong.getMssv() == null || hopDong.getMssv().trim().isEmpty()) {
            return false;
        }
        
        if (hopDong.getIdPhong() <= 0) {
            return false;
        }
        
        if (hopDong.getNgayBatDau() == null || hopDong.getNgayKetThuc() == null) {
            return false;
        }
        
        return true;
    }
    
    // Tính số ngày còn lại của hợp đồng
    public long getRemainingDays(int hopDongId) {
        HopDong hopDong = hopDongDAO.getById(hopDongId);
        if (hopDong == null || !"Hiệu lực".equals(hopDong.getTrangThai())) {
            return 0;
        }
        
        Date now = new Date();
        if (now.after(hopDong.getNgayKetThuc())) {
            return 0;
        }
        
        long diff = hopDong.getNgayKetThuc().getTime() - now.getTime();
        return TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
    }
    
    // Thống kê số lượng hợp đồng theo tháng
    public java.util.Map<String, Integer> countByMonth(int year) {
        List<HopDong> list = hopDongDAO.getAll();
        java.util.Map<String, Integer> stats = new java.util.HashMap<>();
        
        for (HopDong hd : list) {
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.setTime(hd.getNgayBatDau());
            
            if (cal.get(java.util.Calendar.YEAR) == year) {
                int month = cal.get(java.util.Calendar.MONTH) + 1;
                String key = "Tháng " + month;
                stats.put(key, stats.getOrDefault(key, 0) + 1);
            }
        }
        
        return stats;
    }
    
    // Thống kê doanh thu từ hợp đồng
    public double getTotalRevenue() {
        List<HopDong> list = hopDongDAO.getAll();
        double total = 0;
        
        for (HopDong hd : list) {
            // Giả sử mỗi hợp đồng có giá phòng mỗi tháng
            // Tính số tháng thuê
            long diff = hd.getNgayKetThuc().getTime() - hd.getNgayBatDau().getTime();
            long months = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) / 30;
            if (months <= 0) months = 1;
            
            // Lấy giá phòng từ DAO (cần implement)
            // total += months * getGiaPhong(hd.getIdPhong());
        }
        
        return total;
    }
}