# Chapter 15 - Date and String Functions


Learn practical date/time and text functions so you can clean values, compute time gaps, and format report-ready output.

## Prerequisites

- [Chapter 14: Aggregate Functions](Chapter 14 - Aggregate Functions.md) completed
- [Chapter 02: SELECT and Filter](Chapter 02 - Querying and Filtering.md) completed
- **BikeStores** database loaded

## Learning goals

After this chapter, you will be able to:

- **Identify** SQL Server date and time data types
- **Calculate** date differences and date offsets
- **Format** and parse date text safely
- **Extract** and measure text with string functions
- **Combine** date and string functions in real queries


## Time estimate

- **Reading:** about 75 minutes
- **Practice:** about 45 minutes

## What you'll need

| Item | Notes |
|------|-------|
| Database | `BikeStores` |
| Main tables | `sales.orders`, `sales.customers` |
| Key columns | `order_date`, `required_date`, `shipped_date`, `email` |


---

## Date and Time Data Types

### Why this matters

Correct data types prevent bad data and simplify calculations. If dates are stored as text, filtering and reporting become unreliable.

### Concept

Common SQL Server date/time types:

- `DATE` (calendar date only)
- `TIME` (time only)
- `DATETIME` (date + time, legacy precision)
- `DATETIME2` (recommended modern date + time)

BikeStores order tables already use date columns you will query throughout this chapter.

### Syntax

```sql
DECLARE @d  DATE = '2026-06-27';
DECLARE @dt DATETIME2 = '2026-06-27 14:30:00';
```

### Walkthrough

Inspect order date columns.

```sql
USE BikeStores;

SELECT
    TOP 10
    order_id,
    order_date,
    required_date,
    shipped_date
FROM sales.orders
ORDER BY order_date DESC;
```

#### Expected result

Shows date values from real order records.

### How it works

SQL Server stores these values in typed date columns, so comparisons and functions such as `DATEDIFF` work consistently.

### Common mistakes

- Storing dates in `VARCHAR`.
- Mixing `MM/DD/YYYY` and `DD/MM/YYYY` text formats.
- Using `DATETIME` by habit when `DATETIME2` is better.

### Quick recap

- Choose date/time types based on required precision.
- Typed date columns are safer than string dates.
- BikeStores order dates are ready for date-function practice.

### Next

