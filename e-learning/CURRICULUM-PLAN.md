# Part 1 — SQL: The Language of Data
## E-Learning Curriculum Plan (Phase 2)

> **Status:** Implemented — 17 single-file chapters under `e-learning/`.  
> **Created from:** Phase 1 repository analysis (40 source Markdown files).  
> **Target platform:** SQL Server 2022 Developer Edition + SSMS.

---

## Design Principles

1. **One topic per chapter** — split the 10,370-line `SQL Server Basics.md` monolith into teachable units.
2. **BikeStores throughout** — one sample database, consistent examples, progressive complexity.
3. **Learn → Practice → Check** — every chapter ends with exercises and a short recap (content TBD in Phase 3).
4. **Bundled assets** — SQL scripts and diagrams live under `assets/` (scripts added in a later phase, not copied from source yet).
5. **No scrape artifacts** — rewrite in original voice; proper Markdown headings and fenced `sql` blocks.
6. **Explicit dependencies** — each chapter lists prerequisites and defers objects (e.g. views) until they are created.

---

## Repository Layout

```
e-learning/
├── README.md
├── CURRICULUM-PLAN.md
├── STYLE-GUIDE.md
├── Chapter 01 - Environment Setup.md
├── Chapter 02 - Querying and Filtering.md
├── …
├── Chapter 17 - Window Functions.md
└── assets/
    ├── database/                      # BikeStores DDL/DML + tutorial extensions
    └── images/                        # Diagrams, ER model, SSMS screenshots
```

Each chapter is **one Markdown file**. Topics use `##` headings inside the file; exercises and solutions are `## Exercises` and `## Solutions` in the same file. There are no per-chapter subfolders or subtopic files.

---

## Chapter Map — Complete Plan

### Chapter 01 — Environment Setup

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-01-environment-setup/` |
| **Source chapter(s)** | `Chapter 01 - Getting Started/` (all subfolders + `Setup.md`, `SQL Server Tutorial.md`, `Getting Started with SQL Server.md`) |
| **Learning goal** | Install SQL Server 2022 Developer Edition and SSMS, connect to a local instance, understand SQL Server architecture at a high level, and load the BikeStores sample database. |
| **Estimated scope** | **4 lessons**, ~45–60 min read + 30 min hands-on setup |
| **Lessons (planned)** | 1) What is SQL Server? 2) Install & connect (SSMS) 3) BikeStores schema overview 4) Load sample data |
| **Examples to reuse** | `SELECT @@version;` — first query; BikeStores ER overview; all nine base tables (`sales.*`, `production.*`) |
| **Source files referenced** | `What is SQL Server/What is SQL Server.md`, `SQL Server Architecture/*.md`, `SQL Server Editions/SQL Server Editions.md`, `SQL Server Services and Tools/SQL Server Services and Tools.md`, `Install SQL Server/**/*.md`, `Connect to the SQL Server/**/*.md`, `SQL Server Sample Database/SQL Server Sample Database.md`, `Database Tables/**/*.md`, `Load Sample Database/**/*.md`, `Setup.md` (consolidated reference only — deduplicate on rewrite) |
| **Assets to reference** | `assets/database/01-create-objects.sql`, `02-load-data.sql` (future); `assets/images/` for architecture diagram & SSMS walkthrough |
| **Exercises (planned)** | Connect to server; run version query; list tables in BikeStores; describe one table with `sp_help` or SSMS |

---

### Chapter 02 — SELECT and Filter

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-02-select-and-filter/` |
| **Source chapter(s)** | `Chapter 02 - SQL Server Foundations/SQL Server Basics.md` (Sections: SELECT, ORDER BY, OFFSET/FETCH, TOP, DISTINCT, WHERE, AND/OR/IN/BETWEEN/LIKE, aliases) |
| **Learning goal** | Retrieve data from a single table using `SELECT`, filter rows with `WHERE`, sort with `ORDER BY`, and limit results with `TOP` / `OFFSET-FETCH`. |
| **Estimated scope** | **6 lessons**, ~90 min + exercises |
| **Lessons (planned)** | 1) SELECT basics 2) WHERE & operators 3) ORDER BY 4) DISTINCT 5) TOP & pagination 6) Column & table aliases |
| **Examples to reuse** | `sales.customers` — names, emails, cities; `production.products` — list price, TOP 10 expensive products; duplicate-city DISTINCT demo; `LEN(first_name)` in ORDER BY |
| **Source files referenced** | `Chapter 02/.../SQL Server Basics.md` (~lines 86–1690: SELECT through aliases) |
| **Assets to reference** | BikeStores base tables only |
| **Exercises (planned)** | Filter customers by state; top 5 products by price; paginated product list |

