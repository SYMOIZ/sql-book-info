SQL Server Views
Summary: in this tutorial, you will learn about views and how to manage views such as creating a new view, removing a view, and updating data of the underlying tables through a view.

When you use the SELECT statement to query data from one or more tables, you get a result set.

For example, the following statement returns the product name, brand, and list price of all products from the products and brands tables:

SELECT
    product_name, 
    brand_name, 
    list_price
FROM
    production.products p
INNER JOIN production.brands b 
        ON b.brand_id = p.brand_id;
Code language: SQL (Structured Query Language) (sql)
Next time, if you want to get the same result set, you can save this query into a text file, open it, and execute it again.

SQL Server provides a better way to save this query in the database catalog through a view.

A view is a named query stored in the database catalog that allows you to refer to it later.

So the query above can be stored as a view using the CREATE VIEW statement as follows:

CREATE VIEW sales.product_info
AS
SELECT
    product_name, 
    brand_name, 
    list_price
FROM
    production.products p
INNER JOIN production.brands b 
        ON b.brand_id = p.brand_id;
Code language: SQL (Structured Query Language) (sql)
Later, you can reference to the view in the SELECT statement like a table as follows:

SELECT * FROM sales.product_info;
Code language: SQL (Structured Query Language) (sql)
When receiving this query, SQL Server executes the following query:

SELECT 
    *
FROM (
    SELECT
        product_name, 
        brand_name, 
        list_price
    FROM
        production.products p
    INNER JOIN production.brands b 
        ON b.brand_id = p.brand_id;
);
Code language: SQL (Structured Query Language) (sql)
By definition, views do not store data except for indexed views.

A view may consist of columns from multiple tables using joins or just a subset of columns of a single table. This makes views useful for abstracting or hiding complex queries.

The following picture illustrates a view that includes columns from multiple tables:

SQL Server Views
Advantages of views 
Generally speaking, views provide the following advantages:

Security 
You can restrict users to access directly to a table and allow them to access a subset of data via views.

For example, you can allow users to access customer name, phone, email via a view but restrict them to access the bank account and other sensitive information.

Simplicity 
A relational database may have many tables with complex relationships e.g., one-to-one and one-to-many that make it difficult to navigate.

However, you can simplify the complex queries with joins and conditions using a set of views.

Consistency 
Sometimes, you need to write a complex formula or logic in every query.

To make it consistent, you can hide the complex queries logic and calculations in views.

Once views are defined, you can reference the logic from the views rather than rewriting it in separate queries.

Managing views in SQL Server 
Creating a new view – show you how to create a new view in a SQL Server database.
Renaming a view – learn how to rename a view using the SQL Server Management Studio (SSMS) or Transact-SQL command.
Listing views in SQL Server – discuss the various way to list all views in a SQL Server Database.
Getting view information – how to get information about a view.
Removing a view – guide you how to use the DROP VIEW statement to remove one or more views from the database.
Creating an indexed view – show you how to create an indexed view against tables that have infrequent data modification to optimize the performance of the view.

SQL Server CREATE VIEW
Summary: in this tutorial, you will learn how to use the SQL Server CREATE VIEW statement to create new views.

To create a new view in SQL Server, you use the CREATE VIEW statement as shown below:

CREATE VIEW [OR ALTER] schema_name.view_name [(column_list)]
AS
    select_statement;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the view after the CREATE VIEW keywords. The schema_name is the name of the schema to which the view belongs.
Second, specify a SELECT statement (select_statement) that defines the view after the AS keyword. The SELECT statement can refer to one or more tables.
If you don’t explicitly specify a list of columns for the view, SQL Server will use the column list derived from the SELECT statement.

In case you want to redefine the view e.g., adding more columns to it or removing some columns from it, you can use the OR ALTER keywords after the CREATE VIEW keywords.

SQL Server CREATE VIEW examples 
We will use the orders, order_items, and products tables from the sample database for the demonstration.

SQL Server CREATE VIEW sample tables
Creating a simple view example 
The following statement creates a view named daily_sales based on the orders, order_items, and products tables:

CREATE VIEW sales.daily_sales
AS
SELECT
    year(order_date) AS y,
    month(order_date) AS m,
    day(order_date) AS d,
    p.product_id,
    product_name,
    quantity * i.list_price AS sales
FROM
    sales.orders AS o
INNER JOIN sales.order_items AS i
    ON o.order_id = i.order_id
INNER JOIN production.products AS p
    ON p.product_id = i.product_id;