[Date arithmetic](#date-arithmetic)


---

## Date Arithmetic

### Why this matters

Scheduling and SLA analysis depend on date math: days to ship, due dates, overdue intervals, and reporting windows.

### Concept

Core functions:

- `DATEADD(part, value, date)` shifts a date
- `DATEDIFF(part, start, end)` returns interval count
- `EOMONTH(date)` gives month end date

### Syntax

```sql
SELECT
    DATEADD(DAY, 7, @start_date),
    DATEDIFF(DAY, @start_date, @end_date);
```

### Walkthrough

Calculate shipping delay for each order.

```sql
USE BikeStores;

SELECT
    order_id,
    order_date,
    shipped_date,
    DATEDIFF(DAY, order_date, shipped_date) AS days_to_ship
FROM sales.orders
WHERE shipped_date IS NOT NULL
ORDER BY days_to_ship DESC;
```

#### Expected result

Returns one row per shipped order with shipping interval in days.

### How it works

`DATEDIFF` counts day boundaries crossed between `order_date` and `shipped_date`. Orders with null `shipped_date` are excluded because they are not shipped yet.

### Another example

Compute required date plus grace period:

```sql
SELECT
    order_id,
    required_date,
    DATEADD(DAY, 3, required_date) AS grace_deadline
FROM sales.orders;
```

### Common mistakes

- Reversing start and end arguments in `DATEDIFF`.
- Ignoring null dates.
- Assuming `DATEDIFF(MONTH, ...)` means exact days/30.

### Quick recap

- `DATEADD` shifts dates.
- `DATEDIFF` measures intervals.
- Use date arithmetic for logistics and timeline reports.

### Next

[Format and parse dates](#format-and-parse-dates)


---

## Format and Parse Dates

### Why this matters

Data often arrives as text, but reports need consistent date formats. You must convert text safely and present dates clearly.

### Concept

Useful approaches:

- `CONVERT` for style-based date formatting/parsing
- `TRY_CONVERT` for safe parsing (returns `NULL` on failure)
- `FORMAT` for flexible display (slower, reporting use)

### Syntax

```sql
SELECT
    CONVERT(VARCHAR(10), GETDATE(), 23) AS iso_date,
    TRY_CONVERT(DATE, '2026-06-27') AS parsed_date;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    order_id,
    order_date,
    CONVERT(VARCHAR(10), order_date, 23) AS order_date_iso,
    CONVERT(VARCHAR(11), order_date, 106) AS order_date_text
FROM sales.orders;
```

#### Expected result

Each order shows original date and two formatted text versions.

### How it works

`CONVERT` style `23` produces `yyyy-mm-dd`. Style `106` gives text month format. These are string outputs for display, not storage.

### Another example

Safe parsing from text:

```sql
SELECT
    TRY_CONVERT(DATE, '2026-07-01') AS valid_date,
    TRY_CONVERT(DATE, '31/31/2026') AS invalid_date;
```

Second value returns `NULL`.

### Common mistakes

- Storing formatted strings instead of date types.
- Using `FORMAT` in large result sets where speed matters.
- Parsing ambiguous date strings without style/context.

### Quick recap

- `CONVERT` is practical for date display.
- `TRY_CONVERT` protects from parse failures.
- Keep real data typed as date/time.

### Next

[String extract and length](#string-extract-and-length)


---

## String Extract and Length

### Why this matters

You often need part of a string: email domain, area code, product prefix, or cleaned identifier. SQL string functions help extract and measure text.

### Concept

- `LEN(text)` length (without trailing spaces)
- `LEFT(text, n)` first `n` characters
- `RIGHT(text, n)` last `n` characters
- `SUBSTRING(text, start, len)` middle section

### Syntax

```sql
SELECT
    LEN(column_name),
    SUBSTRING(column_name, start_pos, length);
```

### Walkthrough

Extract email domain from customer email.

```sql
USE BikeStores;

SELECT
    customer_id,
    email,
    LEN(email) AS email_length,
    SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS email_domain
FROM sales.customers;
```

#### Expected result

Shows each customer email with derived domain and length.

### How it works

`CHARINDEX('@', email)` finds the separator position. `SUBSTRING` starts after `@` and returns the remaining text.

### Common mistakes

- Using wrong `SUBSTRING` start index (SQL is 1-based).
- Forgetting edge cases where source string has no separator.
- Confusing `LEN` behavior with trailing spaces.

### Quick recap

- `LEN`, `LEFT`, `RIGHT`, and `SUBSTRING` are core extract tools.
- Combine with `CHARINDEX` for pattern-based slicing.
- Great for cleaning imported text fields.

### Next

[Concatenate and search text](#concatenate-and-search-text)


---

## Concatenate and Search Text

### Why this matters

Reports often need display-ready labels like full names and searchable keywords. String concatenation and search functions are essential for this.

### Concept

- `CONCAT(a, b, c)` joins values safely
- `CONCAT_WS(separator, ...)` joins with separator
- `CHARINDEX(text, source)` finds position
- `REPLACE(source, old, new)` swaps text

### Syntax

```sql
SELECT
    CONCAT(col1, ' ', col2) AS full_text,
    CHARINDEX('needle', source_col) AS position;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) AS customer_name,
    CONCAT_WS(', ', city, state) AS city_state,
    CHARINDEX('gmail', email) AS gmail_pos
FROM sales.customers;
```

#### Expected result

Returns readable customer labels and position of `gmail` substring inside email.

### How it works

`CONCAT` handles nulls more safely than `+` concatenation. `CHARINDEX` returns `0` when the search string is not found.

### Another example

Normalize domain text:

```sql
SELECT
    email,
    REPLACE(email, '.com', '.org') AS changed_domain
FROM sales.customers;
```

### Common mistakes

- Using `+` and getting null results when one part is null.
- Assuming `CHARINDEX` returns negative values (it returns `0` when missing).
- Overusing string manipulation in `WHERE` without indexes.

### Quick recap

- `CONCAT` and `CONCAT_WS` create readable labels.
- `CHARINDEX` locates search text.
- `REPLACE` updates string fragments in output.

### Next

[Combining functions in queries](#combining-functions-in-queries)


---

## Combining Functions in Queries

### Why this matters

Real SQL combines multiple function types in one report: date calculations, formatted text, and conditional labels.

### Concept

You can compose functions together to produce cleaner reporting columns without changing source data.

This lesson uses `sales.orders` dates plus customer text fields.

### Syntax

```sql
SELECT
    function_a(function_b(column)),
    CASE WHEN condition THEN ... END
FROM table_name;
```

### Walkthrough

```sql
USE BikeStores;

SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    CONVERT(VARCHAR(10), o.order_date, 23) AS order_date_iso,
    DATEDIFF(DAY, o.order_date, o.required_date) AS days_until_required,
    CASE
        WHEN o.shipped_date IS NULL THEN 'Open'
        WHEN DATEDIFF(DAY, o.order_date, o.shipped_date) <= 3 THEN 'Fast'
        ELSE 'Standard'
    END AS shipping_bucket
FROM sales.orders AS o
INNER JOIN sales.customers AS c ON c.customer_id = o.customer_id
ORDER BY o.order_id;
```

#### Expected result

Each order row includes customer label, formatted date, date difference, and a shipping status bucket.

### How it works

The query joins customer and order tables, then applies string and date functions per row to produce report-friendly derived columns.

### Common mistakes

- Writing too many nested expressions without aliases.
- Mixing data types in `CASE` branches.
- Forgetting null handling for `shipped_date`.

### Quick recap

- Combined functions create useful report columns quickly.
- Keep outputs readable with clear aliases.
- Do transformations in query output, not by changing raw data.

### Next

Practice with [Exercises](#exercises), then continue to [Chapter 16: System Functions](Chapter 16 - System Functions.md).


---

## Exercises


Complete these after working through the topics above. ---

#### Exercise 1 - Shipping interval (warm-up)

Return `order_id` and days between `order_date` and `shipped_date` for shipped orders.

**Tables:** `sales.orders`

---

#### Exercise 2 - Required date + 5 days (warm-up)

Return `order_id`, `required_date`, and a new column with `DATEADD(DAY, 5, required_date)`.

**Tables:** `sales.orders`

---

#### Exercise 3 - Date formatting (apply)

Return `order_id` and `order_date` formatted as `yyyy-mm-dd`.

**Tables:** `sales.orders`

---

#### Exercise 4 - Email domain extraction (apply)

Return `customer_id`, `email`, and extracted domain text after `@`.

**Tables:** `sales.customers`

---

#### Exercise 5 - Full customer label (apply)

Create one column `customer_label` as `First Last (City, State)`.

**Tables:** `sales.customers`

---

#### Exercise 6 - Combined order report (stretch) ★

Join customers and orders, then return full name, order date ISO text, and a status column (`Open` vs `Shipped`) based on `shipped_date`.

**Tables:** `sales.orders`, `sales.customers`


---

## Solutions


## Chapter 15 - Solutions

---

#### Exercise 1 - Solution

```sql
USE BikeStores;

SELECT
    order_id,
    DATEDIFF(DAY, order_date, shipped_date) AS days_to_ship
FROM sales.orders
WHERE shipped_date IS NOT NULL;
```

Shows shipping duration for completed orders.

---

#### Exercise 2 - Solution

```sql
SELECT
    order_id,
    required_date,
    DATEADD(DAY, 5, required_date) AS required_plus_5
FROM sales.orders;
```

Adds five-day offset to each required date.

---

#### Exercise 3 - Solution

```sql
SELECT
    order_id,
    CONVERT(VARCHAR(10), order_date, 23) AS order_date_iso
FROM sales.orders;
```

Formats date as `yyyy-mm-dd`.

---

#### Exercise 4 - Solution

```sql
SELECT
    customer_id,
    email,
    SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS email_domain
FROM sales.customers;
```

Extracts domain text after `@`.

---

#### Exercise 5 - Solution

```sql
SELECT
    CONCAT(first_name, ' ', last_name, ' (', city, ', ', state, ')') AS customer_label
FROM sales.customers;
```

Builds readable customer display labels.

---

#### Exercise 6 - Solution

```sql
SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    CONVERT(VARCHAR(10), o.order_date, 23) AS order_date_iso,
    CASE WHEN o.shipped_date IS NULL THEN 'Open' ELSE 'Shipped' END AS order_status
FROM sales.orders AS o
INNER JOIN sales.customers AS c ON c.customer_id = o.customer_id;
```

Combines date and string functions in one report.

---

## Chapter Summary

You have finished this chapter. Review the exercises and confirm you can run the examples on BikeStores.

**What's next:** [Chapter 16 - System Functions.md](Chapter 16 - System Functions.md)
