# Chapter 13 - Triggers


Learn how SQL Server triggers run automatically on table or schema events, and how to use them carefully for auditing and policy enforcement.

## Prerequisites

- [Chapter 12: User-Defined Functions](Chapter 12 - User-Defined Functions.md) completed
- [Chapter 08: Modifying Data](Chapter 08 - Modifying Data.md) completed
- Run [`04-tutorial-extensions.sql`](assets/database/04-tutorial-extensions.sql) to create `production.product_audits`

## Learning goals

After this chapter, you will be able to:

- **Create** DML triggers for `INSERT`, `UPDATE`, and `DELETE`
- **Use** `inserted` and `deleted` pseudo tables correctly
- **Build** `INSTEAD OF` triggers for custom write behavior
- **Create** basic DDL triggers for schema-change events
- **Manage** trigger lifecycle with enable, disable, and drop


## Time estimate

- **Reading:** about 60-75 minutes
- **Practice:** about 45 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main objects | `production.products`, `production.product_audits` |
| Script | `assets/database/04-tutorial-extensions.sql` |


---

## DML Trigger Basics

### Why this matters

Some rules must run automatically whenever data changes. DML triggers can enforce those rules or create audit records without requiring application code changes.

### Concept

A **DML trigger** fires after `INSERT`, `UPDATE`, or `DELETE` on a table.

- `AFTER` trigger runs after the data change statement.
- Trigger logic runs in the same transaction.
- Triggers should stay short and predictable.

### Syntax

```sql
CREATE TRIGGER schema_name.trigger_name
ON schema_name.table_name
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- trigger logic
END;
```

### Walkthrough

Create an audit trigger on `production.products`.

```sql
USE BikeStores;
GO

CREATE OR ALTER TRIGGER production.trg_product_audit
ON production.products
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO production.product_audits
    (
        product_id, product_name, brand_id, category_id,
        model_year, list_price, updated_at, operation
    )
    SELECT
        i.product_id, i.product_name, i.brand_id, i.category_id,
        i.model_year, i.list_price, GETDATE(), 'INS'
    FROM inserted AS i;
END;
GO
```

#### Expected result

Whenever products are inserted, a matching audit row is written to `production.product_audits`.

### How it works

The `inserted` pseudo table contains new rows from the triggering statement. The trigger copies those rows into the audit table with timestamp and operation code.

### Common mistakes

- Assuming trigger runs once per row (it runs once per statement).
- Writing trigger code that handles only single-row changes.
- Creating expensive trigger logic that slows normal writes.

### Quick recap

- DML triggers react to data modification events.
- Keep trigger logic set-based and lightweight.
- `production.product_audits` is your audit destination table.

### Next

