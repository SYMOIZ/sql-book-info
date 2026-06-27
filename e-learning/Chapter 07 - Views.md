# Chapter 07 - Views


Views let you save query logic as reusable virtual tables. They simplify reporting queries, hide complexity, and help control which columns users can see.

## Prerequisites

- [Chapter 06: CTEs and PIVOT](Chapter 06 - CTEs and Pivot.md) completed
- **BikeStores** database loaded
- Permission to create and manage views in your practice environment

## Learning goals

After this chapter, you will be able to:

- **Explain** what a view is and when to use one
- **Create** views for reusable business queries
- **Inspect** and modify existing views
- **Drop** views safely when no longer needed
- **Describe** indexed views and when they can help performance


## Time estimate

- **Reading:** about 50-65 minutes
- **Practice:** about 30-40 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `sales.orders`, `sales.customers`, `sales.order_items`, `production.products` |
| Tool | SSMS query window with `USE BikeStores;` |

## Troubleshooting

| Problem | What to try |
|---------|-------------|
| `CREATE VIEW must be the first statement` | Run `CREATE VIEW` in its own batch |
| `Invalid object name` from a view | Verify all base tables and schema names |
| `Cannot ALTER VIEW` | Confirm permissions and correct schema |
| Indexed view errors | Check required `WITH SCHEMABINDING` rules and deterministic expressions |


---

## What Is a View?

### Why this matters

Teams often repeat the same long query in reports and dashboards. A view stores that query so everyone can reuse one trusted definition.

### Concept

A view is a named SQL query treated like a virtual table.

- It stores the query definition, not copied data (except indexed views)
- You query it with `SELECT` just like a table
- It can simplify security by exposing only selected columns

### Syntax

```sql
CREATE VIEW schema_name.view_name AS
SELECT ...
FROM ...;
```

Use it:

```sql
SELECT ...
FROM schema_name.view_name;
```

### Walkthrough

```sql
USE BikeStores;

CREATE VIEW sales.v_order_summary AS
SELECT
    o.order_id,
    o.order_date,
    c.first_name + ' ' + c.last_name AS customer_name,
    s.store_name
FROM
    sales.orders AS o
    INNER JOIN sales.customers AS c
        ON o.customer_id = c.customer_id
    INNER JOIN sales.stores AS s
        ON o.store_id = s.store_id;
```

Query it:

```sql
SELECT TOP 10
    order_id,
    order_date,
    customer_name,
    store_name
FROM
    sales.v_order_summary
ORDER BY
    order_date DESC;
```

### How it works

SQL Server expands the view definition into the final query plan. In regular views, data still comes from base tables at runtime.

### Common mistakes

- Treating views as permanent snapshots of data
- Using `SELECT *` in view definitions
- Creating too many layered views and making debugging harder
- Forgetting schema prefix when querying (`sales.v_order_summary`)

### Quick recap

- A view is a reusable named query
- It improves consistency and readability
- Most views do not store data physically

### Next