---

### Chapter 03 — Joins

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-03-joins/` |
| **Source chapter(s)** | `Chapter 02/.../SQL Server Basics.md` (JOIN section) |
| **Learning goal** | Combine rows from multiple tables using `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN`, and `CROSS JOIN`; understand join conditions and when to use each type. |
| **Estimated scope** | **5 lessons**, ~75 min + exercises |
| **Lessons (planned)** | 1) Why joins 2) INNER JOIN 3) OUTER JOINs 4) CROSS JOIN 5) Self-join & multi-table patterns |
| **Examples to reuse** | `production.products` ⋈ `production.brands`; `production.products` ⋈ `production.categories`; `sales.orders` ⋈ `sales.customers` ⋈ `sales.staffs`; staff manager hierarchy (self-join on `sales.staffs`) |
| **Source files referenced** | `Chapter 02/.../SQL Server Basics.md` (~lines 1690–2670: joins) |
| **Assets to reference** | BikeStores base tables |
| **Exercises (planned)** | Product catalog with brand + category; orders with customer name; staff with store name |

---

### Chapter 04 — Grouping and Aggregation Intro

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-04-grouping-and-aggregation/` |
| **Source chapter(s)** | `Chapter 02/.../SQL Server Basics.md` (GROUP BY, HAVING, GROUPING SETS, CUBE, ROLLUP); light overlap with `Chapter 06` intro concepts |
| **Learning goal** | Summarize data with `GROUP BY` and `HAVING`; understand grouping vs. filtering; introduce advanced grouping with `GROUPING SETS`, `CUBE`, and `ROLLUP`. |
| **Estimated scope** | **5 lessons**, ~80 min + exercises |
| **Lessons (planned)** | 1) GROUP BY basics 2) GROUP BY + aggregates 3) HAVING 4) GROUPING SETS 5) CUBE & ROLLUP |
| **Examples to reuse** | Count products per category; avg list price per brand with `HAVING`; `sales.sales_summary` table (create in `assets/database/04-tutorial-extensions.sql`); brand/category sales rollups |
| **Source files referenced** | `Chapter 02/.../SQL Server Basics.md` (~lines 2671–3400: GROUP BY through CUBE/ROLLUP) |
| **Assets to reference** | `04-tutorial-extensions.sql` — `sales.sales_summary` DDL + seed |
| **Exercises (planned)** | Revenue per store; categories with more than N products; CUBE report by brand and category |

---

### Chapter 05 — Subqueries and Set Operators

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-05-subqueries-and-set-operators/` |
| **Source chapter(s)** | `Chapter 02/.../SQL Server Basics.md` (Section 7 Subquery, Section 8 Set Operators) |
| **Learning goal** | Nest queries inside other statements; use correlated subqueries, `EXISTS`, `ANY`/`ALL`, `APPLY`; combine result sets with `UNION`, `INTERSECT`, and `EXCEPT`. |
| **Estimated scope** | **6 lessons**, ~90 min + exercises |
| **Lessons (planned)** | 1) Subquery types 2) Correlated subqueries 3) EXISTS / ANY / ALL 4) CROSS & OUTER APPLY 5) UNION / INTERSECT / EXCEPT 6) When to prefer JOIN vs subquery |
| **Examples to reuse** | Products above average price; customers with orders; `EXISTS` for order history; `UNION` of product name lists |
| **Source files referenced** | `Chapter 02/.../SQL Server Basics.md` (~lines 1–12 TOC + ~3400–4770: subqueries through set operators) |
| **Assets to reference** | BikeStores base tables |
| **Exercises (planned)** | Brands with no products (`NOT EXISTS`); combine two queries with `UNION` |

---

### Chapter 06 — CTEs and Pivot

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-06-ctes-and-pivot/` |
| **Source chapter(s)** | `Chapter 02/.../SQL Server Basics.md` (Section 9 CTE, Section 10 Pivot) |
| **Learning goal** | Write readable multi-step queries with common table expressions (CTEs), including recursive CTEs for hierarchies; reshape data with `PIVOT`. |
| **Estimated scope** | **4 lessons**, ~60 min + exercises |
| **Lessons (planned)** | 1) Non-recursive CTE 2) Recursive CTE (staff hierarchy) 3) CTE vs subquery 4) PIVOT |
| **Examples to reuse** | Staff org chart via `sales.staffs.manager_id`; sales pivot by year/month; duplicate-finding pattern with `ROW_NUMBER()` CTE (preview for Ch 17) |
| **Source files referenced** | `Chapter 02/.../SQL Server Basics.md` (~lines 4770–5250: CTE & PIVOT) |
| **Assets to reference** | BikeStores base tables |
| **Exercises (planned)** | Recursive staff tree; pivot product counts by category |

