-- BikeStores: sample data for learning
-- Run after: 01-create-objects.sql
-- Safe to re-run: clears existing rows before inserting.

USE BikeStores;
GO

-- Clear data (child tables first)
DELETE FROM sales.order_items;
DELETE FROM sales.orders;
DELETE FROM production.stocks;
DELETE FROM sales.customers;
DELETE FROM production.products;
DELETE FROM production.brands;
DELETE FROM production.categories;
DELETE FROM sales.staffs;
DELETE FROM sales.stores;
GO

-- Reset IDENTITY columns so re-runs insert ids 1, 2, 3… again
DBCC CHECKIDENT ('sales.stores', RESEED, 0);
DBCC CHECKIDENT ('sales.staffs', RESEED, 0);
DBCC CHECKIDENT ('production.categories', RESEED, 0);
DBCC CHECKIDENT ('production.brands', RESEED, 0);
DBCC CHECKIDENT ('production.products', RESEED, 0);
DBCC CHECKIDENT ('sales.customers', RESEED, 0);
DBCC CHECKIDENT ('sales.orders', RESEED, 0);
GO

-- StoresINSERT INTO sales.stores (store_name, phone, email, street, city, state, zip_code)
VALUES
    ('Santa Monica Bikes', '310-555-0101', 'santa@cycling.com', '123 Ocean Ave', 'Santa Monica', 'CA', '90401'),
    ('Baldwin Bikes', '516-555-0102', 'baldwin@cycling.com', '456 Main St', 'Baldwin', 'NY', '11510'),
    ('Rowlett Bikes', '972-555-0103', 'rowlett@cycling.com', '789 Lake Dr', 'Rowlett', 'TX', '75088');
GO

-- Staff (manager_id NULL = top manager for that store)
INSERT INTO sales.staffs (first_name, last_name, email, phone, active, store_id, manager_id)
VALUES
    ('Fabiola', 'Jackson', 'fabiola@cycling.com', '310-555-0201', 1, 1, NULL),
    ('Mireya', 'Copeland', 'mireya@cycling.com', '310-555-0202', 1, 1, 1),
    ('Genna', 'Serrano', 'genna@cycling.com', '516-555-0203', 1, 2, NULL),
    ('Virgie', 'Wiggins', 'virgie@cycling.com', '516-555-0204', 1, 2, 3),
    ('Jannette', 'David', 'jannette@cycling.com', '972-555-0205', 1, 3, NULL);
GO

-- Categories
INSERT INTO production.categories (category_name)
VALUES
    ('Children Bicycles'),
    ('Comfort Bicycles'),
    ('Cruisers Bicycles'),
    ('Electric Bikes'),
    ('Mountain Bikes');
GO

-- Brands
INSERT INTO production.brands (brand_name)
VALUES
    ('Electra'),
    ('Haro'),
    ('Heller'),
    ('Pure Cycles'),
    ('Ritchey'),
    ('Sun Bicycles'),
    ('Surly'),
    ('Trek');
GO

-- Products
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price)
VALUES
    ('Trek Fuel EX 8', 8, 5, 2020, 2899.99),
    ('Trek Domane SL 5', 8, 2, 2021, 2199.99),
    ('Electra Townie 7D', 1, 3, 2020, 549.99),
    ('Electra Cruiser 1', 1, 3, 2019, 449.99),
    ('Haro Downtown', 2, 3, 2020, 399.99),
    ('Haro Shift R3', 2, 5, 2021, 759.99),
    ('Heller Shagamaw', 3, 5, 2020, 1999.99),
    ('Pure Cycles Urban Commuter', 4, 2, 2021, 499.99),
    ('Ritchey Timberwolf', 5, 5, 2019, 1299.99),
    ('Sun Bicycles Cruz', 6, 3, 2020, 329.99),
    ('Surly Straggler', 7, 2, 2021, 1549.99),
    ('Trek Kids Dual Sport', 8, 1, 2021, 399.99),
    ('Electra Kids Loft', 1, 1, 2020, 299.99),
    ('Trek Verve 2', 8, 2, 2022, 649.99),
    ('Surly E-36', 7, 4, 2022, 3499.99);
