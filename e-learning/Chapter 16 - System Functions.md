# Chapter 16 - System Functions


Learn essential SQL Server system functions for safe conversions, null handling, conditional logic, and generating number/date series.

## Prerequisites

- [Chapter 15: Date and String Functions](Chapter 15 - Date and String Functions.md) completed
- [Chapter 09: Schema Design](Chapter 09 - Schema Design.md) completed
- **BikeStores** database loaded

## Learning goals

After this chapter, you will be able to:

- **Convert** values with `CAST` and `CONVERT`
- **Use** `TRY_CAST`, `TRY_CONVERT`, and `TRY_PARSE` for safer parsing
- **Handle** nulls and branch logic with `ISNULL`, `IIF`, and `CHOOSE`
- **Apply** practical date conversion recipes
- **Convert** text to date/time reliably
- **Generate** integer sequences with `GENERATE_SERIES`


## Time estimate

- **Reading:** about 75-90 minutes
- **Practice:** about 45 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `sales.orders`, `sales.order_items` |
| SQL Server version | 2022 (required for `GENERATE_SERIES`) |


---

## CAST and CONVERT

### Why this matters

Data arrives in mixed types, and reports often need formatted output. `CAST` and `CONVERT` are the core tools to transform values explicitly.

### Concept

- `CAST(expression AS type)` is ANSI standard.
- `CONVERT(type, expression, style)` is SQL Server-specific and supports formatting styles.

Explicit conversion is safer than implicit conversion guesses.

### Syntax

```sql
SELECT
    CAST(expression AS target_type),
    CONVERT(target_type, expression, style_code);
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    order_id,
    CAST(order_date AS DATETIME2) AS order_date_time,
    CONVERT(VARCHAR(10), order_date, 23) AS order_date_iso
FROM sales.orders;
```

#### Expected result

Shows converted date values in two different target formats.

### How it works

`CAST` changes data type directly, while `CONVERT` can also format output strings with style codes.

### Common mistakes

- Relying on implicit conversion in joins or filters.
- Converting to too-short string lengths.
- Using style codes without checking expected format.

### Quick recap

- Use explicit conversion for clarity and correctness.
- `CAST` is portable; `CONVERT` gives SQL Server style options.
- Keep conversions close to where they are needed.

### Next