[Using INSERTED and DELETED](#using-inserted-and-deleted)


---

## Using INSERTED and DELETED

### Why this matters

To audit updates and deletes, you need both old and new row versions. SQL Server provides these through pseudo tables.

### Concept

- `inserted`: new versions of rows (`INSERT` and `UPDATE`)
- `deleted`: old versions of rows (`DELETE` and `UPDATE`)

For updates, both tables are populated.

### Syntax

```sql
SELECT * FROM inserted;
SELECT * FROM deleted;
```

Inside trigger logic, join or union these sets based on event type.

### Walkthrough

Update trigger to capture all three operations.

```sql
USE BikeStores;
GO

CREATE OR ALTER TRIGGER production.trg_product_audit
ON production.products
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO production.product_audits
    (product_id, product_name, brand_id, category_id, model_year, list_price, updated_at, operation)
    SELECT product_id, product_name, brand_id, category_id, model_year, list_price, GETDATE(), 'INS'
    FROM inserted
    WHERE product_id NOT IN (SELECT product_id FROM deleted);

    INSERT INTO production.product_audits
    (product_id, product_name, brand_id, category_id, model_year, list_price, updated_at, operation)
    SELECT product_id, product_name, brand_id, category_id, model_year, list_price, GETDATE(), 'DEL'
    FROM deleted
    WHERE product_id NOT IN (SELECT product_id FROM inserted);

    INSERT INTO production.product_audits
    (product_id, product_name, brand_id, category_id, model_year, list_price, updated_at, operation)
    SELECT i.product_id, i.product_name, i.brand_id, i.category_id, i.model_year, i.list_price, GETDATE(), 'UPD'
    FROM inserted AS i
    INNER JOIN deleted AS d ON d.product_id = i.product_id;
END;
GO
```

#### Expected result

Insert, delete, and update events are all logged with operation codes `INS`, `DEL`, or `UPD`.

### How it works

Rows present only in `inserted` are inserts. Rows present only in `deleted` are deletes. Rows in both represent updates.

### Common mistakes

- Ignoring multi-row operations.
- Assuming `inserted` has values on delete.
- Forgetting to test update and delete paths separately.

### Quick recap

- `inserted` and `deleted` are core trigger data sources.
- Updates provide both old and new versions.
- Set-based logic handles batches correctly.

### Next

[INSTEAD OF triggers](#instead-of-triggers)


---

## INSTEAD OF Triggers

### Why this matters

Sometimes you want to intercept a write and replace the default behavior. `INSTEAD OF` triggers allow custom logic before any row is written.

### Concept

An `INSTEAD OF` trigger runs instead of the original DML statement.

- Useful for updatable views or custom validation.
- You must explicitly perform the desired insert/update/delete.

### Syntax

```sql
CREATE TRIGGER schema_name.trigger_name
ON schema_name.object_name
INSTEAD OF INSERT
AS
BEGIN
    -- custom logic
END;
```

### Walkthrough

Block product inserts with negative prices.

```sql
USE BikeStores;
GO

CREATE OR ALTER TRIGGER production.trg_products_instead_of_insert
ON production.products
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted WHERE list_price < 0)
    BEGIN
        THROW 50011, 'Negative list_price is not allowed.', 1;
    END;

    INSERT INTO production.products
    (
        product_name, brand_id, category_id, model_year, list_price
    )
    SELECT
        product_name, brand_id, category_id, model_year, list_price
    FROM inserted;
END;
GO
```

#### Expected result

Valid rows insert normally; rows with negative price fail with custom error.

### How it works

SQL Server sends attempted rows to `inserted`. Because this is `INSTEAD OF`, the original insert does not execute automatically. Your trigger decides what to do.

### Common mistakes

- Forgetting to insert valid rows inside the trigger.
- Using `INSTEAD OF` when `AFTER` is enough.
- Writing row-by-row logic for multi-row inserts.

### Quick recap

- `INSTEAD OF` replaces default DML behavior.
- Great for custom validation and view write rules.
- Always define what happens to valid rows.

### Next

[DDL triggers](#ddl-triggers)


---

## DDL Triggers

### Why this matters

Teams often need visibility into schema changes like creating or dropping tables. DDL triggers can log these changes for auditing.

### Concept

A **DDL trigger** responds to schema events such as `CREATE_TABLE`, `ALTER_TABLE`, and `DROP_TABLE`.

- Defined at database or server scope.
- Uses XML event data from `EVENTDATA()`.

### Syntax

```sql
CREATE TRIGGER trigger_name
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    -- use EVENTDATA()
END;
```

### Walkthrough

Create a simple DDL trigger that prints event details.

```sql
USE BikeStores;
GO

CREATE OR ALTER TRIGGER trg_log_table_changes
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    DECLARE @x XML = EVENTDATA();

    SELECT
        @x.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)') AS event_type,
        @x.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(256)') AS object_name,
        @x.value('(/EVENT_INSTANCE/LoginName)[1]', 'NVARCHAR(256)') AS login_name;
END;
GO
```

#### Expected result

When a table is created, altered, or dropped, SSMS shows one row with event details.

### How it works

`EVENTDATA()` returns XML describing the DDL action. XPath expressions extract fields such as event type and object name.

### Common mistakes

- Expecting DDL triggers to capture row-level data changes.
- Creating server-wide triggers when database scope is enough.
- Forgetting to secure who can create or alter DDL triggers.

### Quick recap

- DDL triggers monitor schema events.
- `EVENTDATA()` provides event metadata in XML.
- Use them mainly for auditing and governance.

### Next

[Enable, disable, and drop triggers](#enable-disable-and-drop-triggers)


---

## Enable, Disable, and Drop Triggers

### Why this matters

During testing or data loads, you may need to pause trigger behavior temporarily. SQL Server provides explicit commands to disable, enable, or remove triggers.

### Concept

Trigger lifecycle commands:

- `DISABLE TRIGGER`
- `ENABLE TRIGGER`
- `DROP TRIGGER`

Use these deliberately because they affect data integrity and auditing.

### Syntax

```sql
DISABLE TRIGGER schema.trigger_name ON schema.table_name;
ENABLE TRIGGER schema.trigger_name ON schema.table_name;
DROP TRIGGER schema.trigger_name;
```

### Walkthrough

```sql
USE BikeStores;
GO

DISABLE TRIGGER production.trg_product_audit ON production.products;
GO

ENABLE TRIGGER production.trg_product_audit ON production.products;
GO

DROP TRIGGER IF EXISTS production.trg_products_instead_of_insert;
GO
```

#### Expected result

The first command pauses auditing on `production.products`, the second re-enables it, and the third removes an obsolete trigger.

### How it works

Disabled triggers remain defined but do not execute. Dropped triggers are deleted from metadata and must be recreated if needed.

### Another example

Disable all table triggers in the database (use with caution):

```sql
DISABLE TRIGGER ALL ON DATABASE;
```

### Common mistakes

- Forgetting to re-enable triggers after bulk load.
- Dropping trigger without source script backup.
- Disabling all triggers in shared environments unintentionally.

### Quick recap

- Use disable/enable for temporary control.
- Use drop for permanent removal.
- Document trigger state changes in deployment scripts.

### Next

Finish [Exercises](#exercises), then continue to [Chapter 14: Aggregate Functions](Chapter 14 - Aggregate Functions.md).


---

## Exercises


Complete these after working through the topics above. Ensure `production.product_audits` exists from `04-tutorial-extensions.sql`.

---

#### Exercise 1 - Insert audit trigger (warm-up)

Create `AFTER INSERT` trigger on `production.products` that logs inserted rows to `production.product_audits` with operation `INS`.

---

#### Exercise 2 - Update/delete audit support (warm-up)

Extend your trigger to also log updates (`UPD`) and deletes (`DEL`) using `inserted` and `deleted`.

---

#### Exercise 3 - Test multi-row update (apply)

Run one `UPDATE` statement that changes several rows. Verify your trigger logs all changed rows.

---

#### Exercise 4 - INSTEAD OF validation (apply)

Create `INSTEAD OF INSERT` trigger that blocks negative `list_price` values.

---

#### Exercise 5 - DDL trigger practice (apply)

Create a DDL trigger on `CREATE_TABLE` and `DROP_TABLE` that returns event type and object name via `EVENTDATA()`.

---

#### Exercise 6 - Trigger lifecycle commands (stretch) ★

Disable, enable, and then drop one trigger. Confirm state changes with `sys.triggers`.


---

## Solutions


## Chapter 13 - Solutions

---

#### Exercise 1 - Solution

```sql
USE BikeStores;
GO

CREATE OR ALTER TRIGGER production.trg_product_audit
ON production.products
AFTER INSERT
AS
BEGIN
    INSERT INTO production.product_audits
    (product_id, product_name, brand_id, category_id, model_year, list_price, updated_at, operation)
    SELECT
        product_id, product_name, brand_id, category_id, model_year, list_price, GETDATE(), 'INS'
    FROM inserted;
END;
GO
```

Logs inserted rows to the audit table.

---

#### Exercise 2 - Solution

```sql
CREATE OR ALTER TRIGGER production.trg_product_audit
ON production.products
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO production.product_audits
    (product_id, product_name, brand_id, category_id, model_year, list_price, updated_at, operation)
    SELECT product_id, product_name, brand_id, category_id, model_year, list_price, GETDATE(), 'INS'
    FROM inserted
    WHERE product_id NOT IN (SELECT product_id FROM deleted);

    INSERT INTO production.product_audits
    (product_id, product_name, brand_id, category_id, model_year, list_price, updated_at, operation)
    SELECT product_id, product_name, brand_id, category_id, model_year, list_price, GETDATE(), 'DEL'
    FROM deleted
    WHERE product_id NOT IN (SELECT product_id FROM inserted);

    INSERT INTO production.product_audits
    (product_id, product_name, brand_id, category_id, model_year, list_price, updated_at, operation)
    SELECT i.product_id, i.product_name, i.brand_id, i.category_id, i.model_year, i.list_price, GETDATE(), 'UPD'
    FROM inserted AS i
    INNER JOIN deleted AS d ON i.product_id = d.product_id;
END;
GO
```

Handles all DML operations in one trigger.

---

#### Exercise 3 - Solution

```sql
UPDATE production.products
SET list_price = list_price * 1.02
WHERE category_id = 1;

SELECT TOP 20 *
FROM production.product_audits
WHERE operation = 'UPD'
ORDER BY change_id DESC;
```

Confirms multi-row update auditing.

---

#### Exercise 4 - Solution

```sql
CREATE OR ALTER TRIGGER production.trg_products_instead_of_insert
ON production.products
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE list_price < 0)
        THROW 50021, 'Negative price is not allowed.', 1;

    INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price)
    SELECT product_name, brand_id, category_id, model_year, list_price
    FROM inserted;
END;
GO
```

Rejects invalid rows and inserts valid ones.

---

#### Exercise 5 - Solution

```sql
CREATE OR ALTER TRIGGER trg_table_ddl_log
ON DATABASE
FOR CREATE_TABLE, DROP_TABLE
AS
BEGIN
    DECLARE @x XML = EVENTDATA();
    SELECT
        @x.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)') AS event_type,
        @x.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(256)') AS object_name;
END;
GO
```

Captures basic DDL event metadata.

---

#### Exercise 6 - Solution

```sql
DISABLE TRIGGER production.trg_product_audit ON production.products;
ENABLE TRIGGER production.trg_product_audit ON production.products;
DROP TRIGGER IF EXISTS production.trg_products_instead_of_insert;

SELECT
    name,
    is_disabled
FROM sys.triggers
WHERE name LIKE 'trg_%';
```

Demonstrates full trigger lifecycle operations.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 14 - Aggregate Functions.md](Chapter 14 - Aggregate Functions.md)
