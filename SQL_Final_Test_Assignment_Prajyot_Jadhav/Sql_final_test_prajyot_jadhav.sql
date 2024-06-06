-------------------------------------------------------------------------------------------------------------------------------------------
-- File: Sql_final_test_prajyot_jadhav.sql
-- Author: Prajyot Jadhav
-- Date Created: 2024-04-01
-- Purpose: This script is used for creation of database of Pharmacy and used to perform queries on created database as given in assignment
   -- Case 1:Get the list of all Pharmacies and Users - PharmacyName, User Full Name (Saleem Shaikh), Day of Birth, Role.
   -- Case 2:Get the total deduction of all users having the role 'Manager'. (Username, TotalDeduction)
-------------------------------------------------------------------------------------------------------------------------------------------

USE master;
GO

-- checks and drop the database if already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'PharmacyDB')
BEGIN
    DROP DATABASE PharmacyDB;
END;
GO

-- creates database 
CREATE DATABASE PharmacyDB;
GO

Use PharmacyDB;
GO

-- Pharmacy Table
CREATE TABLE Pharmacy (
	PharmacyId INT PRIMARY KEY,
    [Name] VARCHAR(100),
    Code VARCHAR(20),
    City VARCHAR(50),
    CreatedDate DATE
);
GO

-- inserting records into pharmacy table
INSERT INTO Pharmacy
(
    PharmacyId,
    [Name],
    Code,
    City,
    CreatedDate
)
VALUES
(101, 'MedPlus', 'P1', 'Nashik', '2021-09-19'),
(102, 'CureWell', 'P2', 'Pune', '2019-03-10'),
(103, 'Vighnaharta', 'P3', 'Mumbai', '2023-10-21'),
(104, 'MedZone', 'P4', 'Nagpur', '2023-07-25'),
(105, 'PharmaPro', 'P5', 'Sambhajinagar', '2022-11-15');
GO


-- User Table
CREATE TABLE [User] 
(
    UserId INT PRIMARY KEY,
    Firstname VARCHAR(50),
    Lastname VARCHAR(50),
    DOB DATE,
    [Role] VARCHAR(50),
    PharmacyId INT,
    CreatedDate DATE,
    FOREIGN KEY (PharmacyId) REFERENCES Pharmacy(PharmacyId)
);
GO

--inserting records in user table
INSERT INTO [User]
(
    UserId,
    Firstname,
    Lastname,
    DOB,
    [Role],
    PharmacyId,
    CreatedDate
)
VALUES
(111, 'Prathamesh', 'More', '2001-07-28', 'Manager', 101, '2021-09-19'),
(112, 'Rajendra', 'Kumar', '2003-02-02', 'User', 101, '2021-09-19'),
(113, 'Shubham', 'Jadhav', '1999-10-14', 'User', 101, '2021-09-19'),
(114, 'Yash', 'Thamkhane', '2003-12-30', 'Manager', 102, '2019-03-10'),
(115, 'Kishore', 'Patil', '1998-07-21', 'User', 102, '2019-03-10'),
(116, 'Pratik', 'Patil', '2000-09-08', 'User', 102, '2019-03-10'),
(117, 'Prasad', 'Shelar', '1999-02-17', 'Manager', 103, '2023-10-21'),
(118, 'Shubham', 'Patil', '1996-10-16', 'User', 103, '2023-10-21'),
(119, 'Harish', 'Jadav', '2004-11-05', 'User', 103, '2023-10-21'),
(120, 'Vineet', 'Jadhav', '2002-05-11', 'Manager', 104, '2023-07-25'),
(121, 'Mayuresh', 'Patil', '1999-12-31', 'User', 104, '2023-07-25'),
(122, 'Om', 'kharadkar', '2001-12-12', 'User', 104, '2023-07-25'),
(123, 'Sanket', 'Jagtap', '2003-03-28', 'Manager', 105, '2022-11-15'),
(124, 'Atharva', 'Waghmare', '1998-05-11', 'User', 105, '2022-11-15'),
(125, 'Pratik', 'More', '2002-01-19', 'User', 105, '2022-11-15');
GO

-- display the User table records
SELECT UserId,
       Firstname,
       Lastname,
       DOB,
       [Role],
       PharmacyId,
       CreatedDate
FROM [User];
GO

-- PaymentCode table
CREATE TABLE PaymentCode 
(
    PaymentCodeId INT PRIMARY KEY,
    PaymentCode VARCHAR(50),
    DeductionRate DECIMAL(5,2)
);
GO

-- inserting the records into PaymentCode table
INSERT INTO PaymentCode
(
    PaymentCodeId,
    PaymentCode,
    DeductionRate
)
VALUES
(311, 'BASICPAY', 0),
(322, 'PF', 4.1),
(333, 'PENSION', 5.2);
GO

-- Payslip table
CREATE TABLE Payslip 
(
    PayslipId INT PRIMARY KEY,
    PaymentCodeId INT,
    UserId INT,
    FOREIGN KEY (PaymentCodeId) REFERENCES PaymentCode(PaymentCodeId),
    FOREIGN KEY (UserId) REFERENCES [User](UserId)
);
GO

-- Inserting records in Payslip table
INSERT INTO Payslip
(
    PayslipId,
    PaymentCodeId,
    UserId
)
SELECT ROW_NUMBER() OVER (ORDER BY u.UserId, pc.PaymentCodeId) AS PayslipId,
       pc.PaymentCodeId,
       u.UserId
FROM [User] u
    CROSS JOIN PaymentCode pc;
GO

-- displaying the records of Payslip table
SELECT PayslipId,
       PaymentCodeId,
       UserId
FROM Payslip;
GO

