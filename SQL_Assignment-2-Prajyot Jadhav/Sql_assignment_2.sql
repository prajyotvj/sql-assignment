-- Assignment_2-Prajyot Jadhav

DROP DATABASE assignment_2;
GO

CREATE DATABASE assignment_2;
GO

USE assignment_2;
GO

-- table 1
CREATE TABLE Hospital (
	HospitalID INT,
	HospitalName VARCHAR(50),
	Place VARCHAR(50),
	DoctorName VARCHAR(20),
	ContactNo CHAR(10),
	Rooms INT,
	Specialization VARCHAR(20),
);
GO

--table 2
CREATE TABLE Patient (
    PatientID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender CHAR(1),
	DOB DATE,
    Place VARCHAR(50),
    ContactNum VARCHAR(15),
);
GO

--table 3
CREATE TABLE Appointment (
    AppointmentID INT,
    PatientName VARCHAR(50),
    DoctorName VARCHAR(50),
    AppointmentDate DATE,
    AppointmentTime VARCHAR(10),
    RoomNo INT,
);
GO

INSERT INTO Hospital VALUES 
(1,'Apollo Hospital','Mumbai','Dr Yashwant','9874562141',500,'Cardiology'),
(2,'Hedgewar Hospital','Pune','Dr Jain','9754123647',342,'Orthopedic'),
(3,'HCG Cancer Centre','Nashik','Dr Ruikar','9412478962',850,'Cancer'),
(4,'Global Hospitals','Mumbai','Dr Joshi','9756412354',755,'Orthopedic'),
(5,'Ashoka Hospital','Nashik','Dr Kumar','9874562141',500,'Cancer');
GO

INSERT INTO Patient VALUES 
(1,'Prathamesh','More','M','2002-07-27','Nashik','9754123647'),
(2,'Omkar','Kharadkar','M','2002-01-04','Aurangabad','9412478962'),
(3,'Shubham','Jadhav','M','2001-11-24','Nashik','9756412354'),
(4,'Meghna','Patil','F','2003-03-11','Pune','9111412354'),
(5,'Sakshi','Kale','F','2000-11-24','Pune','9314598756');
GO

INSERT INTO Appointment VALUES 
(1,'Prathamesh More','Dr Jain','2024-03-12','11:00',102),
(2,'Omkar Kharadkar','Dr Ruikar','2024-03-11','11:45',110),
(3,'Shubham Jadhav','Dr Yashwant','2024-03-14','12:30',130),
(4,'Meghna Patil','Dr Joshi','2024-03-15','10:00',111),
(5,'Sakshi Kale','Dr Kumar','2024-03-12','10:15',141);
GO

-- returns the all table
SELECT * FROM Hospital;
GO

-- returns the hospital having specialization 'Orthopedic'
SELECT * FROM Hospital WHERE Specialization = 'Orthopedic';
GO

-- returns the hospital having specialization 'Cancer'
SELECT * FROM Hospital WHERE Specialization = 'Cancer';
GO

SELECT * FROM Patient;
GO

SELECT * FROM Appointment;
GO