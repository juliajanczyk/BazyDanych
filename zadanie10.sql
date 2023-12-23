-- 1 ------------------------------------------------------------
USE AdventureWorks2022
BEGIN TRANSACTION; --zaczyna

UPDATE Production.Product --aktualizuje
SET ListPrice = ListPrice * 1.1 --zwieksza o 10%
WHERE ProductID = 680; 

SELECT * FROM Production.Product WHERE ProductID = 680;

COMMIT TRANSACTION; -- zatwierdza transakcje
--ROLLBACK TRANSACTION; -- cofa transakcje

SELECT * FROM Production.Product WHERE ProductID = 680;

-- 3 ------------------------------------------------------------
USE AdventureWorks2022
BEGIN TRANSACTION;

INSERT INTO Production.Product ( Name, ProductNumber, MakeFlag, FinishedGoodsFlag, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate )
VALUES ('Nowy', 'XY-4558', 0, 0, 9000, 650, 0.00, 0.00, 1, GETDATE());

--INSERT INTO Production.Product (ProductID, Name, ListPrice )
--VALUES (666, 'Nowy Produkt', 34.50);

COMMIT TRANSACTION;-- zatwierdza
SELECT * FROM Production.Product WHERE Name Like 'Nowy';
--- ProductID = 1002

-- 2 ------------------------------------------------------------
USE AdventureWorks2022
BEGIN TRANSACTION;

DELETE FROM Production.Product
WHERE ProductID = 1002;
SELECT * FROM Production.Product WHERE ProductID=1002;

--cofanie transakcji
ROLLBACK TRANSACTION;
SELECT * FROM Production.Product WHERE ProductID=1002;

-- 4 ------------------------------------------------------------
USE AdventureWorks2022
BEGIN TRANSACTION;
UPDATE Production.Product --aktualizuje
SET StandardCost = StandardCost * 1.1
IF (SUM(StandardCost  FROM Production.Product) <= 50000)
BEGIN 
COMMIT TRANSACTION;
END

ELSE
BEGIN
ROLLBACK TRANSACTION;
END

-- 5 ------------------------------------------------------------
USE AdventureWorks2022
BEGIN TRANSACTION; 

INSERT INTO Production.Product ( Name, ProductNumber, MakeFlag, FinishedGoodsFlag, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate )
VALUES ('Nowy', 'XY-4558', 0, 0, 9000, 650, 0.00, 0.00, 1, GETDATE());
IF EXISTS (SELECT ProductNumber FROM Production.Product WHERE ProductNumber='XY-4558' )
BEGIN
ROLLBACK TRANSACTION;
END

ELSE 
BEGIN
COMMIT TRANSACTION;

-- 6 ------------------------------------------------------------
USE AdventureWorks2022
BEGIN TRANSACTION;
UPDATE Sales.SalesOrderDetail
SET OrderQty = OrderQty + 1;
IF EXISTS (SELECT OrderQty FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
ROLLBACK TRANSACTION;
ELSE
COMMIT TRANSACTION;

-- 7 ------------------------------------------------------------
USE AdventureWorks2022
BEGIN TRANSACTION;

SELECT StandardCost FROM Production.Product
DECLARE @ilosc INT
SELECT @ilosc = @@ROWCOUNT FROM Production.Product
DELETE FROM Production.Product
WHERE StandardCost > ( SELECT AVG(Product.StandardCost) FROM Production.Product )

SELECT StandardCost FROM Production.Product
DECLARE @nowailosc INT
SELECT @nowailosc = @@ROWCOUNT FROM Production.Product

IF ( @ilosc - @nowailosc > 10 )
BEGIN 
ROLLBACK TRANSACTION;
END

ELSE
BEGIN
COMMIT TRANSACTION;
END;


