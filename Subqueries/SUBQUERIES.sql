-- Subqueries

USE AdventureWorks2019
GO

SELECT *
FROM (
    SELECT 
        PurchaseOrderID,
        VendorID,
        OrderDate,
        TaxAmt,
        Freight,
        TotalDue,
        [Mostexpensive] = DENSE_RANK() OVER( PARTITION BY VendorID ORDER BY TotalDue DESC )
    FROM Purchasing.PurchaseOrderHeader
) A
WHERE Mostexpensive <= 3