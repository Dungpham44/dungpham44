-- Tạo cơ sở dữ liệu
CREATE DATABASE CuaHangDienTu;
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
-- Thêm dữ liệu ngẫu nhiên vào bảng NhanVien
INSERT INTO NhanVien (Ten, ChucVu, Email, MatKhau)
VALUES 
('Nguyen Van A', 'Quản lý', 'nguyenvana@example.com', 'password123'),
('Tran Thi B', 'Nhân viên bán hàng', 'tranthib@example.com', 'password123'),
('Le Van C', 'Nhân viên kho', 'levanc@example.com', 'password123');

-- Thêm dữ liệu ngẫu nhiên vào bảng KhachHang
INSERT INTO KhachHang (Ten, Email, MatKhau, DienThoai, DiaChi)
VALUES 
('Pham Van D', 'phamvand@example.com', 'password123', '0123456789', '123 Đường A, Quận 1, TP.HCM'),
('Hoang Thi E', 'hoangthie@example.com', 'password123', '0987654321', '456 Đường B, Quận 2, TP.HCM'),
('Nguyen Van F', 'nguyenvanf@example.com', 'password123', '0912345678', '789 Đường C, Quận 3, TP.HCM');

-- Thêm dữ liệu ngẫu nhiên vào bảng SanPham
INSERT INTO SanPham (TenSanPham, DanhMuc, Gia, TonKho, MoTa, HinhAnh, MaNhanVien)
VALUES 
('Điện thoại iPhone 14', 'Điện thoại', 20000000, 50, 'iPhone 14 mới nhất', 'iphone14.jpg', 1),
('Laptop Dell XPS', 'Laptop', 35000000, 20, 'Laptop cao cấp Dell XPS', 'dellxps.jpg', 2),
('Tai nghe AirPods Pro', 'Phụ kiện', 5000000, 100, 'Tai nghe không dây AirPods Pro', 'airpodspro.jpg', 3);

-- Thêm dữ liệu ngẫu nhiên vào bảng DonHang
INSERT INTO DonHang (MaKhachHang, TongTien, TrangThai, MaNhanVien)
VALUES 
(1, 20000000, 'Đang xử lý', 1),
(2, 5000000, 'Đã giao hàng', 2),
(3, 35000000, 'Hủy', 3);

-- Thêm dữ liệu ngẫu nhiên vào bảng ChiTietDonHang
INSERT INTO ChiTietDonHang (MaDonHang, MaSanPham, SoLuong, DonGia)
VALUES 
(1, 1, 1, 20000000),
(2, 3, 1, 5000000),
(3, 2, 1, 35000000);

-- Thêm dữ liệu ngẫu nhiên vào bảng GioHang
INSERT INTO GioHang (MaKhachHang)
VALUES 
(1),
(2),
(3);

-- Thêm dữ liệu ngẫu nhiên vào bảng ChiTietGioHang
INSERT INTO ChiTietGioHang (MaGioHang, MaSanPham, SoLuong)
VALUES 
(1, 1, 1),
(2, 3, 2),
(3, 2, 1);

-- Thêm dữ liệu ngẫu nhiên vào bảng ThanhToan
INSERT INTO ThanhToan (MaDonHang, PhuongThucThanhToan, SoTien, MaNhanVien)
VALUES 
(1, 'Thẻ tín dụng', 20000000, 1),
(2, 'Chuyển khoản', 5000000, 2),
(3, 'Tiền mặt', 35000000, 3);
