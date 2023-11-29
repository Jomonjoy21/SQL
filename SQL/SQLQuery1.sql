/*CREATING TABLE 1*/

--CREATE TABLE EmployeeDemographics
--(
--EmployeeID int,
--FirstName varchar(50),
--LastName varchar(50),
--Age int ,
--Gender varchar(50)
--)

/*INSERTING VALUES INTO TABLE 1*/

--INSERT INTO EmployeeDemographics VALUES
--(1001, 'Jim', 'Halpert', 30, 'Male'),
--(1002, 'Pam', 'Beasley', 30, 'Female'),
--(1003, 'Dwight', 'Schrute', 29, 'Male'),
--(1004, 'Angela', 'Martin', 31, 'Female'),
--(1005, 'Toby', 'Flenderson', 32, 'Male'),
--(1006, 'Michael', 'Scott', 35, 'Male'),
--(1007, 'Meredith', 'Palmer', 32, 'Female'),
--(1008, 'Stanley', 'Hudson', 38, 'Male'),
--(1009, 'Kevin', 'Malone', 31, 'Male')
--(1011, 'Ryan', 'Howard', 26, 'Male'),
--(NULL, 'Holly', 'Flax', NULL, NULL),
--(1013, 'Darryl', 'Philbin', NULL, 'Male')

/*CREATING TABLE 2*/

--CREATE TABLE EmployeeSalary
--(
--EmployeeID int,
--JobTitle varchar(50),
--Salary int
--)

/*INSERTING VALUES INTO TABLE 2*/

--INSERT INTO EmployeeSalary VALUES
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager', 65000),
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)
--(1010, NULL, 47000)
--(NULL, 'Salesman', 43000)


/*CREATING TABLE 3*/

--CREATE TABLE WareHouseEmployeeDemographics 
--(
--EmployeeID int, 
--FirstName varchar(50), 
--LastName varchar(50), 
--Age int, 
--Gender varchar(50)
--)

/*INSERTING VALUES INTO TABLE 3*/

