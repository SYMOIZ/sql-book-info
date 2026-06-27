# Chapter 02 - Querying and Filtering


Learn to read data from BikeStores tables: pick columns, filter rows, sort results, remove duplicates, limit row counts, and use clear column names.

## Prerequisites

- [Chapter 01: Environment Setup](Chapter 01 - Environment Setup.md) completed
- **BikeStores** database loaded ([`02-load-data.sql`](assets/database/02-load-data.sql))
- SSMS connected to your local SQL Server instance

## Learning goals

After this chapter, you will be able to:

- **Write** a `SELECT` statement that returns specific columns or all columns from a table
- **Filter** rows with `WHERE`, comparison operators, `AND`, `OR`, `IN`, `BETWEEN`, and `LIKE`
- **Sort** results using `ORDER BY` with ascending and descending order
- **Return** unique values with `SELECT DISTINCT`
- **Limit** rows using `TOP` and `OFFSET` / `FETCH`
- **Rename** columns and tables with aliases for readable output


## Time estimate

- **Reading:** about 60–75 minutes
- **Practice:** about 30–45 minutes (run queries in SSMS as you read)

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `sales.customers`, `production.products`, `production.categories` |
| Tool | SSMS query window with `USE BikeStores;` at the top of each session |

**Environment:** SQL Server 2022 Developer Edition, SSMS.

## Troubleshooting

| Problem | What to try |
|---------|-------------|
| `Invalid object name 'customers'` | Include the schema: `sales.customers` |
| Query returns zero rows | Check spelling in `WHERE` values (states are two letters, e.g. `'NY'`) |
| `TOP` without `ORDER BY` gives random-looking rows | Always add `ORDER BY` when you care which rows are returned |
| `OFFSET` error | `OFFSET` / `FETCH` require `ORDER BY` in the same query |


---

## The SELECT Statement

### Why this matters

Every report, screen, and export in a database-backed app starts with a question: “What data do I need?” The `SELECT` statement is how you ask that question in SQL. It is the first skill you will use in almost every chapter that follows.

### Concept

#### Tables, rows, and columns

Data in BikeStores lives in **tables**. Each table is a grid:

- A **row** is one record (one customer, one product).
- A **column** is one field (first name, list price).

Tables belong to a **schema**. Always write the full name as `schema.table` — for example, `sales.customers`.

#### What SELECT does

A `SELECT` query **reads** data. It does not change the table. You list the columns you want, name the table, and SQL Server returns a **result set** — a small grid of answers.

#### Clause order (first look)

SQL is not read top-to-bottom like English. For a simple query, SQL Server processes clauses in this order:

1. `FROM` — which table
2. `SELECT` — which columns

You write `SELECT` first, but the server finds the table before it picks columns. You will add `WHERE` and `ORDER BY` in later lessons.

### Syntax

```sql
SELECT column_1, column_2
FROM schema_name.table_name;
```

To return every column (quick exploration only):

```sql
SELECT *
FROM schema_name.table_name;
```

### Walkthrough

Open a new query in SSMS, run `USE BikeStores;`, then try the examples below.

**Example 1 — two columns from customers**

```sql
USE BikeStores;

SELECT
    first_name,
    last_name
FROM
    sales.customers;
```

#### Expected result

Ten rows (with the bundled sample data) — one per customer — with two columns: `first_name` and `last_name`.

**Example 2 — add email**

```sql
SELECT
    first_name,
    last_name,
    email
FROM
    sales.customers;
```

**Example 3 — all columns with `*`**

```sql
SELECT *
FROM sales.customers;
```

Returns every column in `sales.customers`. Useful when you are exploring a table for the first time.

**Example 4 — products**

```sql
SELECT
    product_name,
    list_price
FROM
    production.products;
```

Fifteen rows — one per product in the sample data.

### How it works

SSMS sends your text to SQL Server. The engine locates `sales.customers`, reads the requested columns for each row, and sends the result grid back to you. Nothing is deleted or updated.

### Another example — preview of filtering

You will learn `WHERE` in the next lesson. For now, notice how it narrows the result:

```sql
SELECT
    first_name,
    last_name,
    city,
    state
FROM
    sales.customers
WHERE
    state = 'NY';
```

#### Expected result

Two rows — customers in New York (`Debra Burks` and `Daryl Spence` with the bundled data).

### Common mistakes

