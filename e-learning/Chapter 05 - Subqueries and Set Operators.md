# Chapter 05 - Subqueries and Set Operators


Learn how to nest queries, test existence conditions, and combine multiple result sets in clean, reusable SQL patterns.

## Prerequisites

- [Chapter 04: Grouping and Aggregation](Chapter 04 - Grouping and Aggregation.md) completed
- **BikeStores** database loaded ([`02-load-data.sql`](assets/database/02-load-data.sql))
- Comfortable with joins and aggregate summaries

## Learning goals

After this chapter, you will be able to:

- **Differentiate** scalar, multi-row, and table subqueries
- **Write** correlated subqueries that depend on the outer row
- **Use** `EXISTS`, `ANY`, and `ALL` for set-based filters
- **Apply** `CROSS APPLY` and `OUTER APPLY` for row-by-row derived sets
- **Combine** results with `UNION`, `UNION ALL`, `INTERSECT`, and `EXCEPT`
- **Choose** between joins and subqueries based on readability and intent


## Time estimate

- **Reading:** about 90-105 minutes
- **Practice:** about 50-65 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `production.products`, `production.brands`, `sales.customers`, `sales.orders`, `sales.order_items`, `sales.staffs`, `sales.stores` |
| Tool | SSMS query window with `USE BikeStores;` |

**Bundled sample sizes:** 10 customers, 15 products, 8 orders, 3 stores, 5 staff.

## Troubleshooting

| Problem | What to try |
|---------|-------------|
| `Subquery returned more than 1 value` | Use `IN`, `EXISTS`, `ANY`, or rewrite to ensure scalar output |
| Poor performance on correlated query | Test join or `EXISTS` alternatives |
| Different row counts between `UNION` and `UNION ALL` | `UNION` removes duplicates; `UNION ALL` keeps them |
| `INTERSECT` or `EXCEPT` type mismatch | Align column count, order, and compatible data types |


---

## Subquery types

### Why this matters

Subqueries let you build queries in layers. Instead of hard-coding values, you can derive them from the data itself, which makes SQL dynamic and easier to maintain.

### Concept

A subquery is a query nested inside another query. Common types:

| Type | Returns | Typical use |
|------|---------|-------------|
| Scalar subquery | One value | Compare against a single threshold |
| Multi-row subquery | Many values in one column | `IN`, `ANY`, `ALL` conditions |
| Table subquery (derived table) | Result set | Use in `FROM` as temporary table |

### Syntax

Scalar pattern:

```sql
SELECT
    column_list
FROM
    table_name
WHERE
    column_name > (SELECT aggregate_value FROM other_table);
```

Derived table pattern:

```sql
SELECT
    d.column_name
FROM
    (SELECT ... FROM ... ) AS d;
```

### Walkthrough

**Example 1 — scalar subquery (products above average price)**

```sql
USE BikeStores;

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > (
        SELECT AVG(list_price)
        FROM production.products
    )
ORDER BY
    list_price DESC;
```

#### Expected result

Rows for products priced above the overall average.

**Example 2 — multi-row subquery with IN**

```sql
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    customer_id IN (
        SELECT customer_id
        FROM sales.orders
    )
ORDER BY
    customer_id;
```

#### Expected result

Customers who have at least one order (subset of 10 customers).

**Example 3 — derived table in FROM**

```sql
SELECT
    x.brand_id,
    x.product_count
FROM
    (
        SELECT
            brand_id,
            COUNT(*) AS product_count
        FROM
            production.products
        GROUP BY
            brand_id
    ) AS x
ORDER BY
    x.product_count DESC,
    x.brand_id;
```

#### Expected result

One row per brand with product counts, produced from a subquery-as-table.

### How it works

SQL Server executes inner queries and feeds their output to the outer query. Depending on query shape, this can happen once (uncorrelated) or repeatedly (correlated, covered next).

### Common mistakes

- Using a scalar comparison when subquery returns multiple rows
- Forgetting alias names for derived tables in `FROM`
- Assuming subquery order affects outer query order without outer `ORDER BY`
- Overcomplicating a simple join scenario

### Quick recap

- Subqueries can return a value, list, or table.
- They help build dynamic, layered SQL.
- Match subquery type to outer operator (`=`, `IN`, `EXISTS`, etc.).

### Next

