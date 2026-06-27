# Chapter 12 - User-Defined Functions


Learn to create reusable SQL functions that return either one value or a table, so you can simplify repeated calculations in queries.

## Prerequisites

- [Chapter 11: Stored Procedures](Chapter 11 - Stored Procedures.md) completed
- [Chapter 04: Grouping and Aggregation](Chapter 04 - Grouping and Aggregation.md) completed
- **BikeStores** database loaded

## Learning goals

After this chapter, you will be able to:

- **Create** scalar functions such as `sales.udfNetSale`
- **Use** table variables in multi-statement table-valued functions
- **Build** inline and multi-statement table-valued functions (TVFs)
- **Remove** obsolete functions with `DROP FUNCTION`


## Time estimate

- **Reading:** about 50-60 minutes
- **Practice:** about 30-40 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `sales.order_items`, `production.products`, `production.brands` |
| Tool | SSMS |


---

## Scalar Functions and `udfNetSale`

### Why this matters

When the same formula appears in many queries, copy-paste creates bugs. A scalar user-defined function centralizes that formula in one place.

### Concept

A **scalar function** returns exactly one value. In BikeStores, net sale is:

`quantity * list_price * (1 - discount)`

We will package that as `sales.udfNetSale`.

### Syntax

```sql
CREATE OR ALTER FUNCTION schema_name.function_name
(
    @param1 data_type
)
RETURNS data_type
AS
BEGIN
    RETURN <expression>;
END;
```

### Walkthrough

```sql
USE BikeStores;
GO

CREATE OR ALTER FUNCTION sales.udfNetSale
(
    @quantity   INT,
    @list_price DECIMAL(10,2),
    @discount   DECIMAL(4,2)
)
RETURNS DECIMAL(12,2)
AS
BEGIN
    RETURN @quantity * @list_price * (1 - @discount);
END;
GO

SELECT
    oi.order_id,
    oi.item_id,
    sales.udfNetSale(oi.quantity, oi.list_price, oi.discount) AS net_sale
FROM sales.order_items AS oi;
```

#### Expected result

Returns one row per order item with a calculated `net_sale` value.

### How it works

Each row calls the function with that row's values. SQL Server evaluates the function and returns one scalar output.

### Common mistakes

- Returning a type too small for calculated values.
- Adding data-changing statements inside scalar UDF logic.
- Forgetting schema when calling function.

### Quick recap

- Scalar UDF returns one value.
- Great for reusable formulas.
- `sales.udfNetSale` keeps net sale logic consistent.

### Next

