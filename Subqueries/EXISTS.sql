-- Use EXISTS if you want to apply criteria to fields from a secondary table, but do not need to 
-- include those fields in your output

USE AdventureWorks2019
GO

SELECT
    PurchaseOrderID,
    OrderDate,
    SubTotal,
    TaxAmt
FROM Purchasing.PurchaseOrderHeader AS A
WHERE EXISTS (
    SELECT 1 FROM Purchasing.PurchaseOrderDetail AS B
    WHERE B.OrderQty > 500
    AND A.PurchaseOrderID = B.PurchaseOrderID
    AND B.UnitPrice > 50
)
ORDER BY PurchaseOrderID

SELECT
    PurchaseOrderID,
    OrderDate,
    SubTotal,
    TaxAmt
FROM Purchasing.PurchaseOrderHeader AS A
WHERE NOT EXISTS (
    SELECT 1 FROM Purchasing.PurchaseOrderDetail AS B
    WHERE B.RejectedQty > 0
    AND A.PurchaseOrderID = B.PurchaseOrderID    
)
ORDER BY PurchaseOrderID
