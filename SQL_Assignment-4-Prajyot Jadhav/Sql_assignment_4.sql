-- Assignment-4-Prajyot-Jadhav

DROP DATABASE assignment_4;
GO

CREATE DATABASE assignment_4;
GO

USE assignment_4;
GO

-- creating temporary department table using table variable
DECLARE @Department TABLE (
	Dept_id INT PRIMARY KEY,
	Dept_name VARCHAR(50),
	Dept_hod VARCHAR(50),
	Dept_Location VARCHAR(50)
);

INSERT INTO @Department (Dept_id, Dept_name, Dept_hod, Dept_Location)
VALUES 
(101,'Computer Science','Ankita Karale','C Building'),
(102,'Information Technology','Abhay Gaidhane','B Building'),
(103,'Mechanical','Milind Patil','A Building'),
(104,'Entc','Rahul Gaikwad','E Building'),
(105,'Electrical','Urmila Pawar','D Building');


-- displaying all columns from department table
SELECT * FROM @Department;

-- creating temporary table for teacher 
CREATE TABLE #Teacher (
    Teacher_id INT PRIMARY KEY,
    Teacher_name VARCHAR(50),
    Dept_id INT,
    Teacher_age INT,
	Teacher_salary DECIMAL(10,2),
	Teacher_gender CHAR(1)
);

INSERT INTO #Teacher (Teacher_id, Teacher_name,Dept_id,Teacher_age,Teacher_salary,Teacher_gender)
VALUES
(201, 'Pallavi More', 102,48,50000,'F'),
(202, 'Pawan Warade', 102,52,55000,'M'),
(203, 'Pradeep Patil', 101,42,65000,'M'),
(204, 'Sushmita Jadhav', 101,38,54000,'F'),
(205, 'Lata Nair', 101,47,72000,'F'),
(206, 'Sangeeta Pawar', 105,42,51000,'F'),
(207, 'Uma Kaldate', 105,38,45000,'F'),
(208, 'Keshav shinde',104,43,40000,'M'),
(209, 'Mayuresh Patil',103,48,48000,'M'),
(210, 'Lata Pawar', 103,37,52000,'F'),
(211, 'Vipul Joshi', 104,47,64000,'M'),
(212, 'Atharva Waghmare',104,42,73000,'M'),
(213, 'Shruti Pawar', 105,39,61000,'F'),
(214, 'Pratik Menkar', 104,43,70000,'M'),
(215, 'Harish Jadhav', 103,48,42000,'M');


-- selecting all columns from teacher table 
SELECT * FROM #Teacher;

-- creating temporary student table
CREATE TABLE ##Student (
    Student_id INT PRIMARY KEY,
    Student_name VARCHAR(50),
    Dept_id INT,
	Student_gender CHAR(1),
    Admission_year INT
);

INSERT INTO ##Student
VALUES
(401, 'Prajyot Jadhav', 101,'M', 2020),
(402, 'Prathamesh More', 103,'M', 2019),
(403, 'Jeet Tripude', 105,'M',2021),
(404, 'Sakshi Kangaira', 101,'F', 2021),
(405, 'Shruti Patil', 102,'F', 2020),
(406, 'Sujal Kaldate', 104,'M', 2021),
(407, 'Prasad Shelar', 101,'M', 2019),
(408, 'Ketki Patil', 102,'F', 2020),
(409, 'Yash tamkhane', 103,'M', 2021),
(410, 'Vineet Jadhav', 103,'M', 2019),
(411, 'Gitesh Makhwane', 104,'M', 2020),
(412, 'Udayraj Kadam', 104,'M', 2021),
(413, 'Vrushali Pawar', 104,'F', 2019),
(414, 'Om Joglekar', 105,'M', 2019),
(415, 'Pratik Patil', 104,'M', 2021);

-- selecting all columns from student table
SELECT * FROM ##Student;


-- finding second highest salary of teacher from each department using the CTE
WITH TeacherRank AS (
    SELECT Teacher_id,
           Teacher_name,
           Dept_id,
           Teacher_salary,
           ROW_NUMBER() OVER (PARTITION BY Dept_id ORDER BY Teacher_salary DESC) AS SalaryRank
    FROM #Teacher
)
SELECT Teacher_id, Teacher_name, Dept_id, Teacher_salary
FROM TeacherRank
WHERE SalaryRank = 2;