[Table variables in functions](#table-variables-in-functions)


---

## Table Variables in Functions

### Why this matters

Some functions need to return multiple rows and columns. A table variable lets you build that output step by step inside a function.

### Concept

A **multi-statement TVF** uses a declared return table:

- Define columns in `RETURNS @table_name TABLE (...)`
- Insert rows into `@table_name`
- Return the table variable

### Syntax

```sql
CREATE OR ALTER FUNCTION schema_name.function_name (...)
RETURNS @result TABLE
(
    col1 data_type,
    col2 data_type
)
AS
BEGIN
    INSERT INTO @result
    SELECT ...;

    RETURN;
END;
```

### Walkthrough

```sql
USE BikeStores;
GO

CREATE OR ALTER FUNCTION sales.udfOrderItemsByOrder
(
    @order_id INT
)
RETURNS @items TABLE
(
    product_id INT,
    quantity   INT,
    net_sale   DECIMAL(12,2)
)
AS
BEGIN
    INSERT INTO @items (product_id, quantity, net_sale)
    SELECT
        oi.product_id,
        oi.quantity,
        sales.udfNetSale(oi.quantity, oi.list_price, oi.discount)
    FROM sales.order_items AS oi
    WHERE oi.order_id = @order_id;

    RETURN;
END;
GO

SELECT *
FROM sales.udfOrderItemsByOrder(1);
```

#### Expected result

Returns all order lines for order `1` with computed net sale.

### How it works

The function inserts selected rows into `@items`. When `RETURN` executes, SQL Server outputs that table variable as the function result.

### Common mistakes

- Forgetting to include output columns in `RETURNS @table`.
- Mismatching insert column list and select columns.
- Expecting table variable to persist after function call.

### Quick recap

- Multi-statement TVFs use table variables.
- You build output with `INSERT INTO @table`.
- This pattern is good for step-by-step row shaping.

### Next

[Inline and multi-statement TVFs](#inline-and-multi-statement-tvfs)


---

## Inline and Multi-Statement TVFs

### Why this matters

Table-valued functions (TVFs) are reusable query building blocks. You can join them to other tables and keep business logic centralized.

### Concept

SQL Server supports two TVF styles:

- **Inline TVF:** returns one `SELECT` directly (simpler, often faster).
- **Multi-statement TVF:** builds and returns a table variable (more flexible).

### Syntax

```sql
-- Inline TVF
CREATE FUNCTION ... RETURNS TABLE AS RETURN (SELECT ...);

-- Multi-statement TVF
CREATE FUNCTION ... RETURNS @t TABLE (...) AS BEGIN ... RETURN; END;
```

### Walkthrough

Inline TVF for products by brand:

```sql
USE BikeStores;
GO

CREATE OR ALTER FUNCTION production.udfProductsByBrand
(
    @brand_id INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        product_id,
        product_name,
        list_price
    FROM production.products
    WHERE brand_id = @brand_id
);
GO

SELECT *
FROM production.udfProductsByBrand(1);
```

#### Expected result

Returns products where `brand_id = 1`.

### How it works

An inline TVF behaves like a parameterized view. SQL Server can optimize it similarly to a normal query expression.

### Another example

Join function output with `production.brands`.

```sql
SELECT
    b.brand_name,
    p.product_name,
    p.list_price
FROM production.brands AS b
CROSS APPLY production.udfProductsByBrand(b.brand_id) AS p
ORDER BY b.brand_name, p.product_name;
```

### Common mistakes

- Choosing multi-statement TVF when inline TVF is enough.
- Returning too many columns that callers do not need.
- Forgetting that TVF must be queried with `SELECT`.

### Quick recap

- TVFs return row sets.
- Inline TVFs are compact and optimizer-friendly.
- Multi-statement TVFs help when logic needs intermediate steps.

### Next

[Dropping functions safely](#dropping-functions-safely)


---

## Dropping Functions Safely

### Why this matters

As your schema evolves, some functions become obsolete. You should remove old objects safely so scripts stay clean and deployments are repeatable.

### Concept

`DROP FUNCTION` deletes a function definition. Use `IF EXISTS` to avoid errors when rerunning scripts.

Before dropping, check dependencies in procedures, views, or queries.

### Syntax

```sql
DROP FUNCTION [ IF EXISTS ] schema_name.function_name;
```

### Walkthrough

```sql
USE BikeStores;
GO

DROP FUNCTION IF EXISTS production.udfProductsByBrand;
GO
```

#### Expected result

Function is removed from the database if it exists.

### How it works

`IF EXISTS` makes scripts idempotent: you can run them multiple times without failing when the object is already gone.

### Another example

Drop multiple functions in one statement:

```sql
DROP FUNCTION IF EXISTS
    sales.udfOrderItemsByOrder,
    sales.udfNetSale;
```

### Common mistakes

- Dropping functions still used by views or procedures.
- Forgetting schema name.
- Using `DROP` in production without migration review.

### Quick recap

- Use `DROP FUNCTION IF EXISTS` for safe cleanup scripts.
- Verify dependencies before deleting shared functions.
- Keep schema objects intentional and current.

### Next

Practice with [Exercises](#exercises), then continue to [Chapter 13: Triggers](Chapter 13 - Triggers.md).


---

## Exercises


Complete these after working through the topics above. ---

#### Exercise 1 - Create `udfNetSale` (warm-up)

Create scalar function `sales.udfNetSale` that returns `quantity * list_price * (1 - discount)`.

**Tables:** `sales.order_items`

---

#### Exercise 2 - Use scalar UDF in query (warm-up)

Return `order_id`, `item_id`, and net sale by calling `sales.udfNetSale`.

**Tables:** `sales.order_items`

---

#### Exercise 3 - Build inline TVF (apply)

Create `production.udfProductsByCategory(@category_id)` that returns product id, name, and list price.

**Tables:** `production.products`

---

#### Exercise 4 - Build multi-statement TVF (apply)

Create `sales.udfOrderItemsByOrder(@order_id)` that returns product id, quantity, and net sale.

**Tables:** `sales.order_items`

---

#### Exercise 5 - Drop function safely (apply)

Write statements to drop the two functions above using `IF EXISTS`.

---

#### Exercise 6 - Compare TVF styles (stretch) ★

In 3-4 sentences, explain when inline TVF is a better choice than multi-statement TVF.


---

## Solutions


## Chapter 12 - Solutions

---

#### Exercise 1 - Solution

```sql
USE BikeStores;
GO

CREATE OR ALTER FUNCTION sales.udfNetSale
(
    @quantity   INT,
    @list_price DECIMAL(10,2),
    @discount   DECIMAL(4,2)
)
RETURNS DECIMAL(12,2)
AS
BEGIN
    RETURN @quantity * @list_price * (1 - @discount);
END;
GO
```

Creates a reusable scalar formula.

---

#### Exercise 2 - Solution

```sql
SELECT
    order_id,
    item_id,
    sales.udfNetSale(quantity, list_price, discount) AS net_sale
FROM sales.order_items;
```

Calls the function once per order-item row.

---

#### Exercise 3 - Solution

```sql
CREATE OR ALTER FUNCTION production.udfProductsByCategory
(
    @category_id INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        product_id,
        product_name,
        list_price
    FROM production.products
    WHERE category_id = @category_id
);
GO
```

Returns a filtered row set as an inline TVF.

---

#### Exercise 4 - Solution

```sql
CREATE OR ALTER FUNCTION sales.udfOrderItemsByOrder
(
    @order_id INT
)
RETURNS @items TABLE
(
    product_id INT,
    quantity   INT,
    net_sale   DECIMAL(12,2)
)
AS
BEGIN
    INSERT INTO @items (product_id, quantity, net_sale)
    SELECT
        product_id,
        quantity,
        sales.udfNetSale(quantity, list_price, discount)
    FROM sales.order_items
    WHERE order_id = @order_id;

    RETURN;
END;
GO
```

Uses table-variable return pattern.

---

#### Exercise 5 - Solution

```sql
DROP FUNCTION IF EXISTS sales.udfOrderItemsByOrder;
DROP FUNCTION IF EXISTS production.udfProductsByCategory;
```

Safely removes functions without rerun errors.

---

#### Exercise 6 - Solution

Inline TVFs are usually better when one `SELECT` can express the logic. They are easier to read, and SQL Server can optimize them more effectively in many cases. Multi-statement TVFs are helpful when you need multiple steps or temporary shaping before return.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 13 - Triggers.md](Chapter 13 - Triggers.md)
