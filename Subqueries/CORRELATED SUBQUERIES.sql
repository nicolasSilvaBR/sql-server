
-- CORRELATED SUBQUERY
SELECT 
	   PurchaseOrderID
      ,VendorID
      ,OrderDate
      ,TotalDue
	  ,NonRejectedItems = 
	  (
		  SELECT
			COUNT(*)
		  FROM Purchasing.PurchaseOrderDetail B
		  WHERE A.PurchaseOrderID = B.PurchaseOrderID
		  AND B.RejectedQty = 0
	  )
	  ,MostExpensiveItem = 
	  (
		  SELECT
			MAX(B.UnitPrice)
		  FROM Purchasing.PurchaseOrderDetail B
		  WHERE A.PurchaseOrderID = B.PurchaseOrderID
	  )

FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader A