Code language: SQL (Structured Query Language) (sql)
Once the daily_sales view is created, you can query data against the underlying tables using a simple SELECT statement:

SELECT 
    * 
FROM 
    sales.daily_sales
ORDER BY
    y, m, d, product_name;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

SQL Server Create View example
Redefining the view example 
To add the customer name column to the sales.daily_sales view, you use the CREATE VIEW OR ALTER as follows:

CREATE OR ALTER sales.daily_sales (
    year,
    month,
    day,
    customer_name,
    product_id,
    product_name
    sales
)
AS
SELECT
    year(order_date),
    month(order_date),
    day(order_date),
    concat(
        first_name,
        ' ',
        last_name
    ),
    p.product_id,
    product_name,
    quantity * i.list_price
FROM
    sales.orders AS o
    INNER JOIN
        sales.order_items AS i
    ON o.order_id = i.order_id
    INNER JOIN
        production.products AS p
    ON p.product_id = i.product_id
    INNER JOIN sales.customers AS c
    ON c.customer_id = o.customer_id;
Code language: SQL (Structured Query Language) (sql)
In this example, we specified the column list for the view explicitly.

The following statement queries data against the sales.daily_sales view:

SELECT 
    * 
FROM 
    sales.daily_sales
ORDER BY 
    y, 
    m, 
    d, 
    customer_name;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Create or Alter view example
Creating a view using aggregate functions example 
The following statement creates a view named staff_salesthose summaries the sales by staffs and years using the SUM() aggregate function:

CREATE VIEW sales.staff_sales (
        first_name, 
        last_name,
        year, 
        amount
)
AS 
    SELECT 
        first_name,
        last_name,
        YEAR(order_date),
        SUM(list_price * quantity) amount
    FROM
        sales.order_items i
    INNER JOIN sales.orders o
        ON i.order_id = o.order_id
    INNER JOIN sales.staffs s
        ON s.staff_id = o.staff_id
    GROUP BY 
        first_name, 
        last_name, 
        YEAR(order_date);
Code language: SQL (Structured Query Language) (sql)
The following statement returns the contents of the view:

SELECT  
    * 
FROM 
    sales.staff_sales
ORDER BY 
	first_name,
	last_name,
	year;
Code language: SQL (Structured Query Language) (sql)
The output is:

SQL Server Create View with aggregate function
In this tutorial, you have learned how to create a new view by using the SQL Server CREATE VIEW statement.

SQL Server Rename View
Summary: in this tutorial, you will learn how to rename a view in a SQL Server Database.

Before renaming a view, you must notice that all objects that depend on the view may fail. These include stored procedures, user-defined functions, triggers, queries, other views, and client applications.

Therefore, after renaming the view, you must ensure that all objects that reference the view’s old name use the new name.

SQL Server rename view using Server Server Management Studio (SSMS) 
To rename the name of a view you follow these steps:

First, in Object Explorer, expand the Databases, choose the database name which contains the view that you want to rename and expand the Views folder.

Second, right-click the view that you want to rename and select Rename.

SQL Server Rename View Using SSMS
Third, enter the new name for the view.

SQL Server Rename View Using SSMS - type new view name
SQL Server rename view using Transact-SQL 
If you want to rename a view programmatically, you can use the sp_rename stored procedure:

EXEC sp_rename 
    @objname = 'sales.product_catalog',
    @newname = 'product_list';
Code language: SQL (Structured Query Language) (sql)
In this statement:

First, pass the name of the view which you want to rename using the @objname parameter and the new view name to using the @newname parameter. Note that in the @objectname you must specify the schema name of the view. However, in the @newname parameter, you must not.
Second, execute the statement.
The sp_rename stored procedure returns the following message:

Caution: Changing any part of an object name could break scripts and stored procedures.
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to rename a view in a SQL Server database using SQL Server Management Studio and Transact-SQL.

Was this tutorial helpful?

SQL Server List Views
Summary: in this tutorial, you will learn how to list all views in the SQL Server database by querying the system catalog view.

To list all views in a SQL Server Database, you query the sys.views or sys.objects catalog view. Here is an example:

SELECT 
	OBJECT_SCHEMA_NAME(v.object_id) schema_name,
	v.name
FROM 
	sys.views as v;
Code language: SQL (Structured Query Language) (sql)
The query returns the following list of schema names and view names:

SQL Server List Views Example
In this example, we used the OBJECT_SCHEMA_NAME() function to get the schema names of the views.

The following query returns a list of views through the sys.objects view:

