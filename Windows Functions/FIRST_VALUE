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