CREATE DATABASE Hastane
go 
USE Hastane
GO


CREATE TABLE Hastalar (
    HastaID INT IDENTITY(1,1) PRIMARY KEY,  -- auto-increment
    TCKimlikNo CHAR(11) UNIQUE NOT NULL,
    Ad NVARCHAR(50) NOT NULL,
    Soyad NVARCHAR(50) NOT NULL,
    DogumTarihi DATE,
    KanGrubu VARCHAR(5)
);

CREATE TABLE Klinikler (
    KlinikID INT IDENTITY(1,1) PRIMARY KEY,
    KlinikAdi NVARCHAR(100) NOT NULL
);

CREATE TABLE Doktorlar (
    DoktorID INT IDENTITY(1,1) PRIMARY KEY,
    Ad NVARCHAR(50) NOT NULL,
    Soyad NVARCHAR(50) NOT NULL,
    KlinikID INT NOT NULL,
    
    -- Foreign Key: Bu doktor hangi klinikte çalışıyor?
    CONSTRAINT FK_Doktor_Klinik FOREIGN KEY (KlinikID) REFERENCES Klinikler(KlinikID)
);


CREATE TABLE Muayeneler (
    MuayeneID INT IDENTITY(1,1) PRIMARY KEY,
    HastaID INT NOT NULL,
    DoktorID INT NOT NULL,
    MuayeneTarihi DATETIME DEFAULT GETDATE(),
    Sikayet NVARCHAR(MAX),
    
    CONSTRAINT FK_Muayene_Hasta FOREIGN KEY (HastaID) REFERENCES Hastalar(HastaID),
    CONSTRAINT FK_Muayene_Doktor FOREIGN KEY (DoktorID) REFERENCES Doktorlar(DoktorID)
);


CREATE TABLE Teshisler (
    TeshisID INT IDENTITY(1,1) PRIMARY KEY,
    MuayeneID INT NOT NULL,
    TaniAdi NVARCHAR(200) NOT NULL,
    UygulananIslem NVARCHAR(200),   
    
    CONSTRAINT FK_Teshis_Muayene FOREIGN KEY (MuayeneID) REFERENCES Muayeneler(MuayeneID)
);

CREATE TABLE Ilaclar (
    IlacID INT IDENTITY(1,1) PRIMARY KEY,
    IlacAdi NVARCHAR(100) NOT NULL,
    EtkenMadde NVARCHAR(100)
);

CREATE TABLE ReceteDetay (
    ReceteID INT IDENTITY(1,1) PRIMARY KEY,
    MuayeneID INT NOT NULL,
    IlacID INT NOT NULL,
    Dozaj NVARCHAR(50), 
    
    CONSTRAINT FK_Recete_Muayene FOREIGN KEY (MuayeneID) REFERENCES Muayeneler(MuayeneID),
    CONSTRAINT FK_Recete_Ilac FOREIGN KEY (IlacID) REFERENCES Ilaclar(IlacID)
);