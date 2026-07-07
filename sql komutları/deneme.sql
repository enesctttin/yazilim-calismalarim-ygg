USE sample;
GO

CREATE TABLE Soy (
    SoyadID INT IDENTITY(1,1) PRIMARY KEY, 
    Soyad NVARCHAR(50)
);

CREATE TABLE Cinsiyet (
    CinsiyetID INT IDENTITY(1,1) PRIMARY KEY,
    Cinsiyet NVARCHAR(50)
);


CREATE TABLE Kisi (
    KisiID INT IDENTITY(1,1) PRIMARY KEY,
    Ad NVARCHAR(50) NOT NULL,
    SoyID INT,
    CinsID INT,

    CONSTRAINT FK_soyad FOREIGN KEY (SoyID) REFERENCES Soy(SoyadID),
    CONSTRAINT FK_cinsii FOREIGN KEY (CinsID) REFERENCES Cinsiyet(CinsiyetID)
);
GO


INSERT INTO Cinsiyet (Cinsiyet) 
VALUES ('Kadın'), ('Erkek'), ('Belirtmek İstemiyor');
delete from Cinsiyet where Cinsiyet='Belirtmek İstemiyor'

INSERT INTO Soy (Soyad) 
VALUES ('Yılmaz'), ('Çetin'), ('Kaya');

INSERT INTO Kisi (Ad, SoyID, CinsID) 
VALUES 
('Ayşe', 1, 1), -- Ayşe (SoyID: 1=Yılmaz, CinsID: 1=Kadın)
('Enes', 2, 2), -- Enes (SoyID: 2=Çetin, CinsID: 2=Erkek)
('Ali', 3, 2);  -- Ali  (SoyID: 3=Kaya, CinsID: 2=Erkek)

select * from Kisi
select * from Soy
select * from Cinsiyet

SELECT 
    k.Ad, 
    s.Soyad, 
    c.Cinsiyet 
FROM Kisi k
INNER JOIN Soy s ON k.SoyID = s.SoyadID
INNER JOIN Cinsiyet c ON k.CinsID = c.CinsiyetID;
