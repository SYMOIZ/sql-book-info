-- BikeStores: create schemas and tables
-- Run after: CREATE DATABASE BikeStores;

USE BikeStores;
GO

-- Drop existing objects (safe re-run) — child tables first
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

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'sales')
    EXEC('CREATE SCHEMA sales');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'production')
    EXEC('CREATE SCHEMA production');
GO

-- sales.stores
CREATE TABLE sales.stores (
    store_id   INT IDENTITY(1, 1) PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL,
    phone      VARCHAR(25),
    email      VARCHAR(255),
    street     VARCHAR(255),
    city       VARCHAR(255),
    state      VARCHAR(10),
    zip_code   VARCHAR(5)
);
GO

-- sales.staffs
CREATE TABLE sales.staffs (
    staff_id   INT IDENTITY(1, 1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    email      VARCHAR(255) NOT NULL UNIQUE,
    phone      VARCHAR(25),
    active     TINYINT NOT NULL,
    store_id   INT NOT NULL,
    manager_id INT,
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES sales.staffs (staff_id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- production.categories
CREATE TABLE production.categories (
    category_id   INT IDENTITY(1, 1) PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);
GO

-- production.brands
CREATE TABLE production.brands (
    brand_id   INT IDENTITY(1, 1) PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);
GO

-- production.products
CREATE TABLE production.products (
    product_id   INT IDENTITY(1, 1) PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    brand_id     INT NOT NULL,
    category_id  INT NOT NULL,
    model_year   SMALLINT NOT NULL,
    list_price   DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES production.categories (category_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- sales.customers
CREATE TABLE sales.customers (
    customer_id INT IDENTITY(1, 1) PRIMARY KEY,
    first_name  VARCHAR(255) NOT NULL,
    last_name   VARCHAR(255) NOT NULL,
    phone       VARCHAR(25),
    email       VARCHAR(255) NOT NULL,
    street      VARCHAR(255),
    city        VARCHAR(50),
    state       VARCHAR(25),
    zip_code    VARCHAR(5)
);
GO

-- sales.orders
CREATE TABLE sales.orders (
    order_id      INT IDENTITY(1, 1) PRIMARY KEY,
    customer_id   INT,
    order_status  TINYINT NOT NULL,
    -- 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
    order_date    DATE NOT NULL,
    required_date DATE NOT NULL,
    shipped_date  DATE,
    store_id      INT NOT NULL,
    staff_id      INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES sales.customers (customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- sales.order_items
CREATE TABLE sales.order_items (
    order_id    INT NOT NULL,
    item_id     INT NOT NULL,
    product_id  INT NOT NULL,
    quantity    INT NOT NULL,
    list_price  DECIMAL(10, 2) NOT NULL,
    discount    DECIMAL(4, 2) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES sales.orders (order_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES production.products (product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- production.stocks
CREATE TABLE production.stocks (
    store_id   INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES production.products (product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

PRINT 'BikeStores objects created successfully.';
GO
