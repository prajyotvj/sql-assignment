-------------------------------------------------------------------------------------------
-- Script: Sql_assignment_5.sql
-- Author: Prajyot Jadhav
-- Created Date: 2024-03-29
-- Purpose: Assignment for practice of stored procedure and functions
-------------------------------------------------------------------------------------------

USE master;
GO

-- checks and drop database if it already exists.
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'ProductStoreDB')
BEGIN
    DROP DATABASE ProductStoreDB;
END;

-- creating database
CREATE DATABASE ProductStoreDB;
GO

USE ProductStoreDB;
GO

-- User Table
CREATE TABLE Users
(
    UserID INT PRIMARY KEY,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Dob DATE,
    Email VARCHAR(50),
    Contact_no VARCHAR(10)
);
GO

-- Product Table
CREATE TABLE Product
(
    Product_id INT PRIMARY KEY,
    Product_name VARCHAR(50),
    Price DECIMAL(10, 2),
    Rate DECIMAL(10, 2),
    Quantity INT,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users (UserId)
);
GO

-- Inserting data into Users table
INSERT INTO Users
(
    UserId,
    First_name,
    Last_name,
    Dob,
    Email,
    Contact_no
)
VALUES
(101, 'Prathamesh', 'More', '2002-07-27', 'prathamesh@gmail.com', '9547621345'),
(102, 'Omakar', 'Kharadkar', '2001-05-01', 'omkar@gmail.com', '9789356412'),
(103, 'Saurabh', 'Joshi', '2002-05-22', 'saurabh@gmail.com', '884571264'),
(104, 'Yash', 'Tamkhane', '1998-03-12', 'yash@gmail.com', '9978315462'),
(105, 'Pawan', 'Warade', '1999-04-09', 'pawan@gmail.com', '9612478954');
GO

-- Inserting data into Product table
INSERT INTO Product
(
    Product_id,
    Product_name,
    Price,
    Rate,
    Quantity,
    UserId
)
VALUES
(201, 'Bluetooth headphones', 2000, 3500, 2, 101),
(202, 'Usb type c', 200, 455, 1, 101),
(203, 'laptop', 40000, 55000, 3, 101),
(204, 'Smartphone', 20000, 25000, 4, 102),
(205, 'Airdopes', 2000, 2200, 2, 102),
(206, 'table fan', 1000, 1200, 3, 102),
(208, 'Charger', 200, 250, 2, 102),
(209, 'Television', 30000, 32000, 1, 103),
(210, 'Setup box', 1500, 1600, 2, 103),
(211, 'TV Stand', 850, 900, 5, 103),
(212, 'Washing machine', 25000, 26000, 1, 104),
(213, 'Washing Powder', 250, 300, 3, 104),
(214, 'Mixer', 1250, 1500, 4, 104),
(215, 'Water cooler', 1500, 1550, 1, 105),
(216, 'filter', 2000, 2500, 5, 105),
(217, 'Wire-Socket', 300, 350, 6, 105),
(218, 'Grinder', 1600, 1650, 1, 105);
GO

SELECT UserId,
       First_name,
       Last_name,
       Dob,
       Email,
       Contact_no
FROM Users;
GO

SELECT Product_id,
       Product_name,
       Price,
       Rate,
       Quantity,
       UserId
FROM Product;
GO

-- function to calculate total price
CREATE FUNCTION CalTotalPrice(@Quantity INT,@Rate DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @Quantity * @Rate;
END;
GO

-- function to calculate the discount percentage on product
CREATE FUNCTION CalDiscountPer(@Price DECIMAL(10, 2),@Rate DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN ((@Rate - @Price) / @Rate) * 100;
END;
GO

-- function to calculate the order amount
CREATE FUNCTION CalOrderAmount(@Price DECIMAL(10, 2),@Quantity INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @Price * @Quantity;
END;
GO

-- Procedure for case 1 and case 2
CREATE PROCEDURE GetUserProductAndOrderDetails
	@Case INT,
	@UserId INT = NULL
AS
BEGIN
    IF @Case = 1  -- fetch data of Users with Products
    BEGIN
        SELECT u.UserId, u.First_name, u.Last_name, u.Dob, u.Email, u.Contact_no,
               p.Product_id, p.Product_name, p.Price, p.Rate, p.Quantity
        FROM Users u
        INNER JOIN Product p ON u.UserId = p.UserId;
    END
    ELSE IF @Case = 2 -- fetch per user order details
    BEGIN
        SELECT 
            u.First_name + ' ' + u.Last_name AS Username,
            p.Product_name AS ProductName,
            dbo.CalTotalPrice(p.Quantity, p.Rate) AS TotalPrice,
            dbo.CalDiscountPer(p.Price, p.Rate) AS DiscountInPerc,
            dbo.CalOrderAmount(p.Price, p.Quantity) AS OrderAmount
        FROM Users u
        INNER JOIN Product p ON u.UserId = p.UserId
		WHERE u.UserId = @UserId; 
    END
END;
GO

EXEC GetUserProductAndOrderDetails @Case = 1; -- for Case 1: fetch data of Users with Products
GO

-- for Case 2: fetch per user order details (Username, ProductName, TotalPrice, DiscountInPerc, OrderAmount)
EXEC GetUserProductAndOrderDetails @Case = 2,@UserId = 101;
GO

EXEC GetUserProductAndOrderDetails @Case = 2,@UserId = 102;
GO

EXEC GetUserProductAndOrderDetails @Case = 2,@UserId = 103;
GO

EXEC GetUserProductAndOrderDetails @Case = 2,@UserId = 104;
GO

EXEC GetUserProductAndOrderDetails @Case = 2,@UserId = 105;
GO