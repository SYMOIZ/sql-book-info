# Chapter 03 - Joins


Learn how to combine data across BikeStores tables so your queries answer real business questions, not just single-table lookups.

## Prerequisites

- [Chapter 02: SELECT and Filter](Chapter 02 - Querying and Filtering.md) completed
- **BikeStores** database loaded ([`02-load-data.sql`](assets/database/02-load-data.sql))
- Comfortable with `SELECT`, `WHERE`, and `ORDER BY`

## Learning goals

After this chapter, you will be able to:

- **Explain** why joins are needed in relational databases
- **Write** `INNER JOIN` queries to return matching rows from two or more tables
- **Use** `LEFT JOIN`, `RIGHT JOIN`, and `FULL JOIN` for unmatched-row scenarios
- **Build** `CROSS JOIN` queries for all combinations
- **Create** self-joins to model relationships in one table (for example, staff and manager)


## Time estimate

- **Reading:** about 70-85 minutes
- **Practice:** about 40-50 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `production.products`, `production.brands`, `production.categories`, `sales.orders`, `sales.customers`, `sales.stores`, `sales.staffs` |
| Tool | SSMS query window with `USE BikeStores;` |

**Bundled sample sizes:** 10 customers, 15 products, 8 orders, 3 stores, 5 staff.

## Troubleshooting

| Problem | What to try |
|---------|-------------|
| `Ambiguous column name` | Prefix repeated columns with table aliases (for example, `o.order_id`) |
| No rows returned in an `INNER JOIN` | Check your join keys and schemas; confirm IDs actually match |
| Too many rows returned | Verify your `ON` condition and avoid accidental cross joins |
| Unmatched rows missing | Use `LEFT JOIN` or `FULL JOIN` instead of `INNER JOIN` |


---

## Why joins matter

### Why this matters

In a relational database, data is split into related tables to reduce duplication and keep data clean. To answer useful questions, you often need columns from more than one table. Joins are how you bring those pieces together.

### Concept

BikeStores stores related information in separate tables:

- `production.products` has product details
- `production.brands` has brand names
- `production.categories` has category names
- `sales.orders` has order headers
- `sales.customers` has customer details

Tables connect through keys:

- `production.products.brand_id` -> `production.brands.brand_id`
- `production.products.category_id` -> `production.categories.category_id`
- `sales.orders.customer_id` -> `sales.customers.customer_id`

Without joins, you only see IDs. With joins, you see meaningful names.

### Syntax

```sql
SELECT
    t1.column_name,
    t2.column_name
FROM
    schema1.table1 AS t1
JOIN
    schema2.table2 AS t2
    ON t1.key_column = t2.key_column;
```

Use aliases (`t1`, `t2`) to make queries easier to read.

### Walkthrough

**Example 1 — products with brand names**

```sql
USE BikeStores;

SELECT
    p.product_name,
    p.list_price,
    b.brand_name
FROM
    production.products AS p
JOIN
    production.brands AS b
    ON p.brand_id = b.brand_id
ORDER BY
    p.product_name;
```

#### Expected result

15 rows (one for each product), now with readable brand names instead of only `brand_id`.

**Example 2 — products with category names**

```sql
SELECT
    p.product_name,
    c.category_name
FROM
    production.products AS p
JOIN
    production.categories AS c
    ON p.category_id = c.category_id
ORDER BY
    c.category_name,
    p.product_name;
```

#### Expected result

15 rows grouped by category name, easier for reporting than numeric category IDs.

**Example 3 — orders with customer names**

```sql
SELECT
    o.order_id,
    o.order_date,
    c.first_name + ' ' + c.last_name AS customer_name
FROM
    sales.orders AS o
JOIN
    sales.customers AS c
    ON o.customer_id = c.customer_id
ORDER BY
    o.order_id;
```

#### Expected result

8 rows (one per order), with customer names attached.

### How it works

SQL Server evaluates the `ON` condition for rows from both tables and keeps pairs that match. When keys are correct, each row from the main table is enriched with related columns from the lookup table.

