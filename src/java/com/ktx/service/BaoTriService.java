package com.ktx.service;

import com.ktx.dao.BaoTriDAO;
import com.ktx.model.YeuCauBaoTri;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class BaoTriService {
    
    @Autowired
    private BaoTriDAO baoTriDAO;
    
    public List<YeuCauBaoTri> getAllYeuCau() {
        return baoTriDAO.getAll();
    }
    
    public YeuCauBaoTri getYeuCauById(int id) {
        return baoTriDAO.getById(id);
    }
    
    public boolean addYeuCau(YeuCauBaoTri yeuCau) {
        if (yeuCau == null || yeuCau.getNoiDung() == null || yeuCau.getNoiDung().trim().isEmpty()) {
            return false;
        }
        return baoTriDAO.add(yeuCau) > 0;
    }
    
    public boolean updateYeuCau(YeuCauBaoTri yeuCau) {
        if (yeuCau == null) return false;
        return baoTriDAO.update(yeuCau) > 0;
    }
    
    public boolean deleteYeuCau(int id) {
        return baoTriDAO.delete(id) > 0;
    }
    
    public List<YeuCauBaoTri> getByStatus(String status) {
        return baoTriDAO.getByStatus(status);
    }
    
    public List<YeuCauBaoTri> getByRoom(int phongId) {
        return baoTriDAO.getByRoom(phongId);
    }
    
    public boolean assignStaff(int yeuCauId, int nhanVienId) {
        return baoTriDAO.assignStaff(yeuCauId, nhanVienId) > 0;
    }
    
    public boolean completeRequest(int yeuCauId) {
        return baoTriDAO.completeRequest(yeuCauId) > 0;
    }
    
    public int countPendingRequests() {
        return baoTriDAO.countPendingRequests();
    }
    
    public double getAverageProcessTime() {
        return baoTriDAO.getAverageProcessTime();
    }
}