--getting all teachers details with department name using INNER JOIN for all Departments
SELECT T.Teacher_id, T.Teacher_name, D.Dept_name
FROM #Teacher  As T
INNER JOIN @Department As D ON T.Dept_id = D.Dept_id;


--getting teacher and student details of last department using LEFT JOIN.
DECLARE @last_dep INT;
SELECT TOP 1 @last_dep = Dept_id
FROM @Department
ORDER BY Dept_id DESC;
SELECT t.Teacher_id, t.Teacher_name, s.Student_id, s.Student_name
FROM #Teacher t
LEFT JOIN ##Student s ON t.Dept_id = s.Dept_id
WHERE t.Dept_id = @last_dep;
GO

-- creating Employee table
CREATE TABLE Employee (
	Employee_id INT PRIMARY KEY,
	Frist_name VARCHAR(50),
	Last_name VARCHAR(50),
	Dept_name VARCHAR(50)
);



INSERT INTO Employee (Employee_id,Frist_name,Last_name,Dept_name)
VALUES 
    (1, 'Prathamesh', 'Deo', 'Web dev'),
    (2, 'Shubham', 'Jadhav', 'Anroid dev'),
    (3, 'Omkar', 'Waghmare', 'Frontend'),
    (4, 'Saurabh', 'Joshi', 'Web dev'),
    (5, 'Rohit', 'Kumar', 'Dev ops'),
	(6, 'Omkar', 'Kharadkar', 'Web dev'),
    (7, 'Yash', 'Thamkane', 'Anroid dev'),
    (8, 'Prasad', 'Shelar', 'Frontend'),
    (9, 'Udayraj', 'Kadam', 'Web dev'),
    (10, 'Mrunal', 'Sathe', 'Dev ops');
GO

--selecting all columns from table Employee
SELECT * FROM Employee;
GO

-- creating salary table 
CREATE TABLE Salary (
    Employee_id INT PRIMARY KEY,
    Emp_salary DECIMAL(10, 2),
    Emp_bonus DECIMAL(10, 2)
);
GO

INSERT INTO Salary(Employee_id,Emp_salary,Emp_bonus)
VALUES
(1,60000,5000),
(2,50000,4500),
(3,66000,4000),
(4,52000,5000),
(5,58000,4500),
(6,45000,3000),
(7,47000,4000),
(8,53000,4200),
(9,65000,4500),
(10,62000,4800);
GO

-- selecting all columns form table Salary
SELECT * FROM Salary;
GO

-- selecting the employee of department Web dev
SELECT Frist_name, Last_name FROM Employee WHERE Dept_name ='Web dev' ;
GO

-- inserting the new employee data 
INSERT INTO Employee (Employee_id,Frist_name, Last_name,Dept_name) VALUES (11,'Kishore','Patil','Computer Science');
SELECT * FROM Employee;
GO

-- updating the department of employee_id =3
UPDATE Employee SET Dept_name ='Dev ops'  WHERE Employee_id=3;
SELECT * FROM Employee;
GO

-- deleting the record of employee_id 11
DELETE FROM Employee WHERE Employee_id=11;
GO

-- Selecting the columns of Employee having salary greater than 55000
SELECT * FROM Salary
WHERE Emp_salary > 55000;
GO

-- order the rows of the Employee table in descending order of employee salary
SELECT * FROM Salary
ORDER BY Emp_salary DESC;
GO

--departments with a total employees salary greater than 60000
SELECT 
    Dept_name,
    SUM(Emp_salary) AS Total_salary
FROM 
    Employee
JOIN 
    Salary ON Employee.Employee_id = Salary.Employee_id
GROUP BY 
    Dept_name
HAVING 
    SUM(Emp_salary) > 100000;
GO

--Predefined Functions
SELECT MAX(Emp_salary) AS MaxSalary FROM Salary;
SELECT MIN(Emp_salary) AS MinSalary FROM Salary;
SELECT SUM(Emp_salary) AS total_salary FROM Salary;
SELECT AVG(Emp_salary) AS average_salary FROM Salary;
SELECT UPPER(Frist_name) AS upper_first_name FROM Employee;
SELECT LOWER(Last_name) AS lower_last_name FROM Employee;
SELECT LEFT(Dept_name, 3) AS extracted_col FROM Employee;
SELECT CONCAT(Frist_name, ' ', Last_name) AS full_name FROM Employee;
SELECT COUNT(*) AS total_employees FROM Employee;
SELECT REVERSE(Frist_name) AS reversed_name FROM Employee;
GO
