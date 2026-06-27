# Chapter 09 - Schema Design


Schema design defines how data is structured, validated, and maintained over time. In this chapter, you will create and evolve databases, tables, keys, constraints, and utility objects.

## Prerequisites

- [Chapter 08: Modifying Data](Chapter 08 - Modifying Data.md) completed
- **BikeStores** database available
- Permission to create/alter/drop objects in a practice database

## Learning goals

After this chapter, you will be able to:

- **Create** databases, schemas, and tables
- **Alter** and drop table structures safely
- **Use** identity columns and sequence objects
- **Choose** practical SQL Server data types
- **Apply** constraints for data integrity
- **Use** `CASE`, `COALESCE`, and `NULLIF` effectively
- **Work** with temp tables and synonyms
- **Detect and remove** duplicate records safely


## Time estimate

- **Reading:** about 80-100 minutes
- **Practice:** about 60-75 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` + optional `BikeStoresLab` |
| Main focus | DDL and design patterns |
| Tool | SSMS query window and object explorer |

## Troubleshooting

| Problem | What to try |
|---------|-------------|
| Permission denied on DDL | Use your local practice DB or admin-enabled instance |
| Cannot drop table | Remove dependent constraints/objects first |
| Data truncation | Re-check data type and column length |
| Duplicate delete removed wrong rows | Test row-number logic with `SELECT` before `DELETE` |


---

## CREATE DATABASE and Schema

### Why this matters

Good structure starts at the database and schema level. Schemas organize objects by domain and simplify permissions.

### Concept

- `CREATE DATABASE` creates a new database container
- `CREATE SCHEMA` creates logical namespaces inside a database
- Use schemas to separate modules like `sales`, `production`, `reporting`

### Syntax

```sql
CREATE DATABASE db_name;
GO
USE db_name;
GO
CREATE SCHEMA schema_name;
```

### Walkthrough

```sql
CREATE DATABASE BikeStoresLab;
GO

USE BikeStoresLab;
GO

CREATE SCHEMA reporting;
CREATE SCHEMA staging;
```

### How it works

SQL Server allocates database files for the new DB. Schemas then act as object containers with independent ownership and permission boundaries.

### Common mistakes

- Creating objects in `dbo` unintentionally
- Forgetting `USE database_name`
- Mixing production and lab objects
- Naming schemas inconsistently

### Quick recap

- Databases hold data and objects
- Schemas structure objects and permissions
- Use explicit `schema.object` naming from day one

### Next

[Create, alter, and drop table](#create-alter-and-drop-table)


---

## CREATE, ALTER, and DROP TABLE

### Why this matters

Table design changes over time. You need repeatable DDL patterns to create structures, evolve them safely, and remove unused objects.

### Concept

- `CREATE TABLE` defines columns and base constraints
- `ALTER TABLE` evolves structure
- `DROP TABLE` removes object and data

### Syntax

```sql
CREATE TABLE schema.table_name (...);
ALTER TABLE schema.table_name ADD column_name data_type;
DROP TABLE schema.table_name;
```

### Walkthrough

```sql
USE BikeStoresLab;

CREATE TABLE reporting.sales_snapshot (
    snapshot_id INT IDENTITY(1,1) PRIMARY KEY,
    snapshot_date DATE NOT NULL,
    total_orders INT NOT NULL
);

ALTER TABLE reporting.sales_snapshot
ADD total_revenue DECIMAL(12,2) NULL;

ALTER TABLE reporting.sales_snapshot
ALTER COLUMN total_revenue DECIMAL(14,2) NULL;
```

### How it works

`ALTER TABLE` updates metadata and sometimes data pages depending on change type. Always evaluate impact on large tables and dependent code.

### Common mistakes

- Dropping tables without backups/migration scripts
- Altering column types that truncate existing data
- Skipping default values for new non-null columns
- Forgetting dependent views/procedures

### Quick recap

- Use `CREATE TABLE` for initial structure
- Use `ALTER TABLE` for controlled evolution
- Use `DROP TABLE` only after dependency checks

### Next

[Identity and sequences](#identity-and-sequences)


---

## Identity and Sequences

### Why this matters

Most tables need unique numeric keys. SQL Server provides `IDENTITY` and `SEQUENCE` for auto-generated values.

### Concept

- `IDENTITY` is tied to one table column
- `SEQUENCE` is a separate object reusable across tables

### Syntax

```sql
id INT IDENTITY(1,1)
```

```sql
CREATE SEQUENCE schema.seq_name
AS INT
START WITH 1
INCREMENT BY 1;
```

### Walkthrough

```sql
USE BikeStoresLab;