-- Salary table
CREATE TABLE Salary 
(
    SalaryId INT PRIMARY KEY,
    UserId INT,
    GrossAmount DECIMAL(10, 2),
    Deduction DECIMAL(10, 2),
    NetAmount DECIMAL(10, 2),
    SalaryDate DATE,
    FOREIGN KEY (UserId) REFERENCES [User](UserId)
)
GO

-- Function to calculate total deduction
CREATE FUNCTION CalculateDeduction (@Gross DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @PF DECIMAL(10, 2);
    DECLARE @Pension DECIMAL(10, 2);
    DECLARE @TotalDeduction DECIMAL(10, 2);
    SET @PF = @Gross * 0.041;
    SET @Pension = @Gross * 0.052;
    SET @TotalDeduction = @PF + @Pension;
    RETURN @TotalDeduction;
END;
GO

-- Function to calculate NetAmount
CREATE FUNCTION CalculateNetAmount
(
    @Gross DECIMAL(10, 2),
    @Deduction DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Net DECIMAL(10, 2);
    SET @Net = @Gross - @Deduction;
    RETURN @Net;
END;
GO


-- Insert data into the Salary table while calculating deductions and NetAmount
INSERT INTO Salary
(
    SalaryId,
    UserId,
    GrossAmount,
    Deduction,
    NetAmount,
    SalaryDate
)
VALUES 
(201, 111, 70000.00,dbo.CalculateDeduction(70000.00),dbo.CalculateNetAmount(70000.00,dbo.CalculateDeduction(70000.00)), '2024-03-01'),
(202, 112, 42000.00,dbo.CalculateDeduction(42000.00),dbo.CalculateNetAmount(42000.00,dbo.CalculateDeduction(42000.00)), '2024-03-01'),
(203, 113, 38000.00,dbo.CalculateDeduction(38000.00),dbo.CalculateNetAmount(38000.00,dbo.CalculateDeduction(38000.00)), '2024-03-01'),
(204, 114, 82000.00,dbo.CalculateDeduction(82000.00),dbo.CalculateNetAmount(82000.00,dbo.CalculateDeduction(82000.00)), '2024-03-01'),
(205, 115, 25000.00,dbo.CalculateDeduction(25000.00),dbo.CalculateNetAmount(25000.00,dbo.CalculateDeduction(25000.00)), '2024-03-01'),
(206, 116, 30000.00,dbo.CalculateDeduction(30000.00),dbo.CalculateNetAmount(30000.00,dbo.CalculateDeduction(30000.00)), '2024-03-02'),
(207, 117, 65000.00,dbo.CalculateDeduction(65000.00),dbo.CalculateNetAmount(65000.00,dbo.CalculateDeduction(65000.00)), '2024-03-02'),
(208, 118, 29000.00,dbo.CalculateDeduction(29000.00),dbo.CalculateNetAmount(29000.00,dbo.CalculateDeduction(29000.00)), '2024-03-02'),
(209, 119, 31000.00,dbo.CalculateDeduction(31000.00),dbo.CalculateNetAmount(31000.00,dbo.CalculateDeduction(31000.00)), '2024-03-02'),
(210, 120, 68000.00,dbo.CalculateDeduction(68000.00),dbo.CalculateNetAmount(68000.00,dbo.CalculateDeduction(68000.00)), '2024-03-02'),
(211, 121, 50000.00,dbo.CalculateDeduction(50000.00),dbo.CalculateNetAmount(50000.00,dbo.CalculateDeduction(50000.00)), '2024-03-01'),
(212, 122, 50000.00,dbo.CalculateDeduction(50000.00),dbo.CalculateNetAmount(50000.00,dbo.CalculateDeduction(50000.00)), '2024-03-01'),
(213, 123, 92000.00,dbo.CalculateDeduction(92000.00),dbo.CalculateNetAmount(92000.00,dbo.CalculateDeduction(92000.00)), '2024-03-01'),
(214, 124, 65000.00,dbo.CalculateDeduction(65000.00),dbo.CalculateNetAmount(65000.00,dbo.CalculateDeduction(65000.00)), '2024-03-01'),
(215, 125, 52000.00,dbo.CalculateDeduction(52000.00),dbo.CalculateNetAmount(52000.00,dbo.CalculateDeduction(52000.00)), '2024-03-01');
GO

-- displaying the records of Salary table
Select SalaryId,
       UserId,
       GrossAmount,
       Deduction,
       NetAmount,
       SalaryDate
FROM Salary;
GO

-- Procedure to execute the case 1 and case 2.
CREATE PROCEDURE GetTheResultOfQueries @Case INT
AS
BEGIN
    IF @Case = 1 -- To Get the list of all Pharmacies and Users
    BEGIN
        SELECT P.Name AS PharmacyName,
               CONCAT(U.Firstname, ' ', U.Lastname) AS UserFullName,
               U.DOB,
               U.Role
        FROM Pharmacy P
            JOIN [User] U
                ON P.PharmacyId = U.PharmacyId;
    END
    ELSE IF @Case = 2 -- To Get the total deduction of all users having the role 'Manager'
    BEGIN
        SELECT CONCAT(U.Firstname, ' ', U.Lastname) AS Username,
               SUM(S.Deduction) AS TotalDeduction
        FROM [User] U
            JOIN Salary S
                ON U.UserId = S.UserId
        WHERE [Role] = 'Manager'
        GROUP BY CONCAT(U.Firstname, ' ', U.Lastname);
    END
END;
GO

-- CASE 1: Get the list of all Pharmacies and Users - PharmacyName, User Full Name (Saleem Shaikh), Day of Birth, Role.
EXEC GetTheResultOfQueries @Case = 1;
GO

-- CASE 2: Get the total deduction of all users having the role 'Manager'. (Username, TotalDeduction)
EXEC GetTheResultOfQueries @Case = 2;
GO