# Chapter 06 - CTEs and Pivot


Common table expressions (CTEs) make complex queries easier to read and reuse. In this chapter, you will learn non-recursive and recursive CTEs, compare CTEs with subqueries, and reshape rows into columns with `PIVOT`.

## Prerequisites

- [Chapter 05: Subqueries and Set Operators](Chapter 05 - Subqueries and Set Operators.md) completed
- **BikeStores** database loaded
- SSMS connected and ready to run queries

## Learning goals

After this chapter, you will be able to:

- **Build** non-recursive CTEs to organize multi-step queries
- **Use** recursive CTEs for hierarchy-style reporting
- **Choose** between CTEs and subqueries based on readability and reuse
- **Transform** grouped row data into columns with `PIVOT`


## Time estimate

- **Reading:** about 45-60 minutes
- **Practice:** about 35-45 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `sales.staffs`, `sales.orders`, `sales.order_items` |
| Tool | SSMS query window with `USE BikeStores;` |

## Troubleshooting

| Problem | What to try |
|---------|-------------|
| `Invalid object name` | Include schema names like `sales.orders` |
| Recursive CTE loops forever | Add a stop condition (`WHERE level < n`) |
| `PIVOT` syntax error | Verify the source subquery and `IN (...)` column list |
| Wrong aggregation in pivot | Check the selected measure and grouping keys |


---

## Non-Recursive CTE Basics

### Why this matters

As SQL queries grow, nested subqueries can become hard to read. A common table expression (CTE) lets you name an intermediate result so the final query is cleaner and easier to debug.

### Concept

A non-recursive CTE is a temporary named result set defined with `WITH`. It exists only for the next statement.

- Think of it as a readable "step 1" before "step 2"
- You can reference the CTE name like a normal table in the main query
- You can define multiple CTEs in one `WITH` block

### Syntax

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT ...
FROM cte_name;
```

### Walkthrough

Goal: find monthly sales totals for shipped orders.

```sql
USE BikeStores;

WITH shipped_orders AS (
    SELECT
        o.order_id,
        o.order_date
    FROM
        sales.orders AS o
    WHERE
        o.order_status = 4
),
monthly_totals AS (
    SELECT
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS order_month,
        COUNT(*) AS shipped_orders
    FROM
        shipped_orders
    GROUP BY
        YEAR(order_date),
        MONTH(order_date)
)
SELECT
    order_year,
    order_month,
    shipped_orders
FROM
    monthly_totals
ORDER BY
    order_year,
    order_month;
```

### How it works

`shipped_orders` filters to the rows you care about first. `monthly_totals` then groups those rows. The final `SELECT` only handles presentation and ordering. Each step has one clear purpose.

### Common mistakes

- Forgetting that a CTE only applies to the **next** statement
- Missing the comma between multiple CTE definitions
- Not ending the previous statement with `;` before `WITH`
- Trying to reference the CTE in a separate query window batch

### Quick recap

- Non-recursive CTEs improve readability for multi-step logic
- They are temporary and scoped to one statement
- Multiple CTEs can be chained in one query

### Next

[Recursive CTE staff hierarchy](#recursive-cte-staff-hierarchy)


---

## Recursive CTE Staff Hierarchy

### Why this matters

Many business datasets are hierarchical: manager to employee, parent category to child category, and so on. Recursive CTEs are the SQL Server pattern for traversing those structures.

### Concept

A recursive CTE has two parts:

1. **Anchor member** — starting rows (top-level manager)
2. **Recursive member** — joins back to the CTE to fetch next levels

SQL repeats the recursive part until no more rows are returned.

### Syntax

```sql
WITH cte_name AS (
    -- anchor query
    SELECT ...
    UNION ALL
    -- recursive query
    SELECT ...
    FROM ... JOIN cte_name ...
)
SELECT ...
FROM cte_name;
```

### Walkthrough

Goal: show staff reporting lines from top manager down.

```sql
USE BikeStores;

WITH staff_tree AS (
    -- Anchor: top-level staff (no manager)
    SELECT
        s.staff_id,
        s.first_name + ' ' + s.last_name AS staff_name,
        s.manager_id,
        0 AS level_num,
        CAST(s.first_name + ' ' + s.last_name AS VARCHAR(200)) AS path
    FROM
        sales.staffs AS s
    WHERE
        s.manager_id IS NULL

    UNION ALL

    -- Recursive: direct reports
    SELECT
        child.staff_id,
        child.first_name + ' ' + child.last_name AS staff_name,
        child.manager_id,
        parent.level_num + 1 AS level_num,
        CAST(parent.path + ' > ' + child.first_name + ' ' + child.last_name AS VARCHAR(200)) AS path
    FROM
        sales.staffs AS child
        INNER JOIN staff_tree AS parent
            ON child.manager_id = parent.staff_id
)
SELECT
    level_num,
    staff_id,
    staff_name,
    manager_id,
    path
FROM
    staff_tree
ORDER BY
    path;
