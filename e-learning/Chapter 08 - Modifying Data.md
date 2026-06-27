# Chapter 08 - Modifying Data


This chapter covers Data Manipulation Language (DML): `INSERT`, `UPDATE`, `DELETE`, `MERGE`, and transaction control. You will learn safe patterns for changing data in SQL Server.

> For all practice updates and deletes, use `BEGIN TRAN` + `ROLLBACK` first to avoid accidental permanent changes.

## Prerequisites

- [Chapter 07: Views](Chapter 07 - Views.md) completed
- **BikeStores** database loaded
- Ability to run DML statements in your SQL environment

## Learning goals

After this chapter, you will be able to:

- **Insert** single and multiple rows
- **Insert** from `SELECT` queries
- **Update** rows with filters and joins
- **Delete** rows safely with validation
- **Use** `MERGE` for upsert-style operations
- **Control** transactions with `BEGIN TRAN`, `COMMIT`, and `ROLLBACK`


## Time estimate

- **Reading:** about 60-75 minutes
- **Practice:** about 45-60 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `sales.customers`, `sales.orders`, `sales.staffs` |
| Tool | SSMS query window; run in small, reversible batches |

## Troubleshooting

| Problem | What to try |
|---------|-------------|
| Updated too many rows | Always preview with `SELECT` and use `BEGIN TRAN`/`ROLLBACK` |
| FK constraint errors on delete | Delete child rows first, or redesign process |
| `MERGE` unexpected results | Verify join condition and test source rows carefully |
| Transaction left open | Run `ROLLBACK` if unsure and re-check `@@TRANCOUNT` |


---

## INSERT Basics

### Why this matters

New customers, products, and orders enter the system through `INSERT`. Correct insert patterns protect data quality from day one.

### Concept

`INSERT` adds rows to a table. Best practice is to list target columns explicitly.

### Syntax

```sql
INSERT INTO schema.table_name (col1, col2, col3)
VALUES (val1, val2, val3);
```

### Walkthrough

```sql
USE BikeStores;

BEGIN TRAN;

INSERT INTO sales.customers (
    first_name,
    last_name,
    phone,
    email,
    street,
    city,
    state,
    zip_code
)
VALUES (
    'Amina',
    'Khan',
    '555-0199',
    'amina.khan@example.com',
    '12 Sunset Road',
    'Lahore',
    'PK',
    '54000'
);

SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM
    sales.customers
WHERE
    email = 'amina.khan@example.com';

ROLLBACK;
```

### How it works

SQL Server validates constraints, data types, and nullability before inserting. Wrapping in a transaction lets you test without saving permanent changes.

### Common mistakes

- Omitting column list and relying on table column order
- Inserting string into numeric/date columns without conversion
- Violating `NOT NULL` or unique constraints
- Forgetting to rollback in practice sessions

### Quick recap

- Use explicit column lists with `INSERT`
- Validate results with a follow-up `SELECT`
- Practice safely with `BEGIN TRAN` and `ROLLBACK`

### Next

