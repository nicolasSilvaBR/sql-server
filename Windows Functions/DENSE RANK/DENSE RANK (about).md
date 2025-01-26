# DENSE_RANK in SQL Server

The `DENSE_RANK()` function is a window function in SQL Server that assigns a rank to each row within a partition of a result set, with no gaps in rank values. This means if two or more rows are tied (i.e., have the same rank), the next rank in the sequence is not skipped.

## Syntax
```sql
DENSE_RANK() OVER (
    [PARTITION BY column_name(s)]
    ORDER BY column_name [ASC | DESC]
)
```

### Parameters:
- **PARTITION BY** (optional): Divides the result set into partitions to which the `DENSE_RANK()` function is applied. If omitted, the entire result set is treated as a single partition.
- **ORDER BY**: Specifies the order of rows within each partition. The ranking is calculated based on this ordering.

## Key Characteristics:
- Unlike `RANK()`, which skips rank numbers after a tie, `DENSE_RANK()` does not create gaps in the sequence.
- Rows with equal values in the `ORDER BY` clause receive the same rank.

## Example
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
    ('Charlie', 'North', 4000),
    ('Dave', 'South', 6000),
    ('Eve', 'South', 6000),
    ('Frank', 'South', 3000);

-- Query using DENSE_RANK()
SELECT 
    Salesperson, 
    Region, 
    Revenue,
    DENSE_RANK() OVER (PARTITION BY Region ORDER BY Revenue DESC) AS Rank
FROM Sales;
```

### Output:
| Salesperson | Region | Revenue | Rank |
|-------------|--------|---------|------|
| Dave        | South  | 6000    | 1    |
| Eve         | South  | 6000    | 1    |
| Frank       | South  | 3000    | 2    |
| Alice       | North  | 5000    | 1    |
| Bob         | North  | 4000    | 2    |
| Charlie     | North  | 4000    | 2    |

## Key Difference from RANK()
Using the same data and query structure, `RANK()` would produce gaps in the ranking after ties, while `DENSE_RANK()` ensures ranks are sequential.

## Learn More
- Official Microsoft Documentation: [DENSE_RANK (Transact-SQL)](https://learn.microsoft.com/en-us/sql/t-sql/functions/dense-rank-transact-sql?view=sql-server-ver16)
- Tutorial: [SQL DENSE_RANK Function](https://www.sqltutorial.org/sql-window-functions/sql-dense_rank/)