[TRY_CAST, TRY_CONVERT, TRY_PARSE](#try_cast-try_convert-try_parse)


---

## TRY_CAST, TRY_CONVERT, TRY_PARSE

### Why this matters

Bad input values can break queries. TRY conversion functions return `NULL` instead of throwing an error, which makes cleanup queries safer.

### Concept

- `TRY_CAST`
- `TRY_CONVERT`
- `TRY_PARSE` (culture-aware string parsing)

These functions are useful when reading imported text data.

### Syntax

```sql
SELECT
    TRY_CAST(value AS INT),
    TRY_CONVERT(DATE, value),
    TRY_PARSE(value AS DATE USING 'en-US');
```

### Walkthrough

```sql
SELECT
    TRY_CAST('123' AS INT) AS ok_int,
    TRY_CAST('abc' AS INT) AS bad_int,
    TRY_CONVERT(DATE, '2026-06-27') AS ok_date,
    TRY_CONVERT(DATE, '99/99/2026') AS bad_date;
```

#### Expected result

Valid inputs return converted values; invalid ones return `NULL`.

### How it works

TRY functions trap conversion failures and return `NULL`, so the query continues instead of failing.

### Another example

Filter values that failed parsing:

```sql
SELECT v.raw_value
FROM (VALUES ('2026-01-01'), ('oops')) AS v(raw_value)
WHERE TRY_CONVERT(DATE, v.raw_value) IS NULL;
```

### Common mistakes

- Assuming TRY functions log errors automatically.
- Forgetting to handle returned `NULL`s.
- Using `TRY_PARSE` heavily in large datasets (it can be slower).

### Quick recap

- TRY conversion functions are safer for uncertain input.
- Invalid values become `NULL`.
- Add post-checks to separate valid and invalid rows.

### Next

[ISNULL, IIF, and CHOOSE](#isnull-iif-and-choose)


---

## ISNULL, IIF, and CHOOSE

### Why this matters

Reports need clean output when values are missing, and simple conditional labeling appears in almost every dashboard query.

### Concept

- `ISNULL(value, replacement)` handles nulls
- `IIF(condition, true_value, false_value)` short conditional
- `CHOOSE(index, value1, value2, ...)` selects by position

### Syntax

```sql
SELECT
    ISNULL(col, default_value),
    IIF(condition, a, b),
    CHOOSE(index, option1, option2, option3);
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    order_id,
    ISNULL(CONVERT(VARCHAR(10), shipped_date, 23), 'Not shipped') AS shipped_text,
    IIF(shipped_date IS NULL, 'Open', 'Closed') AS order_status,
    CHOOSE(order_status, 'Pending', 'Processing', 'Completed', 'Cancelled') AS status_label
FROM sales.orders;
```

#### Expected result

Returns readable status values even when `shipped_date` is null.

### How it works

`ISNULL` substitutes display text for nulls, `IIF` creates binary labels, and `CHOOSE` maps numeric status codes to text.

### Common mistakes

- Mixing incompatible data types in `IIF` branches.
- Using `ISNULL` when `COALESCE` would better fit multiple fallbacks.
- Supplying index 0 to `CHOOSE` (indexes start at 1).

### Quick recap

- `ISNULL` fills missing values.
- `IIF` is compact conditional logic.
- `CHOOSE` maps index positions to labels.

### Next

[Date conversion recipes](#date-conversion-recipes)


---

## Date Conversion Recipes

### Why this matters

You will often receive date strings in different formats and need a consistent output format for reports and exports.

### Concept

This lesson gives practical conversion recipes:

- Convert `DATE` to ISO text
- Parse `yyyymmdd` text to date
- Convert date/time to month label

### Syntax

```sql
CONVERT(VARCHAR(10), date_col, 23)
TRY_CONVERT(DATE, text_col, 112)
FORMAT(date_col, 'yyyy-MM')
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    order_id,
    CONVERT(VARCHAR(10), order_date, 23) AS iso_date,
    TRY_CONVERT(DATE, CONVERT(VARCHAR(8), order_date, 112), 112) AS parsed_back_date,
    FORMAT(order_date, 'yyyy-MM') AS year_month
FROM sales.orders;
```

#### Expected result

Shows each order date in multiple useful representations.

### How it works

Style `23` outputs ISO date. Style `112` outputs compact `yyyymmdd` text, which can be parsed back with `TRY_CONVERT`.

### Common mistakes

- Relying on local date formats for imports.
- Using `FORMAT` in very large queries without performance checks.
- Parsing text without validating shape first.

### Quick recap

- Prefer ISO date strings for consistency.
- Use style `112` for compact date text.
- Use TRY conversion when input may be invalid.

### Next

[String to datetime](#string-to-datetime)


---

## String to Datetime

### Why this matters

External files and manual input frequently provide datetime values as strings. You need reliable parsing rules to avoid wrong timestamps.

### Concept

Best practice:

1. Prefer ISO format (`YYYY-MM-DDThh:mm:ss`)
2. Use `TRY_CONVERT` / `TRY_CAST`
3. Validate null results after parsing

### Syntax

```sql
SELECT TRY_CONVERT(DATETIME2, string_value, style_code);
```

### Walkthrough

```sql
SELECT
    TRY_CONVERT(DATETIME2, '2026-06-27T16:45:00', 126) AS iso_datetime,
    TRY_CONVERT(DATETIME2, '2026-06-27 16:45:00', 120) AS style_120_datetime,
    TRY_CONVERT(DATETIME2, 'bad-value', 120) AS invalid_datetime;
```

#### Expected result

First two conversions succeed; invalid input returns `NULL`.

### How it works

Style code guides SQL Server parsing expectations. `TRY_CONVERT` prevents query failure and surfaces invalid values as nulls.

### Another example

Identify rows needing cleanup:

```sql
SELECT raw_text
FROM (VALUES ('2026-06-27 12:00:00'), ('missing')) AS t(raw_text)
WHERE TRY_CONVERT(DATETIME2, raw_text, 120) IS NULL;
```

### Common mistakes

- Mixing culture-specific formats in one column.
- Using plain `CONVERT` and crashing on first bad row.
- Ignoring timezone needs when systems are distributed.

### Quick recap

- Parse datetime strings with explicit style.
- Prefer TRY variants when data quality is uncertain.
- Filter null parse results for correction workflows.

### Next

[GENERATE_SERIES](#generate_series)


---

## GENERATE_SERIES

### Why this matters

You sometimes need a sequence of numbers or dates for analysis, even when no table has those values directly. SQL Server 2022 adds `GENERATE_SERIES` for this.

### Concept

`GENERATE_SERIES(start, stop, step)` returns rows of sequential values.

- Great for calendar spines and test data
- Works with integer-like ranges

### Syntax

```sql
SELECT value
FROM GENERATE_SERIES(start_value, stop_value, step_value);
```

### Walkthrough

Create day offsets and convert to dates.

```sql
USE BikeStores;

DECLARE @start_date DATE = '2026-01-01';

SELECT
    DATEADD(DAY, s.value, @start_date) AS generated_date
FROM GENERATE_SERIES(0, 14, 1) AS s
ORDER BY generated_date;
```

#### Expected result

Returns 15 consecutive dates starting at `2026-01-01`.

### How it works

`GENERATE_SERIES` outputs one column named `value`. `DATEADD` uses each value as day offset from `@start_date`.

### Another example

Generate discount buckets:

```sql
SELECT value AS percent_discount
FROM GENERATE_SERIES(0, 30, 5);
```

### Common mistakes

- Running on SQL Server version older than 2022.
- Using step value that never reaches stop condition.
- Forgetting alias when joining generated series.

### Quick recap

- `GENERATE_SERIES` creates sequence rows without helper tables.
- Useful with `DATEADD` for calendar generation.
- Available in SQL Server 2022+.

### Next

Complete [Exercises](#exercises), then continue to [Chapter 17: Window Functions](Chapter 17 - Window Functions.md).


---

## Exercises


Complete these after working through the topics above. ---

#### Exercise 1 - CAST and CONVERT (warm-up)

Return `order_date` as `DATETIME2` and as ISO text (`yyyy-mm-dd`) in the same query.

---

#### Exercise 2 - TRY conversion check (warm-up)

Using a `VALUES` list of mixed strings, return which values can be converted to `INT` with `TRY_CAST`.

---

#### Exercise 3 - Null handling (apply)

Return `order_id` and `shipped_date` text, replacing null with `Not shipped`.

**Tables:** `sales.orders`

---

#### Exercise 4 - Status label mapping (apply)

Use `IIF` and `CHOOSE` on `sales.orders.order_status` to produce readable status columns.

---

#### Exercise 5 - String to datetime (apply)

Convert sample datetime strings with `TRY_CONVERT`; flag invalid strings.

---

#### Exercise 6 - Date spine (stretch) ★

Use `GENERATE_SERIES` and `DATEADD` to return 10 dates starting from `2026-07-01`.


---

## Solutions


## Chapter 16 - Solutions

---

#### Exercise 1 - Solution

```sql
USE BikeStores;

SELECT
    order_id,
    CAST(order_date AS DATETIME2) AS order_dt2,
    CONVERT(VARCHAR(10), order_date, 23) AS order_date_iso
FROM sales.orders;
```

Demonstrates both core conversion styles.

---

#### Exercise 2 - Solution

```sql
SELECT
    raw_value,
    TRY_CAST(raw_value AS INT) AS as_int
FROM (VALUES ('12'), ('x9'), ('200')) AS v(raw_value);
```

Invalid values return `NULL`.

---

#### Exercise 3 - Solution

```sql
SELECT
    order_id,
    ISNULL(CONVERT(VARCHAR(10), shipped_date, 23), 'Not shipped') AS shipped_text
FROM sales.orders;
```

Replaces null shipped dates for cleaner output.

---

#### Exercise 4 - Solution

```sql
SELECT
    order_id,
    IIF(order_status IN (3, 4), 'Closed', 'Open') AS open_closed,
    CHOOSE(order_status, 'Pending', 'Processing', 'Rejected', 'Completed') AS status_label
FROM sales.orders;
```

Uses conditional functions for readable status text.

---

#### Exercise 5 - Solution

```sql
SELECT
    raw_text,
    TRY_CONVERT(DATETIME2, raw_text, 120) AS parsed_dt,
    IIF(TRY_CONVERT(DATETIME2, raw_text, 120) IS NULL, 'Invalid', 'Valid') AS parse_status
FROM (VALUES
    ('2026-07-01 10:00:00'),
    ('bad input')
) AS t(raw_text);
```

Parses valid datetime text and flags bad rows.

---

#### Exercise 6 - Solution

```sql
DECLARE @start_date DATE = '2026-07-01';

SELECT
    DATEADD(DAY, s.value, @start_date) AS generated_date
FROM GENERATE_SERIES(0, 9, 1) AS s
ORDER BY generated_date;
```

Builds a 10-day date series from a fixed start date.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 17 - Window Functions.md](Chapter 17 - Window Functions.md)
