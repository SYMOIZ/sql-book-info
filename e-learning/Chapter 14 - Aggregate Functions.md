# Chapter 14 - Aggregate Functions


Learn how each major SQL Server aggregate function summarizes data so you can build counts, totals, averages, ranges, and statistical reports.

## Prerequisites

- [Chapter 04: Grouping and Aggregation](Chapter 04 - Grouping and Aggregation.md) completed
- [Chapter 13: Triggers](Chapter 13 - Triggers.md) completed
- **BikeStores** database loaded

## Learning goals

After this chapter, you will be able to:

- **Use** `AVG`, `COUNT`, and `SUM` for common summaries
- **Find** boundaries with `MIN` and `MAX`
- **Measure** spread with `STDEV` and `VAR`
- **Apply** distinct and conditional aggregate patterns
- **Build** readable lists with `STRING_AGG`
- **Explain** what `CHECKSUM_AGG` can and cannot do


## Time estimate

- **Reading:** about 90 minutes
- **Practice:** about 45 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `production.products`, `sales.orders`, `sales.order_items` |
| Tool | SSMS |


---

## Aggregate Function Overview

### Why this matters

Business questions are usually summaries, not raw rows: "How many orders?", "What is total revenue?", "What is average price?" Aggregate functions answer these quickly.

### Concept

An **aggregate function** takes many rows and returns one value.

Common examples:

- `COUNT()` row count
- `SUM()` total
- `AVG()` average
- `MIN()` and `MAX()` boundaries

You can use aggregates for the full table or per group with `GROUP BY`.

### Syntax

```sql
SELECT
    AGG_FUNCTION(column_name)
FROM schema_name.table_name
GROUP BY optional_column;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    COUNT(*) AS total_products,
    AVG(list_price) AS avg_price,
    MIN(list_price) AS min_price,
    MAX(list_price) AS max_price
FROM production.products;
```

#### Expected result

One row with four summary values for the full products table.

### How it works

SQL Server scans the target rows, applies each aggregate, and returns one combined result row because no `GROUP BY` was specified.

### Common mistakes

- Mixing aggregates and non-aggregated columns without `GROUP BY`.
- Assuming `COUNT(column)` includes `NULL` values.
- Using aggregate results in `WHERE` instead of `HAVING`.

### Quick recap

- Aggregates summarize many rows into one value.
- Use `GROUP BY` when you want one summary per category.
- Aggregates are the foundation of reporting SQL.

### Next

