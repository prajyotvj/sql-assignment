-- Assignment-3-Prajyot-Jadhav

DROP DATABASE assignment_3;
GO

CREATE DATABASE assignment_3;
GO

USE assignment_3;
GO

-- Department Table
CREATE TABLE Department (
	department_id INT PRIMARY KEY,
	department_name VARCHAR(50),
	hod VARCHAR(25),
	Location VARCHAR(50),
	teacher_count INT
);
GO

-- Student Table
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    department_id INT,
	gender CHAR(1),
    admission_year INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);
GO

-- Teacher Table
CREATE TABLE Teacher (
	teacher_id INT PRIMARY KEY,
	teacher_name VARCHAR(20),
	department_id INT,
	Course VARCHAR(50),
	age INT,
	Gender CHAR(1),
	FOREIGN KEY (department_id) REFERENCES Department(department_id)
);
GO

INSERT INTO Department
VALUES 
(1, 'Computer Science', 'Dr. Ankita karale', 'Building C', 6),
(2, 'Mechanical', 'Dr Amol Potgantwar', 'Building D', 4),
(3, 'Electrical', 'Dr Pramod Patil', 'Building E', 2),
(4, 'Entc', 'Dr Milind Patil', 'Building B', 4),
(5, 'Civil', 'Dr Namrata ghuse', 'Building A', 5);
GO

SELECT * FROM Department;
GO 

INSERT INTO Teacher 
VALUES 
(101, 'Pallavi More', 2, 'Fluid Dynamics', 48,'F'),
(102, 'Pawan Warade', 1, 'Data Structure', 52,'M'),
(103, 'Pradeep Patil', 3, 'Control System', 42,'M'),
(104, 'Sushmita Jadhav', 5, 'Structural Strength', 38,'F'),
(105, 'Lata Nair', 4, 'Digital Electronics', 47,'F'),
(106, 'Sangeeta Pawar', 2, 'TOM', 42,'F'),
(107, 'Uma Kaldate', 1, 'Computer Networks', 38,'F'),
(108, 'Keshav shinde', 3, 'Signals and Systems', 35,'M'),
(109, 'Mayuresh Patil', 5, 'Construction Mangement', 38,'M'),
(110, 'Lata Pawar', 4, 'Digital Circuits', 37,'F');
GO

SELECT * FROM Teacher;
GO

INSERT INTO Student
VALUES
(201, 'Prajyot Jadhav', 1,'M', 2020),
(202, 'Prathamesh More', 3,'M', 2019),
(203, 'Jeet Tripude', 5,'M',2021),
(204, 'Sakshi Kangaira', 1,'F', 2021),
(205, 'Shruti Patil', 2,'F', 2020),
(206, 'Sujal Kaldate', 4,'M', 2021),
(207, 'Prasad Shelar', 1,'M', 2019),
(208, 'Ketki Patil', 2,'F', 2020),
(209, 'Yash tamkhane', 3,'M', 2021),
(210, 'Vineet Jadhav', 3,'M', 2019),
(211, 'Gitesh Makhwane', 4,'M', 2020),
(212, 'Udayraj Kadam', 4,'M', 2021),
(213, 'Vrushali Pawar', 4,'F', 2019),
(214, 'Om Joglekar', 5,'M', 2019),
(215, 'Pratik Patil', 4,'M', 2021);
GO

SELECT * FROM Student;
GO

-- calculating the average age of the teacher
SELECT AVG(age) AS average_age
FROM Teacher;
GO

SELECT MAX(admission_year) AS max_admission_year
FROM Student;
GO

-- getting the count of the student
SELECT COUNT(*) FROM Student;
SELECT COUNT(gender) AS male_student FROM Student WHERE gender = 'M';
SELECT COUNT(gender) AS female_student FROM Student WHERE gender = 'F';
GO

-- getting the count of the student according to the year they took admission
SELECT admission_year, COUNT(*) AS year_count
FROM Student 
GROUP BY admission_year
GO

-- getting the count of male and female teacher
SELECT Gender, COUNT(*) AS teacher_count
FROM Teacher
GROUP BY Gender;
GO

-- teacher above age 40
SELECT teacher_name AS teacher_above_40
FROM Teacher
WHERE age > 40
GROUP BY teacher_name;
GO

-- getting the count of male and female teacher
SELECT Gender, COUNT(*) AS teacher_count
FROM Teacher
GROUP BY Gender;
GO

-- department having student count more the 2
SELECT department_id, COUNT(*) AS student_count
FROM Student
GROUP BY department_id
HAVING COUNT(*) > 2;
GO

--Predefined Functions
SELECT SUM(teacher_count) AS total_teachers FROM Department;
SELECT AVG(age) AS average_age FROM Teacher;
SELECT LEN(teacher_name) AS name_length FROM Teacher;
SELECT LEFT('Student', 3) AS extracted_string;
SELECT RIGHT('Student', 3) AS extracted_string;
SELECT UPPER(student_name) FROM Student;
SELECT LOWER(student_name) FROM Student;
SELECT REVERSE(teacher_name) FROM Teacher;
SELECT CONCAT('Student ', 'of ', 'Computer ', 'Department') AS Concated_String;
SELECT LTRIM('   Student of Computer Department') AS trimed_string;SELECT REPLACE(hod, 'Dr', 'Engg') AS modified_teacher_name FROM Department;
GO