CREATE TABLE staging.load_batch (
    batch_id INT IDENTITY(1000,1) PRIMARY KEY,
    batch_name VARCHAR(100) NOT NULL
);

CREATE SEQUENCE staging.seq_invoice_no
AS INT
START WITH 50000
INCREMENT BY 1;

SELECT
    NEXT VALUE FOR staging.seq_invoice_no AS next_invoice;
```

### How it works

Identity values are generated on insert. Sequence values are generated when `NEXT VALUE FOR` is called, even outside inserts.

### Common mistakes

- Assuming identity has no gaps (rollbacks can create gaps)
- Requiring business meaning from surrogate keys
- Forgetting sequence permissions for application users
- Using one sequence without understanding concurrency needs

### Quick recap

- `IDENTITY` is simple and table-specific
- `SEQUENCE` is flexible and reusable
- Gaps are normal for generated numeric keys

### Next

[Data types](#data-types)


---

## Data Types

### Why this matters

Choosing the right data type affects storage, performance, and correctness.

### Concept

Common SQL Server types:

- Numeric: `INT`, `BIGINT`, `DECIMAL(p,s)`
- Text: `VARCHAR(n)`, `NVARCHAR(n)`
- Date/time: `DATE`, `DATETIME2`
- Logical: `BIT`

### Syntax

```sql
column_name DECIMAL(12,2) NOT NULL
```

### Walkthrough

```sql
USE BikeStoresLab;

CREATE TABLE reporting.product_pricing (
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    list_price DECIMAL(10,2) NOT NULL,
    release_date DATE NULL,
    is_active BIT NOT NULL DEFAULT 1
);
```

### How it works

Data types enforce valid value formats and define how values are stored and compared. Correct choices reduce conversion overhead and data anomalies.

### Common mistakes

- Using `VARCHAR(MAX)` for short fields
- Storing dates in strings
- Choosing too-small decimal precision
- Mixing Unicode/non-Unicode incorrectly

### Quick recap

- Pick types based on real data shape
- Prefer precise numeric/date types over text
- Type decisions influence both quality and speed

### Next

[Constraints](#constraints)


---

## Constraints

### Why this matters

Constraints enforce business rules at the database level so invalid data cannot enter tables.

### Concept

Key constraints:

- `PRIMARY KEY` for row uniqueness
- `FOREIGN KEY` for referential integrity
- `UNIQUE` for alternate unique columns
- `CHECK` for rule validation
- `DEFAULT` for auto-filled values

### Syntax

```sql
CREATE TABLE schema.t (
    id INT PRIMARY KEY,
    code VARCHAR(20) UNIQUE,
    qty INT CHECK (qty >= 0),
    is_active BIT DEFAULT 1
);
```

### Walkthrough

```sql
USE BikeStoresLab;

CREATE TABLE reporting.dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE reporting.fact_sale (
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    store_id INT NOT NULL,
    qty INT NOT NULL CHECK (qty > 0),
    amount DECIMAL(12,2) NOT NULL CHECK (amount >= 0),
    created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT FK_fact_sale_store
        FOREIGN KEY (store_id) REFERENCES reporting.dim_store(store_id)
);
```

### How it works

On each insert/update, SQL Server validates constraints before committing. Violations fail immediately and preserve data integrity.

### Common mistakes

- Defining rules only in app code, not in DB
- Overusing nullable columns for required data
- Forgetting indexes on foreign key columns for performance
- Weak check constraints that allow bad values

### Quick recap

- Constraints are built-in guardrails
- They reduce bad data and downstream cleanup work
- Design constraints together with data types

### Next

[CASE, COALESCE, NULLIF](#case-coalesce-nullif)


---

## CASE, COALESCE, NULLIF

### Why this matters

Production queries must handle missing values and conditional logic cleanly. These expressions are essential for robust reporting SQL.

### Concept

- `CASE` for conditional output
- `COALESCE` for first non-null value
- `NULLIF` to convert equal values to `NULL`

### Syntax

```sql
CASE WHEN condition THEN value ELSE value END
COALESCE(a, b, c)
NULLIF(x, y)
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    customer_id,
    first_name,
    last_name,
    COALESCE(phone, 'NO PHONE') AS phone_display,
    CASE
        WHEN state IN ('CA', 'NY') THEN 'Tier-1'
        WHEN state IS NULL THEN 'Unknown'
        ELSE 'Standard'
    END AS region_group,
    NULLIF(zip_code, '') AS normalized_zip
FROM
    sales.customers;
