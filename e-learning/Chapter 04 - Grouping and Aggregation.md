# Chapter 04 - Grouping and Aggregation


Learn how to summarize detailed rows into business-level insights using `GROUP BY`, aggregate functions, and advanced grouping features.

## Prerequisites

- [Chapter 03: Joins](Chapter 03 - Joins.md) completed
- **BikeStores** database loaded ([`02-load-data.sql`](assets/database/02-load-data.sql))
- For Lessons 04-05: run [`04-tutorial-extensions.sql`](assets/database/04-tutorial-extensions.sql) to create `sales.sales_summary`

## Learning goals

After this chapter, you will be able to:

- **Group** rows by one or more columns with `GROUP BY`
- **Compute** summaries with `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`
- **Filter** grouped results using `HAVING`
- **Generate** multi-level summaries with `GROUPING SETS`
- **Build** subtotal and grand-total reports with `CUBE` and `ROLLUP`


## Time estimate

- **Reading:** about 75-90 minutes
- **Practice:** about 45-60 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `production.products`, `production.brands`, `production.categories`, `sales.orders`, `sales.order_items`, `sales.sales_summary` |
| Tool | SSMS query window with `USE BikeStores;` |

**Bundled sample sizes:** 10 customers, 15 products, 8 orders, 3 stores, 5 staff.

## Troubleshooting

| Problem | What to try |
|---------|-------------|
| `Column is invalid in the select list...` | Every non-aggregate selected column must be in `GROUP BY` |
| `Invalid object name 'sales.sales_summary'` | Run [`04-tutorial-extensions.sql`](assets/database/04-tutorial-extensions.sql) first |
| Wrong totals | Check joins before aggregation to avoid duplicate rows |
| `HAVING` not working as expected | Use `HAVING` for aggregate filters, `WHERE` for row filters |


---

## Group by basics

### Why this matters

Raw transaction data is detailed, but decision-making needs summaries. `GROUP BY` lets you answer questions like "How many products are in each category?" or "How many orders were placed by each customer?"

### Concept

`GROUP BY` combines rows that share the same value(s) in selected columns.

After grouping, you usually apply aggregate functions:

- `COUNT(*)` for row counts
- `SUM()` for totals
- `AVG()` for averages

You can group by one column or multiple columns.

### Syntax

```sql
SELECT
    group_column,
    COUNT(*) AS row_count
FROM
    schema_name.table_name
GROUP BY
    group_column;
```

Multiple grouping columns:

```sql
GROUP BY
    column_a,
    column_b
```

### Walkthrough

**Example 1 — product count by category**

```sql
USE BikeStores;

SELECT
    category_id,
    COUNT(*) AS product_count
FROM
    production.products
GROUP BY
    category_id
ORDER BY
    category_id;
```

#### Expected result

One row per category present in `production.products`; counts add up to 15 products.

**Example 2 — orders by customer**

```sql
SELECT
    customer_id,
    COUNT(*) AS order_count
FROM
    sales.orders
GROUP BY
    customer_id
ORDER BY
    order_count DESC,
    customer_id;
```

#### Expected result

One row per customer who placed at least one order; total orders counted = 8.

**Example 3 — products by brand and model year**

```sql
SELECT
    brand_id,
    model_year,
    COUNT(*) AS product_count
FROM
    production.products
GROUP BY
    brand_id,
    model_year
ORDER BY
    brand_id,
    model_year;
```

#### Expected result

Multiple grouped rows, one for each brand/year combination in the sample.

### How it works

SQL Server first applies `FROM` and `WHERE`, then forms groups, then computes aggregate values per group. Each output row represents one group, not one original row.

### Common mistakes

- Selecting columns that are neither aggregated nor grouped
- Expecting non-grouped detail rows to remain visible
- Forgetting that `NULL` values are grouped together
- Sorting by aliases not in scope in complex queries

### Quick recap

- `GROUP BY` creates grouped result rows.
- Aggregates summarize each group.
- Grouping can be single-column or multi-column.

