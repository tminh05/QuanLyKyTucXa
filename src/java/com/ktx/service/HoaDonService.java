package com.ktx.service;

import com.ktx.dao.HoaDonDAO;
import com.ktx.model.HoaDon;
import com.ktx.model.ThanhToan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class HoaDonService {
    
    @Autowired
    private HoaDonDAO hoaDonDAO;
    
    public List<HoaDon> getAllHoaDon() {
        return hoaDonDAO.getAll();
    }
    
    public HoaDon getHoaDonById(int id) {
        return hoaDonDAO.getById(id);
    }
    
    public boolean addHoaDon(HoaDon hoaDon) {
        if (hoaDon == null) return false;
        return hoaDonDAO.add(hoaDon) > 0;
    }
    
    public boolean updateHoaDon(HoaDon hoaDon) {
        if (hoaDon == null) return false;
        return hoaDonDAO.update(hoaDon) > 0;
    }
    
    public boolean deleteHoaDon(int id) {
        return hoaDonDAO.delete(id) > 0;
    }
    
    public List<HoaDon> getByRoom(int phongId) {
        return hoaDonDAO.getByRoom(phongId);
    }
    
    public List<HoaDon> getUnpaidInvoices() {
        return hoaDonDAO.getUnpaidInvoices();
    }
    
    public boolean payInvoice(int hoaDonId, double soTien, String phuongThuc) {
        HoaDon hd = hoaDonDAO.getById(hoaDonId);
        if (hd == null || hd.isPaid()) {
            return false;
        }
        return hoaDonDAO.payInvoice(hoaDonId, soTien, phuongThuc) > 0;
    }
    
    public double getRevenueByMonth(String month) {
        return hoaDonDAO.getRevenueByMonth(month);
    }
    
    public List<ThanhToan> getPaymentHistory(int hoaDonId) {
        return hoaDonDAO.getPaymentHistory(hoaDonId);
    }
}