[Create a view](#create-a-view)


---

## Create a View

### Why this matters

Creating views helps standardize query logic and avoid copy-paste SQL in every report.

### Concept

Good view design practices:

- Name views clearly (`v_` prefix is common)
- Select only required columns
- Keep logic business-focused and reusable
- Avoid `ORDER BY` unless paired with `TOP` for a specific reason

### Syntax

```sql
CREATE VIEW schema.view_name AS
SELECT col1, col2, ...
FROM schema.table
WHERE ...;
```

### Walkthrough

Create a revenue-oriented view at order-line level:

```sql
USE BikeStores;

CREATE VIEW sales.v_order_line_revenue AS
SELECT
    o.order_id,
    o.order_date,
    o.store_id,
    oi.item_id,
    oi.product_id,
    oi.quantity,
    oi.list_price,
    oi.discount,
    oi.quantity * oi.list_price * (1 - oi.discount) AS line_revenue
FROM
    sales.orders AS o
    INNER JOIN sales.order_items AS oi
        ON o.order_id = oi.order_id;
```

Use the view:

```sql
SELECT TOP 10
    order_id,
    product_id,
    line_revenue
FROM
    sales.v_order_line_revenue
ORDER BY
    line_revenue DESC;
```

### How it works

The view encapsulates the revenue formula so every consumer uses the same calculation. If formula logic changes later, you update one definition.

### Common mistakes

- Creating a view in the wrong schema
- Returning extra columns "just in case"
- Depending on implicit data type conversions
- Forgetting to document what the view is for

### Quick recap

- Create views for repeatable business logic
- Keep definitions focused and explicit
- Query views like normal tables

### Next

[Manage views](#manage-views)


---

## Manage Views

### Why this matters

Views evolve as requirements change. You need safe ways to inspect definitions and apply updates without breaking downstream queries.

### Concept

Key management tasks:

- Inspect view SQL
- Alter view definition
- Rename carefully (usually avoid rename; create new view name instead)
- Track dependencies

### Syntax

```sql
-- Show definition
EXEC sp_helptext 'schema.view_name';

-- Update definition
ALTER VIEW schema.view_name AS
SELECT ...;
```

### Walkthrough

Inspect and extend an existing view:

```sql
USE BikeStores;

EXEC sp_helptext 'sales.v_order_summary';
```

Now alter it to include `order_status`:

```sql
ALTER VIEW sales.v_order_summary AS
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    c.first_name + ' ' + c.last_name AS customer_name,
    s.store_name
FROM
    sales.orders AS o
    INNER JOIN sales.customers AS c
        ON o.customer_id = c.customer_id
    INNER JOIN sales.stores AS s
        ON o.store_id = s.store_id;
```

Validate:

```sql
SELECT TOP 10
    order_id,
    order_status,
    customer_name
FROM
    sales.v_order_summary;
```

### How it works

`ALTER VIEW` replaces the stored query definition. Existing queries against the view continue to work as long as required columns still exist with compatible meaning.

### Common mistakes

- Dropping and recreating views unnecessarily (can break permissions/dependencies)
- Removing columns used by reports
- Not testing dependent objects after alteration
- Altering in production without rollout planning

### Quick recap

- Use `sp_helptext` to inspect view SQL
- Prefer `ALTER VIEW` for safe updates
- Check dependencies before structural changes

### Next

[Drop view safely](#drop-view-safely)


---

## Drop View Safely

### Why this matters

Dropping a view that other queries depend on can break reporting instantly. Safe deprecation is as important as creation.

### Concept

Use a cautious sequence:

1. Check dependencies
2. Communicate or migrate consumers
3. Drop only when safe
4. Use `IF EXISTS` in scripts

### Syntax

```sql
DROP VIEW IF EXISTS schema.view_name;
```

### Walkthrough

Check if a view exists:

```sql
USE BikeStores;

SELECT
    OBJECT_ID('sales.v_order_summary', 'V') AS view_object_id;
```

Drop safely:

```sql
DROP VIEW IF EXISTS sales.v_order_summary;
```

Recreate if needed:

```sql
CREATE VIEW sales.v_order_summary AS
SELECT
    o.order_id,
    o.order_date,
    c.first_name + ' ' + c.last_name AS customer_name
FROM
    sales.orders AS o
    INNER JOIN sales.customers AS c
        ON o.customer_id = c.customer_id;
```

### How it works

`DROP VIEW IF EXISTS` prevents script failure if the view is already missing. This is useful in repeatable deployment scripts.

### Common mistakes

- Dropping before checking who uses the view
- Assuming `DROP VIEW` removes base table data (it does not)
- Forgetting to regrant permissions after recreate
- Running destructive scripts in the wrong database

### Quick recap

- Always evaluate dependencies first
- Use `DROP VIEW IF EXISTS` for safer scripts
- Dropping a view does not affect underlying table rows

### Next

[Indexed views intro](#indexed-views-intro)


---

## Indexed Views Intro

### Why this matters

Some heavy aggregate queries run repeatedly with similar logic. Indexed views can materialize results to speed specific workloads.

### Concept

An indexed view is a view with a unique clustered index. Unlike normal views, it stores data physically.

Important requirements include:

- `WITH SCHEMABINDING` in view definition
- Deterministic expressions only
- Fully qualified table names
- First index must be unique clustered

### Syntax

```sql
CREATE VIEW schema.view_name
WITH SCHEMABINDING
AS
SELECT ...
FROM schema.table;
GO

CREATE UNIQUE CLUSTERED INDEX ix_name
ON schema.view_name (key_column);
```

### Walkthrough

Intro example pattern (for learning only):

```sql
USE BikeStores;
GO

CREATE VIEW sales.v_store_order_counts
WITH SCHEMABINDING
AS
SELECT
    o.store_id,
    COUNT_BIG(*) AS order_count
FROM
    sales.orders AS o
GROUP BY
    o.store_id;
GO

CREATE UNIQUE CLUSTERED INDEX IX_v_store_order_counts
ON sales.v_store_order_counts (store_id);
GO
```

### How it works

SQL Server persists the view result in storage and maintains it when base tables change. Reads can become faster, but writes can become more expensive due to maintenance overhead.

### Common mistakes

- Forgetting `COUNT_BIG` for aggregate indexed views
- Using non-deterministic functions
- Expecting indexed views to help every query automatically
- Creating too many indexed views and slowing writes

### Quick recap

- Indexed views are physical and can accelerate specific reads
- They add maintenance cost on DML
- Use them only after measuring workload benefits

### Next

Complete [Exercises](#exercises), then continue to [Chapter 08: Modifying Data](Chapter 08 - Modifying Data.md).


---

## Exercises


Complete these after working through the topics above. Run in **BikeStores**.

---

#### Exercise 1 - Create a customer order view

Create `sales.v_customer_orders` with columns: `order_id`, `order_date`, `customer_name`, `store_id`.

**Tables:** `sales.orders`, `sales.customers`

---

#### Exercise 2 - Query a view

Select top 15 rows from `sales.v_customer_orders`, sorted by `order_date` descending.

---

#### Exercise 3 - Alter a view

Alter `sales.v_customer_orders` to include `order_status`.

---

#### Exercise 4 - Inspect definition

Use a system procedure to display the SQL definition of `sales.v_customer_orders`.

---

#### Exercise 5 - Drop and recreate

Drop `sales.v_customer_orders` safely, then recreate it.

---

#### Exercise 6 - Indexed view thought exercise ★

Create a view that groups orders by `store_id` and returns `COUNT_BIG(*)`, then define a unique clustered index on it.


---

## Solutions


## Chapter 07 - Solutions

---

#### Exercise 1 - Solution

```sql
USE BikeStores;

CREATE VIEW sales.v_customer_orders AS
SELECT
    o.order_id,
    o.order_date,
    c.first_name + ' ' + c.last_name AS customer_name,
    o.store_id
FROM
    sales.orders AS o
    INNER JOIN sales.customers AS c
        ON o.customer_id = c.customer_id;
```

---

#### Exercise 2 - Solution

```sql
USE BikeStores;

SELECT TOP 15
    order_id,
    order_date,
    customer_name,
    store_id
FROM
    sales.v_customer_orders
ORDER BY
    order_date DESC;
```

---

#### Exercise 3 - Solution

```sql
USE BikeStores;

ALTER VIEW sales.v_customer_orders AS
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    c.first_name + ' ' + c.last_name AS customer_name,
    o.store_id
FROM
    sales.orders AS o
    INNER JOIN sales.customers AS c
        ON o.customer_id = c.customer_id;
```

---

#### Exercise 4 - Solution

```sql
USE BikeStores;

EXEC sp_helptext 'sales.v_customer_orders';
```

---

#### Exercise 5 - Solution

```sql
USE BikeStores;

DROP VIEW IF EXISTS sales.v_customer_orders;

CREATE VIEW sales.v_customer_orders AS
SELECT
    o.order_id,
    o.order_date,
    c.first_name + ' ' + c.last_name AS customer_name,
    o.store_id
FROM
    sales.orders AS o
    INNER JOIN sales.customers AS c
        ON o.customer_id = c.customer_id;
```

---

#### Exercise 6 - Solution

```sql
USE BikeStores;
GO

CREATE VIEW sales.v_store_order_counts_x
WITH SCHEMABINDING
AS
SELECT
    o.store_id,
    COUNT_BIG(*) AS order_count
FROM
    sales.orders AS o
GROUP BY
    o.store_id;
GO

CREATE UNIQUE CLUSTERED INDEX IX_v_store_order_counts_x
ON sales.v_store_order_counts_x (store_id);
GO
```

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 08 - Modifying Data.md](Chapter 08 - Modifying Data.md)
