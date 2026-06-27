# Part 1 — SQL: The Language of Data (E-Learning)

A beginner-friendly SQL Server course built around the **BikeStores** sample database. Each chapter is a **single Markdown file** with lessons, examples, exercises, and solutions in one place.

## How to use this book

1. Start with [Chapter 01 - Environment Setup.md](Chapter%2001%20-%20Environment%20Setup.md)
2. Work through chapters in order (01 → 17)
3. Run the database scripts in [`assets/database/`](assets/database/) as noted in Chapter 01 and later chapters

## Database scripts

| Script | Purpose |
|--------|---------|
| [01-create-objects.sql](assets/database/01-create-objects.sql) | Create BikeStores tables |
| [02-load-data.sql](assets/database/02-load-data.sql) | Load sample data |
| [03-drop-objects.sql](assets/database/03-drop-objects.sql) | Reset tables |
| [04-tutorial-extensions.sql](assets/database/04-tutorial-extensions.sql) | Views and demo objects (Ch 4, 10, 13, 17) |

## Chapter index

| # | File | Topic |
|---|------|-------|
| 01 | [Chapter 01 - Environment Setup.md](Chapter%2001%20-%20Environment%20Setup.md) | Install SSMS, load BikeStores |
| 02 | [Chapter 02 - Querying and Filtering.md](Chapter%2002%20-%20Querying%20and%20Filtering.md) | SELECT, WHERE, ORDER BY, DISTINCT, TOP |
| 03 | [Chapter 03 - Joins.md](Chapter%2003%20-%20Joins.md) | INNER, OUTER, CROSS, self-joins |
| 04 | [Chapter 04 - Grouping and Aggregation.md](Chapter%2004%20-%20Grouping%20and%20Aggregation.md) | GROUP BY, HAVING, CUBE, ROLLUP |
| 05 | [Chapter 05 - Subqueries and Set Operators.md](Chapter%2005%20-%20Subqueries%20and%20Set%20Operators.md) | Subqueries, EXISTS, UNION |
| 06 | [Chapter 06 - CTEs and Pivot.md](Chapter%2006%20-%20CTEs%20and%20Pivot.md) | CTEs, recursive CTE, PIVOT |
| 07 | [Chapter 07 - Views.md](Chapter%2007%20-%20Views.md) | CREATE, manage, drop views |
| 08 | [Chapter 08 - Modifying Data.md](Chapter%2008%20-%20Modifying%20Data.md) | INSERT, UPDATE, DELETE, MERGE, transactions |
| 09 | [Chapter 09 - Schema Design.md](Chapter%2009%20-%20Schema%20Design.md) | DDL, types, constraints |
| 10 | [Chapter 10 - Indexes.md](Chapter%2010%20-%20Indexes.md) | Clustered and nonclustered indexes |
| 11 | [Chapter 11 - Stored Procedures.md](Chapter%2011%20-%20Stored%20Procedures.md) | Parameters, control flow, TRY/CATCH |
| 12 | [Chapter 12 - User-Defined Functions.md](Chapter%2012%20-%20User-Defined%20Functions.md) | Scalar and table-valued functions |
| 13 | [Chapter 13 - Triggers.md](Chapter%2013%20-%20Triggers.md) | DML and DDL triggers |
| 14 | [Chapter 14 - Aggregate Functions.md](Chapter%2014%20-%20Aggregate%20Functions.md) | AVG, COUNT, SUM, STRING_AGG |
| 15 | [Chapter 15 - Date and String Functions.md](Chapter%2015%20-%20Date%20and%20String%20Functions.md) | Date/time and string manipulation |
| 16 | [Chapter 16 - System Functions.md](Chapter%2016%20-%20System%20Functions.md) | CAST, CONVERT, TRY_*, IIF |
| 17 | [Chapter 17 - Window Functions.md](Chapter%2017%20-%20Window%20Functions.md) | ROW_NUMBER, LAG, LEAD, ranking |

## Planning documents

| Document | Purpose |
|----------|---------|
| [CURRICULUM-PLAN.md](CURRICULUM-PLAN.md) | Original chapter map (historical) |
| [STYLE-GUIDE.md](STYLE-GUIDE.md) | Writing standard |

## File structure

```
e-learning/
├── README.md
├── Chapter 01 - Environment Setup.md
├── Chapter 02 - Querying and Filtering.md
├── …
├── Chapter 17 - Window Functions.md
└── assets/
    ├── database/     # SQL scripts
    └── images/       # Diagrams (optional)
```

Each chapter file uses `#` for the chapter title, `##` for major sections (topics, exercises, solutions), and `###` / `####` for subsections.
