# Chapter 17 - Window Functions


Learn how window functions analyze related rows without collapsing detail, so you can rank, compare, and segment results in advanced reports.

## Prerequisites

- [Chapter 16: System Functions](Chapter 16 - System Functions.md) completed
- [Chapter 14: Aggregate Functions](Chapter 14 - Aggregate Functions.md) completed
- Run [`04-tutorial-extensions.sql`](assets/database/04-tutorial-extensions.sql) first to create:
  - `sales.vw_staff_sales`
  - `sales.vw_category_sales_volume`

## Learning goals

After this chapter, you will be able to:

- **Explain** `OVER`, partitions, and ordering for window calculations
- **Rank** rows with `ROW_NUMBER`, `RANK`, and `DENSE_RANK`
- **Compare** adjacent rows with `LAG` and `LEAD`
- **Read** frame-based values with `FIRST_VALUE` and `LAST_VALUE`
- **Interpret** `CUME_DIST`, `PERCENT_RANK`, and `NTILE`


## Time estimate

- **Reading:** about 90 minutes
- **Practice:** about 60 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main view | `sales.vw_staff_sales` |
| Supporting view | `sales.vw_category_sales_volume` |
| Script | `assets/database/04-tutorial-extensions.sql` |


---

## Window Function Concepts

### Why this matters

Standard aggregates collapse rows, but many analytics questions need row-level detail plus summary context. Window functions solve this by calculating across related rows while keeping each row visible.

### Concept

A window function uses `OVER(...)` with optional:

- `PARTITION BY` to define groups
- `ORDER BY` to define sequence

Unlike `GROUP BY`, window functions do not reduce row count.

### Syntax

```sql
SELECT
    col1,
    window_function(...) OVER (
        PARTITION BY group_col
        ORDER BY sort_col
    ) AS window_value
FROM table_or_view;
```

### Walkthrough

Create required views first (one-time setup):

```sql
USE BikeStores;
GO

-- Run this once before Chapter 17:
-- :r ..\assets\database\04-tutorial-extensions.sql
```

Now calculate yearly total net sales per staff while keeping each staff-year row:

```sql
SELECT
    staff_id,
    year,
    net_sales,
    SUM(net_sales) OVER (PARTITION BY year) AS total_year_sales
FROM sales.vw_staff_sales
ORDER BY year, staff_id;
```

#### Expected result

Each row keeps `staff_id`, `year`, and `net_sales`, plus `total_year_sales` repeated for that year.

### How it works

`PARTITION BY year` groups rows into yearly windows. `SUM` runs over each partition without collapsing rows.

### Common mistakes

- Confusing window functions with `GROUP BY`.
- Omitting `ORDER BY` where sequence-sensitive functions need it.
- Referencing views before running `04-tutorial-extensions.sql`.

### Quick recap

- Window functions return per-row analytics.
- `OVER` defines calculation window.
- Use setup script before chapter examples.

### Next

