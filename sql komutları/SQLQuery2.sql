
-- Database oluşturma
CREATE DATABASE Sample;
GO

-- Database seçme
USE Sample;
GO

-- 1️⃣ tblGender Tablosu
CREATE TABLE tblGender
(
    ID INT NOT NULL PRIMARY KEY,
    Gender NVARCHAR(50) NOT NULL
);
GO

--  Person Tablosu
CREATE TABLE tblPerson
(
    ID INT NOT NULL PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    GenderId INT NULL,

    CONSTRAINT FK_tblPerson_tblGender
    FOREIGN KEY (GenderId)
    REFERENCES tblGender(ID)
);
GO 

INSERT INTO tblGender VALUES ('Male');
INSERT INTO tblGender VALUES ('Female');
INSERT INTO tblGender VALUES ('Unknown');

INSERT INTO tblPerson VALUES ('John','j@j.com',1);
INSERT INTO tblPerson VALUES ('Mary','m@m.com',2);
INSERT INTO tblPerson VALUES ('Simon','s@s.com',1);
INSERT INTO tblPerson VALUES ('Sam','sam@sam.com',1);
INSERT INTO tblPerson VALUES ('May','may@may.com',2);
INSERT INTO tblPerson VALUES ('Kenny','k@k.com',3);