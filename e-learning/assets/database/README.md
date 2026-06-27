# Database Scripts

SQL scripts for the BikeStores practice database used throughout Part 1.

## Run order

1. Create the database in SSMS: `CREATE DATABASE BikeStores;` (or use `IF NOT EXISTS` from Chapter 01)
2. [01-create-objects.sql](./01-create-objects.sql) — schemas and nine tables
3. [02-load-data.sql](./02-load-data.sql) — sample data (safe to re-run)
4. [04-tutorial-extensions.sql](./04-tutorial-extensions.sql) — before Chapters 4, 10, 13, and 17

## Reset

- [03-drop-objects.sql](./03-drop-objects.sql) — drop all BikeStores user tables; then re-run steps 2–4

## Environment

SQL Server 2022 Developer Edition, database name **BikeStores**.
