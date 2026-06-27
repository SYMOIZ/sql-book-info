# Chapter 10 - Indexes


Indexes are the primary tool for SQL Server query performance tuning. In this chapter, you will learn index foundations, core index types, and practical design strategy.

## Prerequisites

- [Chapter 09: Schema Design](Chapter 09 - Schema Design.md) completed
- **BikeStores** database loaded
- Run `04-tutorial-extensions.sql` first so `production.parts` is available for chapter examples

## Learning goals

After this chapter, you will be able to:

- **Explain** heaps, pages, and index fundamentals
- **Create** clustered and nonclustered indexes
- **Use** unique and filtered indexes
- **Apply** included columns and computed-column indexing
- **Build** a practical index strategy for real workloads


## Time estimate

- **Reading:** about 70-90 minutes
- **Practice:** about 60 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main table for chapter | `production.parts` |
| Setup requirement | Execute `04-tutorial-extensions.sql` before starting |
| Tool | SSMS with actual execution plan enabled for experiments |

## Troubleshooting

| Problem | What to try |
|---------|-------------|
| `Invalid object name 'production.parts'` | Run `04-tutorial-extensions.sql` first |
| Index not used | Check selectivity, predicates, and stats; inspect plan |
| Too many indexes hurt writes | Reassess low-value indexes and redundancy |
| Filtered index ignored | Ensure query predicate matches filter condition |


---

## Index Concepts and Heaps

### Why this matters

Indexing decisions strongly affect query speed. Before tuning, you need a clear mental model of how SQL Server stores and locates rows.

### Concept

- A **heap** is a table without a clustered index
- Indexes are lookup structures to avoid full scans
- Query optimizer chooses access path (scan/seek) based on cost

### Syntax

```sql
-- Heap example: table created without clustered index
CREATE TABLE production.parts_heap_demo (...);
```

### Walkthrough

```sql
USE BikeStores;

SELECT TOP 20
    part_id,
    part_name,
    list_price
FROM
    production.parts
WHERE
    list_price > 500
ORDER BY
    list_price DESC;
```

Turn on Actual Execution Plan in SSMS and compare behavior before/after adding indexes in later lessons.

### How it works

Without a supporting index, SQL Server often scans many pages. With a suitable index, it can seek to relevant row ranges quickly.

### Common mistakes

- Assuming every query needs an index
- Ignoring write overhead of additional indexes
- Confusing logical query order with physical storage
- Tuning without reading execution plans

### Quick recap

- Heaps have no clustered index
- Indexes trade write cost for read performance
- Execution plans show whether scans or seeks are used

### Next

