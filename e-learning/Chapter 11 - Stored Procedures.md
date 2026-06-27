# Chapter 11 - Stored Procedures


Learn to package SQL logic into reusable stored procedures so you can run repeatable database tasks with parameters, validation, and safer error handling.

## Prerequisites

- [Chapter 10: Indexes](Chapter 10 - Indexes.md) completed
- [Chapter 08: Modifying Data](Chapter 08 - Modifying Data.md) completed
- **BikeStores** database loaded ([`02-load-data.sql`](assets/database/02-load-data.sql))
- SSMS connected to SQL Server 2022 Developer Edition

## Learning goals

After this chapter, you will be able to:

- **Create** and execute a basic stored procedure such as `production.uspProductList`
- **Pass** input parameters to filter or customize results
- **Declare** and use local variables inside procedure logic
- **Return** values with output parameters
- **Control** flow with `IF`, `WHILE`, `BREAK`, and `CONTINUE`
- **Handle** errors with `TRY...CATCH` and understand dynamic SQL basics


## Time estimate

- **Reading:** about 100-120 minutes
- **Practice:** about 60 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `production.products`, `sales.orders`, `sales.order_items` |
| Tool | SSMS with `USE BikeStores;` |

## Troubleshooting

| Problem | What to try |
|---------|-------------|
| `Could not find stored procedure` | Include schema: `EXEC production.uspProductList;` |
| Parameter error | Check parameter name and data type (`INT`, `VARCHAR`, etc.) |
| Procedure compiles but returns nothing | Test inner `SELECT` query first |
| Error handling not firing | Keep risky code inside `BEGIN TRY ... END TRY` |


---

## Stored Procedure Basics (`uspProductList`)

### Why this matters

If you run the same query every day, copying and pasting is slow and error-prone. A stored procedure saves that query on the server, so you can run it with one command. Teams use procedures for reports, APIs, and recurring admin tasks.

### Concept

A **stored procedure** is a named block of SQL statements stored in the database. You execute it with `EXEC`.

- Procedures can contain multiple statements.
- They can accept parameters (next lesson).
- They are compiled and reused, which helps consistency.

In this chapter, we start with a simple list procedure called `production.uspProductList`.

### Syntax

```sql
CREATE PROCEDURE schema_name.procedure_name
AS
BEGIN
    -- SQL statements
END;
```

To run it:

```sql
EXEC schema_name.procedure_name;
```

### Walkthrough

Create and execute a first procedure.

```sql
USE BikeStores;
GO

CREATE OR ALTER PROCEDURE production.uspProductList
AS
BEGIN
    SELECT
        product_id,
        product_name,
        list_price
    FROM
        production.products
    ORDER BY
        product_name;
END;
GO

EXEC production.uspProductList;
```

#### Expected result

Returns one row per product in BikeStores, sorted by `product_name`.

### How it works

`CREATE OR ALTER` creates the procedure if it does not exist, or updates it if it already exists. SQL Server stores this object in the `production` schema. When you execute it, SQL Server runs the `SELECT` inside the procedure and returns the result set.

### Another example

You can include multiple result sets.

```sql
CREATE OR ALTER PROCEDURE production.uspProductList
AS
BEGIN
    SELECT COUNT(*) AS total_products
    FROM production.products;

    SELECT
        TOP 5 product_name,
        list_price
    FROM production.products
    ORDER BY list_price DESC;
END;
GO

EXEC production.uspProductList;
```

### Common mistakes

- Using `CREATE PROCEDURE` repeatedly without dropping first; use `CREATE OR ALTER`.
- Forgetting the schema when executing (`EXEC uspProductList` may fail).
- Omitting `GO` separators in SSMS for multi-batch scripts.

### Quick recap

- Stored procedures save SQL logic as reusable database objects.
- `CREATE OR ALTER` is the easiest way to maintain a procedure.
- `EXEC` runs the procedure and returns its result.

### Next

