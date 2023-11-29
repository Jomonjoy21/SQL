/*INNER, FULL, LEFT, RIGHT, OUTER Joins*/

--SELECT * FROM SQLIntermediate.dbo.EmployeeDemographics
--SELECT * FROM SQLIntermediate.dbo.EmployeeSalary
--SELECT * FROM SQLIntermediate.dbo.EmployeeDemographics INNER JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--SELECT * FROM SQLIntermediate.dbo.EmployeeDemographics FULL OUTER JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--SELECT * FROM SQLIntermediate.dbo.EmployeeDemographics LEFT OUTER JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--SELECT * FROM SQLIntermediate.dbo.EmployeeDemographics RIGHT OUTER JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--SELECT EmployeeID, FirstName, LastName, JobTitle, Salary FROM SQLIntermediate.dbo.EmployeeDemographics INNER JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID /*Wh yits showing error because we need to specify from which table we want those details from*/
--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary FROM SQLIntermediate.dbo.EmployeeDemographics INNER JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID /*the correct form of the above one*/
--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary FROM SQLIntermediate.dbo.EmployeeDemographics RIGHT OUTER JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary FROM SQLIntermediate.dbo.EmployeeDemographics RIGHT OUTER JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary FROM SQLIntermediate.dbo.EmployeeDemographics INNER JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID WHERE FirstName <> 'Michael' ORDER BY Salary DESC
--SELECT JobTitle, AVG(Salary) FROM SQLIntermediate.dbo.EmployeeDemographics INNER JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID WHERE JobTitle = 'Salesman' GROUP BY JobTitle

/*UNION, UNION ALL*/

--SELECT * FROM SQLIntermediate.dbo.EmployeeDemographics FULL OUTER JOIN SQLIntermediate.dbo.WareHouseEmployeeDemographics ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID
--SELECT * FROM SQLIntermediate.dbo.EmployeeDemographics UNION SELECT * FROM SQLIntermediate.dbo.WareHouseEmployeeDemographics /*Because of UNION the details of the othertable which were in separate column is added down to the first in the correct order. And Darryl was in both tables the reason its not showing multiple times because UNION removed duplicates*/
--SELECT * FROM SQLIntermediate.dbo.EmployeeDemographics UNION ALL SELECT * FROM SQLIntermediate.dbo.WareHouseEmployeeDemographics ORDER BY EmployeeID/*In this UNION ALL it shows all details regardless of whether there is duplicates or not */
/*Lets take two different tables and combine them using UNION*/
--SELECT EmployeeID, FirstName, Age FROM SQLIntermediate.dbo.EmployeeDemographics UNION ALL SELECT EmployeeID, JobTitle, Salary FROM SQLIntermediate.dbo.EmployeeSalary ORDER BY EmployeeID /*Be careful when taking differnt tables if they have different values*/

/*CASE Statement*/

--SELECT FirstName, LastName, Age,
--CASE 
--    WHEN Age > 30 THEN 'Adult' /*If there are multiple conditions only the first one will return*/
--	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
--	ELSE 'Teenager'
--END 
--AS Age_Category FROM SQLIntermediate.dbo.EmployeeDemographics WHERE Age IS NOT NULL ORDER BY Age

--SELECT FirstName, LastName, JobTitle, Salary,
--CASE 
--    WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
--	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
--	WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001) 
--	ELSE Salary + (Salary * .03)
--END
--AS Salary_after_raise FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

/*HAVING Clause*/