```

### How it works

`CASE` evaluates conditions in order. `COALESCE` returns the first non-null argument. `NULLIF(a,b)` returns `NULL` when values are equal, otherwise returns `a`.

### Common mistakes

- Mixing incompatible data types in `CASE` branches
- Expecting `COALESCE` to skip empty strings (it only checks `NULL`)
- Using `NULLIF` without understanding downstream null behavior
- Nesting too many conditional expressions in one query

### Quick recap

- Use `CASE` for branching output logic
- Use `COALESCE` for null fallback values
- Use `NULLIF` to neutralize sentinel values

### Next

[Temp tables and synonyms](#temp-tables-and-synonyms)


---

## Temp Tables and Synonyms

### Why this matters

Intermediate processing and cleaner object naming are common needs in real SQL workflows.

### Concept

- Temp tables (`#temp`) store session-local intermediate results
- Synonyms provide alternate names for existing objects

### Syntax

```sql
CREATE TABLE #temp (...);
CREATE SYNONYM schema.syn_name FOR schema.real_object;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    order_id,
    customer_id,
    order_date
INTO #recent_orders
FROM
    sales.orders
WHERE
    order_date >= '2021-01-01';

SELECT COUNT(*) AS recent_order_count
FROM #recent_orders;

CREATE SYNONYM sales.orders_base FOR sales.orders;

SELECT TOP 5
    order_id,
    order_date
FROM
    sales.orders_base;
```

### How it works

`#recent_orders` exists only in the current session. The synonym `sales.orders_base` acts like an alias pointer to `sales.orders` until dropped.

### Common mistakes

- Expecting temp tables to persist after disconnect
- Creating synonyms without documenting the target object
- Forgetting to drop/recreate synonyms during migrations
- Naming temp tables too generically in large scripts

### Quick recap

- Temp tables are session-scoped work tables
- Synonyms simplify object references
- Both are useful for maintainable ETL/report scripts

### Next

