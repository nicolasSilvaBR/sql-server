# FIRST_VALUE in SQL Server

The `FIRST_VALUE()` function is a window function in SQL Server that returns the first value in an ordered partition of a result set. It is commonly used to retrieve the first occurrence of a value based on specific ordering criteria.

## Syntax
```sql
FIRST_VALUE (scalar_expression) 
OVER (
    [PARTITION BY column_name(s)]
    ORDER BY column_name [ASC | DESC]
)
```

### Parameters:
- **`scalar_expression`**: The column or expression from which the first value is retrieved.
- **`PARTITION BY`** (optional): Divides the result set into partitions. If omitted, the entire result set is treated as a single partition.
- **`ORDER BY`**: Specifies the logical order of rows within each partition. This determines the "first" value.

## Key Characteristics:
- The `FIRST_VALUE()` function operates within the scope of a window (partition) defined by the `OVER` clause.
- If there are multiple rows with the same "first" value in the partition, all rows will have the same result for `FIRST_VALUE()`.

## Example
### Basic Example
```sql
CREATE TABLE Sales (
    Salesperson NVARCHAR(50),
    Region NVARCHAR(50),
    Revenue INT
);

INSERT INTO Sales (Salesperson, Region, Revenue)
VALUES
    ('Alice', 'North', 5000),
    ('Bob', 'North', 4000),
    ('Charlie', 'North', 4500),
    ('Dave', 'South', 6000),
    ('Eve', 'South', 3000);

-- Query using FIRST_VALUE
SELECT 
    Salesperson, 
    Region, 
    Revenue,
    FIRST_VALUE(Salesperson) OVER (PARTITION BY Region ORDER BY Revenue DESC) AS TopSalesperson
FROM Sales;
```

### Output:
| Salesperson | Region | Revenue | TopSalesperson |
|-------------|--------|---------|----------------|
| Alice       | North  | 5000    | Alice          |
| Charlie     | North  | 4500    | Alice          |
| Bob         | North  | 4000    | Alice          |
| Dave        | South  | 6000    | Dave           |
| Eve         | South  | 3000    | Dave           |

### Explanation:
1. The `PARTITION BY` clause separates the rows into two regions: "North" and "South."
2. Within each partition, rows are ordered by `Revenue` in descending order.
3. The `FIRST_VALUE()` function retrieves the salesperson with the highest revenue in each region.

## Use Cases:
- Retrieve the earliest or top-ranking value in a dataset.
- Analyze data trends by identifying the first entry in a time series.
- Simplify queries that require identifying a "first occurrence" without using subqueries.

## Notes:
- Use `FIRST_VALUE()` in combination with the `ROWS` or `RANGE` clauses to refine the window frame if necessary.

## Learn More:
- Official Microsoft Documentation: [FIRST_VALUE (Transact-SQL)](https://learn.microsoft.com/en-us/sql/t-sql/functions/first-value-transact-sql?view=sql-server-ver16)