--INSERT INTO WareHouseEmployeeDemographics VALUES
--(1013, 'Darryl', 'Philbin', NULL, 'Male'),
--(1050, 'Roy', 'Anderson', 31, 'Male'),
--(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
--(1052, 'Val', 'Johnson', 31, 'Female')

/*SELECT Statement*/

--SELECT * FROM EmployeeDemographics
--SELECT FirstName FROM EmployeeDemographics
--SELECT FirstName, LastName FROM EmployeeDemographics
--SELECT TOP 5 * FROM EmployeeDemographics

/*DISTINCT (Used to select unique values in a specific column)*/

--SELECT DISTINCT(EmployeeID) FROM EmployeeDemographics
--SELECT DISTINCT(Gender) FROM EmployeeDemographics

/*COUNT (shows all the non-null values)*/ 

--SELECT COUNT(LastName) FROM EmployeeDemographics /*As it is derived it doesn't shows any column name so AS is used*/
--SELECT COUNT(LastName) AS Last_Name_Count FROM EmployeeDemographics /* AS is used to give names*/

/*MAX, MIN, AVG*/

--SELECT MAX(Salary) FROM EmployeeSalary
--SELECT MIN(Salary) FROM EmployeeSalary
--SELECT AVG(Salary) FROM EmployeeSalary

/*If we want to get the details in master database instead of SQL Intermediate*/
/*First thing to specify is database, then what table and at last*/
--SELECT * FROM SQLIntermediate.dbo.EmployeeSalary

/*WHERE Statement (=, <>, >, AND, OR, LIKE, NULL, NOT NULL, IN)*/ 

--SELECT * FROM EmployeeDemographics WHERE FirstName = 'Jim'
--SELECT * FROM EmployeeDemographics WHERE FirstName <> 'Jim'
--SELECT * FROM EmployeeDemographics WHERE Age > 30
--SELECT * FROM EmployeeDemographics WHERE Age >=30
--SELECT * FROM EmployeeDemographics WHERE Age < 32
--SELECT * FROM EmployeeDemographics WHERE Age <=32
--SELECT * FROM EmployeeDemographics WHERE Age <= 32 AND Gender = 'Male'
--SELECT * FROM EmployeeDemographics WHERE Age <= 32 OR Gender = 'Male'
--SELECT * FROM EmployeeDemographics WHERE LastName LIKE 'S%' /*This (%) symbol is called wild card. And in suffix means starting with specified*/
--SELECT * FROM EmployeeDemographics WHERE LastName LIKE '%S%' /*the before and after the specified means, get those all if its anywhere*/
--SELECT * FROM EmployeeDemographics WHERE LastName LIKE 'S%o%' 
--SELECT * FROM EmployeeDemographics WHERE FirstName IS NULL
--SELECT * FROM EmployeeDemographics WHERE FirstName IS NOT NULL
--SELECT * FROM EmployeeDemographics WHERE FirstName = 'Jim' OR FirstName = 'Toby' /*Insted of this statement we can use this IN*/
--SELECT * FROM EmployeeDemographics WHERE FirstName IN ('Jim', 'Toby') /*IN is a kind of multiple equal statement*/
/*Note: Executing the highlighted position will run that part only.*/

/*GROUP BY, ORDER BY Statements*/

--SELECT DISTINCT(Gender) FROM EmployeeDemographics
--SELECT Gender FROM EmployeeDemographics GROUP BY Gender
--SELECT Gender, COUNT(Gender) FROM EmployeeDemographics GROUP BY Gender
--SELECT Gender, Age, COUNT(Gender) FROM EmployeeDemographics GROUP BY Gender, Age
--SELECT Gender, Age, COUNT(Gender) AS Gender_Count FROM EmployeeDemographics GROUP BY Gender, Age /* why COUNT(Gender) not after GROUP BY because its derived column but Gender and Age are actual columns*/ 
--SELECT Gender, Age, COUNT(Gender) AS Gender_Count FROM EmployeeDemographics WHERE Age > 31 GROUP BY Gender, Age
--SELECT Gender, COUNT(Gender) AS Gender_Count FROM EmployeeDemographics WHERE Age > 31 GROUP BY Gender ORDER BY Gender_Count /*by default ORDER BY is in ASC*/
--SELECT Gender, COUNT(Gender) AS Gender_Count FROM EmployeeDemographics WHERE Age > 31 GROUP BY Gender ORDER BY Gender_Count DESC
--SELECT * FROM EmployeeDemographics ORDER BY Age
--SELECT * FROM EmployeeDemographics ORDER BY Age, Gender DESC
--SELECT * FROM EmployeeDemographics ORDER BY Age DESC, Gender DESC /*This can also be replicated by numbers, which is shown below*/
--SELECT * FROM EmployeeDemographics ORDER BY 4 DESC, 5 DESC

/*Stored PROCEDURE*/ /*Its SQL Statements stored in the database. It can be used by over the network again and again or by different users */

--CREATE PROCEDURE Test AS SELECT * FROM EmployeeDemographics /*It can be found from SQLIntermediate->Programmability->Stored Procedures as dbo.Test*/
--EXEC Test /*The stored procedures are executed not by SELECT but by EXEC*/
--CREATE PROCEDURE Employee3 AS CREATE TABLE #Employee2(JobTitle varchar(50), Employee_per_job int, Avg_age int, Avg_salary int)
--INSERT INTO #Employee2 SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary) FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID GROUP BY JobTitle 
--SELECT * FROM #Employee2 /*If we didn't use the SELECT Statement nothing will be returned as output. And it should be run with the CREATE and INSERT Statement*/
--EXEC Employee3
--ALTER PROCEDURE dbo.Employee3
--@JobTitle nvarchar(100) /*We can change the JobTitle to any other may be to Accountant or even multiple things. And can be used in anywhere in the code*/
--AS CREATE TABLE #Employee2(JobTitle varchar(50), Employee_per_job int, Avg_age int, Avg_salary int)
--INSERT INTO #Employee2 SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary) FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID WHERE JobTitle = @JobTitle GROUP BY JobTitle 
--SELECT * FROM #Employee2
--EXEC Employee3 @JobTitle = 'Salesman'/*When we execute this its gonna to give error because its expecting to include the job parameter*/

/*Subqueries (in the SELECT, FROM and WHERE, INSERT, UPDATE, DELETE)*/ /*A subquery is called inner or nested queries*/ 

--SELECT * FROM EmployeeSalary
--SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS All_avg_salary FROM EmployeeSalary
--SELECT EmployeeID, Salary, AVG(Salary) OVER() AS All_avg_salary FROM EmployeeSalary
--SELECT EmployeeID, Salary, AVG(Salary) AS All_avg_salary FROM EmployeeSalary GROUP BY EmployeeID, Salary ORDER BY 1,2 /*we not get the same like we get in the PARTITON BY*/ 
--SELECT a.EmployeeID, All_avg_salary FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER() AS All_avg_salary FROM EmployeeSalary) AS a
--SELECT EmployeeID, JobTitle, Salary FROM EmployeeSalary WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeDemographics WHERE Age > 30) /*We cannnot select everything when in WHERE statement*/