--SELECT JobTitle, COUNT(JobTitle) FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID WHERE COUNT(JobTitle) > 1 GROUP BY JobTitle
/*Why its shwowing error above case is because we cannot use aggregrate function in the WHERE statement. So we need to use a HAVING clause*/
--SELECT JobTitle, COUNT(JobTitle) FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID HAVING COUNT(JobTitle) > 1 GROUP BY JobTitle 
/*Why still getting error means the HAVING is completely dependant on the GROUP BY statement because its been performing  after being aggregrated. SO, it should go after the WHERE statement */
--SELECT JobTitle, COUNT(JobTitle) AS Title_Count FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID GROUP BY JobTitle HAVING COUNT(JobTitle) > 1
--SELECT JobTitle, AVG(Salary) AS Avg_Salary FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID GROUP BY JobTitle HAVING AVG(Salary) > 45000 ORDER BY AVG(Salary) /* When there is GROUP BY and ORDER BY then we should put the HAVING in between them*/ 

/*UPDATE, DELETE*/

--SELECT * FROM SQLIntermediate.dbo.EmployeeDemographics
--UPDATE SQLIntermediate.dbo.EmployeeDemographics SET EmployeeID = 1012 WHERE FirstName = 'Holly' AND LastName = 'Flax' /*If we execute this without WHERE and only with SET then its gonna to UPDATE all the values of the attribute*/
--UPDATE SQLIntermediate.dbo.EmployeeDemographics SET Age = 31, Gender = 'Female' WHERE FirstName = 'Holly' AND LastName = 'Flax'
--DELETE SQLIntermediate.dbo.EmployeeDemographics WHERE EmployeeID = 1005 /*Tip: instead of DELETE, write SELECT so it enables to see what you are deleting*/

/*ALIAS*/ /*Its used for temporarly changing the table or column name in the script, not gonna to impact the output at all, it increases the readibility of the script*/

--SELECT FirstName AS Fname FROM SQLIntermediate.dbo.EmployeeDemographics /*both works with AS and without AS*/
--SELECT FirstName + ' ' + LastName AS FullName FROM SQLIntermediate.dbo.EmployeeDemographics
--SELECT AVG(Age) AS Avg_age FROM SQLIntermediate.dbo.EmployeeDemographics
--SELECT FirstName, LastName, Gender FROM SQLIntermediate.dbo.EmployeeDemographics WHERE Age = (SELECT AVG(Age) FROM SQLIntermediate.dbo.EmployeeDemographics)

--WITH AvgAge AS (
--    SELECT AVG(Age) AS Avg_age
--    FROM SQLIntermediate.dbo.EmployeeDemographics
--)

--SELECT E.FirstName, E.LastName, E.Gender, A.Avg_age
--FROM SQLIntermediate.dbo.EmployeeDemographics AS E
--INNER JOIN AvgAge AS A ON E.Age = A.Avg_age

--SELECT Demo.EmployeeID FROM SQLIntermediate.dbo.EmployeeDemographics AS Demo /*Here we alias the atble name as Demo. SO, when selecting any thing from the table don't forget to put Demo. as prefix*/
/*whenever we refer column name we have to use entire table name for instance, EmployeeDemographics.Age or EmployeeSalary.Salary instead its easy to refer Demo.Age or SAl.Salary if its aliased*/
--SELECT Demo.EmployeeID, Sal.Salary FROM SQLIntermediate.dbo.EmployeeDemographics AS Demo JOIN SQLIntermediate.dbo.EmployeeSalary AS Sal ON Demo.EmployeeID = Sal.EmployeeID
--SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, Sal.Salary, Ware.Age FROM SQLIntermediate.dbo.EmployeeDemographics AS Demo FULL OUTER JOIN SQLIntermediate.dbo.EmployeeSalary AS Sal ON Demo.EmployeeID = Sal.EmployeeID FULL OUTER JOIN SQLIntermediate.dbo.WareHouseEmployeeDemographics AS Ware ON Demo.EmployeeID = Ware.EmployeeID

/*PARTITION BY*/ /* */

--SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) OVER (PARTITION BY Gender) AS Total_gender FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) AS Total_gender FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID GROUP BY FirstName, LastName, Gender, Salary
--SELECT Gender, COUNT(Gender) AS Total_gender FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID GROUP BY Gender

/*CTE (Common Table Expression)*/

