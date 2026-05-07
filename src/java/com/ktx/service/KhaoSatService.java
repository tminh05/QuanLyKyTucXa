package com.ktx.service;

import com.ktx.dao.KhaoSatDAO;
import com.ktx.model.KhaoSat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class KhaoSatService {

    @Autowired
    private KhaoSatDAO dao;

    public void luuKhaoSat(KhaoSat ks) {
        dao.luuKhaoSat(ks);
    }
}