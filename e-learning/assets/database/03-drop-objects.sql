-- BikeStores: remove all user tables (optional reset)
-- Does not drop the BikeStores database itself.

USE BikeStores;
GO

IF OBJECT_ID(N'sales.order_items', N'U') IS NOT NULL DROP TABLE sales.order_items;
IF OBJECT_ID(N'sales.orders', N'U') IS NOT NULL DROP TABLE sales.orders;
IF OBJECT_ID(N'production.stocks', N'U') IS NOT NULL DROP TABLE production.stocks;
IF OBJECT_ID(N'sales.customers', N'U') IS NOT NULL DROP TABLE sales.customers;
IF OBJECT_ID(N'production.products', N'U') IS NOT NULL DROP TABLE production.products;
IF OBJECT_ID(N'production.brands', N'U') IS NOT NULL DROP TABLE production.brands;
IF OBJECT_ID(N'production.categories', N'U') IS NOT NULL DROP TABLE production.categories;
IF OBJECT_ID(N'sales.staffs', N'U') IS NOT NULL DROP TABLE sales.staffs;
IF OBJECT_ID(N'sales.stores', N'U') IS NOT NULL DROP TABLE sales.stores;
GO

PRINT 'BikeStores tables dropped. Re-run 01-create-objects.sql and 02-load-data.sql to restore.';
GO