[INSERT multiple rows and INSERT...SELECT](#insert-multiple-rows-and-insertselect)


---

## INSERT Multiple Rows and INSERT...SELECT

### Why this matters

Real workflows often load batches of data, not one row at a time. SQL Server supports efficient multi-row inserts and set-based inserts from queries.

### Concept

- `INSERT ... VALUES (...), (...), (...)` for small static batches
- `INSERT ... SELECT` for copying/transformation from existing tables

### Syntax

```sql
INSERT INTO schema.table (col1, col2)
VALUES
    (v1, v2),
    (v3, v4);
```

```sql
INSERT INTO schema.table (col1, col2)
SELECT x, y
FROM other_table;
```

### Walkthrough

```sql
USE BikeStores;

BEGIN TRAN;

-- Demo table
IF OBJECT_ID('sales.customer_stage', 'U') IS NULL
BEGIN
    CREATE TABLE sales.customer_stage (
        first_name VARCHAR(255),
        last_name VARCHAR(255),
        email VARCHAR(255)
    );
END;

INSERT INTO sales.customer_stage (first_name, last_name, email)
VALUES
    ('Sara', 'Ali', 'sara.ali@example.com'),
    ('Hamza', 'Iqbal', 'hamza.iqbal@example.com');

SELECT
    first_name,
    last_name,
    email
FROM
    sales.customer_stage;

ROLLBACK;
```

### How it works

Multi-row `VALUES` sends one statement for multiple records. `INSERT...SELECT` moves data in a set, which is usually faster and cleaner than row-by-row scripts.

### Common mistakes

- Column count mismatch between target and source
- Forgetting to filter source rows in `INSERT...SELECT`
- Ignoring duplicate checks before bulk insert
- Large transactions without chunking

### Quick recap

- Use multi-row `VALUES` for small fixed batches
- Use `INSERT...SELECT` for set-based loading
- Validate target row counts after insert

### Next

[UPDATE and UPDATE JOIN](#update-and-update-join)


---

## UPDATE and UPDATE JOIN

### Why this matters

Business data changes: prices are corrected, addresses updated, statuses fixed. `UPDATE` is powerful and risky, so safe filters and transaction discipline are critical.

### Concept

- Standard `UPDATE` changes rows in one table
- `UPDATE ... FROM ... JOIN ...` updates based on another table's data

### Syntax

```sql
UPDATE schema.table
SET col = value
WHERE condition;
```

```sql
UPDATE t
SET t.col = s.new_value
FROM schema.target AS t
INNER JOIN schema.source AS s
    ON t.key = s.key;
```

### Walkthrough

```sql
USE BikeStores;

BEGIN TRAN;

-- Preview first
SELECT
    customer_id,
    city
FROM
    sales.customers
WHERE
    state = 'NY';

UPDATE sales.customers
SET city = 'New York'
WHERE state = 'NY'
  AND city <> 'New York';

SELECT
    customer_id,
    city
FROM
    sales.customers
WHERE
    state = 'NY';

ROLLBACK;
```

### How it works

SQL Server identifies rows that match `WHERE`, applies `SET`, and logs changes. With transaction wrapping, you can inspect before committing.

### Common mistakes

- Missing `WHERE` and updating all rows
- Joining source tables that produce duplicate matches
- Updating key columns carelessly
- Not previewing affected rows before running update

### Quick recap

- Always preview row scope before `UPDATE`
- `UPDATE JOIN` is useful for synchronized corrections
- Practice with `BEGIN TRAN` + `ROLLBACK` first

### Next

[DELETE safely](#delete-safely)


---

## DELETE Safely

### Why this matters

`DELETE` removes rows permanently after commit. One wrong filter can remove critical data.

### Concept

Safe delete pattern:

1. Run `SELECT` with the same `WHERE`
2. Start transaction
3. Run `DELETE`
4. Verify affected rows
5. `ROLLBACK` during practice, `COMMIT` only when sure

### Syntax

```sql
DELETE FROM schema.table
WHERE condition;
```

### Walkthrough

```sql
USE BikeStores;

BEGIN TRAN;

SELECT
    customer_id,
    email
FROM
    sales.customers
WHERE
    email LIKE '%@example.com';

DELETE FROM sales.customers
WHERE
    email LIKE '%@example.com';

SELECT @@ROWCOUNT AS deleted_rows;

ROLLBACK;
```

### How it works

`DELETE` marks target rows for removal and logs the operation. The transaction determines whether changes persist (`COMMIT`) or are undone (`ROLLBACK`).

### Common mistakes

- Skipping preview `SELECT`
- Deleting parent rows without handling child dependencies
- Confusing `DELETE` with `TRUNCATE TABLE`
- Running large deletes without batching

### Quick recap

- Use exact `WHERE` filters
- Always validate scope first
- Practice deletes inside explicit transactions

### Next

[MERGE basics](#merge-basics)


---

## MERGE Basics

### Why this matters

ETL and synchronization tasks often require "insert if new, update if existing." `MERGE` combines these operations in one statement.

### Concept

`MERGE` compares a **target** table with a **source** dataset and performs actions for matched and unmatched rows.

### Syntax

```sql
MERGE target_table AS t
USING source_table AS s
    ON t.key = s.key
WHEN MATCHED THEN
    UPDATE SET ...
WHEN NOT MATCHED BY TARGET THEN
    INSERT (...) VALUES (...);
```

### Walkthrough

```sql
USE BikeStores;

BEGIN TRAN;

IF OBJECT_ID('sales.staff_updates', 'U') IS NULL
BEGIN
    CREATE TABLE sales.staff_updates (
        staff_id INT PRIMARY KEY,
        phone VARCHAR(25)
    );
END;

DELETE FROM sales.staff_updates;

INSERT INTO sales.staff_updates (staff_id, phone)
VALUES
    (1, '555-7771'),
    (2, '555-7772');

MERGE sales.staffs AS tgt
USING sales.staff_updates AS src
    ON tgt.staff_id = src.staff_id
WHEN MATCHED THEN
    UPDATE SET tgt.phone = src.phone;

SELECT
    staff_id,
    phone
FROM
    sales.staffs
WHERE
    staff_id IN (1, 2);

ROLLBACK;
```

### How it works

`MERGE` executes join logic once, then applies branch actions (`WHEN MATCHED`, `WHEN NOT MATCHED`). It is powerful but should be carefully tested for edge cases.

### Common mistakes

- Non-unique join keys causing unexpected multiple matches
- Missing semicolon terminator after `MERGE` in some scripts
- Overly complex `MERGE` logic that is hard to debug
- Using `MERGE` where separate `UPDATE` + `INSERT` is clearer

### Quick recap

- `MERGE` supports synchronized upsert-style flows
- Join condition quality is critical
- Test carefully and wrap in a transaction during practice

### Next

[Transactions](#transactions)


---

## Transactions

### Why this matters

Data changes must be reliable. Transactions guarantee that a related group of changes either all succeed or all roll back.

### Concept

Core commands:

- `BEGIN TRAN` starts a transaction
- `COMMIT` saves all changes
- `ROLLBACK` undoes all uncommitted changes

ACID principle focus:

- **Atomicity:** all-or-nothing
- **Consistency:** constraints stay valid

### Syntax

```sql
BEGIN TRAN;

-- one or more DML statements

COMMIT;   -- or ROLLBACK;
```

### Walkthrough

```sql
USE BikeStores;

BEGIN TRAN;

UPDATE sales.staffs
SET phone = '555-9001'
WHERE staff_id = 1;

UPDATE sales.staffs
SET phone = '555-9002'
WHERE staff_id = 2;

SELECT
    staff_id,
    phone
FROM
    sales.staffs
WHERE
    staff_id IN (1, 2);

-- Practice mode:
ROLLBACK;
-- In real approved runs: COMMIT;
```

### How it works

Until commit, changes are visible within the transaction and can be undone. SQL Server keeps a transaction log so rollback can reverse modifications.

### Common mistakes

- Leaving transactions open and causing locks
- Forgetting error handling around multi-step changes
- Mixing test and production scripts without clear commit intent
- Assuming transaction scope continues across disconnected sessions

### Quick recap

- Wrap risky DML in explicit transactions
- Use rollback during learning and dry runs
- Commit only after verification

### Next

Complete [Exercises](#exercises), then continue to [Chapter 09: Schema Design](Chapter 09 - Schema Design.md).


---

## Exercises


Complete these after working through the topics above. Use `BEGIN TRAN` + `ROLLBACK` in every practice exercise.

---

#### Exercise 1 - Insert one customer

Insert one new row into `sales.customers`, verify with `SELECT`, then roll back.

---

#### Exercise 2 - Multi-row insert

Create a small staging table and insert at least 3 rows using one `INSERT ... VALUES` statement.

---

#### Exercise 3 - INSERT...SELECT

Insert rows from your staging table into another practice table using `INSERT...SELECT`.

---

#### Exercise 4 - Update with filter

Update customer city for a chosen state, validate changed rows, then roll back.

---

#### Exercise 5 - UPDATE JOIN

Use a source table to update phone values in `sales.staffs` with `UPDATE ... FROM`.

---

#### Exercise 6 - Delete with preview

Preview target rows with `SELECT`, then delete them and verify `@@ROWCOUNT`.

---

#### Exercise 7 - MERGE upsert

Create a source table and run `MERGE` against `sales.staffs` to update at least two rows.

---

#### Exercise 8 - Transaction control ★

Run a multi-step transaction with two updates and one insert. Check results before rolling back.


---

## Solutions


## Chapter 08 - Solutions

> Each solution uses a transaction and ends with `ROLLBACK` for safe practice.

---

#### Exercise 1 - Solution

```sql
USE BikeStores;
BEGIN TRAN;

INSERT INTO sales.customers (
    first_name, last_name, phone, email, street, city, state, zip_code
)
VALUES (
    'Test', 'User', '555-0101', 'test.user@example.com',
    '1 Demo St', 'Austin', 'TX', '73301'
);

SELECT *
FROM sales.customers
WHERE email = 'test.user@example.com';

ROLLBACK;
```

---

#### Exercise 2 - Solution

```sql
USE BikeStores;
BEGIN TRAN;

IF OBJECT_ID('sales.stage_people', 'U') IS NULL
BEGIN
    CREATE TABLE sales.stage_people (
        first_name VARCHAR(255),
        last_name VARCHAR(255),
        email VARCHAR(255)
    );
END;

INSERT INTO sales.stage_people (first_name, last_name, email)
VALUES
    ('A', 'One', 'a.one@example.com'),
    ('B', 'Two', 'b.two@example.com'),
    ('C', 'Three', 'c.three@example.com');

SELECT * FROM sales.stage_people;

ROLLBACK;
```

---

#### Exercise 3 - Solution

```sql
USE BikeStores;
BEGIN TRAN;

IF OBJECT_ID('sales.stage_target', 'U') IS NULL
BEGIN
    CREATE TABLE sales.stage_target (
        first_name VARCHAR(255),
        last_name VARCHAR(255),
        email VARCHAR(255)
    );
END;

INSERT INTO sales.stage_target (first_name, last_name, email)
SELECT
    first_name,
    last_name,
    email
FROM sales.stage_people;

SELECT * FROM sales.stage_target;

ROLLBACK;
```

---

#### Exercise 4 - Solution

```sql
USE BikeStores;
BEGIN TRAN;

UPDATE sales.customers
SET city = 'Houston'
WHERE state = 'TX';

SELECT customer_id, city, state
FROM sales.customers
WHERE state = 'TX';

ROLLBACK;
```

---

#### Exercise 5 - Solution

```sql
USE BikeStores;
BEGIN TRAN;

IF OBJECT_ID('sales.staff_phone_fix', 'U') IS NULL
BEGIN
    CREATE TABLE sales.staff_phone_fix (
        staff_id INT PRIMARY KEY,
        phone VARCHAR(25)
    );
END;

DELETE FROM sales.staff_phone_fix;
INSERT INTO sales.staff_phone_fix (staff_id, phone)
VALUES (1, '555-3001'), (2, '555-3002');

UPDATE s
SET s.phone = f.phone
FROM sales.staffs AS s
INNER JOIN sales.staff_phone_fix AS f
    ON s.staff_id = f.staff_id;

SELECT staff_id, phone
FROM sales.staffs
WHERE staff_id IN (1, 2);

ROLLBACK;
```

---

#### Exercise 6 - Solution

```sql
USE BikeStores;
BEGIN TRAN;

SELECT *
FROM sales.customers
WHERE email LIKE '%@example.com';

DELETE FROM sales.customers
WHERE email LIKE '%@example.com';

SELECT @@ROWCOUNT AS deleted_rows;

ROLLBACK;
```

---

#### Exercise 7 - Solution

```sql
USE BikeStores;
BEGIN TRAN;

IF OBJECT_ID('sales.merge_source_staff', 'U') IS NULL
BEGIN
    CREATE TABLE sales.merge_source_staff (
        staff_id INT PRIMARY KEY,
        phone VARCHAR(25)
    );
END;

DELETE FROM sales.merge_source_staff;
INSERT INTO sales.merge_source_staff (staff_id, phone)
VALUES (1, '555-8111'), (2, '555-8222');

MERGE sales.staffs AS tgt
USING sales.merge_source_staff AS src
ON tgt.staff_id = src.staff_id
WHEN MATCHED THEN
    UPDATE SET tgt.phone = src.phone;

SELECT staff_id, phone
FROM sales.staffs
WHERE staff_id IN (1, 2);

ROLLBACK;
```

---

#### Exercise 8 - Solution

```sql
USE BikeStores;
BEGIN TRAN;

UPDATE sales.staffs
SET phone = '555-7001'
WHERE staff_id = 1;

UPDATE sales.staffs
SET phone = '555-7002'
WHERE staff_id = 2;

INSERT INTO sales.staffs (
    first_name, last_name, email, phone, active, store_id, manager_id
)
VALUES (
    'Demo', 'Staff', 'demo.staff@example.com', '555-7003', 1, 1, 1
);

SELECT staff_id, first_name, phone
FROM sales.staffs
WHERE staff_id IN (1, 2)
   OR email = 'demo.staff@example.com';

ROLLBACK;
```

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 09 - Schema Design.md](Chapter 09 - Schema Design.md)