SELECT 
	OBJECT_SCHEMA_NAME(o.object_id) schema_name,
	o.name
FROM
	sys.objects as o
WHERE
	o.type = 'V';
Code language: SQL (Structured Query Language) (sql)
Creating a stored procedure to show views in SQL Server Database 
The following stored procedure wraps the query above to list all views in the SQL Server Database based on the input schema name and view name:

CREATE PROC usp_list_views(
	@schema_name AS VARCHAR(MAX)  = NULL,
	@view_name AS VARCHAR(MAX) = NULL
)
AS
SELECT 
	OBJECT_SCHEMA_NAME(v.object_id) schema_name,
	v.name view_name
FROM 
	sys.views as v
WHERE 
	(@schema_name IS NULL OR 
	OBJECT_SCHEMA_NAME(v.object_id) LIKE '%' + @schema_name + '%') AND
	(@view_name IS NULL OR
	v.name LIKE '%' + @view_name + '%');
Code language: SQL (Structured Query Language) (sql)
For example, if you want to know the views that contain the word sales, you can call the stored procedure usp_list_views:

EXEC usp_list_views @view_name = 'sales'
Code language: SQL (Structured Query Language) (sql)
Here is the result:

SQL Server List Views using Stored Procedure
In this tutorial, you have learned various ways to list views in a SQL Server Database by querying data from the system catalog views.

Was this tutorial helpful?

How to Get Information About a View in SQL Server
Summary: in this tutorial, you will learn various ways to get the information of a view in a SQL Server Database.

Getting the view information using the sql.sql_module catalog 
To get the information of a view, you use the system catalog sys.sql_module and the OBJECT_ID() function:

SELECT
    definition,
    uses_ansi_nulls,
    uses_quoted_identifier,
    is_schema_bound
FROM
    sys.sql_modules
WHERE
    object_id
    = object_id(
            'sales.daily_sales'
        );
Code language: SQL (Structured Query Language) (sql)
In this query, you pass the name of the view to the OBJECT_ID() function in the WHERE clause. The OBJECT_ID() function returns an identification number of a schema-scoped database object.

Here is the output:

SQL Server Getting View Definition
Note that you need to output the result to the text format in order to see the SELECT statement clearly as the above picture.

To show the results as text, from the query editor, you press Ctrl-T keyboard shortcut or click the Results to Text button as shown in the following screenshot:

SQL Server Getting view definition - show results to text
Getting view information using the sp_helptext stored procedure 
The sp_helptext stored procedure returns the definition of a user-defined object such as a view.

To get a view’s information, you pass the view name to the sp_helptext stored procedure. For example, the following statement returns the information of the sales.product_catalog view:

EXEC sp_helptext 'sales.product_catalog' ;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server Getting view definition using sp_helptext stored procedure
Getting the view information using OBJECT_DEFINITION() function 
Another way to get the view information is to use the OBJECT_DEFINITION() and OBJECT_ID() functions as follows:

SELECT 
    OBJECT_DEFINITION(
        OBJECT_ID(
            'sales.staff_sales'
        )
    ) view_info;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server Getting view information using object_definition stored procedure
In this tutorial, you have learned how to various ways to get the information about a view in SQL Server Database.

Was this tutorial helpful?

SQL Server DROP VIEW
Summary: in this tutorial, you will learn how to use the SQL Server DROP VIEW statement to remove an existing view.

To remove a view from a database, you use the DROP VIEW statement as follows:

DROP VIEW [IF EXISTS] schema_name.view_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax, you specify the name of the view that you want to drop after the DROP VIEW keywords. If the view belongs to a schema, you must also explicitly specify the name of the schema to which the view belongs.

If you attempt to remove a view that does not exist, SQL Server will issue an error. The IF EXISTS clause prevents an error from occurring when you delete a view that does not exist.

To remove multiple views, you use the following syntax:

DROP VIEW [IF EXISTS] 
    schema_name.view_name1, 
    schema_name.view_name2,
    ...;
Code language: SQL (Structured Query Language) (sql)
In this syntax, the views are separated by commas.

Note that when you drop a view, SQL Server removes all permissions for the view.

SQL Server DROP VIEW examples 
We will use the sales.daily_sales and sales.staff_sales views created in the CREATE VIEW tutorial for the demonstration.

Removing one view example 
The following example shows how to drop the sales.daily_sales view from the sample database:

DROP VIEW IF EXISTS sales.daily_sales;
Code language: SQL (Structured Query Language) (sql)
Removing multiple views example 
The following statement creates a view named product_catalogs for demonstration purpose:

