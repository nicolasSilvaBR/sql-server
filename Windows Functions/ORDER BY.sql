-- ORDER BY()
SELECT 
    A.[Name],
    A.ListPrice,
    ProductSubcategory = B.Name,
    ProductCategory = C.Name,   
    [Category Price Rank] = ROW_NUMBER() OVER( PARTITION BY C.NAME ORDER BY A.ListPrice DESC )   
FROM Production.Product AS A
JOIN Production. ProductSubcategory AS B ON B.ProductSubcategoryID = A.ProductSubcategoryID
JOIN Production.ProductCategory  AS C ON C.ProductCategoryID = B.ProductCategoryID
