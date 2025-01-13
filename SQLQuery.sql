-- Tạo cơ sở dữ liệu
CREATE DATABASE CuaHangBanQuanAo;
GO

USE CuaHangDienTu;
GO

-- Tạo bảng nhân viên (Phải tạo bảng nhân viên trước để có thể tham chiếu tới nó)
CREATE TABLE NhanVien (
    MaNhanVien INT PRIMARY KEY IDENTITY(1,1),
    Ten NVARCHAR(100) NOT NULL,
    ChucVu NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    MatKhau NVARCHAR(50) NOT NULL
);

-- Tạo bảng khách hàng
CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY IDENTITY(1,1),
    Ten NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    MatKhau NVARCHAR(50) NOT NULL,
    DienThoai NVARCHAR(15),
    DiaChi NVARCHAR(255),
    NgayDangKy DATETIME DEFAULT GETDATE()
);

-- Tạo bảng sản phẩm
CREATE TABLE SanPham (
    MaSanPham INT PRIMARY KEY IDENTITY(1,1),
    TenSanPham NVARCHAR(100) NOT NULL,
    DanhMuc NVARCHAR(50),
    Gia DECIMAL(10, 2) NOT NULL,
    TonKho INT NOT NULL,
    MoTa NVARCHAR(255),
    HinhAnh NVARCHAR(255),
    NgayTao DATETIME DEFAULT GETDATE(),
    MaNhanVien INT, -- Liên kết với nhân viên quản lý sản phẩm
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

-- Tạo bảng đơn hàng
CREATE TABLE DonHang (
    MaDonHang INT PRIMARY KEY IDENTITY(1,1),
    MaKhachHang INT NOT NULL,
    NgayDatHang DATETIME DEFAULT GETDATE(),
    TongTien DECIMAL(10, 2) NOT NULL,
    TrangThai NVARCHAR(50) DEFAULT 'Đang xử lý',
    MaNhanVien INT, -- Liên kết với nhân viên xử lý đơn hàng
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

-- Tạo bảng chi tiết đơn hàng
CREATE TABLE ChiTietDonHang (
    MaChiTietDonHang INT PRIMARY KEY IDENTITY(1,1),
    MaDonHang INT NOT NULL,
    MaSanPham INT NOT NULL,
    SoLuong INT NOT NULL,
    DonGia DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

-- Tạo bảng giỏ hàng
CREATE TABLE GioHang (
    MaGioHang INT PRIMARY KEY IDENTITY(1,1),
    MaKhachHang INT NOT NULL,
    NgayTao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

-- Tạo bảng chi tiết giỏ hàng
CREATE TABLE ChiTietGioHang (
    MaChiTietGioHang INT PRIMARY KEY IDENTITY(1,1),
    MaGioHang INT NOT NULL,
    MaSanPham INT NOT NULL,
    SoLuong INT NOT NULL,
    FOREIGN KEY (MaGioHang) REFERENCES GioHang(MaGioHang),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

-- Tạo bảng thanh toán
CREATE TABLE ThanhToan (
    MaThanhToan INT PRIMARY KEY IDENTITY(1,1),
    MaDonHang INT NOT NULL,
    NgayThanhToan DATETIME DEFAULT GETDATE(),
    PhuongThucThanhToan NVARCHAR(50),
    SoTien DECIMAL(10, 2) NOT NULL,
    MaNhanVien INT, -- Liên kết với nhân viên thực hiện thanh toán
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);