---

### Chapter 07 — Views

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-07-views/` |
| **Source chapter(s)** | `Chapter 05 - Views/SQL Server Views.md` |
| **Learning goal** | Create, query, rename, list, inspect, and drop views; understand security and simplicity benefits; introduce indexed views. |
| **Estimated scope** | **5 lessons**, ~60 min + exercises |
| **Lessons (planned)** | 1) What is a view? 2) CREATE VIEW 3) Manage views (rename, list, metadata) 4) DROP VIEW 5) Indexed views (conceptual) |
| **Examples to reuse** | `sales.product_info` — products + brands join; pattern reused later by window-function chapters |
| **Source files referenced** | `Chapter 05 - Views/SQL Server Views.md` (full file, 538 lines) |
| **Assets to reference** | `04-tutorial-extensions.sql` — optional starter views |
| **Exercises (planned)** | Create customer summary view; query `INFORMATION_SCHEMA.VIEWS` |

---

### Chapter 08 — Modifying Data

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-08-modifying-data/` |
| **Source chapter(s)** | `Chapter 02/.../SQL Server Basics.md` (Section 11 Modifying data) |
| **Learning goal** | Insert, update, and delete rows; use `INSERT...SELECT`, `UPDATE` with JOIN, `MERGE`, and explicit transactions (`BEGIN` / `COMMIT` / `ROLLBACK`). |
| **Estimated scope** | **6 lessons**, ~75 min + exercises (use dev DB or rollback exercises) |
| **Lessons (planned)** | 1) INSERT 2) INSERT multiple / INSERT-SELECT 3) UPDATE & UPDATE JOIN 4) DELETE 5) MERGE 6) Transactions |
| **Examples to reuse** | Insert new `production.categories` row; update product prices; `MERGE` sync pattern; transaction rollback demo |
| **Source files referenced** | `Chapter 02/.../SQL Server Basics.md` (~lines 5250–5980: INSERT through transactions) |
| **Assets to reference** | BikeStores + sandbox schema or `BEGIN TRAN` exercise scripts |
| **Exercises (planned)** | Add customer; update order status; safe delete with transaction rollback |

---

### Chapter 09 — Schema Design

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-09-schema-design/` |
| **Source chapter(s)** | `Chapter 02/.../SQL Server Basics.md` (Sections 12–16: DDL, data types, constraints, expressions, useful tips) |
| **Learning goal** | Create databases, schemas, and tables; use identity columns, sequences, computed columns, and constraints; apply `CASE`, `COALESCE`, and `NULLIF`; find and remove duplicates. |
| **Estimated scope** | **8 lessons**, ~100 min + exercises |
| **Lessons (planned)** | 1) CREATE DATABASE & schema 2) CREATE / ALTER / DROP TABLE 3) Identity & sequences 4) Data types overview 5) Constraints (PK, FK, UNIQUE, CHECK, NOT NULL) 6) Expressions (CASE, COALESCE, NULLIF) 7) Temp tables & synonyms 8) Find & delete duplicates |
| **Examples to reuse** | BikeStores DDL from Ch01 table docs; `production.parts`-style table; duplicate email check on `sales.customers`; `ROW_NUMBER()` duplicate removal |
| **Source files referenced** | `Chapter 02/.../SQL Server Basics.md` (~lines 5980–10370: DDL through useful tips); `Chapter 01/.../Database Tables/**/*.md` (DDL reference) |
| **Assets to reference** | `01-create-objects.sql` (canonical DDL); `04-tutorial-extensions.sql` |
| **Exercises (planned)** | Design a `reviews` table with FK to `products`; add CHECK constraint; dedupe exercise |

---

### Chapter 10 — Indexes

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-10-indexes/` |
| **Source chapter(s)** | `Chapter 11 - Data Modification & Schema Design/Indexes/SQL Server Indexes.md` |
| **Learning goal** | Understand clustered vs nonclustered indexes; create, rename, disable, enable, and drop indexes; use unique, filtered, and included-column indexes; read execution plans at intro level. |
| **Estimated scope** | **6 lessons**, ~80 min + exercises |
| **Lessons (planned)** | 1) Index concepts & heaps 2) Clustered indexes 3) Nonclustered indexes 4) Unique & filtered indexes 5) Included columns & computed-column indexes 6) Index strategy basics |
| **Examples to reuse** | `production.parts` heap vs clustered; unique index on `sales.customers.email`; `SUBSTRING(email,...)` computed column index |
| **Source files referenced** | `Chapter 11/.../Indexes/SQL Server Indexes.md` (848 lines) |
| **Assets to reference** | `04-tutorial-extensions.sql` — `production.parts`, `production.part_prices` |
| **Exercises (planned)** | Create NC index on `products.list_price`; compare estimated plan before/after |

