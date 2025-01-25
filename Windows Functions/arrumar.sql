-- Windows Function
-- OVER()
-- PARTITION BY()
-- ORDER BY()
-- ROW_NUMBER()
-- RANK()
-- DENSE RANK()
-- LEAD()
-- LAG()
-- FIRST_VALUE()


-- OVER()
-- PARTITION BY()
-- ORDER BY()
-- ROW_NUMBER()
-- RANK()
-- DENSE RANK()
SELECT 
    A.[Name],
    A.ListPrice,
    ProductSubcategory = B.Name,
    ProductCategory = C.Name,
    PriceRank = DENSE_RANK() OVER( ORDER BY A.ListPrice DESC ),
    [Category Price Rank] = ROW_NUMBER() OVER( PARTITION BY C.NAME ORDER BY A.ListPrice DESC ),
    [Top 5 Price In Category] = CASE WHEN DENSE_RANK() OVER( PARTITION BY C.NAME ORDER BY A.ListPrice DESC ) <= 5 THEN 'Yes' ELSE 'NO' END,
    [Category Price Rank With Rank] = RANK() OVER( PARTITION BY C.NAME ORDER BY ListPrice DESC),
    [Category Price Rank With Dense Rank] = DENSE_RANK() OVER( PARTITION BY C.NAME ORDER BY ListPrice DESC)
FROM Production.Product AS A
JOIN Production. ProductSubcategory AS B ON B.ProductSubcategoryID = A.ProductSubcategoryID
JOIN Production.ProductCategory  AS C ON C.ProductCategoryID = B.ProductCategoryID

-- LEAD()
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

-- FIRST_VALUE()
SELECT
    BusinessEntityID AS EmployeeID,
    JobTitle,
    HireDate,
    VacationHours,
    FirstHireVacationHours = FIRST_VALUE(VacationHours) OVER( PARTITION BY JobTitle ORDER BY HireDate)
FROM HumanResources.Employee
ORDER BY JobTitle, HireDate

SELECT
	A.ProductID,
	ProductName = A.[Name],
	B.ListPrice,
    B.ModifiedDate,
    HighestPrice = FIRST_VALUE(B.ListPrice) OVER (PARTITION BY A.ProductID ORDER BY B.ListPrice DESC),
	LowestPrice = FIRST_VALUE(B.ListPrice) OVER (PARTITION BY A.ProductID ORDER BY B.ListPrice),
	PriceRange = FIRST_VALUE(B.ListPrice) OVER (PARTITION BY A.ProductID ORDER BY B.ListPrice DESC) - FIRST_VALUE(B.ListPrice) OVER (PARTITION BY A.ProductID ORDER BY B.ListPrice)
FROM AdventureWorks2019.Production.Product A
	JOIN AdventureWorks2019.Production.ProductListPriceHistory B
  ON A.ProductID = B.ProductID
ORDER BY A.ProductID, B.ModifiedDate

SELECT DISTINCT
    A.ProductID,
	ProductName = A.[Name],
	B.ListPrice,
    B.ModifiedDate
FROM AdventureWorks2019.Production.Product A
JOIN AdventureWorks2019.Production.ProductListPriceHistory B
ON A.ProductID = B.ProductID
WHERE B.ProductID = 707
ORDER BY A.ProductID, B.ModifiedDate



-- Windows Function
-- OVER()
-- PARTITION BY()
-- ORDER BY()
-- ROW_NUMBER()

-- Exercise 1
SELECT 
    A.[Name],
    A.ListPrice,
    ProductSubcategory = B.Name,
    ProductCategory = C.Name
FROM Production.Product AS A
JOIN Production. ProductSubcategory AS B ON B.ProductSubcategoryID = A.ProductSubcategoryID
JOIN Production.ProductCategory  AS C ON C.ProductCategoryID = B.ProductCategoryID

--Exercise 2
SELECT 
    A.[Name],
    A.ListPrice,
    ProductSubcategory = B.Name,
    ProductCategory = C.Name,
    PriceRank = ROW_NUMBER() OVER( ORDER BY A.ListPrice DESC )
FROM Production.Product AS A
JOIN Production. ProductSubcategory AS B ON B.ProductSubcategoryID = A.ProductSubcategoryID
JOIN Production.ProductCategory  AS C ON C.ProductCategoryID = B.ProductCategoryID

--Exercise 3
SELECT 
    A.[Name],
    A.ListPrice,
    ProductSubcategory = B.Name,
    ProductCategory = C.Name,
    PriceRank = ROW_NUMBER() OVER( ORDER BY A.ListPrice DESC ),
    [Category Price Rank] = ROW_NUMBER() OVER( PARTITION BY C.NAME ORDER BY A.ListPrice DESC )
FROM Production.Product AS A
JOIN Production. ProductSubcategory AS B ON B.ProductSubcategoryID = A.ProductSubcategoryID
JOIN Production.ProductCategory  AS C ON C.ProductCategoryID = B.ProductCategoryID

--Exercise 4
SELECT 
    A.[Name],
    A.ListPrice,
    ProductSubcategory = B.Name,
    ProductCategory = C.Name,
    PriceRank = ROW_NUMBER() OVER( ORDER BY A.ListPrice DESC ),
    [Category Price Rank] = ROW_NUMBER() OVER( PARTITION BY C.NAME ORDER BY A.ListPrice DESC ),
    [Top 5 Price In Category] = CASE WHEN ROW_NUMBER() OVER( PARTITION BY C.NAME ORDER BY A.ListPrice DESC ) <= 5 THEN 'Yes' ELSE 'NO' END
FROM Production.Product AS A
JOIN Production. ProductSubcategory AS B ON B.ProductSubcategoryID = A.ProductSubcategoryID
JOIN Production.ProductCategory  AS C ON C.ProductCategoryID = B.ProductCategoryID

