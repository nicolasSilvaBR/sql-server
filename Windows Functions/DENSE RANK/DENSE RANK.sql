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