CREATE VIEW sales.product_catalog
AS
SELECT 
    product_name, 
    category_name, 
	brand_name,
    list_price
FROM 
    production.products p
INNER JOIN production.categories c 
    ON c.category_id = p.category_id
INNER JOIN production.brands b
	ON b.brand_id = p.brand_id;
Code language: SQL (Structured Query Language) (sql)
The following statement removes both sales.staff_sales and sales.product_catalog views at the same time:

DROP VIEW IF EXISTS 
    sales.staff_sales, 
    sales.product_catalogs;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server DROP VIEW statement to remove one or more views from the database.

Was this tutorial helpful?

SQL Server Indexed View
Summary: in this tutorial, you will learn how to create a SQL Server indexed view that stored data physically in the database.

Introduction to SQL Server indexed view 
Regular SQL Server views are the saved queries that provide some benefits such as query simplicity, business logic consistency, and security. However, they do not improve the underlying query performance.

Unlike regular views, indexed views are materialized views that stores data physically like a table hence may provide some the performance benefit if they are used appropriately.

To create an indexed view, you use the following steps:

First, create a view that uses the WITH SCHEMABINDING option which binds the view to the schema of the underlying tables.
Second, create a unique clustered index on the view. This materializes the view.
Because of the WITH SCHEMABINDING option, if you want to change the structure of the underlying tables which affect the indexed view’s definition, you must drop the indexed view first before applying the changes.

In addition, SQL Server requires all object references in an indexed view to include the two-part naming
convention i.e., schema.object, and all referenced objects are in the same database.

When the data of the underlying tables changes, the data in the indexed view is also automatically updated. This causes a write overhead for the referenced tables. It means that when you write to the underlying table, SQL Server also has to write to the index of the view. Therefore, you should only create an indexed view against the tables that have in-frequent data updates.

Creating an SQL Server indexed view example 
The following statement creates an indexed view based on columns of the production.products, production.brands, and production.categories tables from the sample database:

Categories, Products, and Brands
CREATE VIEW product_master
WITH SCHEMABINDING
AS 
SELECT
    product_id,
    product_name,
    model_year,
    list_price,
    brand_name,
    category_name
FROM
    production.products p
INNER JOIN production.brands b 
    ON b.brand_id = p.brand_id
INNER JOIN production.categories c 
    ON c.category_id = p.category_id;
Code language: SQL (Structured Query Language) (sql)
Notice the option WITH SCHEMABINDING after the view name. The rest is the same as a regular view.

Before creating a unique clustered index for the view, let’s examine the query I/O cost statistics by querying data from a regular view and using the SET STATISTICS IO command:

SET STATISTICS IO ON
GO

SELECT 
    * 
FROM
    production.product_master
ORDER BY
    product_name;
GO 
Code language: SQL (Structured Query Language) (sql)
SQL Server returns the following query I/O cost statistics:

Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Workfile'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'products'. Scan count 1, logical reads 5, physical reads 1, read-ahead reads 3, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'categories'. Scan count 1, logical reads 2, physical reads 1, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'brands'. Scan count 1, logical reads 2, physical reads 1, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Code language: JavaScript (javascript)
As you can see clearly from the output, SQL Server had to read from three corresponding tables before returning the result set.

Let’s add a unique clustered index to the view:

CREATE UNIQUE CLUSTERED INDEX 
    ucidx_product_id 
ON production.product_master(product_id);
Code language: SQL (Structured Query Language) (sql)
This statement materializes the view, making it have a physical existence in the database.

You can also add a non-clustered index on the product_name column of the view:

CREATE NONCLUSTERED INDEX 
    ucidx_product_name
ON production.product_master(product_name);
Code language: SQL (Structured Query Language) (sql)
Now, if you query data against the view, you will notice that the statistics have changed:

Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'product_master'. Scan count 1, logical reads 6, physical reads 1, read-ahead reads 11, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Code language: JavaScript (javascript)
Instead of reading data from three tables, SQL Server now reads data directly from the materialized view product_master.

Note that this feature is only available on SQL Server Enterprise Edition. If you use the SQL Server Standard or Developer Edition, you must use the WITH (NOEXPAND) table hint directly in the FROM clause of the query which you want to use the view like the following query:

SELECT * 
FROM production.product_master 
   WITH (NOEXPAND)
ORDER BY product_name;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to create a SQL Server indexed view defined against tables that have infrequent data updates to improve the query performance.

Was this tutorial helpful?