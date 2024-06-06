-- Assignment_1-Prajyot-Jadhav

DROP DATABASE assignment_1;
GO

CREATE DATABASE assignment_1;
GO

USE assignment_1;
GO

CREATE TABLE Book (
	BookID INT PRIMARY KEY,
	Title VARCHAR(50),
	Author VARCHAR(20),
	PublicationYear INT,
	Genre VARCHAR(50),
	Price DECIMAL(10,2)
);
GO

INSERT INTO Book VALUES
    (1, 'Atomic Habbits', 'James Clear', 2018,'self-help',170),
	(2, 'Ikigai', 'Hector Garcia', 2017,'self-help',150),
	(3, 'Harry Potter', 'J.K Rowling', 1997,'self-help',550),
	(4, 'Power of Subconscious mind', 'Dr Joseph Murphy', 2014,'self-help',162),
	(5, 'One Indian Girl', 'Chetan Bhagat', 2016,'fiction',225),
	(6, 'The blue umbrella', 'Ruskin Bond', 1999,'fiction',300),
	(7, 'The Life', 'Chetan Bhagat', 2014,'fiction',225),
	(8, 'Rich Dad Poor Dad', 'Robert Kiyosaki', 2023,'self-help',274),
	(9, 'Think like a monk', 'Jay Shetty', 2016,'self-help',304),
	(10, '3 Mistake of my life', 'Chetan Bhagat', 2015,'fiction',255);
GO
 
DECLARE @fiction_Genre VARCHAR(50), @selfhelp_Genre VARCHAR(50);
SET @fiction_Genre ='fiction';
SET @selfhelp_Genre ='self-help';

-- prints the fiction books 
SELECT * FROM Book WHERE Genre = @fiction_Genre;

-- prints the self-help books
SELECT * FROM Book WHERE Genre = @selfhelp_Genre;
GO

-- prints all table 
SELECT * FROM Book;
GO



CREATE TABLE Agency(
	AgencyID INT PRIMARY KEY,
    AgencyName VARCHAR(50),
    Place VARCHAR(100),
    Person NVARCHAR(200),
    ContactNo CHAR(10)
);
GO

INSERT INTO Agency VALUES
    (1, 'Pragati Books', 'Nashik', 'Ramesh', '984612347'),
    (2, 'XYZ Books', 'Nashik', 'Prathamesh more', '9745541581'),
    (3, 'Good Luck Books', 'Sinnar', 'Omkar', '8745961234'),
    (4, 'Silver books', 'Mumbai', 'Rajesh', '7985682657'),
    (5, 'City Books', 'Pune', 'Yash', '9874612547'),
	(6, 'Hira Books Centre', 'Nagar', 'Pawan', '8564123794'),
    (7, 'ABC books', 'Pune', 'Ganesh', '9875456231'),
    (8, 'Payal books', 'Solapur', 'Saurabh', '9657846321'),
    (9, 'Golden books', 'Mumbai', 'Prince', '9875641237'),
    (10, 'Pawan Books', 'Nashik', 'Harish', '7458246874');
GO

DECLARE @Agency_in_nashik VARCHAR(50);
DECLARE @Agency_in_mumbai VARCHAR(50);
SET @Agency_in_nashik ='Nashik';
SET @Agency_in_mumbai ='Mumbai';

-- prints table of Agencies in Nashik
SELECT * FROM Agency WHERE Place =@Agency_in_nashik;

-- prints table of Agencies in Mumbai
SELECT * FROM Agency WHERE Place =@Agency_in_mumbai;
GO

-- prints all table
SELECT * FROM Agency;
GO