---

### Chapter 11 — Stored Procedures

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-11-stored-procedures/` |
| **Source chapter(s)** | `Chapter 12 - Stored Procedures/SQL Server Stored Procedures.md` |
| **Learning goal** | Create, execute, alter, and drop stored procedures; use parameters, variables, output parameters, control-of-flow, cursors (awareness), `TRY/CATCH`, and introductory dynamic SQL. |
| **Estimated scope** | **8 lessons**, ~100 min + exercises |
| **Lessons (planned)** | 1) SP basics (`uspProductList`) 2) Parameters 3) Variables 4) Output parameters 5) IF/WHILE/BREAK/CONTINUE 6) Cursors (when to avoid) 7) TRY/CATCH & transactions in SPs 8) Dynamic SQL intro |
| **Examples to reuse** | `uspProductList` on `production.products`; error handling with `XACT_STATE()`; `RAISERROR` / `THROW` |
| **Source files referenced** | `Chapter 12 - Stored Procedures/SQL Server Stored Procedures.md` (1,825 lines) |
| **Assets to reference** | BikeStores + `04-tutorial-extensions.sql` for SP objects |
| **Exercises (planned)** | SP to list orders by customer; SP with output parameter for row count |

---

### Chapter 12 — User-Defined Functions

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-12-user-defined-functions/` |
| **Source chapter(s)** | `Chapter 13 - User-defined Functions/SQL Server User-defined Functions.md` |
| **Learning goal** | Build scalar-valued and table-valued functions; use table variables as return types; know limitations (no data modification in scalars). |
| **Estimated scope** | **4 lessons**, ~50 min + exercises |
| **Lessons (planned)** | 1) Scalar functions (`sales.udfNetSale`) 2) Table variables 3) Inline & multi-statement TVFs 4) DROP FUNCTION |
| **Examples to reuse** | `sales.udfNetSale(quantity, list_price, discount)` on `sales.order_items`; order net amount aggregation |
| **Source files referenced** | `Chapter 13 - User-defined Functions/SQL Server User-defined Functions.md` (533 lines) |
| **Assets to reference** | `04-tutorial-extensions.sql` — UDF definitions |
| **Exercises (planned)** | Scalar function for full name; TVF returning products by brand |

---

### Chapter 13 — Triggers

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-13-triggers/` |
| **Source chapter(s)** | `Chapter 14 - Triggers/SQL Server Triggers.md` |
| **Learning goal** | Create DML triggers (`AFTER`, `INSTEAD OF`), DDL triggers, and manage trigger state; use `inserted` / `deleted` virtual tables. |
| **Estimated scope** | **5 lessons**, ~60 min + exercises |
| **Lessons (planned)** | 1) DML trigger basics 2) INSERTED/DELETED 3) INSTEAD OF triggers 4) DDL triggers 5) Enable / disable / drop |
| **Examples to reuse** | `production.product_audits` audit table; `production.trg_product_audit` on `production.products` |
| **Source files referenced** | `Chapter 14 - Triggers/SQL Server Triggers.md` (688 lines) |
| **Assets to reference** | `04-tutorial-extensions.sql` — audit table + trigger |
| **Exercises (planned)** | Audit trigger for price changes; DDL trigger logging `CREATE TABLE` |

---

### Chapter 14 — Aggregate Functions

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-14-aggregate-functions/` |
| **Source chapter(s)** | `Chapter 06 - Aggregation/SQL Server Aggregate Functions.md` |
| **Learning goal** | Use `AVG`, `COUNT`, `SUM`, `MIN`, `MAX`, `STDEV`, `VAR`, `CHECKSUM_AGG`, and `STRING_AGG` with `GROUP BY` / `HAVING`; understand DISTINCT aggregates and conditional patterns (`COUNT IF`, `SUM IF`). |
| **Estimated scope** | **7 lessons**, ~90 min + exercises |
| **Lessons (planned)** | 1) Aggregate overview 2) AVG, COUNT, SUM 3) MIN, MAX 4) STDEV & VAR 5) DISTINCT & conditional aggregates 6) STRING_AGG 7) CHECKSUM_AGG (optional) |
| **Examples to reuse** | `production.products.list_price` — AVG with ROUND/CAST; count products > 500; brand-level `HAVING`; **new content** for `STRING_AGG`, `STDEVP`, `VARP` (missing in source) |
| **Source files referenced** | `Chapter 06 - Aggregation/SQL Server Aggregate Functions.md` (2,146 lines) |
| **Assets to reference** | BikeStores base tables |
| **Exercises (planned)** | Average order line total; string of product names per brand (`STRING_AGG`) |