```

### How it works

The first query seeds the recursion with the root manager. Each recursive pass finds children where `child.manager_id = parent.staff_id`. `level_num` tracks depth, and `path` gives a readable chain.

### Common mistakes

- Using `UNION` instead of `UNION ALL` (adds unnecessary deduplication)
- Missing an anchor row (`manager_id IS NULL`)
- Creating circular relationships in source data
- Forgetting recursion limits in large datasets (`OPTION (MAXRECURSION n)`)

### Quick recap

- Recursive CTEs are ideal for hierarchy traversal
- Build anchor + recursive members with `UNION ALL`
- Add helper columns like `level_num` and `path` for reporting

### Next

[CTE vs subquery](#cte-vs-subquery)


---

## CTE vs Subquery

### Why this matters

Both CTEs and subqueries solve similar problems. Choosing the right one improves readability, maintainability, and team collaboration.

### Concept

- **Subquery**: query nested directly inside another query
- **CTE**: named query block before the main statement

Both are logical query expressions. SQL Server may optimize them similarly, so choose based on clarity unless performance testing proves otherwise.

### Syntax

Subquery style:

```sql
SELECT ...
FROM (
    SELECT ...
) AS x;
```

CTE style:

```sql
WITH x AS (
    SELECT ...
)
SELECT ...
FROM x;
```

### Walkthrough

Goal: list products priced above their brand average.

**Subquery version**

```sql
USE BikeStores;

SELECT
    p.product_name,
    p.list_price,
    b.avg_brand_price
FROM
    production.products AS p
    INNER JOIN (
        SELECT
            brand_id,
            AVG(list_price) AS avg_brand_price
        FROM
            production.products
        GROUP BY
            brand_id
    ) AS b
        ON p.brand_id = b.brand_id
WHERE
    p.list_price > b.avg_brand_price;
```

**CTE version**

```sql
WITH brand_avg AS (
    SELECT
        brand_id,
        AVG(list_price) AS avg_brand_price
    FROM
        production.products
    GROUP BY
        brand_id
)
SELECT
    p.product_name,
    p.list_price,
    ba.avg_brand_price
FROM
    production.products AS p
    INNER JOIN brand_avg AS ba
        ON p.brand_id = ba.brand_id
WHERE
    p.list_price > ba.avg_brand_price;
```

### How it works

The logic is the same. The CTE version typically reads better because the aggregate step has a meaningful name (`brand_avg`) and can be reused by multiple joins in the same statement.

### Common mistakes

- Using CTEs assuming automatic performance gains
- Nesting too many subqueries and hurting readability
- Repeating identical subquery logic instead of naming it once
- Ignoring execution plans when performance matters

### Quick recap

- CTE and subquery are both valid tools
- Prefer CTEs for multi-step readability and reuse
- Validate performance with actual execution plans, not guesses

### Next

[PIVOT basics](#pivot-basics)


---

## PIVOT Basics

### Why this matters

Reports often need month columns, status columns, or category columns. `PIVOT` turns row values into columns directly in SQL Server.

### Concept

`PIVOT` requires:

- A source query with grouping key(s), pivot key, and value
- An aggregate function (`SUM`, `COUNT`, etc.)
- A fixed list of output pivot columns in `IN (...)`

### Syntax

```sql
SELECT ...
FROM (
    SELECT group_col, pivot_col, value_col
    FROM ...
) AS src
PIVOT (
    SUM(value_col)
    FOR pivot_col IN ([A], [B], [C])
) AS p;
```

### Walkthrough

Goal: show shipped order counts by store and year as columns.

```sql
USE BikeStores;

SELECT
    store_name,
    ISNULL([2019], 0) AS orders_2019,
    ISNULL([2020], 0) AS orders_2020,
    ISNULL([2021], 0) AS orders_2021,
    ISNULL([2022], 0) AS orders_2022
FROM (
    SELECT
        s.store_name,
        YEAR(o.order_date) AS order_year,
        o.order_id
    FROM
        sales.orders AS o
        INNER JOIN sales.stores AS s
            ON o.store_id = s.store_id
    WHERE
        o.order_status = 4
) AS src
PIVOT (
    COUNT(order_id)
    FOR order_year IN ([2019], [2020], [2021], [2022])
) AS p
ORDER BY
    store_name;