- **Forgetting the schema** — `FROM customers` fails. Use `FROM sales.customers`.
- **Using `SELECT *` in every query** — fine for practice; in real apps, name only the columns you need.
- **Missing commas** — Column lists need commas between names: `first_name, last_name` not `first_name last_name`.
- **Semicolon** — Optional on SQL Server for one statement, but ending with `;` is a good habit.

> **Tip:** Start each practice session with `USE BikeStores;` so you are querying the right database.

### Quick recap

- `SELECT` lists columns; `FROM` names the table.
- Use `schema.table` (e.g. `sales.customers`).
- `SELECT *` returns all columns — handy for exploration.
- The result of a query is a **result set** (rows and columns).

### Next

[Filtering with WHERE](#filtering-with-where)


---

## Filtering with WHERE

### Why this matters

Tables can hold thousands or millions of rows. Applications rarely need all of them at once. The `WHERE` clause keeps only the rows that match your conditions — customers in one state, products above a price, orders from a given year.

### Concept

#### Predicates

A condition in `WHERE` is called a **predicate**. Each row is tested: if the predicate is **true**, the row stays in the result; if **false**, it is dropped.

#### Combining conditions

| Operator | Meaning |
|----------|---------|
| `AND` | Both conditions must be true |
| `OR` | At least one condition must be true |
| `()` | Group conditions to control order (like math parentheses) |

`AND` is evaluated before `OR` unless you use parentheses. When in doubt, add `()` to make your intent obvious.

#### Comparison operators

| Operator | Meaning |
|----------|---------|
| `=` | Equal to |
| `<>` or `!=` | Not equal to |
| `>` | Greater than |
| `>=` | Greater than or equal |
| `<` | Less than |
| `<=` | Less than or equal |

Text values go in **single quotes**: `'NY'`, not `"NY"`.

#### IN, BETWEEN, LIKE

| Operator | Use when |
|----------|----------|
| `IN (...)` | Value matches any item in a list |
| `BETWEEN a AND b` | Value is in a range (inclusive) |
| `LIKE pattern` | Text matches a pattern (`%` = any characters, `_` = one character) |

### Syntax

```sql
SELECT column_list
FROM schema_name.table_name
WHERE condition;
```

Multiple conditions:

```sql
WHERE condition_1 AND condition_2
WHERE condition_1 OR condition_2
WHERE (condition_1 OR condition_2) AND condition_3
```

### Walkthrough

All examples use `production.products` unless noted.

**Example 1 — equality**

```sql
USE BikeStores;

SELECT
    product_name,
    list_price,
    category_id
FROM
    production.products
WHERE
    category_id = 1;
```

#### Expected result

Two products in category **1** (Children Bicycles): `Trek Kids Dual Sport` and `Electra Kids Loft`.

**Example 2 — AND with two conditions**

```sql
SELECT
    product_name,
    model_year,
    list_price
FROM
    production.products
WHERE
    category_id = 1
    AND model_year = 2021;
```

One row: `Trek Kids Dual Sport` (category 1, year 2021).

**Example 3 — comparison**

```sql
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > 1500
ORDER BY
    list_price DESC;
```

Products priced above **1500** — five rows with the bundled data.

**Example 4 — OR**

```sql
SELECT
    product_name,
    list_price,
    model_year
FROM
    production.products
WHERE
    list_price > 3000
    OR model_year = 2022;
```

Rows that are either very expensive **or** from model year 2022.

**Example 5 — BETWEEN**

```sql
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price BETWEEN 400 AND 550
ORDER BY
    list_price;
```

Prices from **400** through **550** inclusive — includes `Electra Townie 7D`, `Electra Cruiser 1`, `Haro Downtown`, and others in that range.

**Example 6 — IN**

```sql
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price IN (299.99, 399.99, 449.99);
```

Only rows whose price exactly matches one of the listed values.

**Example 7 — LIKE**

```sql
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_name LIKE '%Cruiser%'
ORDER BY
    list_price;
```

Names containing **Cruiser** — e.g. `Electra Cruiser 1`, `Pure Cycles Urban Commuter` does not match; `Electra Cruiser 1` does.

**Example 8 — customers by state**

```sql
SELECT
    first_name,
    last_name,
    city,
    state
FROM
    sales.customers
WHERE
    state = 'TX';
```

Three customers in Texas with the bundled data.

### How it works

SQL Server processes `FROM`, then `WHERE`, then `SELECT`. Every row is checked against your predicate before it appears in the result set.

### Common mistakes

- **Comparing numbers to strings** — `list_price = '500'` may behave unexpectedly. Omit quotes for numeric columns.
- **OR without parentheses** — `WHERE state = 'NY' OR state = 'TX' AND city = 'Albany'` is not the same as `WHERE (state = 'NY' OR state = 'TX') AND city = 'Albany'`.
- **LIKE without wildcards** — `LIKE 'Cruiser'` is the same as `= 'Cruiser'`. Use `%Cruiser%` to find the word anywhere in the name.
- **BETWEEN order** — `BETWEEN 550 AND 400` returns nothing. Put the smaller value first.

### Quick recap

- `WHERE` filters rows before they are returned.
- Use `AND`, `OR`, and `()` to build logic.
- `IN`, `BETWEEN`, and `LIKE` are common shortcuts for filters.
- String literals use single quotes.

### Next

[Sorting with ORDER BY](#sorting-with-order-by)


---

## Sorting with ORDER BY

### Why this matters

The database does not guarantee row order unless you ask for one. `ORDER BY` sorts your result set so you can show cheapest products first, customers alphabetically, or newest orders on top.

### Concept

#### Ascending and descending

| Keyword | Sort direction |
|---------|----------------|
| `ASC` | Low to high, A to Z (default if you omit direction) |
| `DESC` | High to low, Z to A |

#### Multiple sort columns

`ORDER BY col1, col2` sorts by `col1` first. When two rows tie on `col1`, SQL Server uses `col2` to break the tie.

#### NULL values

In SQL Server, `NULL` sorts as the **lowest** value in `ASC` order (appears first).

#### Processing order

For a query with `WHERE` and `ORDER BY`, the order is: `FROM` → `WHERE` → `SELECT` → `ORDER BY`. Sorting happens last.

### Syntax

```sql
SELECT column_list
FROM schema_name.table_name
WHERE optional_condition
ORDER BY column_1 [ASC | DESC], column_2 [ASC | DESC];
```

### Walkthrough

**Example 1 — one column, ascending**

```sql
USE BikeStores;

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name;
```

Customers sorted by first name A→Z.

**Example 2 — descending**

```sql
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC;
```

Most expensive product first: **Surly E-36** at 3499.99 with bundled data.

**Example 3 — two columns**

```sql
SELECT
    product_name,
    model_year,
    list_price
FROM
    production.products
ORDER BY
    model_year DESC,
    list_price DESC;
```

Newer model years first; within the same year, higher prices first.

**Example 4 — ORDER BY with WHERE**

```sql
SELECT
    first_name,
    last_name,
    city
FROM
    sales.customers
WHERE
    state = 'NY'
ORDER BY
    last_name,
    first_name;
```

Two New York customers, sorted by last name.

**Example 5 — sort by expression (length of name)**

```sql
SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    LEN(first_name) DESC;
```

Longer first names appear first. `LEN()` is a function that returns string length — you will see more functions in later chapters.

### How it works

After rows are filtered and columns chosen, SQL Server sorts the result in memory (or using indexes in advanced cases). `ORDER BY` never changes data in the table — only the order you see in the result.

### Common mistakes

- **Sorting by a column not in SELECT** — Allowed when the column exists in the table, but beginners should match `ORDER BY` to visible columns for clarity.
- **Forgetting DESC** — Default is ascending; prices will look “cheapest first” unless you add `DESC`.
- **Using ORDER BY in wrong place** — It must come after `WHERE`, not before.

> **Tip:** When listing “top” or “bottom” rows, pair `ORDER BY` with `TOP` or `OFFSET` / `FETCH` (next lesson).

### Quick recap

- `ORDER BY` controls display order; default is `ASC`.
- Use multiple columns for tie-breaking sorts.
- Combine with `WHERE` to sort a filtered subset.
- Sorting does not modify stored data.

### Next

[Unique values with DISTINCT](#unique-values-with-distinct)


---

## Unique Values with DISTINCT

### Why this matters

Sometimes you need a list of values that appear in a column — all states where you have customers, all model years you sell — without repeating duplicates. `DISTINCT` removes duplicate rows from the result set.

### Concept

#### What DISTINCT does

`SELECT DISTINCT column` returns each unique value **once**. If ten customers live in ten different cities, you get ten rows. If three customers share the same city, you get one row for that city.

#### Multiple columns

`DISTINCT col1, col2` removes duplicate **combinations**. Two rows are duplicates only if **both** columns match.

#### DISTINCT vs GROUP BY

Both can produce unique lists. `DISTINCT` is simpler when you only need unique values. `GROUP BY` (Chapter 04) adds aggregation like `COUNT(*)`. For “list unique cities,” `DISTINCT` is enough.

### Syntax

```sql
SELECT DISTINCT column_name
FROM schema_name.table_name;
```

Multiple columns:

```sql
SELECT DISTINCT column_1, column_2
FROM schema_name.table_name;
```

### Walkthrough

**Example 1 — unique states**

```sql
USE BikeStores;

SELECT DISTINCT
    state
FROM
    sales.customers
ORDER BY
    state;
```

#### Expected result

Ten customers in ten different states/ provinces in the bundled data — ten distinct `state` values (including `AB` for Alberta).

**Example 2 — unique cities (many duplicates possible)**

With only ten customers, each city is likely unique. In a larger database, duplicate city names are common:

```sql
SELECT DISTINCT
    city
FROM
    sales.customers
ORDER BY
    city;
```

**Example 3 — distinct city and state pairs**

```sql
SELECT DISTINCT
    city,
    state
FROM
    sales.customers
ORDER BY
    state,
    city;
```

Each combination of city **and** state appears once.

**Example 4 — distinct model years on products**

```sql
SELECT DISTINCT
    model_year
FROM
    production.products
ORDER BY
    model_year;
```

Shows which model years appear in the catalog: 2019, 2020, 2021, 2022 with bundled data.

**Example 5 — DISTINCT with WHERE**

```sql
SELECT DISTINCT
    state
FROM
    sales.customers
WHERE
    state IN ('NY', 'TX', 'CA');
```

Unique states, but only from that filtered list.

### How it works

SQL Server evaluates `DISTINCT` after it finds matching rows. It compares full rows in the select list and keeps one copy of each unique combination.

### Common mistakes

- **Expecting DISTINCT to fix bad data** — It hides duplicates in the result; it does not delete rows from the table.
- **Using DISTINCT when you need counts** — “How many customers per state?” needs `GROUP BY` and `COUNT`, not `DISTINCT` alone.
- **DISTINCT with `*`** — `SELECT DISTINCT *` compares entire rows; two customers with different ids are never duplicates.

### Quick recap

- `DISTINCT` returns unique values in the result set.
- Multi-column `DISTINCT` applies to combinations of values.
- Use `ORDER BY` to present distinct lists neatly.
- For counting groups, use `GROUP BY` (later chapter).

### Next

[Limiting rows — TOP and pagination](#limiting-rows-top-and-pagination)


---

## Limiting Rows — TOP and Pagination

### Why this matters

Search screens show “10 results per page.” Reports ask for “the 5 most expensive products.” Without limits, queries could return huge result sets. `TOP` and `OFFSET` / `FETCH` control how many rows you get back.

### Concept

#### SELECT TOP

`TOP n` returns the first **n** rows after sorting. Always use **`ORDER BY`** with `TOP` so “first” means something predictable.

| Form | Meaning |
|------|---------|
| `TOP 5` | First 5 rows |
| `TOP 10 PERCENT` | Roughly 10% of rows (rounded up) |
| `TOP 3 WITH TIES` | Include extra rows that tie on the last sort value |

#### OFFSET and FETCH

Available since SQL Server 2012. Used for **pagination** — skip some rows, then take the next batch.

- `OFFSET n ROWS` — skip **n** rows
- `FETCH NEXT m ROWS ONLY` — return **m** rows after the skip

`OFFSET` / `FETCH` **require** `ORDER BY`.

#### TOP vs OFFSET/FETCH

Both limit rows. `TOP` is shorter for “give me the first N.” `OFFSET` / `FETCH` is better for “page 2, page 3” style paging.

### Syntax

```sql
SELECT TOP (n)
    column_list
FROM schema_name.table_name
ORDER BY column_name DESC;
```

Pagination:

```sql
SELECT column_list
FROM schema_name.table_name
ORDER BY column_name
OFFSET skip_count ROWS
FETCH NEXT take_count ROWS ONLY;
```

### Walkthrough

**Example 1 — top 5 expensive products**

```sql
USE BikeStores;

SELECT TOP 5
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC;
```

#### Expected result

Five rows, highest price first. Top product: **Surly E-36** at 3499.99.

**Example 2 — TOP with PERCENT**

With 15 products, `TOP 20 PERCENT` rounds up to **3** rows:

```sql
SELECT TOP 20 PERCENT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC;
```

**Example 3 — TOP WITH TIES**

If two products share the same price at the cutoff, `WITH TIES` keeps both:

```sql
SELECT TOP 3 WITH TIES
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC;
```

**Example 4 — OFFSET only (skip first 5)**

```sql
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name
OFFSET 5 ROWS;
```

Skips the five cheapest products; returns the rest (10 rows with bundled data).

**Example 5 — page-style: skip 5, take 5**

```sql
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;
```

Second “page” of five products when sorted by price ascending.

**Example 6 — top 5 using OFFSET/FETCH**

```sql
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC,
    product_name
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY;
```

Same idea as `TOP 5` when `OFFSET` is zero.

### How it works

SQL Server sorts rows first (`ORDER BY`), then applies `TOP` or `OFFSET` / `FETCH` to the sorted list. The table on disk is unchanged.

### Common mistakes

- **TOP without ORDER BY** — You get arbitrary rows, not “best” or “newest.”
- **OFFSET without ORDER BY** — Syntax error on SQL Server.
- **Wrong page math** — Page 1: `OFFSET 0`; page 2 with page size 5: `OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY`.
- **TOP PERCENT on tiny tables** — Always rounds up; 1% of 15 rows is still 1 row.

### Quick recap

- Use `TOP n` with `ORDER BY` for simple “first N rows.”
- `OFFSET` skips rows; `FETCH NEXT` takes the next batch.
- `WITH TIES` includes rows equal to the last included value.
- Pagination needs both `ORDER BY` and `OFFSET` / `FETCH`.

### Next

[Column and table aliases](#column-and-table-aliases)


---

## Column and Table Aliases

### Why this matters

Raw column names like `category_name` are fine in the database but awkward on a report header. Expressions like `first_name + ' ' + last_name` need a readable label. **Aliases** give columns and tables short, friendly names in your result set.

### Concept

#### Column alias

A **column alias** is a temporary name for a column or expression in the result. It does not rename the column in the table.

#### Table alias

A **table alias** is a short name for a table in a query. You will use table aliases heavily when joining tables in [Chapter 03](Chapter 03 - Joins.md).

#### AS keyword

`AS` is optional in SQL Server:

```sql
column_name AS alias_name
column_name alias_name
```

If the alias has spaces, use quotes: `AS 'Full Name'`.

### Syntax

Column alias:

```sql
SELECT
    column_name AS alias_name,
    expression AS alias_name
FROM
    schema_name.table_name;
```

Table alias:

```sql
SELECT
  t.column_name
FROM
  schema_name.table_name AS t;
```

### Walkthrough

**Example 1 — expression without alias**

```sql
USE BikeStores;

SELECT
    first_name + ' ' + last_name
FROM
    sales.customers;
```

The result column heading shows **(No column name)** — not helpful.

**Example 2 — column alias with AS**

```sql
SELECT
    first_name + ' ' + last_name AS full_name
FROM
    sales.customers
ORDER BY
    first_name;
```

Heading is **full_name**.

**Example 3 — alias with spaces**

```sql
SELECT
    first_name + ' ' + last_name AS 'Full Name'
FROM
    sales.customers;
```

**Example 4 — rename a single column**

```sql
SELECT
    category_name AS 'Product Category'
FROM
    production.categories;
```

Clearer heading for reports.

**Example 5 — ORDER BY alias**

Because `ORDER BY` runs after `SELECT`, you can sort by an alias:

```sql
SELECT
    category_name AS 'Product Category'
FROM
    production.categories
ORDER BY
    'Product Category';
```

**Example 6 — table alias (join preview)**

This query joins customers and orders — a full lesson in Chapter 03. Notice how aliases shorten the text:

```sql
SELECT
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date
FROM
    sales.customers AS c
    INNER JOIN sales.orders AS o
        ON o.customer_id = c.customer_id
ORDER BY
    o.order_date;
```

`c` stands for `sales.customers`; `o` stands for `sales.orders`.

#### Expected result

Eight rows — one per order in the bundled data — with customer names and order dates.

### How it works

Aliases exist only for the duration of the query. The database still stores `first_name` and `last_name`; the alias `full_name` appears only in your result grid.

### Common mistakes

- **Mixing alias and full table name** — After `FROM sales.customers c`, prefer `c.first_name` consistently in that query.
- **Using alias in WHERE** — In standard SQL, `WHERE` runs before `SELECT`, so you usually **cannot** use a column alias in `WHERE` (you can in `ORDER BY`).
- **Forgetting quotes on spaced aliases** — `AS Full Name` causes a syntax error; use `AS 'Full Name'`.

> **Tip:** Modern SQL Server also supports `CONCAT(first_name, ' ', last_name)` instead of `+` for strings. Both work; `+` treats `NULL` differently — you will learn more in later chapters.

### Quick recap

- Column aliases rename output headers; table aliases shorten table references.
- `AS` is optional but improves readability.
- Use table aliases before joins in Chapter 03.
- Quote aliases that contain spaces.

### Next

Complete the [Exercises](#exercises), then continue to [Chapter 03: Joins](Chapter 03 - Joins.md).


---

## Exercises


Complete these after working through the topics above. Run all queries against the **BikeStores** database in SSMS.

---

#### Exercise 1 — Customer emails (warm-up)

List each customer's first name, last name, and email. Sort by last name, then first name.

**Tables:** `sales.customers`

---

#### Exercise 2 — Texas customers (warm-up)

Show first name, last name, and city for customers in Texas (`state = 'TX'`).

**Tables:** `sales.customers`

---

#### Exercise 3 — Mid-range products (apply)

List `product_name` and `list_price` for products priced between **500** and **800** (inclusive). Sort by price from low to high.

**Tables:** `production.products`  
**Hint:** Use `BETWEEN`.

---

#### Exercise 4 — Trek products (apply)

Find products whose name contains **Trek** (anywhere in the name). Return `product_name` and `list_price`.

**Tables:** `production.products`  
**Hint:** Use `LIKE` with `%` wildcards.

---

#### Exercise 5 — Top three prices (apply)

Return the **three** most expensive products (name and price only).

**Tables:** `production.products`  
**Hint:** Use `TOP` with `ORDER BY list_price DESC`.

---

#### Exercise 6 — Distinct model years (apply)

List each **distinct** `model_year` in the products table, sorted ascending.

**Tables:** `production.products`

---

#### Exercise 7 — Full name alias ★ (stretch)

Return one column called `customer_name` that combines first and last name with a space between. Sort by `customer_name`.

**Tables:** `sales.customers`  
**Hint:** Use a column alias and string concatenation with `+`.

---

#### Exercise 8 — Second page of products ★ (stretch)

Products sorted by `list_price` ascending, then `product_name`: skip the first **5** rows and return the **next 5** only.

**Tables:** `production.products`  
**Hint:** Use `OFFSET` and `FETCH NEXT` with `ORDER BY`.


---

## Solutions


---

#### Exercise 1 — Solution

```sql
USE BikeStores;

SELECT
    first_name,
    last_name,
    email
FROM
    sales.customers
ORDER BY
    last_name,
    first_name;
```

Returns 10 rows with customer contact information, sorted alphabetically by name.

---

#### Exercise 2 — Solution

```sql
USE BikeStores;

SELECT
    first_name,
    last_name,
    city
FROM
    sales.customers
WHERE
    state = 'TX';
```

Returns 3 rows: customers in Amarillo, Beaumont, and related Texas cities in the sample data.

---

#### Exercise 3 — Solution

```sql
USE BikeStores;

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price BETWEEN 500 AND 800
ORDER BY
    list_price;
```

Returns products such as `Electra Townie 7D` (549.99) and `Haro Shift R3` (759.99) within the price range.

---

#### Exercise 4 — Solution

```sql
USE BikeStores;

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_name LIKE '%Trek%';
```

Returns 4 rows — all products with **Trek** in the name with bundled data.

---

#### Exercise 5 — Solution

```sql
USE BikeStores;

SELECT TOP 3
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC;
```

Top three: **Surly E-36** (3499.99), **Trek Fuel EX 8** (2899.99), **Trek Domane SL 5** (2199.99).

---

#### Exercise 6 — Solution

```sql
USE BikeStores;

SELECT DISTINCT
    model_year
FROM
    production.products
ORDER BY
    model_year;
```

Returns four values: **2019**, **2020**, **2021**, **2022**.

---

#### Exercise 7 — Solution

```sql
USE BikeStores;

SELECT
    first_name + ' ' + last_name AS customer_name
FROM
    sales.customers
ORDER BY
    customer_name;
```

Returns 10 rows with a single `customer_name` column.

---

#### Exercise 8 — Solution

```sql
USE BikeStores;

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;
```

Returns the second batch of five products when sorted by price ascending — the 6th through 10th cheapest in the catalog.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 03 - Joins.md](Chapter 03 - Joins.md)
