# Common Table Expressions (CTE) in SQL Server

A **Common Table Expression (CTE)** is a temporary result set defined within the execution scope of a single `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement. CTEs improve query readability and make complex queries easier to write and understand.

## Syntax
```sql
WITH cte_name (column1, column2, ...) AS (
    -- Query definition
    SELECT column1, column2, ...
    FROM table_name
    WHERE condition
)
-- Main query
SELECT column1, column2, ...
FROM cte_name;
```

### Components:
- **`WITH` clause**: Declares the CTE and gives it a name.
- **CTE name and column list**: Optionally specify column names for the result set. If omitted, the column names from the query are used.
- **Query definition**: The query that defines the CTE.
- **Main query**: Uses the CTE like a regular table or subquery.

## Advantages of CTEs:
1. Simplify complex queries by breaking them into smaller, more manageable parts.
2. Improve readability and maintainability of the SQL code.
3. Allow recursive queries to handle hierarchical data (e.g., organizational structures, trees).

## Example: Simple CTE
```sql
WITH SalesCTE (Salesperson, TotalRevenue) AS (
    SELECT Salesperson, SUM(Revenue) AS TotalRevenue
    FROM Sales
    GROUP BY Salesperson
)
SELECT *
FROM SalesCTE
WHERE TotalRevenue > 10000;
```

### Explanation:
1. The `WITH` clause creates a CTE named `SalesCTE`.
2. The CTE calculates total revenue for each salesperson.
3. The main query retrieves rows where the total revenue exceeds 10,000.

## Example: Recursive CTE
A recursive CTE references itself to perform hierarchical or iterative operations.

```sql
WITH EmployeeHierarchy AS (
    SELECT EmployeeID, ManagerID, FullName, 1 AS Level
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    SELECT e.EmployeeID, e.ManagerID, e.FullName, eh.Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh
    ON e.ManagerID = eh.EmployeeID
)
SELECT *
FROM EmployeeHierarchy;
```

### Explanation:
1. The anchor query retrieves all employees without a manager (top-level employees).
2. The recursive query retrieves employees reporting to the managers identified in the previous level.
3. The recursion continues until all employees are included in the hierarchy.

## When to Use CTEs:
- To simplify complex joins and nested queries.
- To improve readability for queries with multiple calculations or intermediate steps.
- For recursive queries to handle hierarchical relationships.

## Learn More:
- Official Microsoft Documentation: [WITH Common Table Expression (Transact-SQL)](https://learn.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql?view=sql-server-ver16)
- Tutorial: [SQL Syntax - W3Schools](https://www.w3schools.com/sql/sql_syntax.asp)
