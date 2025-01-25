-- Windows Function
-- OVER()
-- PARTITION BY()

SELECT 
    A.[Name],
    A.ListPrice,
    ProductSubcategory = B.Name,
    ProductCategory = C.Name,
    AvgPriceByCategory = AVG(ListPrice) OVER (PARTITION BY C.Name),
    AvgPriceByCategoryAndSubcategory = AVG(ListPrice) OVER (PARTITION BY C.Name,B.NAME),
    ProductVsCategoryDelta = A.ListPrice - AVG(ListPrice) OVER (PARTITION BY C.Name)
FROM Production.Product AS A
JOIN Production. ProductSubcategory AS B ON B.ProductSubcategoryID = A.ProductSubcategoryID
JOIN Production.ProductCategory  AS C ON C.ProductCategoryID = B.ProductCategoryID
