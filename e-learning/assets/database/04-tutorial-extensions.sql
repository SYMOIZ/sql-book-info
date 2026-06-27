-- BikeStores tutorial extensions
-- Run after 01-create-objects.sql and 02-load-data.sql
-- Used in chapters 4, 7, 10, 13, 17

USE BikeStores;
GO

-- sales.sales_summary for GROUP BY / CUBE / ROLLUP (Chapter 04)
IF OBJECT_ID(N'sales.sales_summary', N'U') IS NOT NULL
    DROP TABLE sales.sales_summary;
GO

SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS sales_amount
INTO sales.sales_summary
FROM sales.order_items AS oi
INNER JOIN production.products AS p ON p.product_id = oi.product_id
INNER JOIN production.brands AS b ON b.brand_id = p.brand_id
INNER JOIN production.categories AS c ON c.category_id = p.category_id
GROUP BY b.brand_name, c.category_name;
GO

-- production.parts for index demos (Chapter 10)
IF OBJECT_ID(N'production.parts', N'U') IS NOT NULL
    DROP TABLE production.parts;
GO

CREATE TABLE production.parts (
    part_id   INT NOT NULL,
    part_name VARCHAR(100)
);
GO

INSERT INTO production.parts (part_id, part_name)
VALUES (1, 'Frame'), (2, 'Head Tube'), (3, 'Handlebar Grip'), (4, 'Shock Absorber'), (5, 'Fork');
GO

-- production.product_audits for triggers (Chapter 13)
IF OBJECT_ID(N'production.product_audits', N'U') IS NOT NULL
    DROP TABLE production.product_audits;
GO

CREATE TABLE production.product_audits (
    change_id    INT IDENTITY(1, 1) PRIMARY KEY,
    product_id   INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id     INT NOT NULL,
    category_id  INT NOT NULL,
    model_year   SMALLINT NOT NULL,
    list_price   DECIMAL(10, 2) NOT NULL,
    updated_at   DATETIME NOT NULL,
    operation    CHAR(3) NOT NULL,
    CHECK (operation IN ('INS', 'DEL', 'UPD'))
);
GO

-- Views for window functions (Chapter 17) — create before use
IF OBJECT_ID(N'sales.vw_staff_sales', N'V') IS NOT NULL
    DROP VIEW sales.vw_staff_sales;
GO

CREATE VIEW sales.vw_staff_sales
AS
SELECT
    s.staff_id,
    YEAR(o.order_date) AS year,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS net_sales
FROM sales.staffs AS s
INNER JOIN sales.orders AS o ON o.staff_id = s.staff_id
INNER JOIN sales.order_items AS oi ON oi.order_id = o.order_id
GROUP BY s.staff_id, YEAR(o.order_date);
GO

IF OBJECT_ID(N'sales.vw_category_sales_volume', N'V') IS NOT NULL
    DROP VIEW sales.vw_category_sales_volume;
GO

CREATE VIEW sales.vw_category_sales_volume
AS
SELECT
    c.category_name,
    YEAR(o.order_date) AS year,
    SUM(oi.quantity) AS total_quantity
FROM production.categories AS c
INNER JOIN production.products AS p ON p.category_id = c.category_id
INNER JOIN sales.order_items AS oi ON oi.product_id = p.product_id
INNER JOIN sales.orders AS o ON o.order_id = oi.order_id
GROUP BY c.category_name, YEAR(o.order_date);
GO

PRINT 'Tutorial extensions created successfully.';
GO
