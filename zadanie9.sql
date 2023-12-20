USE AdventureWorks2022
GO
SELECT * FROM HumanResources.EmployeePayHistory
SELECT * FROM Person.Person

--1
USE AdventureWorks2022
GO
WITH TempEmployeeInfo AS 
(
SELECT Person.FirstName AS Imie, Person.LastName AS Nazwisko, [Rate] FROM AdventureWorks2022.Person.Person
JOIN AdventureWorks2022.HumanResources.EmployeePayHistory ON 
AdventureWorks2022.HumanResources.EmployeePayHistory.BusinessEntityID = Person.Person.BusinessEntityID
)

SELECT * FROM TempEmployeeInfo 

-------------------------------------------

USE AdventureWorksLT2022
GO
SELECT * FROM SalesLT.SalesOrderHeader
SELECT * FROM SalesLT.SalesOrderDetail

USE AdventureWorksLT2022
GO
SELECT * FROM SalesLT.Customer
--WHERE CustomerID LIKE 448 
--WHERE LastName LIKE 'E%'

--2
USE AdventureWorksLT2022
GO
WITH CompanySalesInfo AS
(
SELECT CONCAT(Customer.CompanyName, ' (', Customer.FirstName, ' ', Customer.LastName, ') ' ) AS CompanyContact, 
SUM(SalesOrderDetail.LineTotal) AS Revenue
FROM SalesLT.SalesOrderDetail 

JOIN SalesLT.SalesOrderHeader ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
JOIN SalesLT.Customer ON SalesOrderHeader.CustomerID = Customer.CustomerID
GROUP BY CompanyName,Customer.FirstName,Customer.LastName
)
Select * FROM CompanySalesInfo

----------------------------------------------

--3
USE AdventureWorksLT2022
GO
WITH SalesValue AS 
( 
SELECT Name, ProductCategoryID FROM SalesLT.ProductCategory 
) 
SELECT SalesValue.Name AS Category, SUM(LineTotal) AS SalesValue FROM SalesValue
INNER JOIN SalesLT.Product ON Product.ProductCategoryID = SalesValue.ProductCategoryID
INNER JOIN SalesLT.SalesOrderDetail ON Product.ProductID = SalesLT.SalesOrderDetail.ProductID
GRO
