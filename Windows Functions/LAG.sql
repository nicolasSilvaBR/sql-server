-- LAG()

SELECT 
    PurchaseOrderID,
    OrderDate, 
    VendorName = [Name],
    TotalDue,
    PrevOrderFromVendorAmt = LAG(TotalDue,1) OVER ( PARTITION BY VendorID ORDER BY OrderDate),
    NextOrderByEmployeeVendor = LEAD([Name],1) OVER ( PARTITION BY PurchaseOrderHeader.employeeId ORDER BY OrderDate ),
    Next2OrderByEmployeeVendor = LEAD([Name],2) OVER ( PARTITION BY  PurchaseOrderHeader.employeeId ORDER BY OrderDate ) 
FROM Purchasing.PurchaseOrderHeader
JOIN Purchasing.Vendor ON Vendor.BusinessEntityID = PurchaseOrderHeader.VendorID
WHERE YEAR(OrderDate) > 2013 AND TotalDue > 500