[Working with parameters](#working-with-parameters)


---

## Working with Parameters

### Why this matters

Hard-coded values make procedures less useful. Parameters let you reuse one procedure for many inputs, like brand, year, or price range. This is essential for report filters and app endpoints.

### Concept

A parameter is an input variable defined in the procedure header. Callers pass a value at runtime.

- Parameters can be required or optional.
- Each parameter has a data type.
- You can call by position or by name.

### Syntax

```sql
CREATE OR ALTER PROCEDURE schema_name.proc_name
    @param_name data_type
AS
BEGIN
    SELECT ...
    WHERE column_name = @param_name;
END;
```

### Walkthrough

Create a procedure that returns products for one brand.

```sql
USE BikeStores;
GO

CREATE OR ALTER PROCEDURE production.uspProductsByBrand
    @brand_id INT
AS
BEGIN
    SELECT
        p.product_id,
        p.product_name,
        p.list_price
    FROM
        production.products AS p
    WHERE
        p.brand_id = @brand_id
    ORDER BY
        p.product_name;
END;
GO

EXEC production.uspProductsByBrand @brand_id = 1;
```

#### Expected result

Returns only products that belong to brand `1`.

### How it works

SQL Server substitutes the runtime value into the procedure execution context. The procedure definition stays the same; only input values change.

### Another example

Use an optional parameter with a default value.

```sql
CREATE OR ALTER PROCEDURE production.uspProductsByYear
    @model_year SMALLINT = 2022
AS
BEGIN
    SELECT
        product_name,
        model_year,
        list_price
    FROM production.products
    WHERE model_year = @model_year
    ORDER BY product_name;
END;
GO

EXEC production.uspProductsByYear;             -- uses default 2022
EXEC production.uspProductsByYear @model_year = 2021;
```

### Common mistakes

- Passing string values to numeric parameters.
- Forgetting default values are optional only when defined.
- Mixing parameter order when calling by position.

### Quick recap

- Parameters make stored procedures reusable.
- Define type in header, reference with `@name` in query body.
- Prefer named arguments for readable calls.

### Next

[Variables inside procedures](#variables-inside-procedures)


---

## Variables Inside Procedures

### Why this matters

Many procedures need intermediate values: totals, row counts, date boundaries, or computed discounts. Local variables help break logic into clear steps.

### Concept

A local variable exists only during procedure execution.

- Declare with `DECLARE`.
- Assign with `SET` or `SELECT`.
- Use in later statements.

Variables improve readability when one value is reused multiple times.

### Syntax

```sql
DECLARE @variable_name data_type;
SET @variable_name = <expression>;
```

### Walkthrough

Return products above the average product price.

```sql
USE BikeStores;
GO

CREATE OR ALTER PROCEDURE production.uspProductsAboveAveragePrice
AS
BEGIN
    DECLARE @avg_price DECIMAL(10, 2);

    SELECT
        @avg_price = AVG(list_price)
    FROM
        production.products;

    SELECT
        product_name,
        list_price
    FROM
        production.products
    WHERE
        list_price > @avg_price
    ORDER BY
        list_price DESC;
END;
GO

EXEC production.uspProductsAboveAveragePrice;
```

#### Expected result

Returns products priced above the table average, highest first.

### How it works

The first query calculates one scalar value and saves it in `@avg_price`. The second query reuses that variable for filtering. This avoids repeating the same aggregate expression.

### Another example

Capture row count in a variable.

```sql
CREATE OR ALTER PROCEDURE production.uspProductCountByCategory
    @category_id INT
AS
BEGIN
    DECLARE @total INT;

    SELECT
        @total = COUNT(*)
    FROM
        production.products
    WHERE
        category_id = @category_id;

    SELECT @total AS total_products;
END;
GO
```

### Common mistakes

- Forgetting to declare variable data type.
- Assigning multiple rows into one scalar variable unintentionally.
- Expecting variable values to persist after the procedure ends.

### Quick recap

- Variables store temporary values inside one execution.
- Use `DECLARE` then assign with `SET` or `SELECT`.
- Variables help reuse calculations and simplify SQL.

### Next

[Output parameters](#output-parameters)


---

## Output Parameters

### Why this matters

Sometimes you need a single value back from a procedure, such as total orders for a customer. Output parameters let the procedure return that value to calling code.

### Concept

An output parameter is declared with the `OUTPUT` keyword in both places:

1. In the procedure definition
2. In the `EXEC` statement

This pattern is common in applications that call SQL Server from backend code.

### Syntax

```sql
CREATE OR ALTER PROCEDURE schema_name.proc_name
    @input_param data_type,
    @output_param data_type OUTPUT
AS
BEGIN
    SELECT @output_param = ...;
END;
```

### Walkthrough

Return number of orders for a specific customer.

```sql
USE BikeStores;
GO

CREATE OR ALTER PROCEDURE sales.uspOrderCountByCustomer
    @customer_id INT,
    @order_count INT OUTPUT
AS
BEGIN
    SELECT
        @order_count = COUNT(*)
    FROM
        sales.orders
    WHERE
        customer_id = @customer_id;
END;
GO

DECLARE @result INT;

EXEC sales.uspOrderCountByCustomer
    @customer_id = 3,
    @order_count = @result OUTPUT;

SELECT @result AS order_count;
```

#### Expected result

One value showing how many orders customer `3` has in sample data.

### How it works

Inside the procedure, SQL Server assigns a value to `@order_count`. During `EXEC`, that value is copied into local variable `@result` because both sides use `OUTPUT`.

### Another example

Return earliest and latest order dates with two output parameters.

```sql
CREATE OR ALTER PROCEDURE sales.uspOrderDateRange
    @min_date DATE OUTPUT,
    @max_date DATE OUTPUT
AS
BEGIN
    SELECT
        @min_date = MIN(order_date),
        @max_date = MAX(order_date)
    FROM sales.orders;
END;
GO
```

### Common mistakes

- Forgetting `OUTPUT` on the procedure definition or call.
- Trying to output a value not assigned inside the procedure.
- Mismatched data types between output parameter and receiving variable.

### Quick recap

- Output parameters return scalar values from procedures.
- Mark as `OUTPUT` in definition and in `EXEC`.
- Useful for counts, totals, statuses, and calculated values.

### Next

[Control flow with IF and WHILE](#control-flow-with-if-and-while)


---

## Control Flow with IF and WHILE

### Why this matters

Stored procedures often need decisions and loops: validate input, retry work, or process batches. T-SQL control-of-flow statements make that possible.

### Concept

Two core patterns:

- `IF...ELSE` for branching
- `WHILE` for looping until a condition is false

Use loops carefully; set-based SQL is usually faster.

### Syntax

```sql
IF <condition>
BEGIN
    -- true block
END
ELSE
BEGIN
    -- false block
END;

WHILE <condition>
BEGIN
    -- repeated block
END;
```

### Walkthrough

Validate a minimum price, then count products in a looped range.

```sql
USE BikeStores;
GO

CREATE OR ALTER PROCEDURE production.uspCountProductsByPriceStep
    @start_price DECIMAL(10, 2),
    @end_price   DECIMAL(10, 2)
AS
BEGIN
    IF @start_price >= @end_price
    BEGIN
        PRINT 'start_price must be less than end_price';
        RETURN;
    END;

    DECLARE @current DECIMAL(10, 2) = @start_price;

    WHILE @current < @end_price
    BEGIN
        SELECT
            @current AS bucket_start,
            COUNT(*) AS product_count
        FROM production.products
        WHERE list_price >= @current
          AND list_price < @current + 500;

        SET @current = @current + 500;
    END;
END;
GO
```

#### Expected result

Returns one row per price bucket from start to end in steps of 500.

### How it works

The procedure exits early when input is invalid. Otherwise, `WHILE` repeats a query and increments `@current`. Each iteration reports count for one price range.

### Another example

Use `BREAK` and `CONTINUE`:

```sql
DECLARE @i INT = 0;
WHILE @i < 10
BEGIN
    SET @i += 1;
    IF @i = 3 CONTINUE; -- skip this turn
    IF @i = 8 BREAK;    -- stop loop
    PRINT @i;
END;
```

### Common mistakes

- Infinite loops caused by missing increment.
- Using loops where a single `GROUP BY` query would work.
- Forgetting `RETURN` after validation failure.

### Quick recap

- `IF...ELSE` handles decision logic.
- `WHILE` repeats statements while condition is true.
- Prefer set-based queries; loop only when needed.

### Next

[Cursor awareness](#cursor-awareness)


---

## Cursor Awareness

### Why this matters

Beginners often think row-by-row first because it feels natural. SQL Server is optimized for set-based operations, but you will still see cursors in legacy code. You should know what they are and when to avoid them.

### Concept

A **cursor** processes query results one row at a time.

- Good for rare procedural tasks that truly require per-row actions.
- Usually slower than set-based SQL for reporting and transformations.
- Requires explicit open, fetch, close, and deallocate steps.

### Syntax

```sql
DECLARE cursor_name CURSOR FOR
SELECT ...

OPEN cursor_name;
FETCH NEXT FROM cursor_name INTO @var1, @var2;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- process current row
    FETCH NEXT FROM cursor_name INTO @var1, @var2;
END;

CLOSE cursor_name;
DEALLOCATE cursor_name;
```

### Walkthrough

Cursor demo that prints expensive product names.

```sql
USE BikeStores;
GO

DECLARE @product_name VARCHAR(255);

DECLARE product_cursor CURSOR FOR
SELECT product_name
FROM production.products
WHERE list_price > 1500;

OPEN product_cursor;

FETCH NEXT FROM product_cursor INTO @product_name;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @product_name;
    FETCH NEXT FROM product_cursor INTO @product_name;
END;

CLOSE product_cursor;
DEALLOCATE product_cursor;
```

#### Expected result

Prints one product name per line in SSMS messages.

### How it works

`FETCH NEXT` loads one row into variables. `@@FETCH_STATUS = 0` means fetch succeeded. After the loop, you must close and deallocate to release resources.

### Another example

Set-based replacement for many cursor tasks:

```sql
SELECT
    product_name,
    list_price * 1.05 AS projected_price
FROM production.products
WHERE list_price > 1500;
```

This returns all rows at once and is usually simpler and faster.

### Common mistakes

- Forgetting `CLOSE` and `DEALLOCATE`.
- Using cursors for tasks solvable with one `SELECT` or `UPDATE`.
- Not checking `@@FETCH_STATUS` in loop condition.

### Quick recap

- Cursors iterate row by row.
- They are useful in limited procedural scenarios.
- Prefer set-based SQL unless row-by-row logic is required.

### Next

[TRY/CATCH error handling](#trycatch-error-handling)


---

## TRY/CATCH Error Handling

### Why this matters

Production procedures should fail safely, not silently. `TRY...CATCH` lets you capture errors, rollback transactions, and return a clear message.

### Concept

`TRY...CATCH` splits your code into:

- **TRY block:** statements that may fail
- **CATCH block:** statements that run on failure

Inside `CATCH`, you can use functions such as `ERROR_MESSAGE()` and `ERROR_NUMBER()`.

### Syntax

```sql
BEGIN TRY
    -- risky statements
END TRY
BEGIN CATCH
    SELECT
        ERROR_NUMBER() AS error_number,
        ERROR_MESSAGE() AS error_message;
END CATCH;
```

### Walkthrough

Example with transaction rollback.

```sql
USE BikeStores;
GO

CREATE OR ALTER PROCEDURE sales.uspSafeDiscountUpdate
    @product_id INT,
    @new_price  DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;

        IF @new_price <= 0
            THROW 50001, 'Price must be greater than zero.', 1;

        UPDATE production.products
        SET list_price = @new_price
        WHERE product_id = @product_id;

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRAN;

        SELECT
            ERROR_NUMBER() AS error_number,
            ERROR_MESSAGE() AS error_message;
    END CATCH;
END;
GO
```

#### Expected result

- Valid input: one row updated and transaction committed.
- Invalid input (`@new_price <= 0`): rollback and error details returned.

### How it works

`THROW` raises a custom error. Control immediately moves to `CATCH`, where `XACT_STATE()` checks if a transaction is still active, then performs rollback to keep data consistent.

### Another example

Add context in CATCH:

```sql
SELECT
    ERROR_LINE() AS error_line,
    ERROR_PROCEDURE() AS error_procedure,
    ERROR_MESSAGE() AS error_message;
```

### Common mistakes

- Using `TRY...CATCH` without transaction handling for data changes.
- Swallowing errors without returning or logging details.
- Assuming `TRY...CATCH` catches every warning (it handles runtime errors).

### Quick recap

- `TRY...CATCH` is the standard error-handling pattern in procedures.
- Use `THROW` for clear custom failures.
- Combine with `BEGIN TRAN` and rollback for safe data updates.

### Next

[Dynamic SQL introduction](#dynamic-sql-introduction)


---

## Dynamic SQL Introduction

### Why this matters

Sometimes table names, columns, or filters are not known until runtime. Dynamic SQL lets you build and execute a query string inside a procedure.

### Concept

**Dynamic SQL** means SQL text generated at runtime.

- Use `sp_executesql` (preferred) over plain `EXEC` for parameter support.
- Keep dynamic parts minimal.
- Parameterize values to reduce SQL injection risk.

### Syntax

```sql
DECLARE @sql NVARCHAR(MAX);
SET @sql = N'SELECT ... WHERE column = @p;';

EXEC sp_executesql
    @sql,
    N'@p INT',
    @p = @value;
```

### Walkthrough

Sort products by a column chosen at runtime.

```sql
USE BikeStores;
GO

CREATE OR ALTER PROCEDURE production.uspDynamicProductSort
    @sort_column SYSNAME = N'list_price'
AS
BEGIN
    IF @sort_column NOT IN (N'product_name', N'list_price', N'model_year')
    BEGIN
        THROW 50002, 'Invalid sort column.', 1;
    END;

    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'
        SELECT TOP 20
            product_id,
            product_name,
            model_year,
            list_price
        FROM production.products
        ORDER BY ' + QUOTENAME(@sort_column) + N';';

    EXEC sp_executesql @sql;
END;
GO

EXEC production.uspDynamicProductSort @sort_column = N'product_name';
```

#### Expected result

Returns top 20 products sorted by the selected allowed column.

### How it works

The procedure validates input first, then builds a query string. `QUOTENAME` safely wraps identifier names. `sp_executesql` executes the final SQL text.

### Another example

Dynamic filter with parameterized value:

```sql
DECLARE @sql NVARCHAR(MAX) = N'
SELECT product_name, list_price
FROM production.products
WHERE list_price >= @min_price;';

EXEC sp_executesql
    @sql,
    N'@min_price DECIMAL(10,2)',
    @min_price = 1000;
```

### Common mistakes

- Concatenating user input directly into SQL values.
- Using `EXEC(@sql)` for everything instead of `sp_executesql`.
- Skipping allow-lists when dynamic identifiers are used.

### Quick recap

- Dynamic SQL builds statements at runtime.
- Prefer `sp_executesql` plus parameters.
- Validate dynamic identifiers and avoid unsafe string concatenation.

### Next

Finish chapter practice in [Exercises](#exercises).


---

## Exercises


Complete these after working through the topics above. Use the **BikeStores** database.

---

#### Exercise 1 - Create `uspProductList` (warm-up)

Create `production.uspProductList` to return `product_id`, `product_name`, and `list_price` sorted by `product_name`.

**Tables:** `production.products`

---

#### Exercise 2 - Filter by category parameter (warm-up)

Create `production.uspProductsByCategory` with input parameter `@category_id INT` and return matching products.

**Tables:** `production.products`

---

#### Exercise 3 - Use a local variable (apply)

Create a procedure that calculates average `list_price` into a variable, then returns products above that average.

**Tables:** `production.products`

---

#### Exercise 4 - Output parameter (apply)

Create `sales.uspOrderCountByStaff` with input `@staff_id` and output `@order_count`.

**Tables:** `sales.orders`

---

#### Exercise 5 - IF validation (apply)

Create a procedure that accepts `@min_price` and `@max_price`. If min is greater than or equal to max, print an error and return; otherwise list products in that range.

**Tables:** `production.products`

---

#### Exercise 6 - TRY/CATCH safety (apply)

Create a procedure that updates one product price inside a transaction and uses `TRY...CATCH` with rollback on error.

**Tables:** `production.products`

---

#### Exercise 7 - Dynamic SQL allow-list (stretch) ★

Create a procedure that sorts products by one of two allowed columns: `product_name` or `list_price`. Reject anything else.

**Tables:** `production.products`  
**Hint:** Use `QUOTENAME`.

---

#### Exercise 8 - Cursor awareness reflection (stretch) ★

Write one cursor demo that prints product names above `2000`, then write one set-based query that returns the same names. Compare both approaches in 2-3 sentences.

**Tables:** `production.products`


---

## Solutions


## Chapter 11 - Solutions

---

#### Exercise 1 - Solution

```sql
USE BikeStores;
GO

CREATE OR ALTER PROCEDURE production.uspProductList
AS
BEGIN
    SELECT
        product_id,
        product_name,
        list_price
    FROM production.products
    ORDER BY product_name;
END;
GO
```

Creates a reusable list procedure.

---

#### Exercise 2 - Solution

```sql
CREATE OR ALTER PROCEDURE production.uspProductsByCategory
    @category_id INT
AS
BEGIN
    SELECT
        product_id,
        product_name,
        list_price
    FROM production.products
    WHERE category_id = @category_id
    ORDER BY product_name;
END;
GO
```

Returns products for the given category only.

---

#### Exercise 3 - Solution

```sql
CREATE OR ALTER PROCEDURE production.uspProductsAboveAvg
AS
BEGIN
    DECLARE @avg_price DECIMAL(10, 2);

    SELECT @avg_price = AVG(list_price)
    FROM production.products;

    SELECT
        product_name,
        list_price
    FROM production.products
    WHERE list_price > @avg_price;
END;
GO
```

Uses a local variable to avoid repeated calculation.

---

#### Exercise 4 - Solution

```sql
CREATE OR ALTER PROCEDURE sales.uspOrderCountByStaff
    @staff_id INT,
    @order_count INT OUTPUT
AS
BEGIN
    SELECT @order_count = COUNT(*)
    FROM sales.orders
    WHERE staff_id = @staff_id;
END;
GO
```

Outputs one scalar value to the caller.

---

#### Exercise 5 - Solution

```sql
CREATE OR ALTER PROCEDURE production.uspProductsInPriceRange
    @min_price DECIMAL(10,2),
    @max_price DECIMAL(10,2)
AS
BEGIN
    IF @min_price >= @max_price
    BEGIN
        PRINT 'min_price must be less than max_price';
        RETURN;
    END;

    SELECT
        product_name,
        list_price
    FROM production.products
    WHERE list_price BETWEEN @min_price AND @max_price
    ORDER BY list_price;
END;
GO
```

Validates parameters before running the query.

---

#### Exercise 6 - Solution

```sql
CREATE OR ALTER PROCEDURE production.uspUpdatePriceSafe
    @product_id INT,
    @new_price DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;

        UPDATE production.products
        SET list_price = @new_price
        WHERE product_id = @product_id;

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRAN;

        SELECT ERROR_MESSAGE() AS error_message;
    END CATCH;
END;
GO
```

Rolls back transaction when an error occurs.

---

#### Exercise 7 - Solution

```sql
CREATE OR ALTER PROCEDURE production.uspSortProductsDynamic
    @sort_column SYSNAME
AS
BEGIN
    IF @sort_column NOT IN (N'product_name', N'list_price')
        THROW 50003, 'Invalid sort column.', 1;

    DECLARE @sql NVARCHAR(MAX) =
        N'SELECT product_name, list_price
          FROM production.products
          ORDER BY ' + QUOTENAME(@sort_column) + N';';

    EXEC sp_executesql @sql;
END;
GO
```

Uses allow-list validation and safe identifier quoting.

---

#### Exercise 8 - Solution

```sql
DECLARE @name VARCHAR(255);
DECLARE c CURSOR FOR
SELECT product_name
FROM production.products
WHERE list_price > 2000;

OPEN c;
FETCH NEXT FROM c INTO @name;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @name;
    FETCH NEXT FROM c INTO @name;
END;
CLOSE c;
DEALLOCATE c;

SELECT product_name
FROM production.products
WHERE list_price > 2000;
```

Both approaches identify the same rows; the set-based query is shorter and usually faster.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 12 - User-Defined Functions.md](Chapter 12 - User-Defined Functions.md)
