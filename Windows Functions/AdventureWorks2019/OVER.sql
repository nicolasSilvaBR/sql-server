USE AdventureWorks2019
GO

SELECT 
    FirstName,
    LastName,
    Employee.JobTitle,
    EmployeePayHistory.Rate,
    AverageRate = AVG(Rate) OVER(),
    MaximumRate = MAX(RATE)  OVER(),
    DiffFromAvgRate = Rate - AVG(Rate) OVER(),
    PercentofMaxRate = (Rate / MAX(RATE) OVER())   *100
FROM [Person].[Person]
JOIN HumanResources.Employee on Employee.BusinessEntityID = Person.BusinessEntityID
JOIN HumanResources.EmployeePayHistory on EmployeePayHistory.BusinessEntityID = Person.BusinessEntityID
