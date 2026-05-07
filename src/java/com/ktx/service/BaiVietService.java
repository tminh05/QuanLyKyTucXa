package com.ktx.service;

import com.ktx.dao.BaiVietDAO;
import com.ktx.model.BaiViet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BaiVietService {

    @Autowired
    private BaiVietDAO dao;

    public List<BaiViet> getDanhSachTheoLoai(String loai) {
        return dao.getDanhSachTheoLoai(loai);
    }

    public BaiViet getChiTiet(int id) {
        dao.tangLuotXem(id);
        return dao.getBaiVietById(id);
    }
}