[AVG, COUNT, and SUM](#avg-count-and-sum)


---

## AVG, COUNT, and SUM

### Why this matters

These three functions appear in almost every report. They help answer "how many", "how much", and "what is typical".

### Concept

- `COUNT(*)` counts rows.
- `SUM(column)` adds numeric values.
- `AVG(column)` returns arithmetic mean.

Use `GROUP BY` to calculate per brand, per category, or per year.

### Syntax

```sql
SELECT
    group_col,
    COUNT(*) AS row_count,
    SUM(num_col) AS total_value,
    AVG(num_col) AS avg_value
FROM table_name
GROUP BY group_col;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    p.brand_id,
    COUNT(*) AS products_count,
    SUM(p.list_price) AS total_list_price,
    AVG(p.list_price) AS avg_list_price
FROM production.products AS p
GROUP BY p.brand_id
ORDER BY p.brand_id;
```

#### Expected result

One row per brand with count, sum, and average list price.

### How it works

SQL Server partitions rows by `brand_id`, then computes each aggregate independently per group.

### Another example

Order count per year:

```sql
SELECT
    YEAR(order_date) AS order_year,
    COUNT(*) AS total_orders
FROM sales.orders
GROUP BY YEAR(order_date)
ORDER BY order_year;
```

### Common mistakes

- Forgetting to handle `NULL` values when using `AVG(column)`.
- Using integer types when decimal precision is needed.
- Sorting by alias that is misspelled.

### Quick recap

- `COUNT`, `SUM`, and `AVG` are core reporting tools.
- Combine with `GROUP BY` for segmented summaries.
- Cast/round results for cleaner presentation.

### Next

[MIN and MAX](#min-and-max)


---

## MIN and MAX

### Why this matters

Range questions are common: cheapest product, latest order date, highest value. `MIN` and `MAX` answer these directly.

### Concept

- `MIN(column)` returns smallest value.
- `MAX(column)` returns largest value.

Works for numeric, date, and text columns (text uses collation order).

### Syntax

```sql
SELECT
    MIN(column_name) AS min_value,
    MAX(column_name) AS max_value
FROM table_name;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    MIN(list_price) AS lowest_price,
    MAX(list_price) AS highest_price
FROM production.products;
```

#### Expected result

One row with the lowest and highest product prices.

### How it works

SQL Server scans the column and tracks current smallest and largest values.

### Another example

Order date range by customer:

```sql
SELECT
    customer_id,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM sales.orders
GROUP BY customer_id
ORDER BY customer_id;
```

### Common mistakes

- Expecting `MIN`/`MAX` to return whole rows.
- Forgetting `GROUP BY` when adding non-aggregate columns.
- Comparing date strings instead of date types.

### Quick recap

- `MIN` and `MAX` return boundaries.
- Useful for dates, prices, and IDs.
- Pair with `GROUP BY` for per-entity ranges.

### Next

[STDEV and VAR](#stdev-and-var)


---

## STDEV and VAR

### Why this matters

Averages alone can hide variation. Standard deviation and variance show how spread out values are, which helps in pricing and performance analysis.

### Concept

- `STDEV(column)` sample standard deviation
- `VAR(column)` sample variance
- `STDEVP` and `VARP` are population versions

Higher values mean wider spread.

### Syntax

```sql
SELECT
    STDEV(column_name) AS std_dev,
    VAR(column_name) AS variance_value
FROM table_name;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    category_id,
    STDEV(list_price) AS sample_stddev,
    VAR(list_price) AS sample_variance
FROM production.products
GROUP BY category_id
ORDER BY category_id;
```

#### Expected result

One row per category with spread metrics for product prices.

### How it works

SQL Server computes deviation of each value from the group mean, then returns aggregate spread metrics.

### Another example

Population versions:

```sql
SELECT
    STDEVP(list_price) AS population_stddev,
    VARP(list_price) AS population_variance
FROM production.products;
```

### Common mistakes

- Mixing sample and population formulas without intent.
- Interpreting variance directly without context (units are squared).
- Using these functions on very small groups and overreading results.

### Quick recap

- `STDEV` and `VAR` measure spread.
- Use sample vs population versions intentionally.
- Great complement to `AVG`.

### Next

[DISTINCT and conditional aggregates](#distinct-and-conditional-aggregates)


---

## DISTINCT and Conditional Aggregates

### Why this matters

Real reports often need selective counting, like "unique customers" or "orders shipped late". Distinct and conditional aggregate patterns solve these.

### Concept

Two common patterns:

- `COUNT(DISTINCT column)` for unique counts
- `SUM(CASE WHEN ... THEN ... END)` for conditional totals

SQL Server does not have `COUNT_IF`, so `CASE` is the standard approach.

### Syntax

```sql
SELECT
    COUNT(DISTINCT column_name) AS unique_count,
    SUM(CASE WHEN condition THEN 1 ELSE 0 END) AS conditional_count
FROM table_name;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(CASE WHEN shipped_date IS NULL THEN 1 ELSE 0 END) AS open_orders
FROM sales.orders;
```

#### Expected result

One row showing unique ordering customers and currently unshipped orders.

### How it works

`COUNT(DISTINCT ...)` removes duplicates before counting. `CASE` maps each row to numeric flags, then `SUM` adds those flags.

### Another example

Conditional revenue by discount usage:

```sql
SELECT
    SUM(CASE WHEN discount > 0 THEN quantity * list_price ELSE 0 END) AS discounted_value,
    SUM(CASE WHEN discount = 0 THEN quantity * list_price ELSE 0 END) AS full_price_value
FROM sales.order_items;
```

### Common mistakes

- Forgetting `ELSE 0` in conditional sums.
- Using `COUNT(column)` when `COUNT(*)` is intended.
- Assuming `DISTINCT` on one column makes all selected columns distinct.

### Quick recap

- Use `COUNT(DISTINCT)` for unique values.
- Use `SUM(CASE...)` for conditional metrics.
- These patterns are essential for dashboard-style SQL.

### Next

[STRING_AGG](#string_agg)


---

## STRING_AGG

### Why this matters

Sometimes reports need grouped text, such as all product names in one category. `STRING_AGG` combines multiple row values into one delimited string.

### Concept

`STRING_AGG(expression, separator)` concatenates row values.

- Often used with `GROUP BY`
- Supports ordering with `WITHIN GROUP`

### Syntax

```sql
SELECT
    group_col,
    STRING_AGG(text_col, ', ') WITHIN GROUP (ORDER BY text_col) AS list_text
FROM table_name
GROUP BY group_col;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    p.category_id,
    STRING_AGG(p.product_name, ', ')
        WITHIN GROUP (ORDER BY p.product_name) AS products_in_category
FROM production.products AS p
GROUP BY p.category_id
ORDER BY p.category_id;
```

#### Expected result

One row per category with a comma-separated product list.

### How it works

SQL Server groups rows by `category_id`, sorts product names within each group, then concatenates them into one string.

### Another example

Brand list per model year:

```sql
SELECT
    model_year,
    STRING_AGG(CAST(brand_id AS VARCHAR(10)), ' | ') AS brands
FROM production.products
GROUP BY model_year;
```

### Common mistakes

- Forgetting to cast non-string values.
- Expecting one row per original row (it aggregates to group level).
- Skipping `WITHIN GROUP` when ordered output matters.

### Quick recap

- `STRING_AGG` builds delimited text summaries.
- Combine with `GROUP BY` for one list per group.
- Use `WITHIN GROUP` for deterministic order.

### Next

[CHECKSUM_AGG](#checksum_agg)


---

## CHECKSUM_AGG (Brief)

### Why this matters

You may need a lightweight signal that a result set changed. `CHECKSUM_AGG` provides a fast checksum across values.

### Concept

`CHECKSUM_AGG(expression)` returns an integer checksum for the group or table.

- Useful for quick change detection.
- Not cryptographically secure.
- Different datasets can occasionally produce the same checksum.

### Syntax

```sql
SELECT CHECKSUM_AGG(BINARY_CHECKSUM(column_name)) AS checksum_value
FROM table_name;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    CHECKSUM_AGG(BINARY_CHECKSUM(product_id, list_price)) AS products_checksum
FROM production.products;
```

#### Expected result

One integer checksum for current product id and price values.

### How it works

`BINARY_CHECKSUM` computes row-level checksums for chosen columns, and `CHECKSUM_AGG` combines them into one aggregate checksum.

### Common mistakes

- Treating checksum equality as proof datasets are identical.
- Using checksum for security verification.
- Forgetting that `NULL` handling can affect results.

### Quick recap

- `CHECKSUM_AGG` is for quick change signals.
- It is fast but not collision-proof.
- Use stronger comparisons for critical validation.

### Next

Move to [Exercises](#exercises), then continue to [Chapter 15: Date and String Functions](Chapter 15 - Date and String Functions.md).


---

## Exercises


Complete these after working through the topics above. ---

#### Exercise 1 - Product count and average (warm-up)

Return total products and average product price.

**Tables:** `production.products`

---

#### Exercise 2 - Revenue by order (warm-up)

Return `order_id` and total line value (`SUM(quantity * list_price * (1 - discount))`).

**Tables:** `sales.order_items`

---

#### Exercise 3 - Min/max per category (apply)

For each category, return minimum and maximum product price.

**Tables:** `production.products`

---

#### Exercise 4 - Price spread per brand (apply)

Return `brand_id`, `STDEV(list_price)`, and `VAR(list_price)`.

**Tables:** `production.products`

---

#### Exercise 5 - Distinct customers and open orders (apply)

In one query, return unique customer count and count of orders where `shipped_date` is null.

**Tables:** `sales.orders`

---

#### Exercise 6 - Product names per brand (stretch) ★

Use `STRING_AGG` to list product names for each brand id, alphabetically.

**Tables:** `production.products`

---

#### Exercise 7 - Checksum signal (stretch) ★

Return checksum for `product_id` and `list_price` from `production.products`.


---

## Solutions


## Chapter 14 - Solutions

---

#### Exercise 1 - Solution

```sql
USE BikeStores;

SELECT
    COUNT(*) AS total_products,
    AVG(list_price) AS avg_price
FROM production.products;
```

Returns one-row summary of size and average price.

---

#### Exercise 2 - Solution

```sql
SELECT
    order_id,
    SUM(quantity * list_price * (1 - discount)) AS order_total
FROM sales.order_items
GROUP BY order_id
ORDER BY order_id;
```

Calculates net value per order.

---

#### Exercise 3 - Solution

```sql
SELECT
    category_id,
    MIN(list_price) AS min_price,
    MAX(list_price) AS max_price
FROM production.products
GROUP BY category_id
ORDER BY category_id;
```

Shows price range inside each category.

---

#### Exercise 4 - Solution

```sql
SELECT
    brand_id,
    STDEV(list_price) AS price_stddev,
    VAR(list_price) AS price_variance
FROM production.products
GROUP BY brand_id
ORDER BY brand_id;
```

Measures price spread per brand.

---

#### Exercise 5 - Solution

```sql
SELECT
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(CASE WHEN shipped_date IS NULL THEN 1 ELSE 0 END) AS open_orders
FROM sales.orders;
```

Combines distinct and conditional aggregates.

---

#### Exercise 6 - Solution

```sql
SELECT
    brand_id,
    STRING_AGG(product_name, ', ') WITHIN GROUP (ORDER BY product_name) AS product_list
FROM production.products
GROUP BY brand_id
ORDER BY brand_id;
```

Builds one ordered text list per brand.

---

#### Exercise 7 - Solution

```sql
SELECT
    CHECKSUM_AGG(BINARY_CHECKSUM(product_id, list_price)) AS products_checksum
FROM production.products;
```

Produces a quick checksum-based change signal.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 15 - Date and String Functions.md](Chapter 15 - Date and String Functions.md)
