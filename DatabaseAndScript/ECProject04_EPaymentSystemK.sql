CREATE DATABASE EC_PAYMENT_SYSTEM_ACB
CREATE TABLE PG_30_KHACHHANG
(
    MAKH              VARCHAR(10),
    HOTEN             VARCHAR(50),
    NTNS              DATETIME,
    GIOITINH          VARCHAR(10),
    QUOCTICH          VARCHAR(50),
    CMND_PASSPORT     VARCHAR(16),
    NOICAP            VARCHAR(30),
    NGAYCAP           DATETIME,
    DIACHITHUONGTRU   VARCHAR(100),
    DIACHILIENLAC     VARCHAR(100),
    EMAIL             VARCHAR(50),
    TINHTRANGHONNHAN  VARCHAR(30), 
    NGHENGHIEP        VARCHAR(100),
    SDT               INT,
    
    CONSTRAINT PK_KHACHHANG PRIMARY KEY (MAKH)
)

CREATE TABLE PG_30_TAIKHOANDANGNHAP
(
    TENDANGNHAP       VARCHAR(20),
    PASSWORD          VARCHAR(20),
    MAKH              VARCHAR(10),
    
    CONSTRAINT PK_TKDANGNHAP PRIMARY KEY (TENDANGNHAP),
    
)
ALTER TABLE PG_30_TAIKHOANDANGNHAP ADD CONSTRAINT FK_TKDANGNHAP_KH FOREIGN KEY (MAKH) REFERENCES PG_30_KHACHHANG(MAKH)

CREATE TABLE PG_30_TAIKHOAN
(
    SOTAIKHOAN      VARCHAR(20),
    DONVICAPTK      VARCHAR(50),
    NGAYDAOHAN      DATETIME,
    LOAITAIKHOAN    VARCHAR(100),
    NGAYDANGKI      DATETIME,
    MAKH            VARCHAR(10),
    
    CONSTRAINT PK_TAIKHOAN PRIMARY KEY (SOTAIKHOAN)
)
ALTER TABLE PG_30_TAIKHOAN ADD CONSTRAINT FK_TAIKHOAN_KH FOREIGN KEY (MAKH) REFERENCES PG_30_KHACHHANG (MAKH)

CREATE TABLE PG_30_NHACUNGCAP
(
   MANCC              VARCHAR (10),
   TENNCC             VARCHAR(50),
   DIACHI             VARCHAR(100),
   SDT                INT,
   EMAIL              VARCHAR(50),
   
   CONSTRAINT PK_NHACUNGCAP PRIMARY KEY (MANCC)
)

CREATE TABLE PG_30_LOAITHE
(
    MALOAITHE         VARCHAR(10),
    TENLOAITHE        VARCHAR(30),
    SODUTOITHIEU      INT,
    MANCC             VARCHAR(10),
    
    CONSTRAINT PK_LOAITHE PRIMARY KEY (MALOAITHE)
)
ALTER TABLE PG_30_LOAITHE ADD CONSTRAINT FK_LOAITHE_NCC FOREIGN KEY (MANCC) REFERENCES PG_30_NHACUNGCAP (MANCC)

CREATE TABLE PG_30_THETHANHTOAN
(
    SOTHE           VARCHAR(10),
    SODUKHADUNG     INT,
    NGAYLAP         DATETIME,
    TRANGTHAI       VARCHAR,
    HANMUCTINDUNG   INT,
    MALOAITHE       VARCHAR(10),
    SOTAIKHOAN      VARCHAR(20),
    
    CONSTRAINT PK_THETHANHTOAN PRIMARY KEY (SOTHE)
)
ALTER TABLE PG_30_THETHANHTOAN ADD CONSTRAINT FK_LOAITHE_THE FOREIGN KEY (MALOAITHE) REFERENCES PG_30_LOAITHE (MALOAITHE)
ALTER TABLE PG_30_THETHANHTOAN ADD CONSTRAINT FK_TAIKHOAN_THE FOREIGN KEY (SOTAIKHOAN) REFERENCES PG_30_TAIKHOAN (SOTAIKHOAN)

CREATE TABLE PG_30_TAIKHOANTHUHUONG
(
  SOTAIKHOAN        VARCHAR(20),
  TENDONVITHUHUONG  VARCHAR(50),
  TENNGANGHANG      VARCHAR(50),
  DIACHI            VARCHAR(100),
  TRANGTHAI         VARCHAR(30),
  
  CONSTRAINT PK_TAIKHOANTHUHUONG PRIMARY KEY (SOTAIKHOAN)
)

CREATE TABLE PG_30_HOADON
(
  MAHOADON          VARCHAR(10),
  LOAIHOADON        VARCHAR (50),
  NGAYLAP           DATETIME,
  SOTIENTHANHTOAN   INT,
  SOTIENTEXT        VARCHAR(100),
  NOIDUNGGIAODICH   VARCHAR(100),
  PHUONGTHUCXACTHUC VARCHAR(100),
  
  CONSTRAINT PK_HOADON PRIMARY KEY (MAHOADON)
)

CREATE TABLE PG_30_HOADONTHANHTOAN
(
   SOTAIKHOAN      VARCHAR(20),
   MAHOADON        VARCHAR(10),
   SOTAIKHOANTH    VARCHAR(20),
   NGAYTHANHTOAN   DATETIME
   CONSTRAINT PK_HOADONTHANHTOAN PRIMARY KEY (MAHOADON, SOTAIKHOAN, SOTAIKHOANTH)
)
ALTER TABLE PG_30_HOADONTHANHTOAN ADD CONSTRAINT FK_HDTT_TK FOREIGN KEY (SOTAIKHOAN) REFERENCES PG_30_TAIKHOAN (SOTAIKHOAN)
ALTER TABLE PG_30_HOADONTHANHTOAN ADD CONSTRAINT FK_HDTT_HD FOREIGN KEY (MAHOADON) REFERENCES PG_30_HOADON (MAHOADON)
ALTER TABLE PG_30_HOADONTHANHTOAN ADD CONSTRAINT FK_HDTT_TKTH FOREIGN KEY (SOTAIKHOANTH) REFERENCES PG_30_TAIKHOANTHUHUONG (SOTAIKHOAN)