### Common mistakes

- Joining on the wrong columns (for example, `product_id = brand_id`)
- Skipping table aliases and creating hard-to-read queries
- Selecting only ID columns and forgetting to include descriptive columns
- Assuming every relationship is one-to-one

### Quick recap

- Relational data is intentionally split across tables.
- Joins combine those tables using matching keys.
- Joins turn IDs into meaningful business output.

### Next

[Inner join](#inner-join)


---

## Inner join

### Why this matters

`INNER JOIN` is the most common join type. It returns only rows that match in both tables, which is exactly what you need for most transactional and reporting queries.

### Concept

An `INNER JOIN` keeps **intersection rows**:

- If a row has a match, it appears
- If a row has no match, it is excluded

For BikeStores, this is ideal when you only want valid linked records, such as orders that belong to real customers, or products that belong to a known brand.

### Syntax

```sql
SELECT
    column_list
FROM
    table_a AS a
INNER JOIN
    table_b AS b
    ON a.key = b.key;
```

You can chain more than two tables:

```sql
FROM
    table_a AS a
INNER JOIN
    table_b AS b ON a.key = b.key
INNER JOIN
    table_c AS c ON b.other_key = c.other_key
```

### Walkthrough

**Example 1 — products with brands**

```sql
USE BikeStores;

SELECT
    p.product_name,
    b.brand_name,
    p.list_price
FROM
    production.products AS p
INNER JOIN
    production.brands AS b
    ON p.brand_id = b.brand_id
ORDER BY
    b.brand_name,
    p.product_name;
```

#### Expected result

15 rows. Each product is paired with its brand.

**Example 2 — products with categories**

```sql
SELECT
    p.product_name,
    c.category_name,
    p.model_year
FROM
    production.products AS p
INNER JOIN
    production.categories AS c
    ON p.category_id = c.category_id
ORDER BY
    c.category_name,
    p.product_name;
```

#### Expected result

15 rows with category names, useful for catalog browsing.

**Example 3 — three-table join: orders, customers, stores**

```sql
SELECT
    o.order_id,
    o.order_date,
    c.first_name + ' ' + c.last_name AS customer_name,
    s.store_name
FROM
    sales.orders AS o
INNER JOIN
    sales.customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN
    sales.stores AS s
    ON o.store_id = s.store_id
ORDER BY
    o.order_id;
```

#### Expected result

8 rows (all bundled orders) with customer and store names in one result.

### How it works

SQL Server compares rows using each `ON` condition. Only rows that satisfy every inner join condition remain. In multi-table joins, each additional join narrows or enriches the result.

### Common mistakes

- Using `WHERE` for join keys instead of `ON`, making queries harder to understand
- Forgetting one join condition in multi-table queries
- Assuming row count will always stay the same after joins
- Not qualifying columns like `customer_id`, which exist in multiple tables

### Quick recap

- `INNER JOIN` returns only matching rows.
- It is the default choice for most clean relational queries.
- You can combine multiple tables by chaining joins.

### Next

[Outer joins](#outer-joins)


---

## Outer joins

### Why this matters

Real data is not always perfectly matched. Outer joins let you keep unmatched rows, which is important for audits, data quality checks, and "show me missing records" reports.

### Concept

Outer joins include matched rows plus unmatched rows from one or both sides:

| Join type | Keeps unmatched rows from |
|-----------|---------------------------|
| `LEFT JOIN` | Left table |
| `RIGHT JOIN` | Right table |
| `FULL JOIN` | Both tables |

Unmatched columns are returned as `NULL`.

### Syntax

```sql
SELECT
    column_list
FROM
    table_a AS a
LEFT JOIN
    table_b AS b
    ON a.key = b.key;
```

```sql
SELECT
    column_list
FROM
    table_a AS a
FULL JOIN
    table_b AS b
    ON a.key = b.key;
```

### Walkthrough

**Example 1 — all customers and any orders (`LEFT JOIN`)**

```sql
USE BikeStores;

SELECT
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    o.order_id
FROM
    sales.customers AS c
LEFT JOIN
    sales.orders AS o
    ON c.customer_id = o.customer_id
ORDER BY
    c.customer_id,
    o.order_id;
```

#### Expected result

10+ rows (one or more per customer). Customers with no orders still appear, with `NULL` in `order_id`.

**Example 2 — find customers without orders**

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    sales.customers AS c
LEFT JOIN
    sales.orders AS o
    ON c.customer_id = o.customer_id
WHERE
    o.order_id IS NULL
ORDER BY
    c.customer_id;
```

#### Expected result

Rows for customers who have never placed an order in the bundled sample.

**Example 3 — full comparison**

```sql
SELECT
    c.customer_id,
    o.order_id
FROM
    sales.customers AS c
FULL JOIN
    sales.orders AS o
    ON c.customer_id = o.customer_id
ORDER BY
    c.customer_id,
    o.order_id;
```

#### Expected result

All matched customer-order rows plus unmatched rows on either side (if any). Useful for reconciliation.

### How it works

Outer joins first create matches based on `ON`, then add missing side rows according to join type. Missing columns are padded with `NULL`, which you can test with `IS NULL`.

### Common mistakes

- Filtering unmatched rows in `WHERE` unintentionally (for example, `WHERE o.order_status = 1` after `LEFT JOIN`)
- Using `=` with `NULL` (`o.order_id = NULL` is always unknown)
- Choosing `RIGHT JOIN` when `LEFT JOIN` would be clearer by reversing table order
- Forgetting that outer joins can increase row counts when one-to-many relationships exist

### Quick recap

- Outer joins preserve unmatched rows.
- `LEFT JOIN` is the most common outer join in practice.
- `IS NULL` helps you find missing relationships.

### Next

[Cross join](#cross-join)


---

## Cross join

### Why this matters

Sometimes you need every possible combination between two sets, such as every store with every staff member, or every brand with every category. `CROSS JOIN` creates those combinations.

### Concept

`CROSS JOIN` returns the Cartesian product:

- Row count = rows in table A x rows in table B
- No `ON` condition is used

With bundled data:

- 3 stores x 5 staff = 15 combinations

### Syntax

```sql
SELECT
    column_list
FROM
    table_a
CROSS JOIN
    table_b;
```

You can still add `WHERE` afterward to filter combinations.

### Walkthrough

**Example 1 — all store and staff combinations**

```sql
USE BikeStores;

SELECT
    s.store_name,
    st.first_name + ' ' + st.last_name AS staff_name
FROM
    sales.stores AS s
CROSS JOIN
    sales.staffs AS st
ORDER BY
    s.store_name,
    staff_name;
```

#### Expected result

15 rows (3 x 5). Every store paired with every staff member.

**Example 2 — all brands and categories**

```sql
SELECT
    b.brand_name,
    c.category_name
FROM
    production.brands AS b
CROSS JOIN
    production.categories AS c
ORDER BY
    b.brand_name,
    c.category_name;
```

#### Expected result

Rows equal to number of brands times number of categories in your sample.

**Example 3 — cross join with filter**

```sql
SELECT
    s.store_name,
    st.first_name,
    st.last_name
FROM
    sales.stores AS s
CROSS JOIN
    sales.staffs AS st
WHERE
    s.store_id = 1
ORDER BY
    st.last_name,
    st.first_name;
```

#### Expected result

5 rows: all staff paired with store 1 after filtering.

### How it works

SQL Server pairs each row from the first table with every row from the second table. Because no matching condition exists, output grows quickly as input tables grow.

### Common mistakes

- Creating huge result sets by accident on large tables
- Forgetting that `CROSS JOIN` has no join condition
- Using comma-style joins in `FROM` instead of explicit `CROSS JOIN`
- Assuming duplicates are removed automatically

### Quick recap

- `CROSS JOIN` creates all combinations between two tables.
- It is useful for matrix-style scenarios.
- Always estimate row count before running on large tables.

### Next

[Self join](#self-join)


---

## Self join

### Why this matters

Some relationships exist inside one table. In BikeStores, each staff member can reference a manager in the same `sales.staffs` table through `manager_id`. A self join lets you query that hierarchy.

### Concept

A self join joins one table to itself using different aliases:

- One alias represents the child row (staff member)
- Another alias represents the parent row (manager)

For staff hierarchy:

- `s.manager_id` points to `m.staff_id`

### Syntax

```sql
SELECT
    child.column_name,
    parent.column_name
FROM
    table_name AS child
LEFT JOIN
    table_name AS parent
    ON child.parent_id = parent.id;
```

`LEFT JOIN` is common here so top-level rows (without manager) are still returned.

### Walkthrough

**Example 1 — list staff with manager**

```sql
USE BikeStores;

SELECT
    s.staff_id,
    s.first_name + ' ' + s.last_name AS staff_name,
    m.first_name + ' ' + m.last_name AS manager_name
FROM
    sales.staffs AS s
LEFT JOIN
    sales.staffs AS m
    ON s.manager_id = m.staff_id
ORDER BY
    s.staff_id;
```

#### Expected result

5 rows (one per staff member). Top-level managers show `NULL` manager names.

**Example 2 — only staff who have a manager**

```sql
SELECT
    s.staff_id,
    s.first_name + ' ' + s.last_name AS staff_name,
    m.first_name + ' ' + m.last_name AS manager_name
FROM
    sales.staffs AS s
INNER JOIN
    sales.staffs AS m
    ON s.manager_id = m.staff_id
ORDER BY
    s.staff_id;
```

#### Expected result

Rows only for staff assigned to a manager (no top-level manager rows).

**Example 3 — count direct reports per manager**

```sql
SELECT
    m.staff_id,
    m.first_name + ' ' + m.last_name AS manager_name,
    COUNT(s.staff_id) AS direct_report_count
FROM
    sales.staffs AS m
LEFT JOIN
    sales.staffs AS s
    ON s.manager_id = m.staff_id
GROUP BY
    m.staff_id,
    m.first_name,
    m.last_name
ORDER BY
    direct_report_count DESC,
    manager_name;
```

#### Expected result

One row per staff member, including managers with zero direct reports.

### How it works

A self join treats the same table as two logical tables via aliases. SQL Server performs matching exactly as with any other join; only the source table is the same physical object.

### Common mistakes

- Reusing one alias for both sides of the join
- Choosing `INNER JOIN` and unintentionally dropping top-level manager rows
- Joining on the wrong direction (`m.manager_id = s.staff_id`)
- Forgetting to include both first and last name in grouped manager labels

### Quick recap

- Self joins model parent-child relationships inside one table.
- Use clear aliases like `s` (staff) and `m` (manager).
- `LEFT JOIN` preserves top-level rows with no parent.

### Next

Continue to [Exercises](#exercises), then move on to [Chapter 04: Grouping and Aggregation](Chapter 04 - Grouping and Aggregation.md).


---

## Exercises


Complete these after working through the topics above. Run all queries against **BikeStores**.

---

#### Exercise 1 — Products with brand names (warm-up)

Return `product_name` and `brand_name` for all products.

**Tables:** `production.products`, `production.brands`

---

#### Exercise 2 — Products with category names (warm-up)

Return `product_name`, `category_name`, and `list_price`, sorted by category then product name.

**Tables:** `production.products`, `production.categories`

---

#### Exercise 3 — Orders with customer names (apply)

List `order_id`, `order_date`, and full customer name for every order.

**Tables:** `sales.orders`, `sales.customers`

---

#### Exercise 4 — Orders with customer and store (apply)

Return `order_id`, customer full name, and `store_name` using a three-table join.

**Tables:** `sales.orders`, `sales.customers`, `sales.stores`

---

#### Exercise 5 — Customers without orders (apply)

Find customers who have never placed an order.

**Tables:** `sales.customers`, `sales.orders`  
**Hint:** Use `LEFT JOIN` and `WHERE ... IS NULL`.

---

#### Exercise 6 — Staff and manager (apply)

Show each staff member with their manager name (if any).

**Tables:** `sales.staffs`  
**Hint:** Self join with two aliases.

---

#### Exercise 7 — Store and staff combinations ★ (stretch)

Return all combinations of stores and staff. Include `store_name` and `staff_name`.

**Tables:** `sales.stores`, `sales.staffs`  
**Hint:** `CROSS JOIN`.

---

#### Exercise 8 — Direct report counts ★ (stretch)

For each manager, show manager name and number of direct reports.

**Tables:** `sales.staffs`  
**Hint:** Self join + `GROUP BY`.


---

## Solutions


---

#### Exercise 1 — Solution

```sql
USE BikeStores;

SELECT
    p.product_name,
    b.brand_name
FROM
    production.products AS p
INNER JOIN
    production.brands AS b
    ON p.brand_id = b.brand_id
ORDER BY
    p.product_name;
```

Returns 15 rows with each product and its brand.

---

#### Exercise 2 — Solution

```sql
USE BikeStores;

SELECT
    p.product_name,
    c.category_name,
    p.list_price
FROM
    production.products AS p
INNER JOIN
    production.categories AS c
    ON p.category_id = c.category_id
ORDER BY
    c.category_name,
    p.product_name;
```

Returns all 15 products, grouped by category in the sort order.

---

#### Exercise 3 — Solution

```sql
USE BikeStores;

SELECT
    o.order_id,
    o.order_date,
    c.first_name + ' ' + c.last_name AS customer_name
FROM
    sales.orders AS o
INNER JOIN
    sales.customers AS c
    ON o.customer_id = c.customer_id
ORDER BY
    o.order_id;
```

Returns 8 rows, one per order, with customer names.

---

#### Exercise 4 — Solution

```sql
USE BikeStores;

SELECT
    o.order_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    s.store_name
FROM
    sales.orders AS o
INNER JOIN
    sales.customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN
    sales.stores AS s
    ON o.store_id = s.store_id
ORDER BY
    o.order_id;
```

Returns 8 rows with order, customer, and store details.

---

#### Exercise 5 — Solution

```sql
USE BikeStores;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    sales.customers AS c
LEFT JOIN
    sales.orders AS o
    ON c.customer_id = o.customer_id
WHERE
    o.order_id IS NULL
ORDER BY
    c.customer_id;
```

Returns customers with no matching order rows.

---

#### Exercise 6 — Solution

```sql
USE BikeStores;

SELECT
    s.staff_id,
    s.first_name + ' ' + s.last_name AS staff_name,
    m.first_name + ' ' + m.last_name AS manager_name
FROM
    sales.staffs AS s
LEFT JOIN
    sales.staffs AS m
    ON s.manager_id = m.staff_id
ORDER BY
    s.staff_id;
```

Returns 5 rows with manager names where available.

---

#### Exercise 7 — Solution

```sql
USE BikeStores;

SELECT
    st.store_name,
    sf.first_name + ' ' + sf.last_name AS staff_name
FROM
    sales.stores AS st
CROSS JOIN
    sales.staffs AS sf
ORDER BY
    st.store_name,
    staff_name;
```

Returns 15 rows (3 stores x 5 staff).

---

#### Exercise 8 — Solution

```sql
USE BikeStores;

SELECT
    m.staff_id,
    m.first_name + ' ' + m.last_name AS manager_name,
    COUNT(s.staff_id) AS direct_report_count
FROM
    sales.staffs AS m
LEFT JOIN
    sales.staffs AS s
    ON s.manager_id = m.staff_id
GROUP BY
    m.staff_id,
    m.first_name,
    m.last_name
ORDER BY
    direct_report_count DESC,
    manager_name;
```

Returns one row per staff member with the number of people reporting to them.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 04 - Grouping and Aggregation.md](Chapter 04 - Grouping and Aggregation.md)
