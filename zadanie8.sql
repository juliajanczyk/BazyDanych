-- Zadanie 1

CREATE FUNCTION Fibonacci(@n INT)
RETURNS TABLE
AS
RETURN
(
    WITH fb AS (
        SELECT 1 AS n, CAST(0 AS bigint) AS f, CAST(1 AS bigint) AS f1
        UNION ALL
        SELECT n + 1, f + f1, f AS f1 FROM fb WHERE n < @n
    )
    SELECT f FROM fb
);


CREATE PROCEDURE PrintFibonacci
    @n INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @fib TABLE (Value bigint);

    INSERT INTO @fib (Value)
    SELECT f FROM Fibonacci(@n);

    SELECT * FROM @fib;
END;


EXEC PrintFibonacci @n = 7;

------------------------------------------
-- Zadanie 2
SELECT * FROM Person.Person

USE AdventureWorks2022
GO
CREATE TRIGGER Persons
ON Person.Person
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Person.Person
    SET LastName = UPPER(inserted.LastName)
    FROM Person.Person
    INNER JOIN inserted ON Person.BusinessEntityID = inserted.BusinessEntityID;
END;

UPDATE Person.Person
SET LastName = 'Duffy'
WHERE BusinessEntityID = 2;

SELECT * FROM Person.Person

------------------------------------------
-- Zadanie 3
USE AdventureWorks2022
GO
SELECT * FROM Sales.SalesTaxRate

CCREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

DECLARE @old DECIMAL(3, 2);
DECLARE @new DECIMAL(3, 2);

    SELECT @old = TaxRate FROM deleted;
    SELECT @new = TaxRate FROM inserted;

    IF ABS(@old-@new) / @old > 0.3 -- wiecej niz 30%
    BEGIN
        THROW 2103769, 'Błąd! Zmiana wartości w polu TaxRate o więcej niż 30%', 1; -- lvl błędu, komunikat, state
    END;
END;

SELECT * FROM Sales.SalesTaxRate

UPDATE Sales.SalesTaxRate
SET TaxRate = 1.5 
WHERE SalesTaxRateID = 5; 

  