[Correlated subqueries](#correlated-subqueries)


---

## Correlated subqueries

### Why this matters

Sometimes each outer row needs its own subquery calculation. Correlated subqueries solve row-by-row logic such as "products above their own category average."

### Concept

A correlated subquery references a column from the outer query. Because of that reference:

- It cannot run independently
- It is evaluated for each outer row

This is powerful for comparisons relative to each row's context.

### Syntax

```sql
SELECT
    outer_columns
FROM
    outer_table AS o
WHERE
    o.value > (
        SELECT aggregate_expression
        FROM inner_table AS i
        WHERE i.group_key = o.group_key
    );
```

### Walkthrough

**Example 1 — products above category average**

```sql
USE BikeStores;

SELECT
    p.product_name,
    p.category_id,
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
    )
ORDER BY
    p.category_id,
    p.list_price DESC;
```

#### Expected result

Products priced above the average within their own category.

**Example 2 — customers with order count above 1**

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    sales.customers AS c
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            sales.orders AS o
        WHERE
            o.customer_id = c.customer_id
    ) > 1
ORDER BY
    c.customer_id;
```

#### Expected result

Customers who placed more than one order.

**Example 3 — latest order date per customer (scalar output)**

```sql
SELECT
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    (
        SELECT
            MAX(o.order_date)
        FROM
            sales.orders AS o
        WHERE
            o.customer_id = c.customer_id
    ) AS latest_order_date
FROM
    sales.customers AS c
ORDER BY
    c.customer_id;
```

#### Expected result

10 rows (one per customer). Customers without orders show `NULL` latest date.

### How it works

For each row in the outer query, SQL Server executes the correlated subquery using outer-row values. Optimizer rewrites may reduce repeated work, but logically the pattern is per-row evaluation.

### Common mistakes

- Forgetting correlation condition, causing incorrect global comparisons
- Returning multiple rows in a scalar correlated subquery
- Using correlated queries where a join and aggregate is simpler
- Missing indexes on correlation keys in larger datasets

### Quick recap

- Correlated subqueries depend on outer query columns.
- They are great for row-relative logic.
- Keep correlation predicates explicit and correct.

### Next

[EXISTS, ANY, and ALL](#exists-any-and-all)


---

## EXISTS, ANY, and ALL

### Why this matters

You often need set-based tests: "Does this customer have any orders?", "Is this product more expensive than any in category X?", or "Higher than all products in a brand?" `EXISTS`, `ANY`, and `ALL` express these questions clearly.

### Concept

- `EXISTS` is true if subquery returns at least one row
- `ANY` compares to at least one value from subquery
- `ALL` compares to every value from subquery

`EXISTS` is usually preferred for existence checks.

### Syntax

```sql
WHERE EXISTS (
    SELECT 1
    FROM table_name
    WHERE correlation_condition
)
```

```sql
WHERE value > ANY (SELECT column_name FROM table_name)
WHERE value > ALL (SELECT column_name FROM table_name)
```

### Walkthrough

**Example 1 — customers with at least one order (`EXISTS`)**

```sql
USE BikeStores;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    sales.customers AS c
WHERE
    EXISTS (
        SELECT 1
        FROM sales.orders AS o
        WHERE o.customer_id = c.customer_id
    )
ORDER BY
    c.customer_id;
```

#### Expected result

Customers who appear in orders (fewer than or equal to 10 rows).

**Example 2 — customers with no orders (`NOT EXISTS`)**

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    sales.customers AS c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM sales.orders AS o
        WHERE o.customer_id = c.customer_id
    )
ORDER BY
    c.customer_id;
```

#### Expected result

Customers without matching order rows.

**Example 3 — `ANY` and `ALL` price comparison**

```sql
SELECT
    p.product_name,
    p.list_price
FROM
    production.products AS p
WHERE
    p.list_price > ALL (
        SELECT
            p2.list_price
        FROM
            production.products AS p2
        WHERE
            p2.category_id = 1
    )
ORDER BY
    p.list_price DESC;
```

#### Expected result

Products priced higher than every product in category 1.

### How it works

`EXISTS` stops as soon as one matching row is found. `ANY` and `ALL` evaluate comparison logic over the value set returned by the subquery.

### Common mistakes

- Using `IN` where `EXISTS` is clearer for correlated checks
- Forgetting that `ALL` is strict and often returns fewer rows than expected
- Not considering `NULL` behavior in subquery values
- Writing expensive subqueries without selective predicates