GO

-- Customers
INSERT INTO sales.customers (first_name, last_name, phone, email, street, city, state, zip_code)
VALUES
    ('Debra', 'Burks', '555-1001', 'debra@cycling.com', '123 Main', 'Albany', 'NY', '12201'),
    ('Kasha', 'Todd', '555-1002', 'kasha@cycling.com', '456 Oak', 'Amarillo', 'TX', '79101'),
    ('Tameka', 'Fisher', '555-1003', 'tameka@cycling.com', '789 Pine', 'Anaheim', 'CA', '92801'),
    ('Daryl', 'Spence', '555-1004', 'daryl@cycling.com', '321 Elm', 'Baldwin', 'NY', '11510'),
    ('Charolette', 'Rice', '555-1005', 'charolette@cycling.com', '654 Maple', 'Beaumont', 'TX', '77701'),
    ('Lyndsey', 'Bean', '555-1006', 'lyndsey@cycling.com', '987 Cedar', 'Bentonville', 'AR', '72712'),
    ('Latisha', 'Nixon', '555-1007', 'latisha@cycling.com', '147 Birch', 'Boise', 'ID', '83701'),
    ('Faye', 'Burt', '555-1008', 'faye@cycling.com', '258 Spruce', 'Calgary', 'AB', 'T2P'),
    ('Tammie', 'Austin', '555-1009', 'tammie@cycling.com', '369 Willow', 'Canton', 'OH', '44701'),
    ('Jeannie', 'Reeves', '555-1010', 'jeannie@cycling.com', '741 Ash', 'Cape Coral', 'FL', '33904');
GO

-- Orders
INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES
    (1, 4, '2016-01-01', '2016-01-05', '2016-01-03', 1, 2),
    (2, 4, '2016-01-02', '2016-01-06', '2016-01-04', 1, 2),
    (3, 4, '2016-02-10', '2016-02-14', '2016-02-12', 2, 4),
    (4, 2, '2017-03-15', '2017-03-20', NULL, 2, 3),
    (5, 4, '2017-06-01', '2017-06-05', '2017-06-03', 3, 5),
    (6, 1, '2018-01-20', '2018-01-25', NULL, 3, 5),
    (7, 4, '2018-05-10', '2018-05-15', '2018-05-12', 1, 1),
    (8, 4, '2019-08-01', '2019-08-05', '2019-08-03', 2, 4);
GO

-- Order items
INSERT INTO sales.order_items (order_id, item_id, product_id, quantity, list_price, discount)
VALUES
    (1, 1, 1, 1, 2899.99, 0.05),
    (1, 2, 3, 1, 549.99, 0.00),
    (2, 1, 4, 2, 449.99, 0.10),
    (3, 1, 7, 1, 1999.99, 0.00),
    (3, 2, 9, 1, 1299.99, 0.05),
    (4, 1, 2, 1, 2199.99, 0.00),
    (5, 1, 11, 1, 1549.99, 0.00),
    (5, 2, 10, 1, 329.99, 0.00),
    (6, 1, 15, 1, 3499.99, 0.00),
    (7, 1, 6, 1, 759.99, 0.05),
    (7, 2, 12, 1, 399.99, 0.00),
    (8, 1, 14, 1, 649.99, 0.00),
    (8, 2, 5, 1, 399.99, 0.10);
GO

-- Stocks (sample inventory per store)
INSERT INTO production.stocks (store_id, product_id, quantity)
VALUES
    (1, 1, 5), (1, 3, 12), (1, 4, 8), (1, 12, 15),
    (2, 2, 6), (2, 7, 4), (2, 9, 7), (2, 14, 10),
    (3, 6, 9), (3, 10, 20), (3, 11, 3), (3, 15, 2);
GO

PRINT 'BikeStores sample data loaded successfully.';
GO