[Ranking functions](#ranking-functions)


---

## Ranking Functions

### Why this matters

Ranking helps identify top performers, ties, and leaderboards. SQL Server offers multiple ranking functions with slightly different tie behavior.

### Concept

- `ROW_NUMBER()` unique sequence (no ties)
- `RANK()` ties share rank and leave gaps
- `DENSE_RANK()` ties share rank with no gaps

### Syntax

```sql
SELECT
    ...,
    ROW_NUMBER() OVER (PARTITION BY group_col ORDER BY sort_col DESC) AS rn,
    RANK()       OVER (PARTITION BY group_col ORDER BY sort_col DESC) AS rnk,
    DENSE_RANK() OVER (PARTITION BY group_col ORDER BY sort_col DESC) AS drnk
FROM source;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    year,
    staff_id,
    net_sales,
    ROW_NUMBER() OVER (PARTITION BY year ORDER BY net_sales DESC) AS row_num,
    RANK() OVER (PARTITION BY year ORDER BY net_sales DESC) AS rank_num,
    DENSE_RANK() OVER (PARTITION BY year ORDER BY net_sales DESC) AS dense_rank_num
FROM sales.vw_staff_sales
ORDER BY year, net_sales DESC;
```

#### Expected result

Each staff member gets three ranking outputs within each year.

### How it works

Rows are partitioned by year, sorted by descending sales, then rank values are assigned according to each function's tie rule.

### Common mistakes

- Choosing `ROW_NUMBER` when tied ranks are required.
- Forgetting partition column and getting global rank only.
- Expecting stable ranking without deterministic `ORDER BY`.

### Quick recap

- Use `ROW_NUMBER` for unique sequence.
- Use `RANK` or `DENSE_RANK` when ties matter.
- Always define partition and ordering intentionally.

### Next

[LAG and LEAD](#lag-and-lead)


---

## LAG and LEAD

### Why this matters

Trend analysis requires comparing each row to previous or next row values. `LAG` and `LEAD` make this easy without self-joins.

### Concept

- `LAG(column, offset, default)` reads earlier row value
- `LEAD(column, offset, default)` reads later row value

They work within the order you define in `OVER`.

### Syntax

```sql
LAG(col, 1, 0)  OVER (PARTITION BY group_col ORDER BY sort_col)
LEAD(col, 1, 0) OVER (PARTITION BY group_col ORDER BY sort_col)
```

### Walkthrough

Compare category quantity year-over-year.

```sql
USE BikeStores;

SELECT
    category_name,
    year,
    total_quantity,
    LAG(total_quantity, 1, 0) OVER (
        PARTITION BY category_name
        ORDER BY year
    ) AS prev_year_qty,
    total_quantity
      - LAG(total_quantity, 1, 0) OVER (
            PARTITION BY category_name
            ORDER BY year
        ) AS yoy_change
FROM sales.vw_category_sales_volume
ORDER BY category_name, year;
```

#### Expected result

Each category-year row shows previous-year quantity and year-over-year difference.

### How it works

`LAG` reads the prior row in each category partition ordered by year. The default `0` is used when no prior row exists.

### Common mistakes

- Missing `ORDER BY` in window specification.
- Forgetting default value and getting null unexpectedly.
- Comparing across categories because partitioning was omitted.

### Quick recap

- `LAG` and `LEAD` compare neighboring rows.
- Partition by entity, order by time.
- Ideal for change and trend calculations.

### Next

[FIRST_VALUE and LAST_VALUE](#first_value-and-last_value)


---

## FIRST_VALUE and LAST_VALUE

### Why this matters

Analysts often ask for first or latest value in a period, such as baseline sales vs current sales. Window value functions provide this per partition.

### Concept

- `FIRST_VALUE` returns first ordered value in a window
- `LAST_VALUE` returns last ordered value in a window frame

For `LAST_VALUE`, frame definition matters.

### Syntax

```sql
FIRST_VALUE(col) OVER (PARTITION BY group_col ORDER BY sort_col)
LAST_VALUE(col)  OVER (
    PARTITION BY group_col
    ORDER BY sort_col
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    staff_id,
    year,
    net_sales,
    FIRST_VALUE(net_sales) OVER (
        PARTITION BY staff_id
        ORDER BY year
    ) AS first_year_sales,
    LAST_VALUE(net_sales) OVER (
        PARTITION BY staff_id
        ORDER BY year
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_year_sales
FROM sales.vw_staff_sales
ORDER BY staff_id, year;
```

#### Expected result

Each row includes first and last known yearly sales for that staff member.

### How it works

`FIRST_VALUE` uses ascending year order. `LAST_VALUE` needs full-frame clause; otherwise default frame may stop at current row.

### Common mistakes

- Forgetting frame clause for `LAST_VALUE`.
- Ordering in wrong direction for "first" or "last" business meaning.
- Mixing partitions and getting cross-staff values.

### Quick recap

- Use value functions for baseline and endpoint comparisons.
- `LAST_VALUE` often needs explicit full-frame window.
- Partition and ordering choices define meaning.

### Next

[CUME_DIST and PERCENT_RANK](#cume_dist-and-percent_rank)


---

## CUME_DIST and PERCENT_RANK

### Why this matters

Percentile-style metrics help compare performance relative to peers. They are useful for top-performer thresholds and tiering logic.

### Concept

- `CUME_DIST()` cumulative distribution from 0 to 1
- `PERCENT_RANK()` relative rank from 0 to 1

Both require ordering in `OVER`.

### Syntax

```sql
CUME_DIST()    OVER (PARTITION BY group_col ORDER BY metric_col)
PERCENT_RANK() OVER (PARTITION BY group_col ORDER BY metric_col)
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    year,
    staff_id,
    net_sales,
    CUME_DIST() OVER (PARTITION BY year ORDER BY net_sales) AS cume_dist_value,
    PERCENT_RANK() OVER (PARTITION BY year ORDER BY net_sales) AS percent_rank_value
FROM sales.vw_staff_sales
ORDER BY year, net_sales;
```

#### Expected result

Each staff-year row includes percentile-like position metrics within that year.

### How it works

Rows are ordered by sales in each year partition. SQL Server computes distribution and relative rank based on ordered position and ties.

### Another example

Top 20% performers (highest sales):

```sql
WITH ranked AS
(
    SELECT
        year,
        staff_id,
        net_sales,
        CUME_DIST() OVER (PARTITION BY year ORDER BY net_sales DESC) AS cume_desc
    FROM sales.vw_staff_sales
)
SELECT *
FROM ranked
WHERE cume_desc <= 0.20;
```

### Common mistakes

- Confusing ascending vs descending order semantics.
- Expecting `PERCENT_RANK` to return 1 for single-row partitions.
- Applying percentile filters without understanding tie behavior.

### Quick recap

- `CUME_DIST` and `PERCENT_RANK` measure relative standing.
- Order direction changes meaning.
- Useful for percentile-based segmentation.

### Next

[NTILE](#ntile)


---

## NTILE

### Why this matters

Analysts often split data into equal buckets such as quartiles or deciles. `NTILE` assigns rows to these groups directly.

### Concept

`NTILE(n)` divides ordered rows into `n` buckets.

- Bucket 1 typically holds highest values if ordered descending.
- Buckets are as balanced as possible in row count.

### Syntax

```sql
NTILE(number_of_buckets) OVER (
    PARTITION BY group_col
    ORDER BY metric_col DESC
)
```

### Walkthrough

Split each year's staff into quartiles by net sales.

```sql
USE BikeStores;

SELECT
    year,
    staff_id,
    net_sales,
    NTILE(4) OVER (
        PARTITION BY year
        ORDER BY net_sales DESC
    ) AS sales_quartile
FROM sales.vw_staff_sales
ORDER BY year, sales_quartile, net_sales DESC;
```

#### Expected result

Each row is assigned quartile 1 to 4 within each year.

### How it works

SQL Server orders rows in each partition and distributes them across four buckets as evenly as possible.

### Common mistakes

- Forgetting partitioning when bucket should reset per year/category.
- Interpreting quartile numbers without checking sort direction.
- Using too many buckets for very small partitions.

### Quick recap

- `NTILE` creates equal-sized ranking buckets.
- Sort direction determines bucket meaning.
- Useful for segmentation and score bands.

### Next

Complete [Exercises](#exercises). You have finished Part 1.


---

## Exercises


Complete these after working through the topics above. Run `04-tutorial-extensions.sql` first.

---

#### Exercise 1 - Year totals with window sum (warm-up)

Using `sales.vw_staff_sales`, return each row with `SUM(net_sales) OVER (PARTITION BY year)`.

---

#### Exercise 2 - Ranking by year (warm-up)

Return `ROW_NUMBER`, `RANK`, and `DENSE_RANK` per year ordered by `net_sales DESC`.

---

#### Exercise 3 - Previous year comparison (apply)

For each `staff_id`, calculate previous year's `net_sales` and year-over-year change.

---

#### Exercise 4 - First and last known sales (apply)

For each `staff_id`, return `FIRST_VALUE(net_sales)` and `LAST_VALUE(net_sales)` over year.

---

#### Exercise 5 - Top percentile filter (apply)

Use `CUME_DIST` to return top 30% staff rows per year by `net_sales`.

---

#### Exercise 6 - Quartile segmentation (stretch) ★

Use `NTILE(4)` to assign staff rows into yearly quartiles, then count rows per quartile.


---

## Solutions


## Chapter 17 - Solutions

---

#### Exercise 1 - Solution

```sql
USE BikeStores;

SELECT
    year,
    staff_id,
    net_sales,
    SUM(net_sales) OVER (PARTITION BY year) AS total_year_sales
FROM sales.vw_staff_sales;
```

Adds yearly total to each staff-year row.

---

#### Exercise 2 - Solution

```sql
SELECT
    year,
    staff_id,
    net_sales,
    ROW_NUMBER() OVER (PARTITION BY year ORDER BY net_sales DESC) AS row_num,
    RANK() OVER (PARTITION BY year ORDER BY net_sales DESC) AS rank_num,
    DENSE_RANK() OVER (PARTITION BY year ORDER BY net_sales DESC) AS dense_rank_num
FROM sales.vw_staff_sales;
```

Shows three ranking behaviors side by side.

---

#### Exercise 3 - Solution

```sql
SELECT
    staff_id,
    year,
    net_sales,
    LAG(net_sales, 1, 0) OVER (PARTITION BY staff_id ORDER BY year) AS prev_year_sales,
    net_sales - LAG(net_sales, 1, 0) OVER (PARTITION BY staff_id ORDER BY year) AS yoy_change
FROM sales.vw_staff_sales;
```

Compares each staff row to previous year.

---

#### Exercise 4 - Solution

```sql
SELECT
    staff_id,
    year,
    net_sales,
    FIRST_VALUE(net_sales) OVER (PARTITION BY staff_id ORDER BY year) AS first_sales,
    LAST_VALUE(net_sales) OVER (
        PARTITION BY staff_id
        ORDER BY year
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_sales
FROM sales.vw_staff_sales;
```

Returns baseline and latest values per staff.

---

#### Exercise 5 - Solution

```sql
WITH ranked AS
(
    SELECT
        year,
        staff_id,
        net_sales,
        CUME_DIST() OVER (PARTITION BY year ORDER BY net_sales DESC) AS cume_desc
    FROM sales.vw_staff_sales
)
SELECT *
FROM ranked
WHERE cume_desc <= 0.30
ORDER BY year, net_sales DESC;
```

Filters top 30% performers per year.

---

#### Exercise 6 - Solution

```sql
WITH bucketed AS
(
    SELECT
        year,
        staff_id,
        NTILE(4) OVER (PARTITION BY year ORDER BY net_sales DESC) AS quartile
    FROM sales.vw_staff_sales
)
SELECT
    year,
    quartile,
    COUNT(*) AS rows_in_quartile
FROM bucketed
GROUP BY year, quartile
ORDER BY year, quartile;
```

Segments rows into quartiles, then summarizes each bucket size.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** You have completed Part 1. Review earlier chapters and build a small reporting project on BikeStores.