[Clustered indexes](#clustered-indexes)


---

## Clustered Indexes

### Why this matters

A clustered index defines the physical row order of a table. It is often the most important index choice.

### Concept

- One clustered index per table
- Leaf level contains actual data rows
- Good clustered keys are stable, narrow, and frequently used for range queries

### Syntax

```sql
CREATE CLUSTERED INDEX ix_name
ON schema.table_name (column_name);
```

### Walkthrough

```sql
USE BikeStores;

CREATE CLUSTERED INDEX IX_parts_part_id
ON production.parts (part_id);
```

Test query:

```sql
SELECT
    part_id,
    part_name,
    list_price
FROM
    production.parts
WHERE
    part_id BETWEEN 100 AND 200;
```

### How it works

Rows are ordered by clustered key, so range access on key columns is efficient. Nonclustered indexes also use clustered key values as row locators.

### Common mistakes

- Choosing wide text columns as clustered keys
- Choosing frequently updated columns as clustered keys
- Ignoring insert hotspot patterns on ever-increasing keys
- Rebuilding indexes without reason

### Quick recap

- Clustered index defines table row order
- Choose keys with stability and narrow width
- Clustered key influences all nonclustered indexes

### Next

[Nonclustered indexes](#nonclustered-indexes)


---

## Nonclustered Indexes

### Why this matters

Most query tuning work uses nonclustered indexes to speed specific predicates and joins.

### Concept

A nonclustered index stores key values plus row locators to base table rows (or clustered key). Multiple nonclustered indexes can exist per table.

### Syntax

```sql
CREATE NONCLUSTERED INDEX ix_name
ON schema.table_name (key_col1, key_col2);
```

### Walkthrough

```sql
USE BikeStores;

CREATE NONCLUSTERED INDEX IX_parts_price_brand
ON production.parts (list_price, brand_id);
```

Test query:

```sql
SELECT
    part_id,
    part_name,
    list_price,
    brand_id
FROM
    production.parts
WHERE
    list_price BETWEEN 200 AND 500
    AND brand_id = 3;
```

### How it works

The optimizer can seek on leading key columns and then fetch matching rows quickly. Key column order matters for seek efficiency.

### Common mistakes

- Wrong column order for common predicates
- Creating many overlapping indexes
- Ignoring maintenance overhead on heavy-write tables
- Expecting index usage for non-sargable predicates

### Quick recap

- Nonclustered indexes target specific access patterns
- Column order impacts seek usability
- Keep index portfolio focused and non-redundant

### Next

[Unique and filtered indexes](#unique-and-filtered-indexes)


---

## Unique and Filtered Indexes

### Why this matters

Some columns must be unique; some query patterns target only a subset of rows. Unique and filtered indexes address both needs.

### Concept

- **Unique index** enforces uniqueness and can improve seeks
- **Filtered index** stores only rows matching a `WHERE` filter

### Syntax

```sql
CREATE UNIQUE NONCLUSTERED INDEX ix_unique
ON schema.table_name (col);
```

```sql
CREATE NONCLUSTERED INDEX ix_filtered
ON schema.table_name (col)
WHERE is_active = 1;
```

### Walkthrough

```sql
USE BikeStores;

CREATE UNIQUE NONCLUSTERED INDEX IX_parts_sku_unique
ON production.parts (sku);

CREATE NONCLUSTERED INDEX IX_parts_active_price
ON production.parts (list_price)
WHERE is_active = 1;
```

### How it works

Unique indexes reject duplicates at write time. Filtered indexes reduce index size and maintenance by indexing only relevant rows, often improving targeted query performance.

### Common mistakes

- Creating unique index on dirty data with duplicates
- Filter predicate not matching query predicate
- Assuming filtered index helps all queries
- Forgetting null behavior in unique indexes

### Quick recap

- Unique indexes enforce business uniqueness
- Filtered indexes are compact and workload-specific
- Align filters with real query patterns

### Next

[Included and computed columns](#included-and-computed-columns)


---

## Included and Computed Columns

### Why this matters

Covering indexes can remove key lookups, and computed columns can make complex expressions indexable.

### Concept

- `INCLUDE` adds non-key columns to leaf level only
- Computed columns can be indexed when deterministic and persisted (or otherwise indexable)

### Syntax

```sql
CREATE NONCLUSTERED INDEX ix_covering
ON schema.table_name (key_col)
INCLUDE (non_key_col1, non_key_col2);
```

```sql
ALTER TABLE schema.table_name
ADD computed_col AS (expression) PERSISTED;
```

### Walkthrough

```sql
USE BikeStores;

CREATE NONCLUSTERED INDEX IX_parts_brand_cover
ON production.parts (brand_id)
INCLUDE (part_name, list_price);

ALTER TABLE production.parts
ADD price_bucket AS (
    CASE
        WHEN list_price < 200 THEN 'Budget'
        WHEN list_price < 800 THEN 'Mid'
        ELSE 'Premium'
    END
) PERSISTED;

CREATE NONCLUSTERED INDEX IX_parts_price_bucket
ON production.parts (price_bucket);
```

### How it works

Included columns help satisfy `SELECT` lists without widening key columns. Indexed computed columns pre-store expression results for faster predicate/search operations.

### Common mistakes

- Adding too many included columns
- Indexing non-deterministic computed expressions
- Forgetting storage/write overhead
- Not validating whether lookups actually dropped

### Quick recap

- Use `INCLUDE` to build covering indexes
- Use computed columns for reusable, indexable expressions
- Measure gains using execution plans

### Next

[Index strategy](#index-strategy)


---

## Index Strategy

### Why this matters

Great indexing is not "add indexes everywhere." It is a deliberate strategy balancing read speed, write cost, storage, and maintenance.

### Concept

A practical strategy:

1. Capture slow queries and top workload patterns
2. Add high-value indexes for selective predicates/joins
3. Prefer consolidation over index sprawl
4. Monitor usage and remove dead/redundant indexes

### Syntax

```sql
-- View index usage stats (intro)
SELECT *
FROM sys.dm_db_index_usage_stats
WHERE database_id = DB_ID();
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    i.name AS index_name,
    OBJECT_NAME(i.object_id) AS table_name,
    i.type_desc
FROM
    sys.indexes AS i
WHERE
    i.object_id = OBJECT_ID('production.parts')
ORDER BY
    i.name;
```

Then review query plans for top `production.parts` filters and adjust indexes iteratively.

### How it works

Index strategy is workload-driven. You compare plan quality and resource use before and after changes, then keep only indexes with clear ongoing value.

### Common mistakes

- Chasing one query and harming overall workload
- Keeping obsolete indexes forever
- Ignoring fragmentation/statistics maintenance
- No testing under realistic data volume

### Quick recap

- Indexing is an iterative engineering process
- Optimize for whole workload, not one query
- Measure, validate, then keep or revert

### Next

Complete [Exercises](#exercises) to practice designing a balanced index set on `production.parts`.


---

## Exercises


Run `04-tutorial-extensions.sql` first to ensure `production.parts` exists.

---

#### Exercise 1 - Baseline query

Run a filtered query on `production.parts` by `brand_id` and `list_price`. Capture execution plan notes.

---

#### Exercise 2 - Clustered index

Create a clustered index on `part_id` and rerun a range query.

---

#### Exercise 3 - Nonclustered index

Create a nonclustered index on `(brand_id, list_price)` and compare plan behavior.

---

#### Exercise 4 - Unique and filtered

Create a unique index on `sku`, then create a filtered index on active parts by `list_price`.

---

#### Exercise 5 - Included columns

Create a covering nonclustered index for queries that filter by `brand_id` and return `part_name` + `list_price`.

---

#### Exercise 6 - Computed/index strategy ★

Add a persisted computed column for price band and index it. Then list all indexes on `production.parts` and identify one potentially redundant index.


---

## Solutions


## Chapter 10 - Solutions

> Assumes `production.parts` is available from `04-tutorial-extensions.sql`.

---

#### Exercise 1 - Solution

```sql
USE BikeStores;

SELECT
    part_id,
    part_name,
    brand_id,
    list_price
FROM
    production.parts
WHERE
    brand_id = 3
    AND list_price BETWEEN 200 AND 900
ORDER BY
    list_price;
```

---

#### Exercise 2 - Solution

```sql
USE BikeStores;

CREATE CLUSTERED INDEX IX_parts_part_id
ON production.parts (part_id);

SELECT
    part_id,
    part_name
FROM
    production.parts
WHERE
    part_id BETWEEN 50 AND 120;
```

---

#### Exercise 3 - Solution

```sql
USE BikeStores;

CREATE NONCLUSTERED INDEX IX_parts_brand_price
ON production.parts (brand_id, list_price);

SELECT
    part_id,
    part_name,
    list_price
FROM
    production.parts
WHERE
    brand_id = 2
    AND list_price > 300;
```

---

#### Exercise 4 - Solution

```sql
USE BikeStores;

CREATE UNIQUE NONCLUSTERED INDEX IX_parts_sku_unique
ON production.parts (sku);

CREATE NONCLUSTERED INDEX IX_parts_active_list_price
ON production.parts (list_price)
WHERE is_active = 1;
```

---

#### Exercise 5 - Solution

```sql
USE BikeStores;

CREATE NONCLUSTERED INDEX IX_parts_brand_covering
ON production.parts (brand_id)
INCLUDE (part_name, list_price);

SELECT
    part_name,
    list_price
FROM
    production.parts
WHERE
    brand_id = 4;
```

---

#### Exercise 6 - Solution

```sql
USE BikeStores;

ALTER TABLE production.parts
ADD price_band AS (
    CASE
        WHEN list_price < 200 THEN 'Budget'
        WHEN list_price < 800 THEN 'Mid'
        ELSE 'Premium'
    END
) PERSISTED;

CREATE NONCLUSTERED INDEX IX_parts_price_band
ON production.parts (price_band);

SELECT
    i.name,
    i.type_desc
FROM
    sys.indexes AS i
WHERE
    i.object_id = OBJECT_ID('production.parts')
ORDER BY
    i.name;
```

Potential redundancy example: if both `IX_parts_brand_price` and another index start with `brand_id` and serve the same query set, consolidate.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 11 - Stored Procedures.md](Chapter 11 - Stored Procedures.md)