### Next

[Group by with aggregates](#group-by-with-aggregates)


---

## Group by with aggregates

### Why this matters

Counts alone are useful, but business reports usually need totals, averages, minimums, and maximums. Combining `GROUP BY` with aggregate functions turns raw rows into KPI-ready summaries.

### Concept

Common aggregate functions:

| Function | Purpose |
|----------|---------|
| `COUNT(*)` | Number of rows |
| `SUM(column)` | Total of numeric column |
| `AVG(column)` | Average of numeric column |
| `MIN(column)` | Smallest value |
| `MAX(column)` | Largest value |

You can use several aggregates in one grouped query.

### Syntax

```sql
SELECT
    group_column,
    COUNT(*) AS row_count,
    SUM(numeric_column) AS total_value,
    AVG(numeric_column) AS avg_value
FROM
    schema_name.table_name
GROUP BY
    group_column;
```

### Walkthrough

**Example 1 — price stats by brand**

```sql
USE BikeStores;

SELECT
    b.brand_name,
    COUNT(*) AS product_count,
    MIN(p.list_price) AS min_price,
    MAX(p.list_price) AS max_price,
    AVG(p.list_price) AS avg_price
FROM
    production.products AS p
INNER JOIN
    production.brands AS b
    ON p.brand_id = b.brand_id
GROUP BY
    b.brand_name
ORDER BY
    b.brand_name;
```

#### Expected result

One row per brand with product count and price range summaries.

**Example 2 — order value by order**

```sql
SELECT
    oi.order_id,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS order_total
FROM
    sales.order_items AS oi
GROUP BY
    oi.order_id
ORDER BY
    oi.order_id;
```

#### Expected result

8 rows (one per order in bundled data) with computed order totals.

**Example 3 — quantity summary by product**

```sql
SELECT
    oi.product_id,
    SUM(oi.quantity) AS total_quantity,
    AVG(CAST(oi.quantity AS DECIMAL(10, 2))) AS avg_quantity
FROM
    sales.order_items AS oi
GROUP BY
    oi.product_id
ORDER BY
    total_quantity DESC,
    oi.product_id;
```

#### Expected result

One row for each product that appears in order items, sorted by sold quantity.

### How it works

After groups are created, SQL Server runs each aggregate independently for each group. Expressions inside aggregates (like revenue formulas) are calculated per row before aggregate totals are produced.

### Common mistakes

- Using integer-only math when you need decimal precision
- Forgetting to handle discounts in sales totals
- Assuming `AVG()` ignores data type conversion concerns
- Mixing pre-aggregated and raw tables without checking duplication

### Quick recap

- Aggregates summarize grouped data.
- One query can return multiple metrics per group.
- Use joins plus grouping to produce business-friendly reports.

### Next

[Filtering groups with HAVING](#filtering-groups-with-having)


---

## Filtering groups with HAVING

### Why this matters

After grouping, you often want only specific groups, such as brands with high average prices or customers with multiple orders. `HAVING` filters grouped results the way `WHERE` filters raw rows.

### Concept

- `WHERE` filters rows **before** grouping
- `HAVING` filters groups **after** aggregation

You can use both in one query:

- `WHERE` for row-level conditions
- `HAVING` for aggregate conditions

### Syntax

```sql
SELECT
    group_column,
    aggregate_expression
FROM
    table_name
WHERE
    row_condition
GROUP BY
    group_column
HAVING
    aggregate_condition;
```

### Walkthrough

**Example 1 — brands with average price above 1000**

```sql
USE BikeStores;

SELECT
    b.brand_name,
    AVG(p.list_price) AS avg_price
FROM
    production.products AS p
INNER JOIN
    production.brands AS b
    ON p.brand_id = b.brand_id
GROUP BY
    b.brand_name
HAVING
    AVG(p.list_price) > 1000
ORDER BY
    avg_price DESC;
```

#### Expected result

Only brands whose average list price is above 1000.

**Example 2 — customers with at least 2 orders**

```sql
SELECT
    o.customer_id,
    COUNT(*) AS order_count
FROM
    sales.orders AS o
GROUP BY
    o.customer_id
HAVING
    COUNT(*) >= 2
ORDER BY
    order_count DESC,
    o.customer_id;
```

#### Expected result

Rows only for repeat-order customers in the bundled dataset.

**Example 3 — combine WHERE and HAVING**

```sql
SELECT
    p.brand_id,
    COUNT(*) AS products_2021_plus
FROM
    production.products AS p
WHERE
    p.model_year >= 2021
GROUP BY
    p.brand_id
HAVING
    COUNT(*) >= 2
ORDER BY
    p.brand_id;
```

#### Expected result

Only brands with at least two products from model year 2021 or newer.

### How it works

SQL Server applies `WHERE`, then groups rows, computes aggregates, and finally applies `HAVING`. That order explains why aggregate functions are valid in `HAVING` but not usually in `WHERE`.

### Common mistakes

- Writing aggregate filters in `WHERE`
- Repeating complex aggregate expressions inconsistently
- Assuming `HAVING` can replace all row-level filtering
- Forgetting that `HAVING` can slow queries if you skip useful `WHERE` filters

### Quick recap

- `WHERE` filters rows; `HAVING` filters groups.
- Use `HAVING` with aggregate expressions like `COUNT(*)` or `AVG(...)`.
- Combine both clauses for precise and efficient summaries.

### Next

[Grouping sets](#grouping-sets)


---

## Grouping sets

### Why this matters

Reports often need multiple summary levels at once, such as "by brand", "by category", and "overall total". `GROUPING SETS` calculates all those levels in a single query.

### Concept

`GROUPING SETS` lets you define several grouping combinations explicitly.

For this lesson, use `sales.sales_summary`, created by running:

- [`assets/database/04-tutorial-extensions.sql`](assets/database/04-tutorial-extensions.sql)

This table contains:

- `brand`
- `category`
- `sales_amount`

### Syntax

```sql
SELECT
    column_list,
    SUM(measure_column) AS total_value
FROM
    table_name
GROUP BY
    GROUPING SETS (
        (group_col_1),
        (group_col_2),
        (group_col_1, group_col_2),
        ()
    );
```

`()` means grand total.

### Walkthrough

**Example 1 — brand totals and category totals**

```sql
USE BikeStores;

SELECT
    brand,
    category,
    SUM(sales_amount) AS total_sales
FROM
    sales.sales_summary
GROUP BY
    GROUPING SETS (
        (brand),
        (category)
    )
ORDER BY
    brand,
    category;
```

#### Expected result

Rows for each brand total and each category total. Columns not part of a grouping set return `NULL`.

**Example 2 — brand/category detail plus grand total**

```sql
SELECT
    brand,
    category,
    SUM(sales_amount) AS total_sales
FROM
    sales.sales_summary
GROUP BY
    GROUPING SETS (
        (brand, category),
        ()
    )
ORDER BY
    brand,
    category;
```

#### Expected result

Detail rows plus one grand-total row where both `brand` and `category` are `NULL`.

**Example 3 — full custom report**

```sql
SELECT
    brand,
    category,
    SUM(sales_amount) AS total_sales
FROM
    sales.sales_summary
GROUP BY
    GROUPING SETS (
        (brand, category),
        (brand),
        (category),
        ()
    )
ORDER BY
    brand,
    category;
```

#### Expected result

A single result set containing detail, subtotals, and grand total.

### How it works

SQL Server runs aggregation for each grouping set and combines the outputs with a union-like internal operation. This avoids writing multiple separate queries and manually combining results.

### Common mistakes

- Forgetting to run `04-tutorial-extensions.sql` first
- Misreading `NULL` as missing data instead of subtotal/grand-total markers
- Ordering results without considering mixed detail and subtotal rows
- Writing overlapping grouping sets without understanding duplicate intent

### Quick recap

- `GROUPING SETS` computes custom summary levels in one query.
- It is more flexible than plain `GROUP BY`.
- `NULL` often indicates subtotal context in grouped output.

### Next

[CUBE and ROLLUP](#cube-and-rollup)


---

## CUBE and ROLLUP

### Why this matters

Analytical reports commonly require subtotals by level and a final grand total. `ROLLUP` and `CUBE` generate these hierarchical summaries quickly without writing many separate queries.

### Concept

Use `sales.sales_summary` from [`assets/database/04-tutorial-extensions.sql`](assets/database/04-tutorial-extensions.sql).

Difference:

- `ROLLUP(a, b)` returns hierarchy totals: `(a, b)`, `(a)`, `()`
- `CUBE(a, b)` returns all combinations: `(a, b)`, `(a)`, `(b)`, `()`

For two columns, `CUBE` is like a complete subtotal matrix.

### Syntax

```sql
SELECT
    col_a,
    col_b,
    SUM(measure) AS total_value
FROM
    table_name
GROUP BY
    ROLLUP (col_a, col_b);
```

```sql
SELECT
    col_a,
    col_b,
    SUM(measure) AS total_value
FROM
    table_name
GROUP BY
    CUBE (col_a, col_b);
```

### Walkthrough

**Example 1 — hierarchical totals with ROLLUP**

```sql
USE BikeStores;

SELECT
    brand,
    category,
    SUM(sales_amount) AS total_sales
FROM
    sales.sales_summary
GROUP BY
    ROLLUP (brand, category)
ORDER BY
    brand,
    category;
```

#### Expected result

Rows for each brand/category detail, then brand subtotals, then one grand total row.

**Example 2 — full matrix with CUBE**

```sql
SELECT
    brand,
    category,
    SUM(sales_amount) AS total_sales
FROM
    sales.sales_summary
GROUP BY
    CUBE (brand, category)
ORDER BY
    brand,
    category;
```

#### Expected result

Detail rows plus subtotals by brand, subtotals by category, and grand total.

**Example 3 — label subtotal rows**

```sql
SELECT
    COALESCE(brand, 'ALL BRANDS') AS brand_label,
    COALESCE(category, 'ALL CATEGORIES') AS category_label,
    SUM(sales_amount) AS total_sales
FROM
    sales.sales_summary
GROUP BY
    CUBE (brand, category)
ORDER BY
    brand_label,
    category_label;
```

#### Expected result

Same totals, but subtotal rows are easier to read because `NULL` labels are replaced.

### How it works

`ROLLUP` and `CUBE` expand to multiple grouping sets behind the scenes. SQL Server aggregates each level and merges the outputs into one result set.

### Common mistakes

- Using `CUBE` when only hierarchy totals are needed, creating extra rows
- Misinterpreting `NULL` subtotal markers as missing values
- Forgetting to mention script prerequisites for `sales.sales_summary`
- Sorting results in a way that mixes detail and subtotals unpredictably

### Quick recap

- `ROLLUP` gives hierarchical subtotals.
- `CUBE` gives all subtotal combinations.
- Both are powerful shortcuts for report-style SQL.

### Next

Continue to [Exercises](#exercises), then move to [Chapter 05: Subqueries and Set Operators](Chapter 05 - Subqueries and Set Operators.md).


---

## Exercises


Complete these after working through the topics above. Run all queries against **BikeStores**.

---

#### Exercise 1 — Products per category (warm-up)

Count products in each category (`category_id`) and sort by `category_id`.

**Tables:** `production.products`

---

#### Exercise 2 — Orders per customer (warm-up)

Count how many orders each customer placed.

**Tables:** `sales.orders`

---

#### Exercise 3 — Revenue per order (apply)

Calculate total value for each order using `quantity * list_price * (1 - discount)`.

**Tables:** `sales.order_items`

---

#### Exercise 4 — Brands with expensive average price (apply)

Show brands where average `list_price` is greater than 900.

**Tables:** `production.products`, `production.brands`  
**Hint:** `GROUP BY` + `HAVING`.

---

#### Exercise 5 — Category totals from sales_summary (apply)

Return total `sales_amount` by `category` from `sales.sales_summary`.

**Tables:** `sales.sales_summary`  
**Prerequisite:** Run `assets/database/04-tutorial-extensions.sql` first.

---

#### Exercise 6 — Grouping sets summary (apply)

From `sales.sales_summary`, return totals by `(brand, category)` and grand total in one query.

**Tables:** `sales.sales_summary`  
**Hint:** `GROUPING SETS ((brand, category), ())`

---

#### Exercise 7 — ROLLUP report ★ (stretch)

Produce hierarchical totals using `ROLLUP (brand, category)`.

**Tables:** `sales.sales_summary`

---

#### Exercise 8 — CUBE report with labels ★ (stretch)

Build a `CUBE` report and replace `NULL` with labels (`ALL BRANDS`, `ALL CATEGORIES`).

**Tables:** `sales.sales_summary`  
**Hint:** `COALESCE`.


---

## Solutions


---

#### Exercise 1 — Solution

```sql
USE BikeStores;

SELECT
    category_id,
    COUNT(*) AS product_count
FROM
    production.products
GROUP BY
    category_id
ORDER BY
    category_id;
```

Returns one row per category; product counts sum to 15.

---

#### Exercise 2 — Solution

```sql
USE BikeStores;

SELECT
    customer_id,
    COUNT(*) AS order_count
FROM
    sales.orders
GROUP BY
    customer_id
ORDER BY
    order_count DESC,
    customer_id;
```

Returns customers who have at least one order; order counts sum to 8.

---

#### Exercise 3 — Solution

```sql
USE BikeStores;

SELECT
    order_id,
    SUM(quantity * list_price * (1 - discount)) AS order_total
FROM
    sales.order_items
GROUP BY
    order_id
ORDER BY
    order_id;
```

Returns 8 rows (one per order) with computed totals.

---

#### Exercise 4 — Solution

```sql
USE BikeStores;

SELECT
    b.brand_name,
    AVG(p.list_price) AS avg_price
FROM
    production.products AS p
INNER JOIN
    production.brands AS b
    ON p.brand_id = b.brand_id
GROUP BY
    b.brand_name
HAVING
    AVG(p.list_price) > 900
ORDER BY
    avg_price DESC;
```

Returns only brands whose average list price is above 900.

---

#### Exercise 5 — Solution

```sql
USE BikeStores;

SELECT
    category,
    SUM(sales_amount) AS total_sales
FROM
    sales.sales_summary
GROUP BY
    category
ORDER BY
    category;
```

Returns one row per category from the summary table.

---

#### Exercise 6 — Solution

```sql
USE BikeStores;

SELECT
    brand,
    category,
    SUM(sales_amount) AS total_sales
FROM
    sales.sales_summary
GROUP BY
    GROUPING SETS (
        (brand, category),
        ()
    )
ORDER BY
    brand,
    category;
```

Returns detail rows plus one grand-total row.

---

#### Exercise 7 — Solution

```sql
USE BikeStores;

SELECT
    brand,
    category,
    SUM(sales_amount) AS total_sales
FROM
    sales.sales_summary
GROUP BY
    ROLLUP (brand, category)
ORDER BY
    brand,
    category;
```

Returns hierarchy rows: detail, brand subtotal, and grand total.

---

#### Exercise 8 — Solution

```sql
USE BikeStores;

SELECT
    COALESCE(brand, 'ALL BRANDS') AS brand_label,
    COALESCE(category, 'ALL CATEGORIES') AS category_label,
    SUM(sales_amount) AS total_sales
FROM
    sales.sales_summary
GROUP BY
    CUBE (brand, category)
ORDER BY
    brand_label,
    category_label;
```

Returns a full subtotal matrix with readable labels for subtotal rows.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 05 - Subqueries and Set Operators.md](Chapter 05 - Subqueries and Set Operators.md)
