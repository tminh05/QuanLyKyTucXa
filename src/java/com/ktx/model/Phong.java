package com.ktx.model;

public class Phong {
    private int idPhong;
    private Integer idToaNha;
    private Integer idLoaiPhong;
    private String tenPhong;
    private int sucChua;
    private int soNguoiHienTai;
    private String trangThai;
    private String tenToaNha;
    private String tenLoaiPhong;
    private double giaPhong;

    public Phong() {}

    public Phong(int idToaNha, int idLoaiPhong, String tenPhong, int sucChua) {
        this.idToaNha = idToaNha;
        this.idLoaiPhong = idLoaiPhong;
        this.tenPhong = tenPhong;
        this.sucChua = sucChua;
        this.soNguoiHienTai = 0;
        this.trangThai = "Trống";
    }

    public int getIdPhong() { 
    return idPhong; }
    
    public void setIdPhong(int idPhong) {
        this.idPhong = idPhong; 
    }

    public Integer getIdToaNha() { 
        return idToaNha; 
    }
    
    public void setIdToaNha(Integer idToaNha) { 
        this.idToaNha = idToaNha; 
    }

    public Integer getIdLoaiPhong() { 
        return idLoaiPhong; 
    }
    
    public void setIdLoaiPhong(Integer idLoaiPhong) { 
        this.idLoaiPhong = idLoaiPhong; 
    }

    public String getTenPhong() { 
        return tenPhong; 
    }
    
    public void setTenPhong(String tenPhong) { 
        this.tenPhong = tenPhong; }

    public int getSucChua() { 
        return sucChua; 
    }
    
    public void setSucChua(int sucChua) { 
        this.sucChua = sucChua; 
    }

    public int getSoNguoiHienTai() { 
        return soNguoiHienTai; 
    }
    
    public void setSoNguoiHienTai(int soNguoiHienTai) { 
        this.soNguoiHienTai = soNguoiHienTai; 
    }

    public String getTrangThai() { 
        return trangThai; 
    }
    
    public void setTrangThai(String trangThai) { 
        this.trangThai = trangThai; 
    }

    public String getTenToaNha() { 
        return tenToaNha; 
    }
    
    public void setTenToaNha(String tenToaNha) { 
        this.tenToaNha = tenToaNha; 
    }

    public String getTenLoaiPhong() { 
        return tenLoaiPhong; 
    }
    
    public void setTenLoaiPhong(String tenLoaiPhong) { 
        this.tenLoaiPhong = tenLoaiPhong; 
    }

    public double getGiaPhong() { 
        return giaPhong; 
    }
    
    public void setGiaPhong(double giaPhong) { 
        this.giaPhong = giaPhong; }

    public boolean isAvailable() { 
        return soNguoiHienTai < sucChua; 
    }
    
    public boolean isFull() { 
        return soNguoiHienTai >= sucChua; 
    }
    
    public int getAvailableSlots() { 
        return sucChua - soNguoiHienTai; 
    }

    @Override
    public String toString() {
        return tenPhong + " (" + tenToaNha + ")";
    }
}