```

### How it works

The source query creates one row per order with `store_name`, `order_year`, and `order_id`. `PIVOT` groups by `store_name`, then spreads year values into separate columns and applies `COUNT(order_id)`.

### Common mistakes

- Forgetting to include all needed year values in `IN (...)`
- Pivoting raw rows without the right grouping fields
- Expecting dynamic columns without dynamic SQL
- Skipping `ISNULL` and getting `NULL` instead of `0`

### Quick recap

- `PIVOT` rotates rows to columns for report-style output
- You need source, aggregate, pivot key, and explicit output columns
- `ISNULL` helps produce cleaner numeric reports

### Next

Complete [Exercises](#exercises), then move to [Chapter 07: Views](Chapter 07 - Views.md).


---

## Exercises


Complete these after working through the topics above. Run all queries in **BikeStores**.

---

#### Exercise 1 - Non-recursive CTE warm-up

Create a CTE that returns all orders with `order_status = 4`, then select `order_id`, `customer_id`, and `order_date` sorted by `order_date`.

**Tables:** `sales.orders`

---

#### Exercise 2 - CTE with aggregate

Use a CTE to calculate total revenue per order from `sales.order_items` (`quantity * list_price * (1 - discount)`), then return top 10 orders by revenue.

**Tables:** `sales.order_items`

---

#### Exercise 3 - Recursive hierarchy

Write a recursive CTE that starts from top-level staff (`manager_id IS NULL`) and returns `staff_id`, `manager_id`, and `level_num`.

**Tables:** `sales.staffs`

---

#### Exercise 4 - CTE vs subquery

Return products with `list_price` above the average `list_price` of their category. Solve once using a subquery and once using a CTE.

**Tables:** `production.products`

---

#### Exercise 5 - Pivot order counts

Create a pivot report by `store_id` with columns `[2019]`, `[2020]`, `[2021]`, `[2022]` counting orders by year.

**Tables:** `sales.orders`

---

#### Exercise 6 - Pivot with revenue ★

Build a pivot that shows revenue by store for years 2019-2022. Use `sales.orders` + `sales.order_items` and `SUM(...)`.

**Tables:** `sales.orders`, `sales.order_items`


---

## Solutions


## Chapter 06 - Solutions

---

#### Exercise 1 - Solution

```sql
USE BikeStores;

WITH shipped AS (
    SELECT
        order_id,
        customer_id,
        order_date
    FROM
        sales.orders
    WHERE
        order_status = 4
)
SELECT
    order_id,
    customer_id,
    order_date
FROM
    shipped
ORDER BY
    order_date;
```

---

#### Exercise 2 - Solution

```sql
USE BikeStores;

WITH order_revenue AS (
    SELECT
        order_id,
        SUM(quantity * list_price * (1 - discount)) AS revenue
    FROM
        sales.order_items
    GROUP BY
        order_id
)
SELECT TOP 10
    order_id,
    revenue
FROM
    order_revenue
ORDER BY
    revenue DESC;
```

---

#### Exercise 3 - Solution

```sql
USE BikeStores;

WITH staff_hierarchy AS (
    SELECT
        staff_id,
        manager_id,
        0 AS level_num
    FROM
        sales.staffs
    WHERE
        manager_id IS NULL

    UNION ALL

    SELECT
        c.staff_id,
        c.manager_id,
        p.level_num + 1
    FROM
        sales.staffs AS c
        INNER JOIN staff_hierarchy AS p
            ON c.manager_id = p.staff_id
)
SELECT
    staff_id,
    manager_id,
    level_num
FROM
    staff_hierarchy
ORDER BY
    level_num,
    staff_id;
```

---

#### Exercise 4 - Solution

```sql
USE BikeStores;

-- Subquery version
SELECT
    p.product_name,
    p.list_price
FROM
    production.products AS p
WHERE
    p.list_price > (
        SELECT
            AVG(p2.list_price)
        FROM
            production.products AS p2
        WHERE
            p2.category_id = p.category_id
    );

-- CTE version
WITH cat_avg AS (
    SELECT
        category_id,
        AVG(list_price) AS avg_price
    FROM
        production.products
    GROUP BY
        category_id
)
SELECT
    p.product_name,
    p.list_price
FROM
    production.products AS p
    INNER JOIN cat_avg AS c
        ON p.category_id = c.category_id
WHERE
    p.list_price > c.avg_price;
```

---

#### Exercise 5 - Solution

```sql
USE BikeStores;

SELECT
    store_id,
    ISNULL([2019], 0) AS orders_2019,
    ISNULL([2020], 0) AS orders_2020,
    ISNULL([2021], 0) AS orders_2021,
    ISNULL([2022], 0) AS orders_2022
FROM (
    SELECT
        store_id,
        YEAR(order_date) AS order_year,
        order_id
    FROM
        sales.orders
) AS src
PIVOT (
    COUNT(order_id)
    FOR order_year IN ([2019], [2020], [2021], [2022])
) AS p
ORDER BY
    store_id;
```

---

#### Exercise 6 - Solution

```sql
USE BikeStores;

SELECT
    store_id,
    ISNULL([2019], 0) AS revenue_2019,
    ISNULL([2020], 0) AS revenue_2020,
    ISNULL([2021], 0) AS revenue_2021,
    ISNULL([2022], 0) AS revenue_2022
FROM (
    SELECT
        o.store_id,
        YEAR(o.order_date) AS order_year,
        oi.quantity * oi.list_price * (1 - oi.discount) AS line_revenue
    FROM
        sales.orders AS o
        INNER JOIN sales.order_items AS oi
            ON o.order_id = oi.order_id
) AS src
PIVOT (
    SUM(line_revenue)
    FOR order_year IN ([2019], [2020], [2021], [2022])
) AS p
ORDER BY
    store_id;
```

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 07 - Views.md](Chapter 07 - Views.md)