/*the CTE is not stored anywhere so each time when we run the CTE we have to run full not the select statement only*/
--WITH Employee AS (SELECT FirstName, LastName, Gender, Salary , COUNT(Gender) OVER (PARTITION BY Gender) AS Total_gender, AVG(Salary) OVER (PARTITION BY Gender) AS Avg_salary FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID WHERE Salary > '45000') SELECT * FROM Employee

/*Temporary Tables*/ /*It is like normal table but the only differences between the normal and temp table is the hash (#) sign. Most of the time Temporary tables are used for stored procedures*/
/*When we run again temporary table it shows error actually it lives somewhere but not in the actual database because already a tenp table is created. inorder to run it multiple times there is a trick that is to DROP TABLE IF EXISTS*/
--DROP TABLE IF EXISTS #Employee
--CREATE TABLE #Employee(EmployeeID int, JobTitle varchar (100), Salary int)
--INSERT INTO #Employee VALUES ('1001', 'HR', '45000')
--INSERT INTO #Employee SELECT * FROM SQLIntermediate.dbo.EmployeeSalary/*One thing is we can do select data from another table and insert that into a temp table*/
--SELECT * FROM #Employee
/*We can also take the subquery and insert that to temp table*/
--CREATE TABLE #Employee2(JobTitle varchar(50), Employee_per_job int, Avg_age int, Avg_salary int)
--INSERT INTO #Employee2 SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary) FROM SQLIntermediate.dbo.EmployeeDemographics JOIN SQLIntermediate.dbo.EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID GROUP BY JobTitle 
--SELECT * FROM #Employee2

/*String Functions: TRIM, LTRIM, RTRIM, REPLACE, SUBSTRING, UPPER, LOWER*/ 

--Drop Table EmployeeErrors;
--CREATE TABLE EmployeeErrors (EmployeeID varchar(50), FirstName varchar(50), LastName varchar(50))
--INSERT INTO EmployeeErrors VALUES
--('1001  ', 'Jimbo', 'Halbert'),
--('  1002', 'Pamela', 'Beasely'),
--('1005', 'TOby', 'Flenderson - Fired')
--Select * From EmployeeErrors
--SELECT EmployeeID, TRIM(EmployeeID) AS ID_Trim FROM EmployeeErrors /*TRIM get rid of both the right and the left side*/ 
--SELECT EmployeeID, RTRIM(EmployeeID) AS ID_RTrim FROM EmployeeErrors /*RTRIM only get rid of the right side*/ 
--SELECT EmployeeID, LTRIM(EmployeeID) AS IDL_Trim FROM EmployeeErrors /*LTRIM only get rid of the left side*/
--SELECT LastName, REPLACE(LastName, '- Fired', '') AS LastName_fixed FROM EmployeeErrors /*Replaced Fired with blank*/
--SELECT SUBSTRING(FirstName,1,3) FROM EmployeeErrors /*the numbers represent from where to start and how long should it go*/
/*Fuzzy Match*/ /*if the name in one table is Alex and on the another its Alexander if we try those two together based on name they will not join because one name is Alex and the another is Alexander. but if taking the substring as position 1 nad more 4 char forward, its gonna to take Alex and match together. But these may not be perfect that is why its called a fuzzy match*/ 
--SELECT err.FirstName, SUBSTRING (err.FirstName,1,3), dem.FirstName, SUBSTRING(dem.FirstName,1,3), err.LastName,SUBSTRING(err.LastName,1,3), dem.LastName, SUBSTRING(dem.LastName,1,3)
--FROM EmployeeErrors AS err JOIN SQLIntermediate.dbo.EmployeeDemographics AS dem ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3) AND SUBSTRING(err.LastName,1,3) = SUBSTRING(dem.LastName,1,3)
--SELECT firstname, LOWER(firstname) FROM EmployeeErrors
--SELECT Firstname, UPPER(FirstName) FROM EmployeeErrors