### Quick recap

- `EXISTS`/`NOT EXISTS` handle presence and absence checks.
- `ANY` means "at least one"; `ALL` means "every value."
- Pick the operator that matches your business rule exactly.

### Next

[APPLY](#apply)


---

## APPLY

### Why this matters

`APPLY` is useful when the right-side query depends on each row from the left side. It is especially good for "top N per group" patterns and row-by-row derived result sets.

### Concept

Two types:

| Operator | Behavior |
|----------|----------|
| `CROSS APPLY` | Returns only left rows that produce right-side rows |
| `OUTER APPLY` | Returns all left rows; missing right-side rows become `NULL` |

Think of `APPLY` as a join to a subquery/table expression that can reference left-table columns.

### Syntax

```sql
SELECT
    column_list
FROM
    left_table AS l
CROSS APPLY
    (
        SELECT ...
        FROM right_table AS r
        WHERE r.key = l.key
    ) AS x;
```

Use `OUTER APPLY` to keep unmatched left rows.

### Walkthrough

**Example 1 — top priced product per brand (`CROSS APPLY`)**

```sql
USE BikeStores;

SELECT
    b.brand_name,
    x.product_name,
    x.list_price
FROM
    production.brands AS b
CROSS APPLY
    (
        SELECT TOP 1
            p.product_name,
            p.list_price
        FROM
            production.products AS p
        WHERE
            p.brand_id = b.brand_id
        ORDER BY
            p.list_price DESC
    ) AS x
ORDER BY
    b.brand_name;
```

#### Expected result

One row per brand that has products, showing the highest-priced product.

**Example 2 — top order per customer (`OUTER APPLY`)**

```sql
SELECT
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    x.order_id,
    x.order_date
FROM
    sales.customers AS c
OUTER APPLY
    (
        SELECT TOP 1
            o.order_id,
            o.order_date
        FROM
            sales.orders AS o
        WHERE
            o.customer_id = c.customer_id
        ORDER BY
            o.order_date DESC
    ) AS x
ORDER BY
    c.customer_id;
```

#### Expected result

10 rows (all customers). Customers with no orders show `NULL` in order columns.

**Example 3 — recent order amount per customer (`OUTER APPLY`)**

```sql
SELECT
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    x.order_id,
    x.order_total
FROM
    sales.customers AS c
OUTER APPLY
    (
        SELECT TOP 1
            o.order_id,
            SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS order_total
        FROM
            sales.orders AS o
        INNER JOIN
            sales.order_items AS oi
            ON oi.order_id = o.order_id
        WHERE
            o.customer_id = c.customer_id
        GROUP BY
            o.order_id,
            o.order_date
        ORDER BY
            o.order_date DESC
    ) AS x
ORDER BY
    c.customer_id;
```

#### Expected result

10 rows with latest order totals where available.

### How it works

For each left row, SQL Server evaluates the right expression. `CROSS APPLY` behaves like an inner join for produced rows; `OUTER APPLY` behaves like a left join.

### Common mistakes

- Using `CROSS APPLY` when left rows must be preserved
- Omitting `ORDER BY` inside `TOP 1` subqueries
- Forgetting that right-side expressions run per left row
- Confusing `APPLY` with static derived tables

### Quick recap

- `APPLY` supports row-dependent right-side queries.
- `CROSS APPLY` keeps matching left rows only.
- `OUTER APPLY` keeps all left rows.

### Next

[Set operators](#set-operators)


---

## Set operators

### Why this matters

Sometimes results come from separate queries that need to be combined or compared. Set operators let you merge and compare result sets without complicated joins.

### Concept

Main set operators:

| Operator | Behavior |
|----------|----------|
| `UNION` | Combines results and removes duplicates |
| `UNION ALL` | Combines results and keeps duplicates |
| `INTERSECT` | Returns rows present in both queries |
| `EXCEPT` | Returns rows from first query not in second |

Both queries must return:

- Same number of columns
- Compatible data types
- Comparable column order

### Syntax

```sql
query_1
UNION
query_2;
```

```sql
query_1
INTERSECT
query_2;
```

### Walkthrough

**Example 1 — union customer and staff names**

```sql
USE BikeStores;

SELECT
    first_name + ' ' + last_name AS person_name
FROM
    sales.customers
UNION
SELECT
    first_name + ' ' + last_name AS person_name
FROM
    sales.staffs
ORDER BY
    person_name;
```

#### Expected result

Unique names from both tables. Row count depends on overlap.

**Example 2 — union all model years from products and orders**

```sql
SELECT
    CAST(model_year AS INT) AS year_value
FROM
    production.products
UNION ALL
SELECT
    YEAR(order_date) AS year_value
FROM
    sales.orders
ORDER BY
    year_value;
```

#### Expected result

Combined list with duplicates preserved (`UNION ALL`).

**Example 3 — customers with orders vs all customers**

```sql
SELECT
    customer_id
FROM
    sales.customers
EXCEPT
SELECT
    customer_id
FROM
    sales.orders
ORDER BY
    customer_id;
```

#### Expected result

Customer IDs that exist in `sales.customers` but not in `sales.orders`.

### How it works

Each query runs independently, then SQL Server applies set logic to combine or compare outputs. `UNION`/`INTERSECT`/`EXCEPT` perform duplicate-handling and comparison work; `UNION ALL` simply appends.

### Common mistakes

- Mismatched column positions between queries
- Expecting `UNION ALL` to remove duplicates
- Sorting each subquery instead of sorting final combined result
- Ignoring data type conversions between query branches

### Quick recap

- Set operators combine or compare full query outputs.
- `UNION ALL` is faster when duplicate removal is not needed.
- Keep query column structures aligned.

### Next

[Join vs subquery](#join-vs-subquery)


---

## Join vs subquery

### Why this matters

Many SQL problems can be solved with either joins or subqueries. Choosing the right approach improves readability, correctness, and maintainability.

### Concept

General guidance:

- Use **joins** to combine columns across related tables
- Use **subqueries** for filtering or calculations that read naturally as "based on this set/value"
- Use **`EXISTS`** for existence checks
- Prefer clear intent over clever syntax

Both approaches can produce the same result, so readability matters.

### Syntax

Join-style pattern:

```sql
SELECT
    a.column_a,
    b.column_b
FROM
    table_a AS a
INNER JOIN
    table_b AS b
    ON a.key = b.key;
```

Subquery-style pattern:

```sql
SELECT
    column_list
FROM
    table_a
WHERE
    key IN (SELECT key FROM table_b);
```

### Walkthrough

**Example 1 — customers with orders (join approach)**

```sql
USE BikeStores;

SELECT DISTINCT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    sales.customers AS c
INNER JOIN
    sales.orders AS o
    ON o.customer_id = c.customer_id
ORDER BY
    c.customer_id;
```

#### Expected result

Only customers who placed orders.

**Example 2 — customers with orders (subquery approach)**

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    sales.customers AS c
WHERE
    c.customer_id IN (
        SELECT
            o.customer_id
        FROM
            sales.orders AS o
    )
ORDER BY
    c.customer_id;
```

#### Expected result

Same customer set as Example 1.

**Example 3 — customers with no orders (`NOT EXISTS`)**

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    sales.customers AS c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM sales.orders AS o
        WHERE o.customer_id = c.customer_id
    )
ORDER BY
    c.customer_id;
```

#### Expected result

Customers without orders (complement set of prior examples).

### How it works

Joins combine row sets first and then allow filtering. Subqueries can resolve a filter set/value first and then apply it. SQL Server optimizer may transform both to similar execution plans.

### Common mistakes

- Using joins when only existence is needed, then forgetting `DISTINCT`
- Using `NOT IN` with nullable subquery output and getting unexpected results
- Picking complex correlated subqueries when a simple join is clearer
- Assuming one style is always faster

### Quick recap

- Joins and subqueries are complementary tools.
- Pick the style that expresses intent most clearly.
- For existence logic, `EXISTS`/`NOT EXISTS` is often best.

### Next

Continue to [Exercises](#exercises), then move on to [Chapter 06: CTEs and Pivot](Chapter 06 - CTEs and Pivot.md).


---

## Exercises


Complete these after working through the topics above. Run all queries against **BikeStores**.

---

#### Exercise 1 — Above-average products (warm-up)

List products with `list_price` above the overall average price.

**Tables:** `production.products`

---

#### Exercise 2 — Customers with orders (warm-up)

Return customers who have placed at least one order using a subquery.

**Tables:** `sales.customers`, `sales.orders`  
**Hint:** `IN` or `EXISTS`.

---

#### Exercise 3 — Category-above-average products (apply)

Return products priced above the average price of their own category.

**Tables:** `production.products`  
**Hint:** Correlated subquery.

---

#### Exercise 4 — Customers without orders (apply)

Find all customers who have never placed an order.

**Tables:** `sales.customers`, `sales.orders`  
**Hint:** `NOT EXISTS`.

---

#### Exercise 5 — Top product per brand (apply)

For each brand, return the single highest-priced product.

**Tables:** `production.brands`, `production.products`  
**Hint:** `CROSS APPLY` with `TOP 1`.

---

#### Exercise 6 — Customer/staff name list with UNION (apply)

Return one combined name list from customers and staff with duplicate names removed.

**Tables:** `sales.customers`, `sales.staffs`

---

#### Exercise 7 — IDs in both sets with INTERSECT ★ (stretch)

Find IDs that appear in both `sales.customers.customer_id` and `sales.orders.customer_id`.

**Tables:** `sales.customers`, `sales.orders`

---

#### Exercise 8 — Join vs subquery comparison ★ (stretch)

Write two queries that return customers with orders:
1) one using `INNER JOIN`, and 2) one using `EXISTS`.

Confirm both return the same customer IDs.

**Tables:** `sales.customers`, `sales.orders`


---

## Solutions


---

#### Exercise 1 — Solution

```sql
USE BikeStores;

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > (
        SELECT AVG(list_price)
        FROM production.products
    )
ORDER BY
    list_price DESC;
```

Returns products priced above overall average.

---

#### Exercise 2 — Solution

```sql
USE BikeStores;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    sales.customers AS c
WHERE
    EXISTS (
        SELECT 1
        FROM sales.orders AS o
        WHERE o.customer_id = c.customer_id
    )
ORDER BY
    c.customer_id;
```

Returns customers who have at least one order.

---

#### Exercise 3 — Solution

```sql
USE BikeStores;

SELECT
    p.product_name,
    p.category_id,
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
    )
ORDER BY
    p.category_id,
    p.list_price DESC;
```

Returns products priced above their category average.

---

#### Exercise 4 — Solution

```sql
USE BikeStores;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    sales.customers AS c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM sales.orders AS o
        WHERE o.customer_id = c.customer_id
    )
ORDER BY
    c.customer_id;
```

Returns customers with no matching orders.

---

#### Exercise 5 — Solution

```sql
USE BikeStores;

SELECT
    b.brand_name,
    x.product_name,
    x.list_price
FROM
    production.brands AS b
CROSS APPLY
    (
        SELECT TOP 1
            p.product_name,
            p.list_price
        FROM
            production.products AS p
        WHERE
            p.brand_id = b.brand_id
        ORDER BY
            p.list_price DESC
    ) AS x
ORDER BY
    b.brand_name;
```

Returns one highest-priced product row per brand.

---

#### Exercise 6 — Solution

```sql
USE BikeStores;

SELECT
    first_name + ' ' + last_name AS person_name
FROM
    sales.customers
UNION
SELECT
    first_name + ' ' + last_name AS person_name
FROM
    sales.staffs
ORDER BY
    person_name;
```

Returns a unique combined list of names from both tables.

---

#### Exercise 7 — Solution

```sql
USE BikeStores;

SELECT
    customer_id
FROM
    sales.customers
INTERSECT
SELECT
    customer_id
FROM
    sales.orders
ORDER BY
    customer_id;
```

Returns customer IDs present in both sets (customers who ordered).

---

#### Exercise 8 — Solution

```sql
USE BikeStores;

-- Version 1: INNER JOIN
SELECT DISTINCT
    c.customer_id
FROM
    sales.customers AS c
INNER JOIN
    sales.orders AS o
    ON o.customer_id = c.customer_id
ORDER BY
    c.customer_id;

-- Version 2: EXISTS
SELECT
    c.customer_id
FROM
    sales.customers AS c
WHERE
    EXISTS (
        SELECT 1
        FROM sales.orders AS o
        WHERE o.customer_id = c.customer_id
    )
ORDER BY
    c.customer_id;
```

Both queries return the same set of customer IDs in the bundled sample.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 06 - CTEs and Pivot.md](Chapter 06 - CTEs and Pivot.md)