[Find and delete duplicates](#find-and-delete-duplicates)


---

## Find and Delete Duplicates

### Why this matters

Duplicate rows create reporting errors and customer experience issues. SQL patterns with window functions help identify and remove them safely.

### Concept

Use `ROW_NUMBER()` partitioned by duplicate-defining columns:

- Keep row `1`
- Delete rows where row number `> 1`

### Syntax

```sql
WITH d AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY key_cols
               ORDER BY tie_breaker
           ) AS rn
    FROM schema.table
)
DELETE FROM d
WHERE rn > 1;
```

### Walkthrough

```sql
USE BikeStoresLab;

BEGIN TRAN;

IF OBJECT_ID('staging.customer_dedup_demo', 'U') IS NULL
BEGIN
    CREATE TABLE staging.customer_dedup_demo (
        customer_email VARCHAR(255),
        created_at DATETIME2 DEFAULT SYSDATETIME()
    );
END;

INSERT INTO staging.customer_dedup_demo (customer_email)
VALUES ('dup@example.com'), ('dup@example.com'), ('unique@example.com');

WITH d AS (
    SELECT
        customer_email,
        created_at,
        ROW_NUMBER() OVER (
            PARTITION BY customer_email
            ORDER BY created_at
        ) AS rn
    FROM
        staging.customer_dedup_demo
)
SELECT *
FROM d
ORDER BY customer_email, rn;

-- Delete duplicates (keep first)
WITH d AS (
    SELECT
        customer_email,
        created_at,
        ROW_NUMBER() OVER (
            PARTITION BY customer_email
            ORDER BY created_at
        ) AS rn
    FROM
        staging.customer_dedup_demo
)
DELETE FROM d
WHERE rn > 1;

ROLLBACK;
```

### How it works

`ROW_NUMBER` creates an ordering per duplicate key group. Any row with `rn > 1` is considered extra and can be safely removed after validation.

### Common mistakes

- Deleting before previewing ranked rows
- Weak partition keys that remove valid distinct rows
- Unstable ordering column in `ROW_NUMBER`
- Running dedupe without transaction safety

### Quick recap

- Use window functions for deterministic deduplication
- Always preview before delete
- Protect dedupe operations with transactions

### Next

Complete [Exercises](#exercises), then move to [Chapter 10: Indexes](Chapter 10 - Indexes.md).


---

## Exercises


Complete these after working through the topics above. ---

#### Exercise 1 - Database and schemas

Create `BikeStoresLab` (if missing) and create schemas `reporting` and `staging`.

---

#### Exercise 2 - Create and alter table

Create a table in `reporting` with an identity primary key, then add one new column using `ALTER TABLE`.

---

#### Exercise 3 - Sequence usage

Create a sequence and return at least 3 consecutive values with `NEXT VALUE FOR`.

---

#### Exercise 4 - Data types design

Create a table with columns covering `INT`, `VARCHAR`, `DECIMAL`, `DATE`, and `BIT`.

---

#### Exercise 5 - Constraints

Create parent-child tables with primary key, foreign key, check, unique, and default constraints.

---

#### Exercise 6 - CASE/COALESCE/NULLIF

Write a query against `sales.customers` using all three expressions in one result set.

---

#### Exercise 7 - Temp table + synonym

Create `#recent_orders` from `sales.orders` and create a synonym to `sales.orders`.

---

#### Exercise 8 - Duplicate cleanup ★

Create a small duplicate demo table, detect duplicates with `ROW_NUMBER`, then delete duplicates safely in a transaction.


---

## Solutions


## Chapter 09 - Solutions

---

#### Exercise 1 - Solution

```sql
IF DB_ID('BikeStoresLab') IS NULL
    CREATE DATABASE BikeStoresLab;
GO

USE BikeStoresLab;
GO

IF SCHEMA_ID('reporting') IS NULL
    EXEC('CREATE SCHEMA reporting');
IF SCHEMA_ID('staging') IS NULL
    EXEC('CREATE SCHEMA staging');
```

---

#### Exercise 2 - Solution

```sql
USE BikeStoresLab;

CREATE TABLE reporting.sales_day_summary (
    summary_id INT IDENTITY(1,1) PRIMARY KEY,
    summary_date DATE NOT NULL,
    order_count INT NOT NULL
);

ALTER TABLE reporting.sales_day_summary
ADD total_revenue DECIMAL(12,2) NULL;
```

---

#### Exercise 3 - Solution

```sql
USE BikeStoresLab;

CREATE SEQUENCE staging.seq_batch_id
AS INT
START WITH 100
INCREMENT BY 1;

SELECT NEXT VALUE FOR staging.seq_batch_id AS v1;
SELECT NEXT VALUE FOR staging.seq_batch_id AS v2;
SELECT NEXT VALUE FOR staging.seq_batch_id AS v3;
```

---

#### Exercise 4 - Solution

```sql
USE BikeStoresLab;

CREATE TABLE reporting.type_demo (
    id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    active_from DATE NULL,
    is_active BIT NOT NULL DEFAULT 1
);
```

---

#### Exercise 5 - Solution

```sql
USE BikeStoresLab;

CREATE TABLE reporting.parent_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE reporting.child_sale (
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    store_id INT NOT NULL,
    qty INT NOT NULL CHECK (qty > 0),
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    created_at DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT FK_child_sale_store
        FOREIGN KEY (store_id) REFERENCES reporting.parent_store(store_id)
);
```

---

#### Exercise 6 - Solution

```sql
USE BikeStores;

SELECT
    customer_id,
    CASE
        WHEN state = 'CA' THEN 'California'
        WHEN state = 'NY' THEN 'New York'
        ELSE 'Other'
    END AS state_group,
    COALESCE(phone, 'NO PHONE') AS phone_display,
    NULLIF(zip_code, '') AS normalized_zip
FROM
    sales.customers;
```

---

#### Exercise 7 - Solution

```sql
USE BikeStores;

SELECT
    order_id,
    customer_id,
    order_date
INTO #recent_orders
FROM
    sales.orders
WHERE
    order_date >= '2021-01-01';

SELECT COUNT(*) AS total_recent FROM #recent_orders;

CREATE SYNONYM sales.orders_alias FOR sales.orders;

SELECT TOP 5 order_id, order_date
FROM sales.orders_alias;
```

---

#### Exercise 8 - Solution

```sql
USE BikeStoresLab;
BEGIN TRAN;

IF OBJECT_ID('staging.dupe_demo', 'U') IS NULL
BEGIN
    CREATE TABLE staging.dupe_demo (
        email VARCHAR(255),
        created_at DATETIME2 DEFAULT SYSDATETIME()
    );
END;

INSERT INTO staging.dupe_demo (email)
VALUES ('d@example.com'), ('d@example.com'), ('u@example.com');

WITH ranked AS (
    SELECT
        email,
        created_at,
        ROW_NUMBER() OVER (
            PARTITION BY email
            ORDER BY created_at
        ) AS rn
    FROM staging.dupe_demo
)
DELETE FROM ranked
WHERE rn > 1;

SELECT email, COUNT(*) AS cnt
FROM staging.dupe_demo
GROUP BY email;

ROLLBACK;
```

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 10 - Indexes.md](Chapter 10 - Indexes.md)