> **Note:** Placed after Ch 04 intentionally — Ch 04 teaches *grouping logic*; Ch 14 deep-dives *each aggregate function*. Cross-link both chapters.

---

### Chapter 15 — Date and String Functions

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-15-date-and-string-functions/` |
| **Source chapter(s)** | **No dedicated source file** — referenced in `Setup.md` / `Getting Started with SQL Server.md` but never written; scattered usage in Ch 02 (`LEN`, `CONCAT`), Ch 09 (`CONCAT_WS`), Ch 11 (`SUBSTRING`) |
| **Learning goal** | Format, parse, and manipulate dates (`GETDATE`, `DATEADD`, `DATEDIFF`, `DATETIME2`, `FORMAT`) and strings (`LEN`, `SUBSTRING`, `REPLACE`, `TRIM`, `CONCAT`, `CONCAT_WS`, `CHARINDEX`). |
| **Estimated scope** | **6 lessons**, ~75 min + exercises (**mostly new writing**) |
| **Lessons (planned)** | 1) Date/time types 2) Current date & arithmetic 3) Formatting & parsing 4) String extraction & length 5) Concatenation & search 6) Combining functions in queries |
| **Examples to reuse** | `sales.orders.order_date`, `required_date`, `shipped_date`; customer name building from `sales.customers`; email domain extraction (`SUBSTRING` + `CHARINDEX`) |
| **Source files referenced** | `Chapter 01/.../Setup.md` (TOC only); `Chapter 02/.../SQL Server Basics.md` (scattered `LEN`); `Chapter 11/.../SQL Server Indexes.md` (`SUBSTRING` on email) |
| **Assets to reference** | BikeStores `sales.orders` date columns |
| **Exercises (planned)** | Days between order and ship; format dates for report; parse and clean phone numbers |

---

### Chapter 16 — System Functions

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-16-system-functions/` |
| **Source chapter(s)** | `Chapter 15 - Built-in Functions/System Functions/SQL Server System Functions.md` |
| **Learning goal** | Convert types safely with `CAST`, `CONVERT`, `TRY_CAST`, `TRY_CONVERT`, `TRY_PARSE`; use `ISNULL`, `IIF`, `CHOOSE`, `ISNUMERIC`, and `GENERATE_SERIES`. |
| **Estimated scope** | **6 lessons**, ~75 min + exercises |
| **Lessons (planned)** | 1) CAST & CONVERT 2) TRY_* safe conversion 3) ISNULL & NULL handling 4) IIF & CHOOSE 5) Date/string conversion recipes 6) GENERATE_SERIES |
| **Examples to reuse** | Implicit vs explicit conversion; `sales.order_items` joins with type casts; date series generation with `GENERATE_SERIES` |
| **Source files referenced** | `Chapter 15/.../System Functions/SQL Server System Functions.md` (1,372 lines) — **dedupe** duplicate string-to-datetime section on rewrite |
| **Assets to reference** | BikeStores tables |
| **Exercises (planned)** | Safe cast of user input; `IIF` for discount tier; generate date spine |

---

### Chapter 17 — Window Functions

| Field | Detail |
|-------|--------|
| **Folder** | `chapter-17-window-functions/` |
| **Source chapter(s)** | `Chapter 09 - Window Functions/SQL Server Window Functions.md` |
| **Learning goal** | Rank, offset, and aggregate over partitions without collapsing rows — `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `NTILE`, `LAG`, `LEAD`, `FIRST_VALUE`, `LAST_VALUE`, `CUME_DIST`, `PERCENT_RANK`. |
| **Estimated scope** | **6 lessons**, ~90 min + exercises |
| **Lessons (planned)** | 1) Window function concepts 2) Ranking functions 3) LAG & LEAD 4) FIRST_VALUE & LAST_VALUE 5) CUME_DIST & PERCENT_RANK 6) NTILE & practical reporting |
| **Examples to reuse** | `sales.vw_staff_sales` + `sales.staffs` — **create view in Lesson 1 before use**; `sales.vw_category_sales_volume`; `sales.vw_netsales_brands`; top 20% sales staff by `CUME_DIST` |
| **Source files referenced** | `Chapter 09 - Window Functions/SQL Server Window Functions.md` (1,327 lines) — **remove duplicate LEAD section** on rewrite |
| **Assets to reference** | `04-tutorial-extensions.sql` — all window-function views defined *before* chapter content references them |
| **Exercises (planned)** | Running total of monthly sales; rank products by price within category |

---

## Source → E-Learning Mapping (Quick Reference)

| E-Learning Chapter | Primary Source | Secondary Source |
|--------------------|----------------|------------------|
| 01 Environment | Ch 01 (all) | — |
| 02 SELECT & Filter | Ch 02 (part 1) | — |
| 03 Joins | Ch 02 (part 2) | — |
| 04 Grouping | Ch 02 (part 3) | Ch 06 (concepts) |
| 05 Subqueries | Ch 02 (part 4) | — |
| 06 CTEs & Pivot | Ch 02 (part 5) | — |
| 07 Views | Ch 05 | — |
| 08 Modifying Data | Ch 02 (part 6) | — |
| 09 Schema Design | Ch 02 (part 7) | Ch 01 table DDL docs |
| 10 Indexes | Ch 11 | — |
| 11 Stored Procedures | Ch 12 | — |
| 12 UDFs | Ch 13 | — |
| 13 Triggers | Ch 14 | — |
| 14 Aggregate Functions | Ch 06 | Ch 02 (GROUP BY) |
| 15 Date & String | **New** | Ch 02, 11 (fragments) |
| 16 System Functions | Ch 15 | — |
| 17 Window Functions | Ch 09 | Ch 07 (views) |

---

## Recommended Learning Path

```
01 Setup → 02 SELECT → 03 JOINs → 04 GROUP BY → 05 Subqueries
    → 06 CTEs → 07 Views → 08 DML → 09 DDL → 10 Indexes
    → 11 SPs → 12 UDFs → 13 Triggers
    → 14 Aggregates (deep dive) → 15 Date/String → 16 System → 17 Window
```

**Optional reorder:** Move **14 Aggregate Functions** immediately after **04 Grouping** if you prefer function reference before advanced grouping (CUBE/ROLLUP stays in Ch 04).

---

## Assets Plan (Not Copied Yet)

| File | Purpose | First used in |
|------|---------|---------------|
| `assets/database/01-create-objects.sql` | BikeStores schemas + 9 tables | Ch 01 |
| `assets/database/02-load-data.sql` | Seed data | Ch 01 |
| `assets/database/03-drop-objects.sql` | Reset script | Ch 01 |
| `assets/database/04-tutorial-extensions.sql` | `sales_summary`, `parts`, audit tables, tutorial views (`vw_staff_sales`, etc.) | Ch 04, 10, 13, 17 |
| `assets/images/er-bikestores.png` | ER diagram | Ch 01 |
| `assets/images/ssms-*.png` | Install/connect screenshots | Ch 01 |

Scripts will be sourced from the external BikeStores zip (documented in source repo) during Phase 3 — **not copied in Phase 2**.

---

## What Phase 3 Will Do (After Approval)

1. Write `e-learning/README.md` course landing page.
2. Populate `assets/database/` scripts.
3. Author chapter `README.md` + `lessons/*.md` + `exercises/*.md` one chapter at a time.
4. Rewrite content (no scrape artifacts, proper Markdown).
5. Add cross-links and prerequisite chains.

---

## Open Decisions for Your Approval

1. **17 chapters** vs compressing (e.g. merge 15+16 into one "Built-in Functions" chapter)?
2. **Chapter 14 placement** — after Ch 04 (functions first) or after Ch 13 (current plan: deep dive before date/string)?
3. **Solutions visibility** — include `exercises/solutions.md` in repo or separate instructor pack?
4. **SQL dialect note** — SQL Server 2022 only, or add callouts for Azure SQL / older versions?

---

*End of curriculum plan — awaiting approval before Phase 3 content writing.*
