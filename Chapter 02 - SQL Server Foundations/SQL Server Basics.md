CUBE – generate grouping sets with all combinations of the dimension columns.
ROLLUP – generate grouping sets with an assumption of the hierarchy between input columns.
 Section 7. Subquery 
This section covers subqueries, which are queries nested within another statement, such as SELECT, INSERT, UPDATE, or DELETE.

Subquery – explain the subquery concept and show you how to use various subquery types to select data.
Correlated subquery – introduce you to the correlated subquery concept.
EXISTS – test for the existence of rows returned by a subquery.
ANY – compare a value with a single-column set of values returned by a subquery and return TRUE if the value matches any value in the set.
ALL – compare a value with a single-column set of values returned by a subquery and return TRUE if the value matches all values in the set.
CROSS APPLY – perform an inner join of a table with a table-valued function or a correlated subquery.
OUTER APPLY – perform a left join of a table with a table-valued function or a correlated subquery.
Section 8. Set Operators 
This section guides you through the steps of using set operators, including union, intersect, and except, to combine multiple result sets from input queries.

UNION – combine the result sets of two or more queries into a single result set.
INTERSECT – return the intersection of the result sets of two or more queries.
EXCEPT – find the difference between the two result sets of two input queries.
Section 9. Common Table Expression (CTE) 
CTE – use common table expressions to make complex queries more readable.
Recursive CTE – query hierarchical data using recursive CTE.
Section 10. Pivot 
PIVOT – convert rows to columns
Section 11. Modifying data 
In this section, you will learn how to modify data in the database using Data Manipulation Language (DML), which includes SQL commands such as INSERT, DELETE, and UPDATE.

INSERT – insert a row into a table
INSERT multiple rows – insert multiple rows into a table using a single INSERT statement
INSERT INTO SELECT – insert data that comes from the result set of a query into a table.
UPDATE – change the existing values in a table.
UPDATE JOIN – update values in a table based on values from another table using JOIN clauses.
DELETE – delete one or more rows of a table.
MERGE – walk you through the steps of performing a mixture of insertion, update, and deletion using a single statement.
Transaction – show you how to start a transaction explicitly using the BEGIN TRANSACTION, COMMIT, and ROLLBACK statements
Section 12. Data definition 
This section shows you how to manage the most important database objects including databases and tables.

CREATE DATABASE – show you how to create a new database in an SQL Server instance using the CREATE DATABASE statement and SQL Server Management Studio.
DROP DATABASE – learn how to delete existing databases.
CREATE SCHEMA – describe how to create a new schema in a database.
ALTER SCHEMA – show how to transfer a securable from one schema to another within the same database.
DROP SCHEMA – learn how to delete a schema from a database.
CREATE TABLE – walk you through the steps of creating a new table in a specific schema of a database.
Identity column – learn how to use the IDENTITY property to create the identity column for a table.
Sequence – describe how to generate a sequence of numeric values based on a specification.
ALTER TABLE ADD column – show you how to add one or more columns to an existing table
ALTER TABLE ALTER COLUMN – show you how to change the definition of existing columns in a table.
ALTER TABLE DROP COLUMN – learn how to drop one or more columns from a table.
Computed columns – how to use the computed columns to reuse the calculation logic in multiple queries.
DROP TABLE – show you how to delete tables from the database.
TRUNCATE TABLE – delete all data from a table faster and more efficiently.
SELECT INTO – learn how to create a table and insert data from a query into it.
Rename a table –  walk you through the process of renaming a table to a new one.
Temporary tables – introduce you to the temporary tables for storing temporary immediate data in stored procedures or database sessions.
Synonym – explain the synonym and show you how to create synonyms for database objects.
Section 13. SQL Server Data Types 
SQL Server data types – give you an overview of the built-in SQL Server data types.
BIT – store bit data i.e., 0, 1, or NULL in the database with the BIT data type.
INT – learn about various integer types in SQL server including BIGINT, INT, SMALLINT, and TINYINT.
DECIMAL – show you how to store exact numeric values in the database by using DECIMAL or NUMERIC data type.
CHAR – learn how to store fixed-length, non-Unicode character strings in the database.
NCHAR –  show you how to store fixed-length, Unicode character strings and explains the differences between CHAR and NCHAR data types
VARCHAR – store variable-length, non-Unicode string data in the database.
NVARCHAR – learn how to store variable-length, Unicode string data in a table and understand the main differences between VARCHAR and NVARCHAR.
DATETIME2 – illustrate how to store both date and time data in a database.
DATE – discuss the date data type and how to store the dates in the table.
TIME – show you how to store time data in the database by using the TIME data type.
DATETIMEOFFSET – show you how to manipulate datetime with the time zone.
GUID – learn about the GUID and how to use the NEWID() function to generate GUID values.
Section 14. Constraints 
Primary key  – explain the primary key concept and show you how to use the primary key constraint to manage the primary key of a table.
Foreign key – introduce you to the foreign key concept and show you use the FOREIGN KEY constraint to enforce the link of data in two tables.
NOT NULL constraint – show you how to ensure a column does not accept NULL.
UNIQUE constraint – ensure that data contained in a column, or a group of columns, is unique among rows in a table.
CHECK constraint – walk you through the process of adding logic for checking data before storing them in tables.
Section 15. Expressions 
CASE – add if-else logic to SQL queries by using simple and searched CASE expressions.
COALESCE – handle NULL values effectively using the COALESCE expression.
NULLIF – return NULL if the two arguments are equal; otherwise, return the first argument.
Section 16. Useful Tips 
Find duplicates – show you how to find duplicate values in one or more columns of a table.
Delete duplicates – describe how to remove duplicate rows from a table.  


-----------------------------------------------------
SQL Server SELECT
Summary: This tutorial introduces you to the basics of the SQL Server SELECT statement, focusing on how to retrieve data from a single table.

Basic SQL Server SELECT statement 
In SQL Server, tables are objects that store all the data in a database. They organize data in a row-and-column format, similar to a spreadsheet. Each row represents a unique record in a table, and each column represents a field in that record.

For example, the following customers table contains customer data such as customer ID, first name, last name, phone, email, and address:

Customers table
SQL Server uses schemas to logically group tables and other database objects. For example, our sample database has two schemas: sales and production.

The sales schema includes all the sales-related tables, while the production schema groups all the production-related tables.

To retrieve data from a table, you use the SELECT statement with the following syntax:

SELECT
    select_list
FROM
    schema_name.table_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify a list of comma-separated columns from which you want to query data in the SELECT clause.
Second, specify the table name and its schema in the FROM clause.
When processing the SELECT statement, SQL Server first processes the FROM clause, followed by the SELECT clause, even though the SELECT clause appears before the FROM clause:

SQL Server SELECT - clause order evaluation
SQL Server SELECT statement examples 
Let’s use the customers table in the sample database for the demonstration.


1) Basic SQL Server SELECT statement example 
The following query uses a SELECT statement to retrieve the first and last names of all customers:

SELECT
    first_name,
    last_name
FROM
    sales.customers;
Code language: SQL (Structured Query Language) (sql)
Here is the result:

sql server select - some columns
The result of a query is often called a result set.

The following statement uses the SELECT statement to retrieve the first name, last name, and email of all customers:

SELECT
    first_name,
    last_name,
    email
FROM
    sales.customers;
Code language: SQL (Structured Query Language) (sql)
Output:

sql server select - select three columns
2) Using the SQL Server SELECT to retrieve all columns of a table 
To retrieve data from all table columns, you can specify all the columns in the SELECT list. Alternatively, you can also use SELECT * as a shorthand to select all columns:

SELECT * FROM sales.customers;
Code language: SQL (Structured Query Language) (sql)
sql server select - select all columns
Using the SELECT * is useful for examining the table that you are not familiar with and it is particularly helpful for ad-hoc queries.

However, you should not use the SELECT * in production code for the following main reasons:

First, using SELECT * often retrieves more data than your application needs. This unnecessary data takes more time to transfer from the database server to the application, slowing down the application.
Second, if new columns are added to the table, SELECT * will retrieve all columns, including the new ones that your application may not expect. This could potentially cause the application to behave unexpectedly.
In the following section, we’ll briefly introduce the additional clauses of the SELECT statement:

WHERE : filter rows in the result set.
ORDER BY: sort rows in the result set by one or more columns.
GROUP BY: group rows into groups.
HAVING: filter groups.
Please note that we’ll cover these clauses in greater detail in the upcoming tutorials.

3) Filtering rows using the WHERE clause 
To filter rows based on one or more conditions, you use a WHERE clause.

For example, the following SELECT statement uses a WHERE clause to find customers located in California:

SELECT
    *
FROM
    sales.customers
WHERE
    state = 'CA';
Code language: SQL (Structured Query Language) (sql)
sql server select - where clause
If the SELECT statement includes both WHERE and FROM clauses, SQL Server processes them in the following sequence: FROM, WHERE, and SELECT.

SQL Server SELECT - from where select
4) Sorting rows using the ORDER BY clause 
To sort rows in a result set based, you use the ORDER BY clause. For example, the following query uses the ORDER BY clause to sort customers by their first names in ascending order.

SELECT
    *
FROM
    sales.customers
WHERE
    state = 'CA'
ORDER BY
    first_name;
Code language: SQL (Structured Query Language) (sql)
Output:

sql server select - order by clause
When the SELECT statement includes the FROM, WHERE, and ORDER BY clause, SQL Server processes them in the following order: FROM, WHERE, SELECT, and ORDER BY:

SQL Server SELECT - from where select order by
5) Grouping rows into groups 
To group rows into groups, you use the GROUP BY clause.

For example, the following statement returns all the cities of customers located in California and the number of customers in each city.

SELECT
    city,
    COUNT (*)
FROM
    sales.customers
WHERE
    state = 'CA'
GROUP BY
    city
ORDER BY
    city;
Code language: SQL (Structured Query Language) (sql)
sql server select - group by clause
In this case, SQL Server processes the clauses in the following order: FROM, WHERE, GROUP BY, SELECT, and ORDER BY.


6) Filtering groups using the HAVING clause 
To filter groups based on one or more conditions, you use the HAVING clause.

For example, the following statement uses the HAVING clause to return the city in California, which has more than ten customers:

SELECT
    city,
    COUNT (*)
FROM
    sales.customers
WHERE
    state = 'CA'
GROUP BY
    city
HAVING
    COUNT (*) > 10
ORDER BY
    city;
Code language: SQL (Structured Query Language) (sql)
sql server select - having clause
Notice that the WHERE clause filters rows while the HAVING clause filter groups.

Summary 
Use the SQL Server SELECT statement to retrieve data from a table. 
--------------------------------------------
SQL Server ORDER BY
Summary: in this tutorial, you will learn how to use the SQL Server ORDER BY clause to sort the result set of a query by one or more columns.

Introduction to the SQL Server ORDER BY clause 
The ORDER BY clause is an option clause of the SELECT statement. The ORDER BY clause allows you to sort the result set of a query by one or more columns.

Here’s the syntax of the ORDER BY clause:

SELECT
    select_list
FROM
    table_name
ORDER BY 
    column_name | expression [ASC | DESC ];
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify a column name or an expression you want to sort in the ORDER BY clause.

If you use multiple columns, the ORDER BY clause will sort rows by the first column first, then sort the sorted rows by the second column, and so on.

The columns in the ORDER BY clause must match either column in the select list or columns defined in the table specified in the FROM clause.

Second, specify the sort order by using either the ASC or DESC keyword.

The ASC keyword sorts rows from low to high, while the DESC keyword sorts the rows from high to low.

Both ASC and DESC are optional. If you don’t explicitly specify either ASC or DESC, the ORDER BY clause defaults to ASC.

Additionally, SQL Server treats NULL as the lowest value. This means that it will place NULL before other values after sorting.

When processing the SELECT statement that has an ORDER BY clause, SQL Server processes the ORDER BY clause last.

SQL Server ORDER BY clause example 
We will use the customers table in the sample database from the demonstration.

SQL Server Order By - customers table
1) Sort a result set by one column in ascending order 
The following statement uses the ORDER BY clause to sort customers by their first names in ascending order:

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server ORDER BY - sort by one column
In this example, we don’t specify ASC or DESC, the ORDER BY clause defaults to ASC. Therefore, the above query is equivalent to the following query:

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name ASC;
Code language: CSS (css)
2) Sort a result set by one column in descending order 
The following statement uses the ORDER BY clause to sort customers by their first names in descending order:

SELECT
    firstname,
    lastname
FROM
    sales.customers
ORDER BY
    first_name DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server ORDER BY - sort by one column in descending order
In this example, we explicitly use the DESC option, so the ORDER BY clause sorts the rows by values in the first_name column in descending order.

3) Sort a result set by multiple columns 
The following statement uses the ORDER BY clause to sort customers by cities first and then by first names:

SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city,
    first_name;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server ORDER BY - sort by two columns
4) Sort a result set by multiple columns in different orders 
The following statement uses the ORDER BY clause to sort customers by cities in descending order and then sort the customers by their first names in alphabetical order:

SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city DESC,
    first_name ASC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server ORDER BY - sort by two columns in differnt orders
5) Sort a result set by a column that is not in the select list 
SQL Server allows you to sort a result set by columns specified in a table, even if those columns do not appear in the select list.

For example, the following statement uses the ORDER BY clause to sort customers by states, even though the state column does not appear on the select list:

SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    state;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server ORDER BY - sort by hidden column
Note that the state column is defined in the  customers table. If it doesn’t, then you’ll have an invalid query.

6) Sort a result set by an expression 
The LEN() function returns the number of characters in a string.

The following statement uses the LEN() function in the ORDER BY clause to sort customers by the lengths of their first names:

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    LEN(first_name) DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server ORDER BY - sort by an expression
7) Sort by ordinal positions of columns 
SQL Server allows you to sort the result set based on the ordinal positions of columns that appear in the select list.

The following statement sorts the customers by first and last names. But instead of specifying the column names explicitly, it uses the ordinal positions of the columns:

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    1,
    2;
Code language: SQL (Structured Query Language) (sql)
In this example, the numbers 1 and 2, which appear after the ORDER BY clause, denote the first_name and last_name columns respectively.

Using the ordinal positions of columns in the ORDER BY clause is not recommended for several reasons:

First, the columns in a table don’t have ordinal positions and should be referenced by names.
Second, if you modify the select list, you might forget to update the ORDER BY clause accordingly.
Therefore, it is best practice to always specify column names explicitly in the ORDER BY clause.

Summary 
Use the ORDER BY clause to sort the result set by columns in ascending or descending order.
Use the ASC keyword to sort rows in ascending order.
Use the DESC keyword to sort rows in descending order. 
------------------------------------------------

SQL Server OFFSET FETCH
Summary: in this tutorial, you will learn how to use the SQL Server OFFSET FETCH clauses to limit the number of rows returned by a query.

Introduction to SQL Server OFFSET FETCH 
The OFFSET and FETCH clauses are options of the ORDER BY clause. They allow you to limit the number of rows returned by a query.

Here’s the syntax for using the OFFSET and FETCH clauses:

ORDER BY column_list [ASC |DESC]
OFFSET offset_row_count {ROW | ROWS}
FETCH {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY
Code language: SQL (Structured Query Language) (sql)
In this syntax:

The OFFSET clause specifies the number of rows to skip before starting to return rows from the query. The offset_row_count can be a constant, variable, or parameter that is greater or equal to zero.
The FETCH clause specifies the number of rows to return after the OFFSET clause has been processed. The offset_row_count can be a constant, variable, or scalar that is greater or equal to one.
The OFFSET clause is mandatory, while the FETCH clause is optional. Additionally, FIRST and NEXT are synonyms and can be used interchangeably. Similarly, you can use ROW and ROWS interchangeably.
The following picture illustrates the OFFSET and FETCH clauses:

SQL Server OFFSET FETCH
It’s important to note that you must use the OFFSET and FETCH clauses with the ORDER BY clause. Otherwise, you encounter an error.

The OFFSET and FETCH clauses are preferable for implementing the query paging solutions compared to the TOP clause.

The OFFSET and FETCH clauses have been available since SQL Server 2012 (11.x) and later, as well as Azure SQL Database.

SQL Server OFFSET and FETCH clause examples 
We will use the products table from the sample database for the demonstration.

products
1) Using the SQL Server OFFSET FETCH example 
The following query uses a SELECT statement to retrieve all rows from the products table and sorts them by the list prices and names:

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server OFFSET FETCH result set
To skip the first 10 products and return the rest, you use the OFFSET clause as shown in the following statement:

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server OFFSET FETCH example
To skip the first 10 products and select the next 10 products, you use both OFFSET and FETCH clauses as follows:

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server OFFSET FETCH skip 10 rows fetch next 10 rows example
2) Using the OFFSET FETCH clause to get the top N rows 
The following example uses the OFFSET FETCH clause to retrieve the top 10 most expensive products from the products table:

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC,
    product_name 
OFFSET 0 ROWS 
FETCH FIRST 10 ROWS ONLY;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server OFFSET FETCH top 10 most expensive products
In this example:

First, the ORDER BY clause sorts the products by their list prices in descending order.
Then, the OFFSET clause skips zero rows, and the FETCH clause retrieves the first 10 products from the list.
Summary 
Use the SQL Server OFFSET FETCH clauses to limit the number of rows returned by a query.

--------------------------------------------------

SQL Server SELECT TOP
Summary: in this tutorial, you will learn how to use the SQL Server SELECT TOP statement to limit the rows returned by a query.

Introduction to SQL Server SELECT TOP 
The SELECT TOP clause allows you to limit the rows or percentage of rows returned by a query. It is useful when you want to retrieve a specific number of rows from a large table.

Since the order of rows stored in a table is unspecified, the SELECT TOP statement should always be used with the ORDER BY clause. This ensures the result set is limited to the first N number of ordered rows.

The following shows the syntax of the TOP clause with the SELECT statement:

SELECT TOP (expression) [PERCENT]
    [WITH TIES]
FROM 
    table_name
ORDER BY 
    column_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax, the SELECT statement may include other clauses such as WHERE, JOIN, and GROUP BY and HAVING.

expression 
Following the TOP keyword is an expression that specifies the number of rows to be returned. The expression is evaluated to a float value if PERCENT is used, otherwise, it is converted to a BIGINT value.

PERCENT 
The PERCENT keyword indicates that the query returns the first N percentage of rows, where N is the result of the expression.

 WITH TIES 
The WITH TIES allows you to return additional rows with values that match those of the last row in the limited result set. Note that WITH TIES may result in more rows being returned than specified in the expression.

For example, if you want to return the most expensive product, you can use the TOP 1. However, if two or more products have the same prices as the most expensive product, then you may miss the other most expensive products in the result set.

To avoid this, you can use TOP 1 WITH TIES. This will include not only the most expensive product but also other products that have the same highest price. By doing this, you won’t miss any equally expensive products in the result set.

SQL Server SELECT TOP examples 
We will use the production.products table in the sample database for the demonstration.

products
1) Using SQL Server SELECT TOP with a constant value 
The following query uses SELECT TOP with a constant to return the top 10 most expensive products from the production.products table:

SELECT TOP 10
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Here is the result:

SQL Server SELECT TOP - top ten most expensive products
2) Using SELECT TOP to return a percentage of rows 
The following example uses PERCENT to specify the number of products returned in the result set.

The production.products table has 321 rows. Therefore, one percent of 321 is a fraction value ( 3.21), SQL Server rounds it up to the next whole number, which is four ( 4) in this case:

SELECT TOP 1 PERCENT
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server SELECT TOP - TOP PERCENT example
3) Using SELECT TOP WITH TIES to include rows that match values in the last row 
The following query uses the SELECT TOP WITH TIES to retrieve the top three most expensive products from the production.products table:

SELECT TOP 3 WITH TIES
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server SELECT TOP - TOP WITH TIES example
In this example, the third most expensive product has a list price of 6499.99.

Because the statement uses TOP WITH TIES, it returns three additional products with the same list prices as the third one.

Summary 
Use the SQL Server SELECT TOP statement to limit the number of rows or percentage of rows returned by a query.
---------------------------------------------------

SQL Server SELECT DISTINCT
Summary: in this tutorial, you will learn how to use the SQL Server SELECT DISTINCT clause to return distinct rows from a result set.

Introduction to SQL Server SELECT DISTINCT clause 
Sometimes, you may want to get only distinct values in a specified column of a table. To achieve this, you can use the SELECT DISTINCT clause.

Here’s how you can do it:

SELECT 
  DISTINCT column_name 
FROM 
  table_name;
Code language: SQL (Structured Query Language) (sql)
The query will return unique values from the column column_name. In other words, it removes duplicate values from the column_name in the result set.

If you use the DISTINCT clause with multiple columns as follows:

SELECT DISTINCT
	column_name1,
	column_name2 ,
	...
FROM
	table_name;
Code language: SQL (Structured Query Language) (sql)
The query will evaluate the uniqueness based on the combination of values in all the specified columns in the SELECT list. It will return only rows with unique combinations of the specified columns.

When you apply the DISTINCT clause to a column that contains NULLs, it will keep only one NULL and eliminate the others. In other words, the DISTINCT clause treats all NULLs as the same value.

SQL Server SELECT DISTINCT examples 
We will use the customers table from the sample database for the demonstration:


1) Using the SELECT DISTINCT with one column 
The following statement uses the SELECT statement to retrieve all cities of all customers from the customers tables:

SELECT 
  city 
FROM 
  sales.customers 
ORDER BY 
  city;
Code language: SQL (Structured Query Language) (sql)
SQL Server SELECT DISTINCT - duplicate cities
The output indicates that the cities are duplicates.

To retrieve only distinct cities, you can use the SELECT DISTINCT keyword as follows:

SELECT 
  DISTINCT city 
FROM 
  sales.customers 
ORDER BY 
  city;
Code language: SQL (Structured Query Language) (sql)
SQL Server SELECT DISTINCT - distinct cities
The output shows that the SELECT DISTINCT returns only distinct cities without duplicates.

2) Using SELECT DISTINCT with multiple columns 
The following example uses the SELECT statement to retrieve the cities and states of all customers from the customers table:

SELECT 
  city, 
  state 
FROM 
  sales.customers 
ORDER BY 
  city, 
  state;
Code language: SQL (Structured Query Language) (sql)
SQL Server SELECT DISTINCT - multiple columns example before
The output indicates that there are duplicate cities & states, for example, Albany NY, Amarillo TX, and so on.

To retrieve the distinct cities and states of customers, you can use the SELECT DISTINCT with the city and state columns:

SELECT 
  DISTINCT city, state 
FROM 
  sales.customers
Code language: SQL (Structured Query Language) (sql)
SQL Server SELECT DISTINCT - multiple columns example
In this example, the statement uses the combination of values in both city and state columns to evaluate the duplicate.

3) Using SELECT DISTINCT with NULL 
The following statement finds the distinct phone numbers of customers:

SELECT 
  DISTINCT phone 
FROM 
  sales.customers 
ORDER BY 
  phone;
Code language: SQL (Structured Query Language) (sql)
SQL Server SELECT DISTINCT - null example
In this example, the DISTINCT clause keeps only one NULL in the phone column and removes other NULLs.

DISTINCT vs. GROUP BY 
The following statement uses the GROUP BY clause to return distinct cities together with state and zip code from the sales.customers table:

SELECT 
  city, 
  state, 
  zip_code 
FROM 
  sales.customers 
GROUP BY 
  city, 
  state, 
  zip_code 
ORDER BY 
  city, 
  state, 
  zip_code
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial output:

SQL Server SELECT DISTINCT vs GROUP BY
It is equivalent to the following query that uses the DISTINCT operator :

SELECT 
  DISTINCT city, state, zip_code 
FROM 
  sales.customers;
Code language: SQL (Structured Query Language) (sql)
Both DISTINCT and GROUP BY clause reduces the number of returned rows in the result set by removing the duplicates.

However, you should use the GROUP BY clause when you want to apply an aggregate function to one or more columns.

Summary 
Use the SQL Server SELECT DISTINCT clause to retrieve the distinct values from one or more columns.
 

 --------------------------------------------


SQL Server WHERE Clause
Summary: in this tutorial, you will learn how to use the SQL Server WHERE clause to filter rows returned by a query.

Introduction to SQL Server WHERE clause 
The SELECT statement retrieves all rows from a table. However, this is often unnecessary because the application may only need to process a subset of rows at the time.

To retrieve rows that satisfy one or more conditions, you use the WHERE clause in the SELECT statement.

Here’s the syntax of the WHERE clause:

SELECT
    select_list
FROM
    table_name
WHERE
    search_condition;
Code language: SQL (Structured Query Language) (sql)
In this syntax, the search_condition is a logical expression or a combination of multiple logical expressions. In SQL, a logical expression is also known as a predicate.

In the WHERE clause, you specify a search condition to filter rows returned by the FROM clause. The WHERE clause only returns the rows for which the search_condition evaluates to TRUE.

Note that SQL Server uses three-valued predicate logic where a logical expression can evaluate to TRUE, FALSE, or UNKNOWN. The WHERE clause will not return any row that causes the predicate to evaluate to FALSE or UNKNOWN.

SQL Server WHERE examples 
We will use the production.products table from the sample database for the demonstration.

Products Table
1) Using the WHERE clause with a simple equality operator 
The following query uses a WHERE clause to retrieve products with the category ID 1:

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    category_id = 1
ORDER BY
    list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:


2) Using the WHERE clause with the AND operator 
The following example uses a WHERE clause to find products that belong to category id 1 and the model 2018:

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    category_id = 1 AND model_year = 2018
ORDER BY
    list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server WHERE - match two conditions
In this example, the condition in the WHERE clause uses the logical operator AND to combine the two conditions.

3) Using WHERE to filter rows using a comparison operator 
The following statement finds the products with a list price greater than 300 and the model of 2018.

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price > 300 AND model_year = 2018
ORDER BY
    list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server WHERE - comparison operators
4) Using the WHERE clause to filter rows that meet any of two conditions 
The following query uses a WHERE clause to find products that meet either condition: a list price greater than 3,000 or the model of 2018:

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price > 3000 OR model_year = 2018
ORDER BY
    list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server WHERE - match any of two conditions
Note that the WHERE clause uses the OR operator to combine conditions.

5) Using the WHERE clause to filter rows with the value between two values 
The following statement finds the products with list prices between 1,899 and 1,999.99:

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price BETWEEN 1899.00 AND 1999.99
ORDER BY
    list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server WHERE - between operator
6) Using the WHERE clause to filter rows that have a value in a list of values 
The following example uses the IN operator to find products with a list price of 299.99, 466.99, or 489.99.

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price IN (299.99, 369.99, 489.99)
ORDER BY
    list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server WHERE - IN operator
7) Finding rows whose values contain a string 
The following example uses the LIKE operator to find products whose name contains the string Cruiser:

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    product_name LIKE '%Cruiser%'
ORDER BY
    list_price;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server WHERE - LIKE operator  

-----------------------------------------------------

SQL Server AND Operator
Summary: in this tutorial, you will learn how to use the SQL Server AND operator to combine multiple Boolean expressions.

Introduction to SQL Server AND operator 
The AND is a logical operator that allows you to combine two Boolean expressions. It returns TRUE only when both expressions are evaluated to TRUE.

The following illustrates the syntax of the AND operator:

boolean_expression AND boolean_expression 
Code language: SQL (Structured Query Language) (sql)
The boolean_expression is any valid Boolean expression that evaluates to TRUE, FALSE, and UNKNOWN.

The following table shows the result when you combine TRUE, FALSE, and UNKNOWN values using the AND operator:

TRUE	FALSE	UNKNOWN
TRUE	TRUE	FALSE	UNKNOWN
FALSE	FALSE	FALSE	FALSE
UNKNOWN	UNKNOWN	FALSE	UNKNOWN
When you use more than one logical operator in an expression, SQL Server always evaluates the AND operators first. However, you can change the order of evaluation by using parentheses ().

SQL Server AND operator examples 
We’ll use the following products table from the sample database:


1) Basic SQL Server AND operator example 
The following example uses the AND operator to find the products with the category ID 1 and the list price greater than 400:

SELECT 
  * 
FROM 
  production.products 
WHERE 
  category_id = 1 
  AND list_price > 400 
ORDER BY 
  list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server AND operator example
2) Using multiple SQL Server AND operators 
The following statement uses the AND operator to find products that meet all the following conditions: category ID is 1, the list price is greater than 400, and the brand ID is 1:

SELECT 
  * 
FROM 
  production.products 
WHERE 
  category_id = 1 
  AND list_price > 400 
  AND brand_id = 1 
ORDER BY 
  list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server AND multiple operators example
3) Using the AND operator with other logical operators 
The following example shows how to use the AND with the OR operator:

SELECT
    *
FROM
    production.products
WHERE
    brand_id = 1
OR brand_id = 2
AND list_price > 1000
ORDER BY
    brand_id DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server AND and OR operators example
In this example, we used both OR and AND operators in the condition of the WHERE clause. SQL Server always evaluates the AND operator first. Therefore, the query retrieves the products with brand ID 2 and list price greater than 1,000 or brand ID 1.

To retrieve products with brand ID 1 or 2 and a list price larger than 1,000, you can use parentheses as follows:

SELECT
    *
FROM
    production.products
WHERE
    (brand_id = 1 OR brand_id = 2)
AND list_price > 1000
ORDER BY
    brand_id;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server AND and OR operators with parentheses
Summary 
Use the AND operator to combine two Boolean expressions.
The AND operator returns TRUE only if both expressions are TRUE. 


-----------------------------------------------

SQL Server OR Operator
Summary: in this tutorial, you will learn how to use the SQL Server OR operator to combine two Boolean expressions.

Introduction to SQL Server OR operator 
The SQL Server OR is a logical operator that allows you to combine two Boolean expressions. It returns TRUE when either of the conditions evaluates to TRUE.

The following shows the syntax of the OR operator:

boolean_expression OR boolean_expression
Code language: SQL (Structured Query Language) (sql)
In this syntax, the boolean_expression is any valid Boolean expression that evaluates to true, false, and unknown.

The following table shows the results of the OR operator when you combine TRUE, FALSE, and UNKNOWN:

TRUE	FALSE	UNKNOWN
TRUE	TRUE	TRUE	TRUE
FALSE	TRUE	FALSE	UNKNOWN
UNKNOWN	TRUE	UNKNOWN	UNKNOWN
When you use multiple logical operators in an expression, SQL Server always evaluates the OR operators after AND operators. But you can use the parentheses () to change the order of the evaluation.

SQL Server OR operator examples 
We’ll use the following production.roducts table from the sample database.


1) Basic SQL Server OR operator example 
The following example uses the OR operator to find the products whose list price is less than 200 or greater than 6,000:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price < 200
OR list_price > 6000
ORDER BY
    list_price;
Code language: SQL (Structured Query Language) (sql)
SQL Server OR example
2) Using multiple OR operators 
The following statement uses multiple OR operators to find the products whose brand id is 1, 2, or 4:

SELECT
    product_name,
    brand_id
FROM
    production.products
WHERE
    brand_id = 1
OR brand_id = 2
OR brand_id = 4
ORDER BY
    brand_id DESC;
Code language: SQL (Structured Query Language) (sql)

You can replace multiple OR operators by the IN operator as shown in the following query:

SELECT
    product_name,
    brand_id
FROM
    production.products
WHERE
    brand_id IN (1, 2, 3)
ORDER BY
    brand_id DESC;
Code language: SQL (Structured Query Language) (sql)
3) Combining the OR operator with the AND operator 
The following example shows how to combine the OR operator with the AND operator within the same expression:

SELECT 
    product_name, 
    brand_id, 
    list_price
FROM 
    production.products
WHERE 
    brand_id = 1
      OR brand_id = 2
      AND list_price > 500
ORDER BY 
    brand_id DESC, 
    list_price;
Code language: SQL (Structured Query Language) (sql)
SQL Server OR with AND operator
In this example, we used both OR and AND operators. As always, SQL Server evaluated the AND operator first. Therefore, the query returned the products whose brand id is 2 and the list price is greater than 500 or those whose brand id is 1.

To find the products whose brand id is 1 or 2 and list price is greater than 500, you use the parentheses as shown in the following query:

SELECT
    product_name,
    brand_id,
    list_price
FROM
    production.products
WHERE
    (brand_id = 1 OR brand_id = 2)
     AND list_price > 500
ORDER BY
    brand_id;
Code language: SQL (Structured Query Language) (sql)

Summary 
Use the SQL Server OR operator to combine two Boolean expressions.
The OR operator returns TRUE if one of the expressions is TRUE.
By default, SQL Server evaluates the OR operators after the AND operators within the same expression. But you can use parentheses () to change the order of evaluation. 

----------------------------------------------------

SQL Server IN Operator
Summary: in this tutorial, you will learn how to use the SQL Server IN operator to check whether a value matches any value in a list.

SQL Server IN operator overview 
The IN operator is a logical operator that allows you to check whether a value matches any value in a list.

The following shows the syntax of the SQL Server IN operator:

column | expression IN ( v1, v2, v3, ...)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the column or expression to test.
Second, specify a list of values to test. All the values must have the same type as the type of the column or expression.
If a value in the column or the expression is equal to any value in the list, the result of the IN operator is TRUE.

The IN operator is equivalent to multiple OR operators, therefore, the following predicates are equivalent:

column IN (v1, v2, v3)

column = v1 OR column = v2 OR column = v3
Code language: SQL (Structured Query Language) (sql)
To negate the IN operator, you use the NOT IN operator as follows:

column | expression NOT IN ( v1, v2, v3, ...)
Code language: SQL (Structured Query Language) (sql)
The result the NOT IN operator is TRUE if the column or expression does not equal any value in the list.

In addition to a list of values, you can use a subquery that returns a list of values with the IN operator as shown below:

column | expression IN (subquery)
Code language: SQL (Structured Query Language) (sql)
In this syntax, the subquery is a SELECT statement that returns a list of values of a single column.

Note that if a list contains NULL, the result of IN or NOT IN will be UNKNOWN.

SQL Server IN operator examples 
We’ll use following production.products table from the sample database.


1) Basic SQL Server IN operator example 
The following statement uses the IN operator to find products whose list price is one of the following values: 89.99, 109.99, and 159.99:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price IN (89.99, 109.99, 159.99)
ORDER BY
    list_price;
Code language: SQL (Structured Query Language) (sql)
SQL Server IN example
The query above is equivalent to the following query that uses the OR operator instead:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price = 89.99 OR list_price = 109.99 OR list_price = 159.99
ORDER BY
    list_price;
Code language: SQL (Structured Query Language) (sql)
To find the products whose list prices are not one of the prices 89.99, 109.99, and 159.99, you use the NOT IN operator. For example:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price NOT IN (89.99, 109.99, 159.99)
ORDER BY
    list_price;
Code language: SQL (Structured Query Language) (sql)
SQL Server NOT IN example
2) Using SQL Server IN operator with a subquery example 
The following query returns a list of product identification numbers of the products located in store id 1 and has a quantity greater than or equal to 30:

SELECT
    product_id
FROM
    production.stocks
WHERE
    store_id = 1 AND quantity >= 30;
Code language: SQL (Structured Query Language) (sql)
SQL Server IN - simple query
You can use the query above as a subquery as shown in the following query:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_id IN (
        SELECT
            product_id
        FROM
            production.stocks
        WHERE
            store_id = 1 AND quantity >= 30
    )
ORDER BY
    product_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server IN with subquery example
In this example:

First, the subquery returned a list of product id.
Second, the outer query retrieved the product names and list prices of the products whose product id matches any value returned by the subquery.
For more information on the subquery, check out the subquery tutorial.

Summary 
Use the SQL Server IN operator to check whether a value matches any value in a list or is returned by a subquery.


---------------------------------------------

SQL Server BETWEEN Operator
Summary: in this tutorial, you will learn how to use the SQL Server BETWEEN operator to specify a range to test.

Overview of the SQL Server BETWEEN operator 
The BETWEEN operator is a logical operator that allows you to specify a range to test.

The following illustrates the syntax of the BETWEEN operator:

column | expression BETWEEN start_expression AND end_expression
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the column or expression to test.
Second, place the  start_expression and end_expression between the BETWEEN and the AND keywords. The start_expression, end_expression and the expression to test must have the same data type.
The BETWEEN operator returns TRUE if the expression to test is greater than or equal to the value of the start_expression and less than or equal to the value of the end_expression.

You can use the greater than or equal to (>=) and less than or equal to (<=) to substitute the BETWEEN operator as follows:

column | expression <= end_expression AND column | expression >= start_expression   
Code language: SQL (Structured Query Language) (sql)
The condition that uses the BETWEEN operator is much more readable than the one that uses the comparison operators >=, <= and the logical operator AND.

To negate the result of the BETWEEN operator, you use NOT BETWEEN operator as follows:

column | expression NOT BETWEEN start_expression AND end_expresion
Code language: SQL (Structured Query Language) (sql)
The NOT BETWEEN returns TRUE if the value in the column or expression is less than the value of the  start_expression and greater than the value of the end_expression. It is equivalent to the following condition:

column | expression < start_expression AND column | expression > end_expression
Code language: SQL (Structured Query Language) (sql)
Note that if any input to the BETWEEN or NOT BETWEEN is NULL, then the result is UNKNOWN.

SQL Server BETWEEN examples 
Let’s take some examples of using the BETWEEN operator to understand how it works.

A) Using SQL Server BETWEEN with numbers example 
See the following products table from the sample database:


The following query finds the products whose list prices are between 149.99 and 199.99:

SELECT
    product_id,
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price BETWEEN 149.99 AND 199.99
ORDER BY
    list_price;
Code language: SQL (Structured Query Language) (sql)
SQL Server BETWEEN Example
To get the products whose list prices are not in the range of 149.99 and 199.99, you use the NOT BETWEEN operator as follows:

SELECT
    product_id,
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price NOT BETWEEN 149.99 AND 199.99
ORDER BY
    list_price;
Code language: SQL (Structured Query Language) (sql)
SQL Server NOT BETWEEN example
B) Using SQL Server BETWEEN with dates example 
Consider the following orders table:


The following query finds the orders that customers placed between January 15, 2017 and January 17, 2017:

SELECT
    order_id,
    customer_id,
    order_date,
    order_status
FROM
    sales.orders
WHERE
    order_date BETWEEN '20170115' AND '20170117'
ORDER BY
    order_date;
Code language: SQL (Structured Query Language) (sql)
SQL Server BETWEEN dates example
Notice that to specify a literal date, you use the format ‘YYYYMMDD‘ where YYYY is 4-digit year e.g., 2017, MM is 2-digits month e.g., 01 and DD is 2-digits day e.g., 15.

In this tutorial, you have learned how to use the SQL Server BETWEEN operator to form a condition that tests against a range of values.

------------------------------------------------

SQL Server LIKE Operator
Summary: in this tutorial, you will learn how to use the SQL Server LIKE operator to check whether a character string matches a specified pattern.

Introduction to SQL Server LIKE operator 
The SQL Server LIKE operator is a logical operator that checks if a character string matches a specified pattern.

A pattern may include regular characters and wildcard characters. The LIKE operator is used in the WHERE clause of the SELECT, UPDATE, and DELETE statements to filter rows based on pattern matching.

Here’s the syntax of the LIKE operator:

column | expression LIKE pattern [ESCAPE escape_character]
Code language: SQL (Structured Query Language) (sql)
Pattern 
The pattern is a sequence of characters to search for in the column or expression. It can include the following valid wildcard characters:

The percent wildcard (%): any string of zero or more characters.
The underscore (_) wildcard: any single character.
The [list of characters] wildcard: any single character within the specified set.
The [character-character]: any single character within the specified range.
The [^]: any character that is not within a list or a range.
The wildcard characters make the LIKE operator more flexible than the equal (=) and not equal (!=) string comparison operators.

Escape character 
The escape character instructs the LIKE operator to treat the wildcard characters as regular characters. The escape character has no default value and must be evaluated to only one character.

The LIKE operator returns TRUE if the column or expression matches the specified pattern.

To negate the result of the LIKE operator, you use the NOT operator as follows:

column | expression NOT LIKE pattern [ESCAPE escape_character]
Code language: SQL (Structured Query Language) (sql)
SQL Server LIKE operator examples 
We’ll use the following customers table from the sample database:

customers table
1) Using the LIKE operator with the % wildcard examples 
The following example uses the LIKE operator with the % wildcard to find the customers whose last name starts with the letter z:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE 'z%'
ORDER BY
    first_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server LIKE example
The following example uses the LIKE operator with the % wildcard to return the customers whose last name ends with the string er:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '%er'
ORDER BY
    first_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server LIKE percent example
The following statement uses the LIKE operator to retrieve the customers whose last name starts with the letter t and ends with the letter s:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE 't%s'
ORDER BY
    first_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server LIKE percent wildcard example
2) Using the LIKE operator with the _ (underscore) wildcard example 
The underscore represents a single character. For example, the following statement returns the customers where the second character is the letter u:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '_u%'
ORDER BY
    first_name; 
Code language: SQL (Structured Query Language) (sql)
SQL Server LIKE underscore wildcard example
The pattern _u%

The first underscore character ( _) matches any single character.
The second letter u matches the letter u exactly.
The third character % matches any sequence of characters.
3) Using the LIKE operator with the [list of characters] wildcard example 
The square brackets with a list of characters e.g., [ABC] represents a single character that must be one of the characters specified in the list.

For example, the following query returns the customers where the first character in the last name is Y or Z:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[YZ]%'
ORDER BY
    last_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server LIKE character list example
4) Using the LIKE operator with the [character-character] wildcard example 
The square brackets with a character range e.g., [A-C] represent a single character that must be within a specified range.

For example, the following query finds the customers where the first character in the last name is the letter in the range A through C:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[A-C]%'
ORDER BY
    first_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server LIKE range example
5) Using the LIKE operator with the [^Character List or Range] wildcard example 
The square brackets with a caret sign (^) followed by a range e.g., [^A-C] or character list e.g., [ABC] represent a single character that is not in the specified range or character list.

For example, the following query returns the customers where the first character in the last name is not the letter in the range A through X:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[^A-X]%'
ORDER BY
    last_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server LIKE caret example
6) Using the NOT LIKE operator example 
The following example uses the NOT LIKE operator to find customers where the first character in the first name is not the letter A:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    first_name NOT LIKE 'A%'
ORDER BY
    first_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server NOT LIKE example
7) Using the LIKE operator with ESCAPE example 
First, create a new table for the demonstration:

CREATE TABLE sales.feedbacks (
  feedback_id INT IDENTITY(1, 1) PRIMARY KEY, 
  comment VARCHAR(255) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Second, insert some rows into the sales.feedbacks table:

INSERT INTO sales.feedbacks(comment)
VALUES('Can you give me 30% discount?'),
      ('May I get me 30USD off?'),
      ('Is this having 20% discount today?');
Code language: SQL (Structured Query Language) (sql)
Third, query data from the sales.feedbacks table:

SELECT * FROM sales.feedbacks;
Code language: SQL (Structured Query Language) (sql)
SQL Server LIKE - sample table
If you want to search for 30% in the comment column, you may come up with a query like this:

SELECT 
   feedback_id,
   comment
FROM 
   sales.feedbacks
WHERE 
   comment LIKE '%30%';
Code language: SQL (Structured Query Language) (sql)
SQL Server LIKE without ESCAPE clause
The query returns comments that contain 30% and 30 USD, which is not what we expected.

To address this issue, you can use the ESCAPE clause:

SELECT 
   feedback_id, 
   comment
FROM 
   sales.feedbacks
WHERE 
   comment LIKE '%30!%%' ESCAPE '!';
Code language: SQL (Structured Query Language) (sql)
SQL Server LIKE with ESCAPE clause
In this query, the  ESCAPE clause specified that the character ! is the escape character.

It instructs the LIKE operator to treat the % character as a literal string instead of a wildcard. Note that without the ESCAPE clause, the query would return an empty result set.

Summary 
Use the LIKE operator to check if a value matches a specified pattern.
Use the NOT operator to negate the LIKE operator.

------------------------------------------------

SQL Server Alias
Summary: in this tutorial, you will learn how to use the SQL Server aliases, including column aliases and table aliases.

SQL Server column alias 
When you use the SELECT statement to query data from a table, SQL Server uses the column names as the column headings for the output. For example:

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name;
Code language: SQL (Structured Query Language) (sql)

The output indicates that the SQL Server uses the first_name and last_name column names as the column headings respectively.

To obtain the full names of customers, you can concatenate the first name, space, and the last name using the concatenation  + operator as shown in the following query:

SELECT
    first_name + ' ' + last_name
FROM
    sales.customers
ORDER BY
    first_name;
Code language: SQL (Structured Query Language) (sql)

SQL Server returns the full name column as ( No column name) which is not meaningful in this case.

To assign a column or an expression a temporary name during the query execution, you use a column alias.

The following illustrates the column alias syntax:

column_name | expression  AS column_alias
Code language: SQL (Structured Query Language) (sql)
In this syntax, you use the AS keyword to separate the column name or expression and the alias.

Because the AS keyword is optional, you can assign an alias to a column as follows:

column_name | expression column_alias
Code language: SQL (Structured Query Language) (sql)
Back to the example above, you can rewrite the query using a column alias:

SELECT
    first_name + ' ' + last_name AS full_name
FROM
    sales.customers
ORDER BY
    first_name;
Code language: SQL (Structured Query Language) (sql)
Note that if the column alias contains spaces, you need to enclose it in quotation marks, as shown in the following example:

SELECT
    first_name + ' ' + last_name AS 'Full Name'
FROM
    sales.customers
ORDER BY
    first_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server Alias - column alias with space example
The following example shows how to assign an alias to a column:

SELECT
    category_name 'Product Category'
FROM
    production.categories;
Code language: SQL (Structured Query Language) (sql)
SQL Server Alias - column alias
In this example, the product category column alias is much more clear than the category_name column name.

When you assign a column an alias, you can use either the column name or the column alias in the ORDER BY clause as shown in the following example:

SELECT
    category_name 'Product Category'
FROM
    production.categories
ORDER BY
    category_name;  


SELECT
    category_name 'Product Category'
FROM
    production.categories
ORDER BY
    'Product Category';
Code language: SQL (Structured Query Language) (sql)
Note that SQL Server processes the ORDER BY clause after the SELECT clause, so you can use column aliases in the ORDER BY clause.

SQL Server table alias 
A table can be given an alias, which is known as a correlation name or range variable.

Similar to the column alias, you can assign a table a temporary name with or without the AS keyword:

table_name AS table_alias
table_name table_alias
Code language: SQL (Structured Query Language) (sql)
For example:

SELECT
    sales.customers.customer_id,
    first_name,
    last_name,
    order_id
FROM
    sales.customers
INNER JOIN sales.orders ON sales.orders.customer_id = sales.customers.customer_id;
Code language: SQL (Structured Query Language) (sql)
SQL Server Alias - table alias
In this example, both the customers and the orders tables have a column with the same name customer_id, so you need to refer to the column using the following syntax:

table_name.column_name
Code language: SQL (Structured Query Language) (sql)
such as:

sales.custoners.customer_id
sales.orders.customer_id
Code language: SQL (Structured Query Language) (sql)
If you don’t do so, the SQL server will issue an error.

The query above is quite difficult to read. Fortunately, you can improve its readability by using the table alias as follows:

SELECT
    c.customer_id,
    first_name,
    last_name,
    order_id
FROM
    sales.customers c
INNER JOIN sales.orders o ON o.customer_id = c.customer_id;
Code language: SQL (Structured Query Language) (sql)
In this query, c is the alias for the sales.customers table and o is the alias for the sales.orders table.

When you assign an alias to a table, you must use the alias to refer to the table column. Otherwise, SQL Server will issue an error.

Summary 
A column alias is a temporary name assigned to a column or an expression in a query’s result set.
Use a column alias to rename the output of a column or an expression to make it more meaningful.
A table alias is a shorthand or temporary name assigned to a table in a query.
Use table aliases when joining multiple tables or when referencing the same table more than once in a query.


-------------------------------------------------

SQL Server Joins
Summary: in this tutorial, you will learn about various SQL Server joins that allow you to combine data from two tables.

In a relational database, data is distributed in multiple logical tables. To get a complete meaningful set of data, you need to query data from these tables using joins. SQL Server supports many kinds of joins, including inner join, left join, right join, full outer join, and cross join. Each join type specifies how SQL Server uses data from one table to select rows in another table.

Let’s set up sample tables for demonstration.

Setting up sample tables 
First, create a new schema named hr:

CREATE SCHEMA hr;
GO
Code language: SQL (Structured Query Language) (sql)
Second, create two new tables named candidates and employees in the hr schema:

CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Third, insert some rows into the candidates and employees tables:

INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');


INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');
Code language: SQL (Structured Query Language) (sql)
Let’s call the candidates table the left table and the employees table the right table.

SQL Server Inner Join 
Inner join produces a data set that includes rows from the left table, and matching rows from the right table.

The following example uses the inner join clause to get the rows from the candidates table that has the corresponding rows with the same values in the fullname column of the employees table:

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    INNER JOIN hr.employees e 
        ON e.fullname = c.fullname;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Joins - Inner Join
The following Venn diagram illustrates the result of the inner join of two result sets:

SQL Server Joins - Inner Join
SQL Server Left Join 
Left join selects data starting from the left table and matching rows in the right table. The left join returns all rows from the left table and the matching rows from the right table. If a row in the left table does not have a matching row in the right table, the columns of the right table will have nulls.

The left join is also known as the left outer join. The outer keyword is optional.

The following statement joins the candidates table with the employees table using left join:

SELECT  
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM 
	hr.candidates c
	LEFT JOIN hr.employees e 
		ON e.fullname = c.fullname;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Joins - left Join
The following Venn diagram illustrates the result of the left join of two result sets:


To get the rows that are available only in the left table but not in the right table, you add a WHERE clause to the above query:

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    LEFT JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE 
    e.id IS NULL;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server Joins - left Join with a where clause
The following Venn diagram illustrates the result of the left join that selects rows available only in the left table:

SQL Server Joins - Left Join with only rows in the left table
SQL Server Right Join 
The right join or right outer join selects data starting from the right table. It is a reversed version of the left join.

The right join returns a result set that contains all rows from the right table and the matching rows in the left table. If a row in the right table does not have a matching row in the left table, all columns in the left table will contain nulls.

The following example uses the right join to query rows from candidates and employees tables:

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    RIGHT JOIN hr.employees e 
        ON e.fullname = c.fullname;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Joins - right Join
Notice that all rows from the right table (employees) are included in the result set.

The Venn diagram illustrates the right join of two result sets:


Similarly, you can get rows that are available only in the right table by adding a WHERE clause to the above query as follows:

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    RIGHT JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE
    c.id IS NULL;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Joins - right Join with a where clause
And the Venn diagram that illustrates the operation:

SQL Server Joins - Right Join with only rows in the right table
SQL Server full join 
The full outer join or full join returns a result set that contains all rows from both left and right tables, with the matching rows from both sides where available. In case there is no match, the missing side will have NULL values.

The following example shows how to perform a full join between the candidates and employees tables:

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    FULL JOIN hr.employees e 
        ON e.fullname = c.fullname;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Joins - full Join
The Venn diagram that illustrates the full outer join:

SQL Server Joins - full outer Join
To select rows that exist in either the left or right table, you exclude rows that are common to both tables by adding a WHERE clause as shown in the following query:

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    FULL JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE
    c.id IS NULL OR
    e.id IS NULL;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Joins - full Join with a where clause
The Venn diagram illustrates the above operation:

SQL Server Joins - full outer Join with rows unique to both tables
In this tutorial, you have learned various SQL Server joins that combine data from two tables.

  

  -------------------------------------------------

  SQL Server Inner Join
Summary: in this tutorial, you will learn how to use the SQL Server INNER JOIN clause to query data from multiple tables.

Introduction to SQL Server INNER JOIN clause 
The inner join is one of the most commonly used joins in SQL Server. The inner join clause allows you to query data from two or more related tables.

See the following products and categories tables:

Products & Categories Tables
The following statement retrieves the product information from the production.products table:

SELECT
    product_name,
    list_price,
    category_id
FROM
    production.products
ORDER BY
    product_name DESC;
Code language: SQL (Structured Query Language) (sql)
SQL Server Inner Join Sample Table
The query returned only a list of category identification numbers, not the category names. To include the category names in the result set, you use the INNER JOIN clause as follows:

SELECT
    product_name,
    category_name,
    list_price
FROM
    production.products p
INNER JOIN production.categories c 
    ON c.category_id = p.category_id
ORDER BY
    product_name DESC;
Code language: SQL (Structured Query Language) (sql)
SQL Server Inner Join example
In this query:

The c and p are the table aliases of the production.categories  and  production.products tables.

By doing this, when you reference a column in these tables, you can use the alias.column_name instead of using the table_name.column_name.

For example, the query uses c.category_id instead of production.categories.category_id. Hence, it saves you some typing.

For each row in the production.products table, the inner join clause matches it with every row in the product.categories table based on the values of the category_id column:

If both rows have the same value in the category_id column, the inner join forms a new row whose columns are from the rows of the production.categories and production.products tables according to the columns in the select list and includes this new row in the result set.
If the row in the production.products table doesn’t match the row from the production.categories table, the inner join clause just ignores these rows and does not include them in the result set.
SQL Server INNER JOIN syntax 
The following shows the syntax of the SQL Server INNER JOIN clause:

SELECT
    select_list
FROM
    T1
INNER JOIN T2 ON join_predicate;
Code language: SQL (Structured Query Language) (sql)
In this syntax, the query retrieved data from both T1 and T2 tables:

First, specify the main table (T1) in the FROM clause
Second, specify the second table in the INNER JOIN clause (T2) and a join predicate. Only rows that cause the join predicate to evaluate to TRUE are included in the result set.
The INNER JOIN clause compares each row of table T1 with rows of table T2 to find all pairs of rows that satisfy the join predicate. If the join predicate evaluates to TRUE, the column values of the matching rows of T1 and T2 are combined into a new row and included in the result set.

The following table illustrates the inner join of two tables T1 (1,2,3) and T2 (A, B, C). The result includes rows: (2, A) and (3, B) as they have the same patterns.

SQL Server INNER JOIN
Note that the INNER keyword is optional, you can skip it as shown in the following query:

SELECT
    select_list
FROM
    T1
JOIN T2 ON join_predicate;
Code language: SQL (Structured Query Language) (sql)
More SQL Server inner join examples 
See the following products, categories, and brands tables:

Categories, products & brands tables
The following statement uses two INNER JOIN clauses to query data from the three tables:

SELECT
    product_name,
    category_name,
    brand_name,
    list_price
FROM
    production.products p
INNER JOIN production.categories c ON c.category_id = p.category_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
ORDER BY
    product_name DESC;
Code language: SQL (Structured Query Language) (sql)
SQL Server Inner Join clause - select from three tables example
In this tutorial, you have learned how to use the SQL Server INNER JOIN clause to query data from multiple tables.

----------------------------------------------------

SQL Server Left Join
Summary: in this tutorial, you will learn about the SQL Server LEFT JOIN clause and how to query data from multiple tables.

Introduction to SQL Server LEFT JOIN clause 
The LEFT JOIN is a clause of the SELECT statement. The LEFT JOIN clause allows you to query data from multiple tables.

The LEFT JOIN returns all rows from the left table and the matching rows from the right table. If no matching rows are found in the right table, NULL are used.

The following illustrates how to join two tables T1 and T2 using the LEFT JOIN clause:

SELECT
    select_list
FROM
    T1
LEFT JOIN T2 ON
    join_predicate;
Code language: SQL (Structured Query Language) (sql)
In this syntax, T1 and T2 are the left and right tables, respectively.

For each row from the T1 table, the query compares it with all the rows from the T2 table. If a pair of rows causes the join predicate to evaluate to TRUE, the column values from these rows will be combined to form a new row which is then included in the result set.

If a row from the left table (T1) does not have any matching row from the T2 table, the query combines column values of the row from the left table with NULL for each column value from the right table.

In short, the LEFT JOIN clause returns all rows from the left table (T1) and matching rows or NULL values from the right table (T2).

The following illustrates the LEFT JOIN of two tables T1(1, 2, 3) and T2(A, B, C). The LEFT JOIN will match rows from the T1 table with the rows from the T2 table using patterns:

SQL Server LEFT JOIN
In this illustration, no row from the T2 table matches row 1 from the T1 table; therefore, NULL is used. Rows 2 and 3 from the T1 table match rows A and B from the T2 table, respectively.

SQL Server LEFT JOIN example 
See the following products and order_items tables:

The order_items & products Tables
Each sales order item includes one product. The link between the order_items and the products tables is the product_id column.

The following statement uses the LEFT JOIN clause to query data from the products and order_items tables:

SELECT
    product_name,
    order_id
FROM
    production.products p
LEFT JOIN sales.order_items o ON o.product_id = p.product_id
ORDER BY
    order_id;
Code language: SQL (Structured Query Language) (sql)
SQL Server Left Join example
As you see clearly from the result set, a list of NULL in the order_id column indicates that the corresponding products have not been sold to any customer yet.

It is possible to use the WHERE clause to limit the result set. The following query returns the products that do not appear in any sales order:

SELECT
    product_name,
    order_id
FROM
    production.products p
LEFT JOIN sales.order_items o ON o.product_id = p.product_id
WHERE order_id IS NULL
Code language: SQL (Structured Query Language) (sql)
SQL Server Left Join find unmatching rows
As always, SQL Server processes the WHERE clause after the LEFT JOIN clause.

The following example shows how to join three tables: production.products, sales.orders, and sales.order_items using the LEFT JOIN clauses:


SELECT
    p.product_name,
    o.order_id,
    i.item_id,
    o.order_date
FROM
    production.products p
	LEFT JOIN sales.order_items i
		ON i.product_id = p.product_id
	LEFT JOIN sales.orders o
		ON o.order_id = i.order_id
ORDER BY
    order_id;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server LEFT JOIN - join three tables
SQL Server LEFT JOIN: conditions in ON vs. WHERE clause 
The following query finds the products that belong to order id 100:

SELECT
    product_name,
    order_id
FROM
    production.products p
LEFT JOIN sales.order_items o 
   ON o.product_id = p.product_id
WHERE order_id = 100
ORDER BY
    order_id;
Code language: SQL (Structured Query Language) (sql)
SQL Server Left Join and WHERE clause
Let’s move the condition order_id = 100 to the ON clause:

SELECT
    p.product_id,
    product_name,
    order_id
FROM
    production.products p
    LEFT JOIN sales.order_items o 
         ON o.product_id = p.product_id AND 
            o.order_id = 100
ORDER BY
    order_id DESC;
Code language: SQL (Structured Query Language) (sql)
SQL Server LEFT JOIN - move condition to ON clause
The query returned all products, but only the order with id 100 has the associated product’s information.

Note that for the INNER JOIN clause, the condition in the ON clause is functionally equivalent if it is placed in the WHERE clause.

In this tutorial, you have learned how to use the SQL Server LEFT JOIN clause to retrieve data from multiple related tables.

  --------------------------------------------

  SQL Server Right Join
Summary: in this tutorial, you will learn how to use the SQL Server RIGHT JOIN clause to query data from two tables.

Introduction to the SQL Server RIGHT JOIN clause 
The RIGHT JOIN is a clause of the SELECT statement. The RIGHT JOIN clause combines data from two or more tables.

The RIGHT JOIN clause starts selecting data from the right table and matching it with the rows from the left table. The RIGHT JOIN returns a result set that includes all rows in the right table, whether or not they have matching rows from the left table.

If a row in the right table does not have any matching rows from the left table, the column of the left table in the result set will have nulls.

The following shows the syntax of the RIGHT JOIN clause:

SELECT 
    select_list
FROM 
    T1
RIGHT JOIN T2 ON join_predicate;
Code language: SQL (Structured Query Language) (sql)
In this syntax, T1 is the left table and T2 is the right table.

Note that RIGHT JOIN and RIGHT OUTER JOIN is the same. The OUTER keyword is optional.

The following Venn diagram illustrates the RIGHT JOIN operation:

SQL Server RIGHT JOIN illustration
SQL Server RIGHT JOIN example 
We will use the sales.order_items and production.products table from the sample database for the demonstration.

products order_items
The following statement returns all order_id from the sales.order_items and product name from the production.products table:

SELECT
    product_name,
    order_id
FROM
    sales.order_items o
    RIGHT JOIN production.products p 
        ON o.product_id = p.product_id
ORDER BY
    order_id;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server RIGHT JOIN example
The query returned all rows from the production.products table (right table) and rows from sales.order_items table (left table). If a product does not have any sales, the order_id column will have a null.

To get the products that do not have any sales, you add a WHERE clause to the above query to filter out the products that have sales:

SELECT
    product_name,
    order_id
FROM
    sales.order_items o
    RIGHT JOIN production.products p 
        ON o.product_id = p.product_id
WHERE 
    order_id IS NULL
ORDER BY
    product_name;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server RIGHT JOIN - rows from the right table only
The following Venn diagram illustrates the above RIGHT JOIN operation:

SQL Server RIGHT JOIN - select only rows from the right table
In this tutorial, you have learned how to use the SQL Server RIGHT JOIN to query data from two tables.

-------------------------------------------

SQL Server Full Outer Join
Summary: in this tutorial, you will learn how to use the SQL Server FULL OUTER JOIN to query data from two or more tables.

Introduction to SQL Server full outer join 
The FULL OUTER JOIN is a clause of the SELECT statement. The FULL OUTER JOIN clause returns a result set that includes rows from both left and right tables.

When no matching rows exist for the row in the left table, the columns of the right table will contain NULL. Likewise, when no matching rows exist for the row in the right table, the column of the left table will contain NULL.

The following shows the syntax of FULL OUTER JOIN clause when joining two tables T1 and T2:

SELECT 
    select_list
FROM 
    T1
FULL OUTER JOIN T2 ON join_predicate;
Code language: SQL (Structured Query Language) (sql)
The OUTER keyword is optional so you can skip it as shown in the following query:

SELECT 
    select_list
FROM 
    T1
FULL JOIN T2 ON join_predicate;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the left table T1 in the FROM clause.
Second, specify the right table T2 and a join predicate.
The following Venn diagram illustrates the FULL OUTER JOIN of two result sets:

SQL Server Full Outer Join illustration
SQL Server full outer join example 
Let’s set up some sample table to demonstrate the full outer join.

First, create a new schema named pm which stands for project management:

CREATE SCHEMA pm;
GO
Code language: SQL (Structured Query Language) (sql)
Next, create new tables named projects and members in the pm schema:

CREATE TABLE pm.projects(
    id INT PRIMARY KEY IDENTITY,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE pm.members(
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(120) NOT NULL,
    project_id INT,
    FOREIGN KEY (project_id) 
        REFERENCES pm.projects(id)
);
Code language: SQL (Structured Query Language) (sql)
Suppose, each member only can participate in one project and each project has zero or more members. If a project is in the initial phase, hence there is no member assigned.

Then, insert some rows into the projects and members tables:

INSERT INTO 
    pm.projects(title)
VALUES
    ('New CRM for Project Sales'),
    ('ERP Implementation'),
    ('Develop Mobile Sales Platform');


INSERT INTO
    pm.members(name, project_id)
VALUES
    ('John Doe', 1),
    ('Lily Bush', 1),
    ('Jane Doe', 2),
    ('Jack Daniel', null);
Code language: SQL (Structured Query Language) (sql)
After that, query data from the projects and members tables:

SELECT * FROM pm.projects;
Code language: SQL (Structured Query Language) (sql)
SQL Server full outer join - projects table
SELECT * FROM pm.members;
Code language: SQL (Structured Query Language) (sql)
SQL Server full outer join - members table
Finally, use the FULL OUTER JOIN to query data from projects and members tables:

SELECT 
    m.name member, 
    p.title project
FROM 
    pm.members m
    FULL OUTER JOIN pm.projects p 
        ON p.id = m.project_id;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server full outer join example
In this example, the query returned members who participate in projects, members who do not participate in any projects, and projects which do not have any members.

To find the members who do not participate in any project and projects which do not have any members, you add a WHERE clause to the above query:

SELECT 
    m.name member, 
    p.title project
FROM 
    pm.members m
    FULL OUTER JOIN pm.projects p 
        ON p.id = m.project_id
WHERE
    m.id IS NULL OR
    P.id IS NULL;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server full outer join with a WHERE clause example
As clearly shown in the output, Jack Daniel does not participate in any project and Develop Mobile Sales Platform does not have any members.

In this tutorial, you have learned how to use SQL Server full outer join to query data from two or more tables.

 ---------------------------------------


 SQL Server Full Outer Join
Summary: in this tutorial, you will learn how to use the SQL Server FULL OUTER JOIN to query data from two or more tables.

Introduction to SQL Server full outer join 
The FULL OUTER JOIN is a clause of the SELECT statement. The FULL OUTER JOIN clause returns a result set that includes rows from both left and right tables.

When no matching rows exist for the row in the left table, the columns of the right table will contain NULL. Likewise, when no matching rows exist for the row in the right table, the column of the left table will contain NULL.

The following shows the syntax of FULL OUTER JOIN clause when joining two tables T1 and T2:

SELECT 
    select_list
FROM 
    T1
FULL OUTER JOIN T2 ON join_predicate;
Code language: SQL (Structured Query Language) (sql)
The OUTER keyword is optional so you can skip it as shown in the following query:

SELECT 
    select_list
FROM 
    T1
FULL JOIN T2 ON join_predicate;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the left table T1 in the FROM clause.
Second, specify the right table T2 and a join predicate.
The following Venn diagram illustrates the FULL OUTER JOIN of two result sets:

SQL Server Full Outer Join illustration
SQL Server full outer join example 
Let’s set up some sample table to demonstrate the full outer join.

First, create a new schema named pm which stands for project management:

CREATE SCHEMA pm;
GO
Code language: SQL (Structured Query Language) (sql)
Next, create new tables named projects and members in the pm schema:

CREATE TABLE pm.projects(
    id INT PRIMARY KEY IDENTITY,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE pm.members(
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(120) NOT NULL,
    project_id INT,
    FOREIGN KEY (project_id) 
        REFERENCES pm.projects(id)
);
Code language: SQL (Structured Query Language) (sql)
Suppose, each member only can participate in one project and each project has zero or more members. If a project is in the initial phase, hence there is no member assigned.

Then, insert some rows into the projects and members tables:

INSERT INTO 
    pm.projects(title)
VALUES
    ('New CRM for Project Sales'),
    ('ERP Implementation'),
    ('Develop Mobile Sales Platform');


INSERT INTO
    pm.members(name, project_id)
VALUES
    ('John Doe', 1),
    ('Lily Bush', 1),
    ('Jane Doe', 2),
    ('Jack Daniel', null);
Code language: SQL (Structured Query Language) (sql)
After that, query data from the projects and members tables:

SELECT * FROM pm.projects;
Code language: SQL (Structured Query Language) (sql)
SQL Server full outer join - projects table
SELECT * FROM pm.members;
Code language: SQL (Structured Query Language) (sql)
SQL Server full outer join - members table
Finally, use the FULL OUTER JOIN to query data from projects and members tables:

SELECT 
    m.name member, 
    p.title project
FROM 
    pm.members m
    FULL OUTER JOIN pm.projects p 
        ON p.id = m.project_id;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server full outer join example
In this example, the query returned members who participate in projects, members who do not participate in any projects, and projects which do not have any members.

To find the members who do not participate in any project and projects which do not have any members, you add a WHERE clause to the above query:

SELECT 
    m.name member, 
    p.title project
FROM 
    pm.members m
    FULL OUTER JOIN pm.projects p 
        ON p.id = m.project_id
WHERE
    m.id IS NULL OR
    P.id IS NULL;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server full outer join with a WHERE clause example
As clearly shown in the output, Jack Daniel does not participate in any project and Develop Mobile Sales Platform does not have any members.

In this tutorial, you have learned how to use SQL Server full outer join to query data from two or more tables.

---------------------------------------------------


SQL Server Cross Join
Summary: in this tutorial, you will learn how to use the SQL Server CROSS JOIN to join two or more tables.

Introduction to the SQL Server CROSS JOIN clause 
A cross join allows you to combine rows from the first table with every row of the second table. In other words, it returns the Cartesian product of two tables.

Here’s the basic syntax for a cross join:

SELECT
  select_list
FROM
  T1
CROSS JOIN T2;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

T1 and T2 are the tables that you want to perform a cross join.
Unlike other join types such as INNER JOIN or LEFT JOIN, the cross join does not require a join condition.

If T1 table has n rows and T2 table has m rows, the cross join will create a result set with nxm rows.

For example, if both tables T1 and T2 have 1000 rows, the cross join will return a result set with 1,000,000 rows.

Because a cross join may create a large number of rows in the result set, you should use it carefully to avoid performance issues.

SQL Server Cross Join illustration 
Suppose the T1 table contains three rows 1, 2, and 3 and the T2 table contains three rows A, B, and C.

The CROSS JOIN combines each row from the first table (T1) with every row in the second table (T2), creating a new row for each combination. It repeats this process for each subsequent row in the first table (T1) and so on.

SQL Server CROSS JOIN example
In this illustration, the CROSS JOIN creates a total of nine rows.

SQL Server CROSS JOIN examples 
The following statement returns the combinations of all products and stores:

SELECT
    product_id,
    product_name,
    store_id,
    0 AS quantity
FROM
    production.products
CROSS JOIN sales.stores
ORDER BY
    product_name,
    store_id;
Code language: SQL (Structured Query Language) (sql)
Output:


The result set can be used for the stocktaking procedure at the month-end or year-end closing.

The following statement finds the products that have no sales across the stores:

SELECT
    s.store_id,
    p.product_id,
    ISNULL(sales, 0) sales
FROM
    sales.stores s
CROSS JOIN production.products p
LEFT JOIN (
    SELECT
        s.store_id,
        p.product_id,
        SUM (quantity * i.list_price) sales
    FROM
        sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.stores s ON s.store_id = o.store_id
    INNER JOIN production.products p ON p.product_id = i.product_id
    GROUP BY
        s.store_id,
        p.product_id
) c ON c.store_id = s.store_id
AND c.product_id = p.product_id
WHERE
    sales IS NULL
ORDER BY
    product_id,
    store_id;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial result set:

SQL Server Cross Join StockTaking example
Summary 
Use the CROSS JOIN to combine rows from the first table with every row from the second table.

-------------------------------------------------

SQL Server Self Join
Summary: in this tutorial, you will learn how to use the SQL Server self join to join a table to itself.

SQL Server self join syntax 
A self join allows you to join a table to itself. It helps query hierarchical data or compare rows within the same table.

A self join uses the inner join or left join clause. Because the query that uses the self join references the same table, the table alias is used to assign different names to the same table within the query.

Note that referencing the same table more than once in a query without using table aliases will result in an error.

The following shows the syntax of joining the table T to itself:

SELECT
    select_list
FROM
    T t1
[INNER | LEFT]  JOIN T t2 ON
    join_predicate; 
Code language: SQL (Structured Query Language) (sql)
The query references the table T twice. The table aliases t1 and t2 are used to assign the T table different names in the query.

SQL Server self join examples 
Let’s take some examples to understand how the self join works.

1) Using self join to query hierarchical data 
Consider the following  staffs table from the sample database:


SQL Server Self Join - staffs table
The  staffs table stores the staff information such as id, first name, last name, and email. It also has a column named manager_id that specifies the direct manager. For example, Mireya reports to Fabiola because the value in the manager_id of  Mireya is Fabiola.

Fabiola has no manager, so the manager id column has a NULL.

To get who reports to whom, you use the self join as shown in the following query:

SELECT
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager
FROM
    sales.staffs e
INNER JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;
Code language: SQL (Structured Query Language) (sql)
SQL Server Self Join with INNER JOIN
In this example, we referenced to the  staffs table twice: one as e for the employees and the others as m for the managers. The join predicate matches the employee and manager relationship using the values in the e.manager_id and m.staff_id columns.

The employee column does not have Fabiola Jackson because of the INNER JOIN effect. If you replace the INNER JOIN clause by the LEFT JOIN clause as shown in the following query, you will get the result set that includes Fabiola Jackson in the employee column:

SELECT
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager
FROM
    sales.staffs e
LEFT JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;
Code language: SQL (Structured Query Language) (sql)
SQL Server Self Join with LEFT JOIN clause
2) Using self join to compare rows within a table 
See the following customers table:

customers table
The following statement uses the self join to find the customers located in the same city.

SELECT
    c1.city,
    c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id > c2.customer_id
AND c1.city = c2.city
ORDER BY
    city,
    customer_1,
    customer_2;
Code language: SQL (Structured Query Language) (sql)
SQL Server Self Join - compare rows in the same table
The following condition makes sure that the statement doesn’t compare the same customer:

c1.customer_id > c2.customer_id
Code language: SQL (Structured Query Language) (sql)
The following condition matches the city of the two customers:

AND c1.city = c2.city
Code language: SQL (Structured Query Language) (sql)
Note that if you change the greater than ( > ) operator by the not equal to (<>) operator, you will get more rows:

SELECT
    c1.city,
    c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id <> c2.customer_id
AND c1.city = c2.city
ORDER BY
    city,
    customer_1,
    customer_2;
Code language: SQL (Structured Query Language) (sql)
SQL Server Self Join - compare rows in the same table with not equal to operator
Let’s see the difference between > and <> in the ON clause by limiting to one city to make it easier for comparison.

The following query returns the customers located in Albany:

SELECT 
   customer_id, first_name + ' ' + last_name c, 
   city
FROM 
   sales.customers
WHERE
   city = 'Albany'
ORDER BY 
   c;
Code language: SQL (Structured Query Language) (sql)
SQL Server Self Join - customers in a city
This query uses ( >) operator in the ON clause:

SELECT
    c1.city,
    c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id > c2.customer_id
AND c1.city = c2.city
WHERE c1.city = 'Albany'
ORDER BY
    c1.city,
    customer_1,
    customer_2;
Code language: SQL (Structured Query Language) (sql)
The output is:

SQL Server Self Join - compare rows in the same table with greater than operator
This query uses ( <>) operator in the ON clause:

SELECT
    c1.city,
	c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id <> c2.customer_id
AND c1.city = c2.city
WHERE c1.city = 'Albany'
ORDER BY
	c1.city,
    customer_1,
    customer_2;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Self Join with not equal to operator
In this tutorial, you have learned how to use an SQL Server self join to query hierarchical data and compare rows in the same table.  


---------------------------------------------

SQL Server GROUP BY Clause
Summary: in this tutorial, you will learn how to use the SQL Server GROUP BY clause to arrange rows in groups by one or more columns.

Introduction to SQL Server GROUP BY clause 
The GROUP BY clause allows you to arrange the rows of a query in groups. The groups are determined by the columns that you specify in the GROUP BY clause.

The following illustrates the GROUP BY clause syntax:

SELECT
    select_list
FROM
    table_name
GROUP BY
    column_name1,
    column_name2 ,...;
Code language: SQL (Structured Query Language) (sql)
In this query, the GROUP BY clause produces a group for each combination of the values in the columns listed in the GROUP BY clause.

Consider the following example:

SELECT
    customer_id,
    YEAR (order_date) order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
ORDER BY
    customer_id;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUP BY clause
In this example, we retrieve the customer id and the ordered year of the customers with customer id 1 and 2.

The output indicates that the customer with id 1 placed one order in 2016 and two orders in 2018. The customer id 2 placed two orders in 2017 and one order in 2018.

Let’s add a GROUP BY clause to the query to see the effect:

SELECT
    customer_id,
    YEAR (order_date) order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUP BY clause example
The GROUP BY clause arranged the first three rows into two groups and the next three rows into the other two groups with the unique combinations of the customer id and order year.

Functionally speaking, the GROUP BY clause in the above query produced the same result as the following query that uses the DISTINCT clause:

SELECT DISTINCT
    customer_id,
    YEAR (order_date) order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
ORDER BY
    customer_id;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUP BY - DISTINCT example
SQL Server GROUP BY clause and aggregate functions 
In practice, the GROUP BY clause is often used with aggregate functions for generating summary reports.

An aggregate function performs a calculation on a group and returns a unique value per group. For example, COUNT() returns the number of rows in each group. Other commonly used aggregate functions are SUM(), AVG() (average), MIN() (minimum), MAX() (maximum).

The GROUP BY clause arranges rows into groups and an aggregate function returns the summary (count, min, max, average, sum, etc.,) for each group.

For example, the following query returns the number of orders placed by the customer by year:

SELECT
    customer_id,
    YEAR (order_date) order_year,
    COUNT (order_id) order_placed
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id; 
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUP BY clause - expression example
If you want to reference a column or expression that is not listed in the GROUP BY clause, you must use that column as the input of an aggregate function. Otherwise, you will get an error because there is no guarantee that the column or expression will return a single value per group. For example, the following query will fail:

SELECT
    customer_id,
    YEAR (order_date) order_year,
    order_status
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY
    customer_id;
Code language: SQL (Structured Query Language) (sql)
More GROUP BY clause examples 
Let’s take some more examples to understand how the GROUP BY clause works.

1) Using GROUP BY clause with the COUNT() function example 
The following query returns the number of customers in every city:

SELECT
    city,
    COUNT (customer_id) customer_count
FROM
    sales.customers
GROUP BY
    city
ORDER BY
    city;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUP BY - COUNT example
In this example, the GROUP BY clause groups the customers by city and the COUNT() function returns the number of customers in each city.

Similarly, the following query returns the number of customers by state and city.

SELECT
    city,
    state,
    COUNT (customer_id) customer_count
FROM
    sales.customers
GROUP BY
    state,
    city
ORDER BY
    city,
    state;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUP BY clause - multiple columns example
2) Using GROUP BY clause with the MIN and MAX functions example 
The following statement returns the minimum and maximum list prices of all products with the model 2018 by brand:

SELECT
    brand_name,
    MIN (list_price) min_price,
    MAX (list_price) max_price
FROM
    production.products p
INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE
    model_year = 2018
GROUP BY
    brand_name
ORDER BY
    brand_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUP BY - MIN and MAX example
In this example, the WHERE clause is processed before the GROUP BY clause, as always.

3) Using GROUP BY clause with the AVG() function example 
The following statement uses the AVG() function to return the average list price by brand for all products with the model year 2018:

SELECT
    brand_name,
    AVG (list_price) avg_price
FROM
    production.products p
INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE
    model_year = 2018
GROUP BY
    brand_name
ORDER BY
    brand_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUP BY - AVG example
4) Using GROUP BY clause with the SUM function example 
See the following order_items table:

order_items
The following query uses the SUM() function to get the net value of every order:

SELECT
    order_id,
    SUM (
        quantity * list_price * (1 - discount)
    ) net_value
FROM
    sales.order_items
GROUP BY
    order_id;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUP BY - SUM example
Summary 
Use the SQL Server GROUP BY clause to arrange rows in groups by a specified list of columns.


-----------------------------------------------

SQL Server HAVING Clause
Summary: in this tutorial, you will learn how to use the SQL Server HAVING clause to filter the groups based on specified conditions.

Introduction to SQL Server HAVING clause 
The HAVING clause is often used with the GROUP BY clause to filter groups based on a specified list of conditions. The following illustrates the HAVING clause syntax:

SELECT
    select_list
FROM
    table_name
GROUP BY
    group_list
HAVING
    conditions;
Code language: SQL (Structured Query Language) (sql)
In this syntax, the GROUP BY clause summarizes the rows into groups and the HAVING clause applies one or more conditions to these groups. Only groups that make the conditions evaluated TRUE are included in the result. In other words, the groups for which the condition evaluates to  FALSE or UNKNOWN are filtered out.

Because SQL Server processes the HAVING clause after the GROUP BY clause, you cannot refer to the aggregate function specified in the select list by using the column alias. The following query will fail:

SELECT
    column_name1,
    column_name2,
    aggregate_function (column_name3) column_alias
FROM
    table_name
GROUP BY
    column_name1,
    column_name2
HAVING
    column_alias > value;
Code language: SQL (Structured Query Language) (sql)
Instead, you need to use the aggregate function expression in the HAVING clause explicitly as follows:

SELECT
    column_name1,
    column_name2,
    aggregate_function (column_name3) alias
FROM
    table_name
GROUP BY
    column_name1,
    column_name2
HAVING
    aggregate_function (column_name3) > value;
Code language: SQL (Structured Query Language) (sql)
SQL Server HAVING examples 
Let’s take some examples to understand how the HAVING clause works.

SQL Server HAVING with the COUNT function example 
See the following orders table from the sample database:


The following statement uses the HAVING clause to find the customers who placed at least two orders per year:

SELECT
    customer_id,
    YEAR (order_date),
    COUNT (order_id) order_count
FROM
    sales.orders
GROUP BY
    customer_id,
    YEAR (order_date)
HAVING
    COUNT (order_id) >= 2
ORDER BY
    customer_id;
Code language: SQL (Structured Query Language) (sql)

In this example:

First, the GROUP BY clause groups the sales order by customer and order year. The COUNT() function returns the number of orders each customer placed each year.
Second, the HAVING clause filtered out all the customers whose number of orders is less than two.
SQL Server HAVING clause with the SUM() function example 
Consider the following order_items table:


The following statement finds the sales orders whose net values are greater than 20,000:

SELECT
    order_id,
    SUM (
        quantity * list_price * (1 - discount)
    ) net_value
FROM
    sales.order_items
GROUP BY
    order_id
HAVING
    SUM (
        quantity * list_price * (1 - discount)
    ) > 20000
ORDER BY
    net_value;
Code language: SQL (Structured Query Language) (sql)

In this example:

First, the SUM() function returns the net values of sales orders.
Second, the HAVING clause filters the sales orders whose net values are less than or equal to 20,000.
SQL Server HAVING clause with MAX and MIN functions example 
See the following products table:


The following statement first finds the maximum and minimum list prices in each product category. Then, it filters out the category which has a maximum list price greater than 4,000 or a minimum list price less than 500:

SELECT
    category_id,
    MAX (list_price) max_list_price,
    MIN (list_price) min_list_price
FROM
    production.products
GROUP BY
    category_id
HAVING
    MAX (list_price) > 4000 OR MIN (list_price) < 500;
Code language: SQL (Structured Query Language) (sql)

SQL Server HAVING clause with AVG() function example 
The following statement finds product categories whose average list prices are between 500 and 1,000:

SELECT
    category_id,
    AVG (list_price) avg_list_price
FROM
    production.products
GROUP BY
    category_id
HAVING
    AVG (list_price) BETWEEN 500 AND 1000;
Code language: SQL (Structured Query Language) (sql)

Summary 
Use the SQL Server HAVING clause to filter groups based on specified conditions.


----------------------------------------------

SQL Server GROUPING SETS
Summary: in this tutorial, you will learn how to use the SQL Server GROUPING SETS to generate multiple grouping sets.

Setup a sales summary table 
Let’s create a new table named sales.sales_summary for the demonstration.

SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
    round(
        SUM (
            quantity * i.list_price * (1 - discount)
        ),
        0
    ) sales INTO sales.sales_summary
FROM
    sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year
ORDER BY
    b.brand_name,
    c.category_name,
    p.model_year;
Code language: SQL (Structured Query Language) (sql)
In this query, we retrieve the sales amount data by brand and category and populate it into the sales.sales_summary table.

The following query returns data from the sales.sales_summary table:

SELECT
	*
FROM
	sales.sales_summary
ORDER BY
	brand,
	category,
	model_year;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUPING SETS - UNION ALL
Getting started with SQL Server GROUPING SETS 
By definition, a grouping set is a group of columns by which you group. Typically, a single query with an aggregate defines a single grouping set.

For example, the following query defines a grouping set that includes brand and category which is denoted as (brand, category). The query returns the sales amount grouped by brand and category:

SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand,
    category
ORDER BY
    brand,
    category;
Code language: SQL (Structured Query Language) (sql)

The following query returns the sales amount by brand. It defines a grouping set (brand):

SELECT
    brand,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand
ORDER BY
    brand;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUPING SETS by brand
The following query returns the sales amount by category. It defines a grouping set (category):

SELECT
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    category
ORDER BY
    category;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUPING SETS by brand
The following query defines an empty grouping set (). It returns the sales amount for all brands and categories.

SELECT
    SUM (sales) sales
FROM
    sales.sales_summary;
Code language: SQL (Structured Query Language) (sql)

The four queries above return four result sets with four grouping sets:

(brand, category)
(brand)
(category)
()
Code language: SQL (Structured Query Language) (sql)
To get a unified result set with the aggregated data for all grouping sets, you can use the UNION ALL operator.

Because UNION ALL operator requires all result sets to have the same number of columns, you need to add NULL to the select list of the queries like this:

SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand,
    category
UNION ALL
SELECT
    brand,
    NULL,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand
UNION ALL
SELECT
    NULL,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    category
UNION ALL
SELECT
    NULL,
    NULL,
    SUM (sales)
FROM
    sales.sales_summary
ORDER BY brand, category;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUPING SETS - UNION ALL
The query generated a single result with the aggregates for all grouping sets as we expected.

However, it has two major problems:

The query is quite lengthy.
The query is slow because the SQL Server needs to execute four subqueries and combine the result sets into a single one.
To fix these problems, SQL Server provides a subclause of the GROUP BY clause called GROUPING SETS.

The GROUPING SETS defines multiple grouping sets in the same query. The following shows the general syntax of the GROUPING SETS:

SELECT
    column1,
    column2,
    aggregate_function (column3)
FROM
    table_name
GROUP BY
    GROUPING SETS (
        (column1, column2),
        (column1),
        (column2),
        ()
);
Code language: SQL (Structured Query Language) (sql)
This query creates four grouping sets:

(column1,column2)
(column1)
(column2)
()
Code language: SQL (Structured Query Language) (sql)
You can use this GROUPING SETS to rewrite the query that gets the sales data as follows:

SELECT
	brand,
	category,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	GROUPING SETS (
		(brand, category),
		(brand),
		(category),
		()
	)
ORDER BY
	brand,
	category;
Code language: SQL (Structured Query Language) (sql)
As you can see, the query produces the same result as the one that uses the UNION ALL operator. However, this query is much more readable and of course more efficient.

GROUPING function 
The GROUPING function indicates whether a specified column in a GROUP BY clause is aggregated or not. It returns 1 for aggregated or 0 for not aggregated in the result set.

See the following query example:

SELECT
    GROUPING(brand) grouping_brand,
    GROUPING(category) grouping_category,
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    GROUPING SETS (
        (brand, category),
        (brand),
        (category),
        ()
    )
ORDER BY
    brand,
    category;
Code language: SQL (Structured Query Language) (sql)
SQL Server GROUPING SETS - GROUPING function
The value in the grouping_brand column indicates whether the row is aggregated or not:

1 means that the sales amount is aggregated by brand
0 means that the sales amount is not aggregated by brand.
The same logic is applied to the grouping_category column.

Summary #
Use the GROUPING SETS to generate multiple grouping sets in a query.  


-----------------------------------------


SQL Server CUBE
Summary: in this tutorial, you will learn how to use the SQL Server CUBE to generate multiple grouping sets.

Introduction to SQL Server CUBE 
Grouping sets specify groupings of data in a single query. For example, the following query defines a single grouping set represented as (brand):

SELECT 
    brand, 
    SUM(sales)
FROM 
    sales.sales_summary
GROUP BY 
    brand;
Code language: SQL (Structured Query Language) (sql)
If you have not followed the GROUPING SETS tutorial, you can create the sales.sales_summary table by using the following query:

SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
    round(
        SUM (
            quantity * i.list_price * (1 - discount)
        ),
        0
    ) sales INTO sales.sales_summary
FROM
    sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year
ORDER BY
    b.brand_name,
    c.category_name,
    p.model_year;
Code language: SQL (Structured Query Language) (sql)
Even though the following query does not use the GROUP BY clause, it generates an empty grouping set which is denoted as ().

SELECT 
    SUM(sales)
FROM 
    sales.sales_summary;
Code language: SQL (Structured Query Language) (sql)
The CUBE is a subclause of the GROUP BY clause that allows you to generate multiple grouping sets. The following illustrates the general syntax of the CUBE:

SELECT
    d1,
    d2,
    d3,
    aggregate_function (c4)
FROM
    table_name
GROUP BY
    CUBE (d1, d2, d3);     
Code language: SQL (Structured Query Language) (sql)
In this syntax, the CUBE generates all possible grouping sets based on the dimension columns d1, d2, and d3 that you specify in the CUBE clause.

The above query returns the same result set as the following query, which uses the  GROUPING SETS:

SELECT
    d1,
    d2,
    d3,
    aggregate_function (c4)
FROM
    table_name
GROUP BY
    GROUPING SETS (
        (d1,d2,d3), 
        (d1,d2),
        (d1,d3),
        (d2,d3),
        (d1),
        (d2),
        (d3), 
        ()
     );
Code language: SQL (Structured Query Language) (sql)
If you have N dimension columns specified in the CUBE, you will have 2N grouping sets.

It is possible to reduce the number of grouping sets by using the CUBE partially as shown in the following query:

SELECT
    d1,
    d2,
    d3,
    aggregate_function (c4)
FROM
    table_name
GROUP BY
    d1,
    CUBE (d2, d3);
Code language: SQL (Structured Query Language) (sql)
In this case, the query generates four grouping sets because there are only two dimension columns specified in the CUBE.

SQL Server CUBE examples 
The following statement uses the CUBE to generate four grouping sets:

(brand, category)
(brand)
(category)
()
SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    CUBE(brand, category);
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server CUBE example
In this example, we have two dimension columns specified in the CUBE clause, therefore, we have a total of four grouping sets.

The following example illustrates how to perform a partial CUBE to reduce the number of grouping sets generated by the query:

SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand,
    CUBE(category);
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server CUBE partially example
In this tutorial, you have learned how to use the SQL Server CUBE to generate multiple grouping sets.

----------------------------------------------------

SQL Server ROLLUP
Summary: in this tutorial, you will learn how to use the SQL Server ROLLUP to generate multiple grouping sets.

Introduction to the SQL Server ROLLUP 
The SQL Server ROLLUP is a subclause of the GROUP BY clause which provides a shorthand for defining multiple grouping sets.

Unlike the CUBE subclause, ROLLUP does not create all possible grouping sets based on the dimension columns; the CUBE makes a subset of those.

When generating the grouping sets, ROLLUP assumes a hierarchy among the dimension columns and only generates grouping sets based on this hierarchy.

The ROLLUP is often used to generate subtotals and totals for reporting purposes.

Let’s consider an example. The following CUBE (d1,d2,d3) defines eight possible grouping sets:

(d1, d2, d3)
(d1, d2)
(d2, d3)
(d1, d3)
(d1)
(d2)
(d3)
()
Code language: SQL (Structured Query Language) (sql)
And the ROLLUP(d1,d2,d3) creates only four grouping sets, assuming the hierarchy d1 > d2 > d3, as follows:

(d1, d2, d3)
(d1, d2)
(d1)
()
Code language: SQL (Structured Query Language) (sql)
The ROLLUP is commonly used to calculate the aggregates of hierarchical data such as sales by year > quarter > month.

SQL Server ROLLUP syntax 
The general syntax of the SQL Server ROLLUP is as follows:

SELECT
    d1,
    d2,
    d3,
    aggregate_function(c4)
FROM
    table_name
GROUP BY
    ROLLUP (d1, d2, d3);
Code language: SQL (Structured Query Language) (sql)
In this syntax, d1, d2, and d3 are dimension columns. The statement will calculate the aggregation of values in the column c4 based on the hierarchy d1 > d2 > d3.

You can also do a partial roll-up to reduce the subtotals generated by using the following syntax:

SELECT
    d1,
    d2,
    d3,
    aggregate_function(c4)
FROM
    table_name
GROUP BY
    d1, 
    ROLLUP (d2, d3);
Code language: SQL (Structured Query Language) (sql)
SQL Server ROLLUP examples 
We will reuse the sales.sales_summary table created in the GROUPING SETS tutorial for the demonstration. If you have not created the sales.sales_summary table, you can use the following statement to create it.

SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
    round(
        SUM (
            quantity * i.list_price * (1 - discount)
        ),
        0
    ) sales INTO sales.sales_summary
FROM
    sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year
ORDER BY
    b.brand_name,
    c.category_name,
    p.model_year;
Code language: SQL (Structured Query Language) (sql)
The following query uses the ROLLUP to calculate the sales amount by brand (subtotal) and both brand and category (total).

SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    ROLLUP(brand, category);
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server ROLLUP example
In this example, the query assumes that there is a hierarchy between brand and category, which is the brand > category.

Note that if you change the order of brand and category, the result will be different as shown in the following query:

SELECT
    category,
    brand,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    ROLLUP (category, brand);
Code language: SQL (Structured Query Language) (sql)
In this example, the hierarchy is the brand > segment:

SQL Server ROLLUP example 2
The following statement shows how to perform a partial roll-up:

SELECT
    brand,
    category,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand,
    ROLLUP (category);
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server Partial ROLLUP example
In this tutorial, you have learned how to use the SQL Server ROLLUP to generate multiple grouping sets with an assumption of a hierarchy of the input columns. 


-------------------------------------------------


SQL Server Subquery
Summary: in this tutorial, you will learn about the SQL Server subquery and how to use the subquery for querying data.

Introduction to SQL Server subquery 
A subquery is a query nested inside another statement such as SELECT, INSERT, UPDATE, or DELETE.

Let’s see the following example.

Consider the orders and customers tables from the sample database.


The following statement shows how to use a subquery in the WHERE clause of a SELECT statement to find the sales orders of the customers located in New York:

SELECT
    order_id,
    order_date,
    customer_id
FROM
    sales.orders
WHERE
    customer_id IN (
        SELECT
            customer_id
        FROM
            sales.customers
        WHERE
            city = 'New York'
    )
ORDER BY
    order_date DESC;
Code language: SQL (Structured Query Language) (sql)
Here is the result:

SQL Server Subquery example
In this example, the following statement is a subquery:

SELECT
    customer_id
FROM
    sales.customers
WHERE
    city = 'New York'
Code language: SQL (Structured Query Language) (sql)
Note that you must always enclose the SELECT query of a subquery in parentheses ().

A subquery is also known as an inner query or inner select, while the statement containing the subquery is called an outer select or outer query:

SQL Server Subquery
SQL Server executes the whole query example above as follows:

First, it executes the subquery to get a list of customer identification numbers of the customers located in New York.

SELECT
    customer_id
FROM
    sales.customers
WHERE
    city = 'New York'
Code language: SQL (Structured Query Language) (sql)
SQL Server Subquery result
Second, SQL Server substitutes customer identification numbers returned by the subquery in the IN operator and executes the outer query to get the final result set.

As you can see, by using the subquery, you can combine two steps. The subquery removes the need for selecting the customer identification numbers and plugging them into the outer query. Moreover, the query itself automatically adjusts whenever the customer data changes.

Nesting subquery 
A subquery can be nested within another subquery. SQL Server supports up to 32 levels of nesting. Consider the following example:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > (
        SELECT
            AVG (list_price)
        FROM
            production.products
        WHERE
            brand_id IN (
                SELECT
                    brand_id
                FROM
                    production.brands
                WHERE
                    brand_name = 'Strider'
                OR brand_name = 'Trek'
            )
    )
ORDER BY
    list_price;
Code language: SQL (Structured Query Language) (sql)
SQL Server Subquery nesting subquery examples
First, SQL Server executes the following subquery to get a list of brand identification numbers of the Strider and Trek brands:

SELECT
    brand_id
FROM
    production.brands
WHERE
    brand_name = 'Strider'
OR brand_name = 'Trek';
Code language: SQL (Structured Query Language) (sql)
SQL Server Subquery brand id list
Second, SQL Server calculates the average price list of all products that belong to those brands.

SELECT
    AVG (list_price)
FROM
    production.products
WHERE
    brand_id IN (6,9)
Code language: SQL (Structured Query Language) (sql)
Third, SQL Server finds the products whose list price is greater than the average list price of all products with the Strider or Trek brand.

SQL Server subquery types 
You can use a subquery in many places:

In place of an expression
With IN or NOT IN
With ANY or ALL
With EXISTS or NOT EXISTS
In UPDATE, DELETE, orINSERT statement
In the FROM clause
SQL Server subquery is used in place of an expression 
If a subquery returns a single value, it can be used anywhere an expression is used.

In the following example, a subquery is used as a column expression named max_list_price in a SELECT statement.

SELECT
    order_id,
    order_date,
    (
        SELECT
            MAX (list_price)
        FROM
            sales.order_items i
        WHERE
            i.order_id = o.order_id
    ) AS max_list_price
FROM
    sales.orders o
order by order_date desc;
Code language: SQL (Structured Query Language) (sql)
SQL Server subquery is used in place of an expression
SQL Server subquery is used with IN operator 
A subquery that is used with the IN operator returns a set of zero or more values. After the subquery returns values, the outer query makes use of them.

The following query finds the names of all mountain bikes and road bikes products that the Bike Stores sell.

SELECT
    product_id,
    product_name
FROM
    production.products
WHERE
    category_id IN (
        SELECT
            category_id
        FROM
            production.categories
        WHERE
            category_name = 'Mountain Bikes'
        OR category_name = 'Road Bikes'
    );
Code language: SQL (Structured Query Language) (sql)
SQL Server subquery is used with IN operator
This query is evaluated in two steps:

First, the inner query returns a list of category identification numbers that match the names Mountain Bikes and code Road Bikes.
Second, these values are substituted into the outer query that finds the product names which have the category identification number match with one of the values in the list.
SQL Server subquery is used with ANY operator 
The subquery is introduced with the ANY operator has the following syntax:

scalar_expression comparison_operator ANY (subquery)
Code language: SQL (Structured Query Language) (sql)
Assuming that the subquery returns a list of value v1, v2, … vn. The ANY operator returns TRUE if one of a comparison pair (scalar_expression, vi) evaluates to TRUE; otherwise, it returns FALSE.

For example, the following query finds the products whose list prices are greater than or equal to the average list price of any product brand.

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price >= ANY (
        SELECT
            AVG (list_price)
        FROM
            production.products
        GROUP BY
            brand_id
    )
Code language: SQL (Structured Query Language) (sql)
SQL Server subquery is used with ANY operator
For each brand, the subquery finds the maximum list price. The outer query uses these max prices and determines which individual product’s list price is greater than or equal to any brand’s maximum list price.

SQL Server subquery is used with ALL operator 
The ALL operator has the same syntax as the ANY operator:

scalar_expression comparison_operator ALL (subquery)
Code language: SQL (Structured Query Language) (sql)
The ALL operator returns TRUE if all comparison pairs (scalar_expression, vi) evaluate to TRUE; otherwise, it returns FALSE.

The following query finds the products whose list price is greater than or equal to the average list price returned by the subquery:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price >= ALL (
        SELECT
            AVG (list_price)
        FROM
            production.products
        GROUP BY
            brand_id
    )
Code language: SQL (Structured Query Language) (sql)
SQL Server subquery is used with ALL operator
SQL Server subquery is used with EXISTS or NOT EXISTS 
The following illustrates the syntax of a subquery introduced with EXISTS operator:

WHERE [NOT] EXISTS (subquery)
Code language: SQL (Structured Query Language) (sql)
The EXISTS operator returns TRUE if the subquery return results; otherwise, it returns FALSE.

The NOT EXISTS negates the EXISTS operator.

The following query finds the customers who bought products in 2017:

SELECT
    customer_id,
    first_name,
    last_name,
    city
FROM
    sales.customers c
WHERE
    EXISTS (
        SELECT
            customer_id
        FROM
            sales.orders o
        WHERE
            o.customer_id = c.customer_id
        AND YEAR (order_date) = 2017
    )
ORDER BY
    first_name,
    last_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server subquery is used with EXISTS operator
If you use the NOT EXISTS instead of EXISTS, you can find the customers who did not buy any products in 2017.

SELECT
    customer_id,
    first_name,
    last_name,
    city
FROM
    sales.customers c
WHERE
    NOT EXISTS (
        SELECT
            customer_id
        FROM
            sales.orders o
        WHERE
            o.customer_id = c.customer_id
        AND YEAR (order_date) = 2017
    )
ORDER BY
    first_name,
    last_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server subquery is used with NOT EXISTS operator
SQL Server subquery in the FROM clause 
Suppose that you want to find the average of the sum of orders of all sales staff. To do this, you can first find the number of orders by staff:

SELECT 
   staff_id, 
   COUNT(order_id) order_count
FROM 
   sales.orders
GROUP BY 
   staff_id;
Code language: SQL (Structured Query Language) (sql)
SQL Server subquery in the FROM clause
Then, you can apply the AVG() function to this result set. Since a query returns a result set that looks like a virtual table, you can place the whole query in the FROM clause of another query like this:

SELECT 
   AVG(order_count) average_order_count_by_staff
FROM
(
    SELECT 
	staff_id, 
        COUNT(order_id) order_count
    FROM 
	sales.orders
    GROUP BY 
	staff_id
) t;
Code language: SQL (Structured Query Language) (sql)

The query that you place in the FROM clause must have a table alias. In this example, we used the t as the table alias for the subquery.  To come up with the final result, SQL Server carries the following steps:

Execute the subquery in the FROM clause.
Use the result of the subquery and execute the outer query.
In this tutorial, you have learned about the SQL Server subquery concept and how to use various subquery types to query data.


-------------------------------------------


SQL Server Correlated Subquery
Summary: in this tutorial, you will learn about the SQL Server correlated subquery which is a subquery that depends on the outer query for its values.

Introduction to the SQL Server correlated subquery 
A correlated subquery is a subquery that uses the values of the outer query. In other words, the correlated subquery depends on the outer query for its values.

Because of this dependency, a correlated subquery cannot be executed independently as a simple subquery.

Moreover, a correlated subquery is executed repeatedly, once for each row evaluated by the outer query. The correlated subquery is also known as a repeating subquery.

Consider the following products table from the sample database:

products
The following example finds the products whose list price is equal to the highest list price of the products within the same category:

SELECT
    product_name,
    list_price,
    category_id
FROM
    production.products p1
WHERE
    list_price IN (
        SELECT
            MAX (p2.list_price)
        FROM
            production.products p2
        WHERE
            p2.category_id = p1.category_id
        GROUP BY
            p2.category_id
    )
ORDER BY
    category_id,
    product_name;
Code language: SQL (Structured Query Language) (sql)
Here is the result:

SQL Server Correlated Subquery
In this example, for each product evaluated by the outer query, the subquery finds the highest price of all products in its category.

If the price of the current product is equal to the highest price of all products in its category, the product is included in the result set. This process continues for the next product and so on.

As you can see, the correlated subquery is executed once for each product evaluated by the outer query.

Summary 
A correlated subquery is a subquery that uses the values of the outer query


------------------------------------------------

SQL Server EXISTS
Summary: in this tutorial, you will learn how to use the SQL Server EXISTS operator in the condition to test for the existence of rows in a subquery.

SQL Server EXISTS operator overview 
The EXISTS operator is a logical operator that allows you to check whether a subquery returns any row. The EXISTS operator returns TRUE if the subquery returns one or more rows.

The following shows the syntax of the SQL Server EXISTS operator:

EXISTS ( subquery)
Code language: SQL (Structured Query Language) (sql)
In this syntax, the subquery is a SELECT statement only. As soon as the subquery returns rows, the EXISTS operator returns TRUE and stop processing immediately.

Note that even though the subquery returns a NULL value, the EXISTS operator is still evaluated to TRUE.

SQL Server EXISTS operator examples 
Let’s take some examples to understand how EXISTS operator works.

A) Using EXISTS with a subquery returns NULL example 
See the following customers table from the sample database.


The following example returns all rows from the  customers table:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    EXISTS (SELECT NULL)
ORDER BY
    first_name,
    last_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server EXISTS with NULL example
In this example, the subquery returned a result set that contains NULL which causes the EXISTS operator to evaluate to TRUE. Therefore, the whole query returns all rows from the customers table.

B) Using EXISTS with a correlated subquery example 
Consider the following customers and orders tables:


The following example finds all customers who have placed more than two orders:

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers c
WHERE
    EXISTS (
        SELECT
            COUNT (*)
        FROM
            sales.orders o
        WHERE
            customer_id = c.customer_id
        GROUP BY
            customer_id
        HAVING
            COUNT (*) > 2
    )
ORDER BY
    first_name,
    last_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server EXISTS with the correlated subquery example
In this example, we had a correlated subquery that returns customers who place more than two orders.

If the number of orders placed by the customer is less than or equal to two, the subquery returns an empty result set that causes the EXISTS operator to evaluate to FALSE.

Based on the result of the EXISTS operator, the customer will be included in the result set.

C) EXISTS vs. IN example 
The following statement uses the IN operator to find the orders of the customers from San Jose:

SELECT
    *
FROM
    sales.orders
WHERE
    customer_id IN (
        SELECT
            customer_id
        FROM
            sales.customers
        WHERE
            city = 'San Jose'
    )
ORDER BY
    customer_id,
    order_date;
Code language: SQL (Structured Query Language) (sql)
The following statement uses the EXISTS operator that returns the same result:

SELECT
    *
FROM
    sales.orders o
WHERE
    EXISTS (
        SELECT
            customer_id
        FROM
            sales.customers c
        WHERE
            o.customer_id = c.customer_id
        AND city = 'San Jose'
    )
ORDER BY
    o.customer_id,
    order_date;
Code language: SQL (Structured Query Language) (sql)
SQL Server EXISTS vs IN example
EXISTS vs. JOIN 
The EXISTS operator returns TRUE or FALSE while the JOIN clause returns rows from another table.

You use the EXISTS operator to test if a subquery returns any row and short circuits as soon as it does. On the other hand, you use JOIN to extend the result set by combining it with the columns from related tables.

In practice, you use the EXISTS when you need to check the existence of rows from related tables without returning data from them.

In this tutorial, you have learned how to use the SQL Server EXISTS operator to test if a subquery returns rows.

-------------------------------------------

SQL Server ANY
Summary: in this tutorial, you will learn how to use the SQL Server ANY operator to compare a value with a single-column set of values returned by a subquery.

Introduction to SQL Server ANY operator 
The ANY operator is a logical operator that compares a scalar value with a single-column set of values returned by a subquery.

The following shows the syntax of the ANY operator:

scalar_expression comparison_operator ANY (subquery)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

scalar_expression is any valid expression.
comparison_operator is any comparison operator.
subquery is a SELECT statement which returns a result set of a single column with the data is the same as the data type of the scalar expression.
Suppose the subquery returns a list of values v1, v2, …,  vn. The ANY operator returns TRUE if any comparison (scalar_expression, vi) returns TRUE. Otherwise, it returns FALSE.

Note that the SOME operator is equivalent to the ANY operator.

SQL Server ANY operator example 
See the following products table from the sample database.

products
The following example finds the products that were sold with more than two units in a sales order:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_id = ANY (
        SELECT
            product_id
        FROM
            sales.order_items
        WHERE
            quantity >= 2
    )
ORDER BY
    product_name;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server ANY operator to compare a value with a single-column set of values.


--------------------------------------------------

SQL Server ANY
Summary: in this tutorial, you will learn how to use the SQL Server ANY operator to compare a value with a single-column set of values returned by a subquery.

Introduction to SQL Server ANY operator 
The ANY operator is a logical operator that compares a scalar value with a single-column set of values returned by a subquery.

The following shows the syntax of the ANY operator:

scalar_expression comparison_operator ANY (subquery)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

scalar_expression is any valid expression.
comparison_operator is any comparison operator.
subquery is a SELECT statement which returns a result set of a single column with the data is the same as the data type of the scalar expression.
Suppose the subquery returns a list of values v1, v2, …,  vn. The ANY operator returns TRUE if any comparison (scalar_expression, vi) returns TRUE. Otherwise, it returns FALSE.

Note that the SOME operator is equivalent to the ANY operator.

SQL Server ANY operator example 
See the following products table from the sample database.

products
The following example finds the products that were sold with more than two units in a sales order:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_id = ANY (
        SELECT
            product_id
        FROM
            sales.order_items
        WHERE
            quantity >= 2
    )
ORDER BY
    product_name;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server ANY operator to compare a value with a single-column set of values.

-----------------------------------------------------

SQL Server ALL
Summary: in this tutorial, you will learn how to use the SQL Server ALL operator to compare a value with a list of single column set of values.

Overview of the SQL Server ALL operator 
The SQL Server ALL operator is a logical operator that compares a scalar value with a single-column list of values returned by a subquery.

The following illustrates the ALL operator syntax:

scalar_expression comparison_operator ALL ( subquery) 
Code language: SQL (Structured Query Language) (sql)
In this syntax:

The scalar_expression is any valid expression.
The comparison_operator is any valid comparison operator including equal (=), not equal (<>), greater than (>), greater than or equal (>=), less than (<), less than or equal (<=).
The subquery within the parentheses is a SELECT statement that returns a result of a single column. Also, the data type of the returned column must be the same data type as the data type of the scalar expression.
The ALL operator returns TRUE if all the pairs (scalar_expression, v) evaluates to TRUE; v is a value in the single-column result.

If one of the pairs (scalar_expression, v) returns FALSE, then the ALL operator returns FALSE.

SQL Server ALL operator examples 
Consider the following products table from the sample database.

products table
The following statement returns a list average list prices of products for each brand:

SELECT
    AVG (list_price) avg_list_price
FROM
    production.products
GROUP BY
    brand_id
ORDER BY
    avg_list_price;
Code language: SQL (Structured Query Language) (sql)
SQL Server ALL average list price by brand
1) scalar_expression > ALL ( subquery ) 
The expression returns TRUE if the scalar_expression is greater than the largest value returned by the subquery.

For example, the following query finds the products whose list prices are bigger than the average list price of products of all brands:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > ALL (
        SELECT
            AVG (list_price) avg_list_price
        FROM
            production.products
        GROUP BY
            brand_id
    )
ORDER BY
    list_price;
Code language: SQL (Structured Query Language) (sql)
SQL Server ALL with greater than operator example
2) scalar_expression < ALL ( subquery ) 
The expression evaluates to TRUE if the scalar expression is smaller than the smallest value returned by the subquery.

The following example finds the products whose list price is less than the smallest price in the average price list by brand:

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price < ALL (
        SELECT
            AVG (list_price) avg_list_price
        FROM
            production.products
        GROUP BY
            brand_id
    )
ORDER BY
    list_price DESC;
Code language: SQL (Structured Query Language) (sql)
SQL Server ALL with less than operator example
Similarly, you can take your own examples of using the ALL operator with one of the following comparison operators such as equal to (=), greater than or equal (>=), less than or equal to (<=), and not equal (<>).

In this tutorial, you have learned how to use the SQL Server ALL operator to compare a scalar value with a single column set of values returned by a subquery.

--------------------------------

SQL Server CROSS APPLY
Summary: in this tutorial, you will learn how to use the SQL Server CROSS APPLY clause to perform an inner join a table with a table-valued function or a correlated subquery.

Introduction to the SQL Server CROSS APPLY clause 
The CROSS APPLY clause allows you to perform an inner join a table with a table-valued function or a correlated subquery.

In SQL Server, a table-valued function is a user-defined function that returns multiple rows as a table.

The CROSS APPLY clause works like an INNER JOIN clause. But instead of joining two tables, the CROSS APPLY clause joins a table with a table-valued function or a correlated subquery.

Here’s the basic syntax of the CROSS APPLY clause:

SELECT
  select_list
FROM
  table1
  CROSS APPLY table_function(table1.column) AS alias;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

table1 is the main table from which you want to join.
table_function: is the table-valued function to apply to each row. Alternatively, you can use a correlated subquery.
column: is the column from table1 that will be passed as a parameter to the table_function.
alias is the alias for the result set returned by the table_function.
The CROSS APPLY clause will apply the table_function to each row from the table1. If you use a correlated subquery, the CROSS APPLY clause will execute it for each row from the table1.

In practice, you should use the CROSS APPLY clauses when you cannot use INNER JOIN clauses.

SQL Server CROSS APPLY clause examples 
Let’s explore some useful use cases of the CROSS APPLY clause.

We’ll use the production.categories and production.products tables from the sample database for the demonstration:

SQL Server CROSS APPLY Operator - Sample table example
1) Using the SQL Server CROSS APPLY clause to join a table with a correlated subquery 
The following example uses the CROSS APPLY clause to join the production.categories table with a correlated subquery to retrieve the top two most expensive products for each product category:

SELECT
  c.category_name,
  r.product_name,
  r.list_price
FROM
  production.categories c
  CROSS APPLY (
    SELECT
      TOP 2 *
    FROM
      production.products p
    WHERE
      p.category_id = c.category_id
    ORDER BY
      list_price DESC,
      product_name
  ) r
ORDER BY
  c.category_name,
  r.list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

category_name       | product_name                                   | list_price
--------------------+------------------------------------------------+---------
Children Bicycles   | Electra Straight 8 3i (20-inch) - Boy's - 2017 | 489.99
Children Bicycles   | Electra Townie 3i EQ (20-inch) - Boys' - 2017  | 489.99
Comfort Bicycles    | Electra Townie Go! 8i - 2017/2018              | 2599.99
Comfort Bicycles    | Electra Townie Balloon 7i EQ - 2018            | 899.99
Cruisers Bicycles   | Electra Townie Commute Go! - 2018              | 2999.99
Cruisers Bicycles   | Electra Townie Commute Go! Ladies' - 2018      | 2999.99
Cyclocross Bicycles | Trek Boone 7 Disc - 2018                       | 3999.99
Cyclocross Bicycles | Trek Boone 7 - 2017                            | 3499.99
Electric Bikes      | Trek Powerfly 8 FS Plus - 2017                 | 4999.99
Electric Bikes      | Trek Powerfly 7 FS - 2018                      | 4999.99
Mountain Bikes      | Trek Fuel EX 9.8 27.5 Plus - 2017              | 5299.99
Mountain Bikes      | Trek Remedy 9.8 - 2017                         | 5299.99
Road Bikes          | Trek Domane SLR 9 Disc - 2018                  | 11999.99
Road Bikes          | Trek Domane SLR 8 Disc - 2018                  | 7499.99
(14 rows)
Code language: SQL (Structured Query Language) (sql)
How it works.

For each row from the production.categories table, the CROSS APPLY executes the following correlated subquery to retrieve the top two most expensive products:

SELECT
  TOP 2 *
FROM
  production.products p
WHERE
  p.category_id = c.category_id
ORDER BY
  list_price DESC,
  product_name
Code language: SQL (Structured Query Language) (sql)
2) Using the CROSS APPLY clause to join a table with a table-valued function 
First, define a table-valued function that returns the top two most expensive products by category id:

CREATE FUNCTION GetTopProductsByCategory (@category_id INT)
RETURNS TABLE
AS
RETURN (
    SELECT TOP 2 *
    FROM production.products p
    WHERE p.category_id = @category_id 
    ORDER BY list_price DESC, product_name
);
Code language: SQL (Structured Query Language) (sql)
Second, use the CROSS APPLY clause with the table-valued function GetTopProductsByCategory to retrieve the top two most expensive products within each category:

SELECT
  c.category_name,
  r.product_name,
  r.list_price
FROM
  production.categories c
  CROSS APPLY GetTopProductsByCategory(c.category_id) r
ORDER BY
  c.category_name,
  r.list_price DESC;
Code language: SQL (Structured Query Language) (sql)
It returns the same result as the query that uses the correlated subquery above.

3) Using the CROSS APPLY clause to process JSON data 
First, create a table called product_json to store the product data:

CREATE TABLE product_json(
    id INT IDENTITY PRIMARY KEY,
    info NVARCHAR(MAX)
);
Code language: SQL (Structured Query Language) (sql)
In the product_json table:

id is the primary key column with the identity attribute.
info is the NVARCHAR(MAX) that will store the JSON data.
Second, insert rows into the product_json table:

INSERT INTO product_json(info)
VALUES 
    ('{"Name": "Laptop", "Price": 999, "Category": "Electronics"}'),
    ('{"Name": "Headphones", "Price": 99, "Category": "Electronics"}'),
    ('{"Name": "Book", "Price": 15, "Category": "Books"}');
Code language: SQL (Structured Query Language) (sql)
Third, extract information from the info JSON data using the CROSS APPLY clause with the OPENJSON() function:

SELECT
  p.id,
  j.*
FROM
  product_json p
  CROSS APPLY OPENJSON (p.info) WITH
  (
    Name NVARCHAR(100),
    Price DECIMAL(10, 2),
    Category NVARCHAR(100)
  ) AS j;
Code language: SQL (Structured Query Language) (sql)
Output:

id | Name       | Price  | Category
---+------------+--------+-------------
1  | Laptop     | 999.00 | Electronics
2  | Headphones | 99.00  | Electronics
3  | Book       | 15.00  | Books
(3 rows)
Code language: SQL (Structured Query Language) (sql)
4) Using the CROSS APPLY clause to remove the nested REPLACE() function 
First, create a table called companies that stores the company names:

CREATE TABLE companies(
   id INT IDENTITY PRIMARY KEY,
   name VARCHAR(255) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Second, insert rows into the companies table:

INSERT INTO
  companies (name)
VALUES
  ('ABC Corporation'),
  ('XYZ Inc.'),
  ('JK Pte Ltd');
Code language: SQL (Structured Query Language) (sql)
Suppose you want to get the company names without words like Corporation, Inc., and Pte Ltd. To achieve this, you can use multiple REPLACE() functions.

Third, retrieve the company names from the companies table:

SELECT TRIM(REPLACE(REPLACE(REPLACE(name,'Corporation',''), 'Inc.',''),'Pte Ltd','')) company_name
FROM companies;
Code language: SQL (Structured Query Language) (sql)
Output:

company_name
------------
ABC
XYZ
JK
(3 rows)
Code language: SQL (Structured Query Language) (sql)
The query works as expected but it is quite complex. To fix this, you can utilize the CROSS APPLY clause follows:

SELECT TRIM(r3.name) company_name
FROM companies c
CROSS APPLY (SELECT REPLACE(c.name,'Corporation', '') name) AS r1 
CROSS APPLY (SELECT REPLACE(r1.name,'Inc.', '') name) AS r2
CROSS APPLY (SELECT REPLACE(r2.name,'Pte Ltd', '') name) AS r3;
Code language: SQL (Structured Query Language) (sql)
In this query, we use a series of CROSS APPLY clauses to progressively replace specific words (Corporation, Inc., and Pte Ltd) from the company names.

Summary 
Use the CROSS APPLY clause to perform an inner join a table with the table-valued function or a correlated subquery.
Was this tutorial helpful?
SQL Server OUTER APPLY
Summary: in this tutorial, you will learn how to use the SQL Server OUTER APPLY clause to perform a left join of a table with a table-valued function or a correlated subquery.

Introduction to the SQL Server OUTER APPLY clause 
The OUTER APPLY clause allows you to perform a left join of a table with a table-valued function or a correlated subquery.

In SQL Server, a table-valued function is a user-defined function that returns multiple rows as a table.

The OUTER APPLY clause works like a LEFT JOIN clause. However, instead of joining two tables, the OUTER APPLY clause joins a table with a table-valued function or a correlated subquery.

The following shows the syntax of the OUTER APPLY clause:

SELECT
  select_list
FROM
  table1
  OUTER APPLY table_function(table1.column) AS alias;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

table1 is the main table from which you want to join.
table_function is the table-valued function to apply to each row. Alternatively, you can use a correlated subquery.
column is the column from table1 that will be passed as a parameter to the table_function.
alias is the alias for the result set returned by the table_function.
In this query, the OUTER APPLY clause will apply the table_function to each row from the table1, or execute a correlated subquery for each row from the table1.

If there are no corresponding rows from the result set of the table-valued function or correlated subquery, the OUTER APPLY clause will use NULL for “right table” to create a new row in the result set.

In practice, you should use the OUTER APPLY clauses when you cannot use LEFT JOIN clauses.

SQL Server OUTER APPLY clause examples 
Let’s take some examples of using the OUTER APPLY clause.

We’ll use the production.products and production.order_items tables from the sample database for the demonstration:

SQL Server OUTER APPLY clause - Sample Tables
1) Using the SQL Server OUTER APPLY clause to join a table with a correlated subquery 
The following example uses the OUTER APPLY clause to join the production.products table with a correlated subquery to retrieve the product name, quantity, and discount of the products with the brand id 1 in the latest orders:

SELECT
  p.product_name,
  r.quantity,
  r.discount
FROM
  production.products p OUTER apply (
    SELECT
      top 1 i.*
    FROM
      sales.order_items i
      INNER JOIN sales.orders o ON o.order_id = i.order_id
    WHERE
      product_id = p.product_id
    ORDER BY
      order_date DESC
  ) r
WHERE
  p.brand_id = 1
ORDER BY
  r.quantity;
Code language: SQL (Structured Query Language) (sql)
Output:

product_name                                          | quantity | discount
-----------------------------------------------------------------------
Electra Townie Go! 8i Ladies' - 2018                  | NULL     | NULL
Electra Savannah 1 (20-inch) - Girl's - 2018          | NULL     | NULL
Electra Sweet Ride 1 (20-inch) - Girl's - 2018        | NULL     | NULL
Electra Townie Original 21D - 2018                    | 1        | 0.20
Electra Townie Balloon 7i EQ - 2018                   | 1        | 0.10
Electra Townie Balloon 3i EQ - 2017/2018              | 1        | 0.10
Electra Townie Balloon 8D EQ - 2016/2017/2018         | 1        | 0.07
Code language: SQL (Structured Query Language) (sql)
How it works.

For each row from the production.products table, the OUTER APPLY executes the following correlated subquery to retrieve the discount and quantity of the latest orders:

SELECT
  TOP 1 i.*
FROM
  sales.order_items i
  INNER JOIN sales.orders o ON o.order_id = i.order_id
WHERE
  product_id = p.product_id
ORDER BY
  order_date DESC
Code language: SQL (Structured Query Language) (sql)
2) Using the OUTER APPLY clause to join a table with a table-valued function 
First, define a table-valued function that returns latest order items of a product specified by the product id:

CREATE FUNCTION GetLatestQuantityDiscount (@product_id INT) 
RETURNS TABLE 
AS RETURN (
  SELECT
    TOP 1 i.*
  FROM
    sales.order_items i
    INNER JOIN sales.orders o ON o.order_id = i.order_id
  WHERE
    product_id = @product_id
  ORDER BY
    order_date DESC
);
Code language: SQL (Structured Query Language) (sql)
Second, use the OUTER APPLY clause with the table-valued function GetLatestQuantityDiscount to retrieve the latest quantity and discount of each product in the production.products table:

SELECT
  p.product_name,
  r.quantity,
  r.discount
FROM
  production.products p 
OUTER APPLY GetLatestQuantityDiscount(p.product_id) r
WHERE
  p.brand_id = 1
ORDER BY
  r.quantity;
Code language: SQL (Structured Query Language) (sql)
It returns the same result as the query that joins with the correlated subquery above.

Summary 
Use the OUTER APPLY operator to perform a left join of a table with the table-valued function or a correlated subquery.
Was this tutorial helpful?



SQL Server UNION
Summary: in this tutorial, you will learn how to use the SQL Server UNION to combine the results of two or more queries into a single result set.

Introduction to SQL Server UNION operator 
SQL Server UNION is one of the set operations that allow you to combine results of two SELECT statements into a single result set which includes all the rows that belong to the SELECT statements in the union.

The following illustrates the syntax of the SQL Server UNION:

query_1
UNION
query_2
Code language: SQL (Structured Query Language) (sql)
The following are requirements for the queries in the syntax above:

The number and the order of the columns must be the same in both queries.
The data types of the corresponding columns must be the same or compatible.
The following Venn diagram illustrates how the result set of the T1 table unions with the result set of the T2 table:

SQL Server UNION Venn Diagram
UNION vs. UNION ALL 
By default, the UNION operator removes all duplicate rows from the result sets. However, if you want to retain the duplicate rows, you need to specify the ALL keyword is explicitly as shown below:

query_1
UNION ALL
query_2
Code language: SQL (Structured Query Language) (sql)
In other words, the UNION  operator removes the duplicate rows while the UNION ALL operator includes the duplicate rows in the final result set.

UNION vs. JOIN 
The join such as INNER JOIN or LEFT JOIN combines columns from two tables while the UNION combines rows from two queries.

In other words, join appends the result sets horizontally while union appends the result set vertically.

The following picture illustrates the main difference between UNION and JOIN:

SQL Server UNION vs JOIN
SQL Server UNION examples 
See the following staffs and customers tables from the sample database:



UNION and UNION ALL examples 
The following example combines names of staff and customers into a single list:

SELECT
    first_name,
    last_name
FROM
    sales.staffs
UNION
SELECT
    first_name,
    last_name
FROM
    sales.customers;
Code language: SQL (Structured Query Language) (sql)
SQL Server UNION example
It returns 1,454 rows.

The staffs table has 10 rows and the customers table has 1,445 rows as shown in the following queries:

SELECT
    COUNT (*)
FROM
    sales.staffs;
-- 10       

SELECT
    COUNT (*)
FROM
    sales.customers;
-- 1454
Code language: SQL (Structured Query Language) (sql)
Because the result set of the union returns only 1,454 rows, it means that one duplicate row was removed.

To include the duplicate row, you use the UNION ALL as shown in the following query:

SELECT
    first_name,
    last_name
FROM
    sales.staffs
UNION ALL
SELECT
    first_name,
    last_name
FROM
    sales.customers;
Code language: SQL (Structured Query Language) (sql)
The query returns 1,455 rows as expected.

UNION and ORDER BY example 
To sort the result set returned by the UNION operator, you place the ORDER BY clause in the last query as follows:

SELECT
    select_list
FROM
    table_1
UNION
SELECT
    select_list
FROM
    table_2
ORDER BY
    order_list;
Code language: SQL (Structured Query Language) (sql)
For example, to sort the first names and last names of customers and staff, you use the following query:

SELECT
    first_name,
    last_name
FROM
    sales.staffs
UNION ALL
SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    first_name,
    last_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server UNION ALL example
In this tutorial, you have learned how to use the SQL Server UNION to combine rows from multiple queries into a single result set.

Was this tutorial helpful?


SQL Server INTERSECT
Summary: in this tutorial, you will learn how to use the SQL Server INTERSECT operator to combine result sets of two input queries and return the distinct rows that appear in both inputs.

Introduction to SQL Server INTERSECT 
The SQL Server INTERSECT combines result sets of two or more queries and returns distinct rows that are output by both queries.

The following illustrates the syntax of the SQL Server INTERSECT:

query_1
INTERSECT
query_2
Code language: SQL (Structured Query Language) (sql)
Similar to the UNION operator, the queries in the syntax above must conform to the following rules:

Both queries must have the same number and order of columns.
The data type of the corresponding columns must be the same or compatible.
SQL Server INTERSECT Illustration
The following picture illustrates the INTERSECT operation:

In this illustration, we had two result sets T1 and T2:

T1 result set includes 1, 2, and 3.
T2 result set includes 2, 3, and 4.
The intersection of T1 and T2 result sets returns the distinct rows which are 2 and 3.

SQL Server INTERSECT example 
Consider the following query:

SELECT
    city
FROM
    sales.customers
INTERSECT
SELECT
    city
FROM
    sales.stores
ORDER BY
    city;
Code language: SQL (Structured Query Language) (sql)
SQL Server INTERSECT example
The first query finds all cities of the customers and the second query finds the cities of the stores. The whole query, which uses INTERSECT, returns the common cities of customers and stores, which are the cities output by both input queries.

Notice that we added the ORDER BY clause to the last query to sort the result set.

In this tutorial, you have learned how to use the SQL Server INTERSECT  operator to return the intersection of the result sets of two queries.

SQL Server EXCEPT
Summary: in this tutorial, you will learn how to use the SQL Server EXCEPT operator to subtract a result set of a query from another result set of another query.

Introduction to SQL Server EXCEPT operator 
The SQL Server EXCEPT compares the result sets of two queries and returns the distinct rows from the first query that are not output by the second query. In other words, the EXCEPT subtracts the result set of a query from another.

The following shows the syntax of the SQL Server EXCEPT:

query_1
EXCEPT
query_2
Code language: SQL (Structured Query Language) (sql)
The following are the rules for combining the result sets of two queries in the above syntax:

The number and order of columns must be the same in both queries.
The data types of the corresponding columns must be the same or compatible.
The following picture shows the EXCEPT operation of the two result sets T1 and T2:

SQL Server EXCEPT illustration
In this illustration:

T1 result set includes 1, 2, and 3.
T2 result set includes 2, 3, and 4.
The except of the T1 and T2 returns 1 which is the distinct row from the T1 result set that does not appear in the T2 result set.

SQL Server EXCEPT operator example 
See the following products and order_items tables from the sample database:


A) Simple EXCEPT example 
The following example uses the EXCEPT operator to find the products that have no sales:

SELECT
    product_id
FROM
    production.products
EXCEPT
SELECT
    product_id
FROM
    sales.order_items;
Code language: SQL (Structured Query Language) (sql)
SQL Server EXCEPT example
In this example, the first query returns all the products. The second query returns the products that have sales. Therefore, the result set includes only the products that have no sales.

B) EXCEPT with ORDER BY example 
To sort the result set created by the EXCEPT operator, you add the ORDER BY clause in the last query. For example, the following example finds the products that had no sales and sorts the products by their id in ascending order:

SELECT
    product_id
FROM
    production.products
EXCEPT
SELECT
    product_id
FROM
    sales.order_items
ORDER BY 
	product_id;
Code language: SQL (Structured Query Language) (sql)
SQL Server EXCEPT with ORDER BY example
In this tutorial, you have learned how to use the SQL Server EXCEPT to combine result sets of two queries.


SQL Server CTE
Summary: in this tutorial, you will learn about the common table expression or CTE in SQL Server by using the WITH clause.

Introduction to CTE in SQL Server 
CTE stands for common table expression. A CTE allows you to define a temporary named result set that available temporarily in the execution scope of a statement such as SELECT, INSERT, UPDATE, DELETE, or MERGE.

The following shows the common syntax of a CTE in SQL Server:

WITH expression_name[(column_name [,...])]
AS
    (CTE_definition)
SQL_statement;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the expression name (expression_name) to which you can refer later in a query.
Next, specify a list of comma-separated columns after the expression_name. The number of columns must be the same as the number of columns defined in the CTE_definition.
Then, use the AS keyword after the expression name or column list if the column list is specified.
After, define a SELECT statement whose result set populates the common table expression.
Finally, refer to the common table expression in a query (SQL_statement) such as SELECT, INSERT, UPDATE, DELETE, or MERGE.
We prefer to use common table expressions rather than to use subqueries because common table expressions are more readable. We also use CTE in the queries that contain analytic functions (or window functions)

SQL Server CTE examples 
Let’s take some examples of using common table expressions.

A) Simple SQL Server CTE example 
This query uses a CTE to return the sales amounts by sales staffs in 2018:

WITH cte_sales_amounts (staff, sales, year) AS (
    SELECT    
        first_name + ' ' + last_name, 
        SUM(quantity * list_price * (1 - discount)),
        YEAR(order_date)
    FROM    
        sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.staffs s ON s.staff_id = o.staff_id
    GROUP BY 
        first_name + ' ' + last_name,
        year(order_date)
)

SELECT
    staff, 
    sales
FROM 
    cte_sales_amounts
WHERE
    year = 2018;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the result set:

SQL Server CTE example
In this example:

First, we defined cte_sales_amounts as the name of the common table expression. the CTE returns a result that that consists of three columns staff, year, and sales derived from the definition query.
Second, we constructed a query that returns the total sales amount by sales staff and year by querying data from the orders, order_items and staffs tables.
Third, we referred to the CTE in the outer query and select only the rows whose year are 2018.
Noted that this example is solely for the demonstration purpose to help you gradually understand how common table expressions work. There is a more optimal way to achieve the result without using CTE.

B) Using a common table expression to make report averages based on counts 
This example uses the CTE to return the average number of sales orders in 2018 for all sales staffs.

WITH cte_sales AS (
    SELECT 
        staff_id, 
        COUNT(*) order_count  
    FROM
        sales.orders
    WHERE 
        YEAR(order_date) = 2018
    GROUP BY
        staff_id

)
SELECT
    AVG(order_count) average_orders_by_staff
FROM 
    cte_sales;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

average_orders_by_staff
-----------------------
48

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
In this example:

First, we used cte_sales as the name of the common table expression. We skipped the column list of the CTE so it is derived from the CTE definition statement. In this example, it includes staff_id and order_count columns.

Second, we use the following query to define the result set that populates the common table expression cte_sales. The query returns the number of orders in 2018 by sales staff.

SELECT    
    staff_id, 
    COUNT(*) order_count
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    staff_id;
Code language: SQL (Structured Query Language) (sql)
Third, we refer to the cte_sales in the outer statement and use the AVG() function to get the average sales order by all staffs.

SELECT
    AVG(order_count) average_orders_by_staff
FROM 
    cte_sales;
Code language: SQL (Structured Query Language) (sql)
C) Using multiple SQL Server CTE in a single query example 
The following example uses two CTE cte_category_counts and cte_category_sales to return the number of the products and sales for each product category. The outer query joins two CTEs using the category_id column.

WITH cte_category_counts (
    category_id, 
    category_name, 
    product_count
)
AS (
    SELECT 
        c.category_id, 
        c.category_name, 
        COUNT(p.product_id)
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
    GROUP BY 
        c.category_id, 
        c.category_name
),
cte_category_sales(category_id, sales) AS (
    SELECT    
        p.category_id, 
        SUM(i.quantity * i.list_price * (1 - i.discount))
    FROM    
        sales.order_items i
        INNER JOIN production.products p 
            ON p.product_id = i.product_id
        INNER JOIN sales.orders o 
            ON o.order_id = i.order_id
    WHERE order_status = 4 -- completed
    GROUP BY 
        p.category_id
) 

SELECT 
    c.category_id, 
    c.category_name, 
    c.product_count, 
    s.sales
FROM
    cte_category_counts c
    INNER JOIN cte_category_sales s 
        ON s.category_id = c.category_id
ORDER BY 
    c.category_name;
Code language: SQL (Structured Query Language) (sql)
Here is the result set:

SQL Server CTE join two CTEs example
In this tutorial, you have learned how to use common table expressions or CTE in SQL Server to construct complex queries in an easy-to-understand manner.

Was this tutorial helpful?

SQL Server Recursive CTE
Summary: in this tutorial, you will learn how to use the SQL Server recursive CTE to query hierarchical data.

Introduction to SQL Server recursive CTE 
A recursive common table expression (CTE) is a CTE that references itself. By doing so, the CTE repeatedly executes, returns subsets of data, until it returns the complete result set.

A recursive CTE is useful in querying hierarchical data such as organization charts where one employee reports to a manager or multi-level bill of materials when a product consists of many components, and each component itself also consists of many other components.

The following shows the syntax of a recursive CTE:

WITH expression_name (column_list)
AS
(
    -- Anchor member
    initial_query  
    UNION ALL
    -- Recursive member that references expression_name.
    recursive_query  
)
-- references expression name
SELECT *
FROM   expression_name
Code language: SQL (Structured Query Language) (sql)
In general, a recursive CTE has three parts:

An initial query that returns the base result set of the CTE. The initial query is called an anchor member.
A recursive query that references the common table expression, therefore, it is called the recursive member. The recursive member is union-ed with the anchor member using the UNION ALL operator.
A termination condition specified in the recursive member that terminates the execution of the recursive member.
The execution order of a recursive CTE is as follows:

First, execute the anchor member to form the base result set (R0), use this result for the next iteration.
Second, execute the recursive member with the input result set from the previous iteration (Ri-1) and return a sub-result set (Ri) until the termination condition is met.
Third, combine all result sets R0, R1, … Rn using UNION ALL operator to produce the final result set.
The following flowchart illustrates the execution of a recursive CTE:

SQL Server Recursive CTE execution flow
SQL Server Recursive CTE examples 
Let’s take some examples of using recursive CTEs

A) Simple SQL Server recursive CTE example 
This example uses a recursive CTE to returns weekdays from Monday to Saturday:

WITH cte_numbers(n, weekday) 
AS (
    SELECT 
        0, 
        DATENAME(DW, 0)
    UNION ALL
    SELECT    
        n + 1, 
        DATENAME(DW, n + 1)
    FROM    
        cte_numbers
    WHERE n < 6
)
SELECT 
    weekday
FROM 
    cte_numbers;
Code language: SQL (Structured Query Language) (sql)
Here is the result set:

SQL Server Recursive CTE example
In this example:

The DATENAME() function returns the name of the weekday based on a weekday number.

The anchor member returns the Monday

SELECT 
    0, 
    DATENAME(DW, 0)
Code language: SQL (Structured Query Language) (sql)
The recursive member returns the next day starting from the Tuesday till Sunday.

    SELECT    
        n + 1, 
        DATENAME(DW, n + 1)
    FROM    
        cte_numbers
    WHERE n < 6
Code language: SQL (Structured Query Language) (sql)
The condition in the WHERE clause is the termination condition that stops the execution of the recursive member when n is 6

n < 6
Code language: SQL (Structured Query Language) (sql)
B) Using a SQL Server recursive CTE to query hierarchical data 
See the following sales.staffs table from the sample database:


In this table, a staff reports to zero or one manager. A manager may have zero or more staffs. The top manager has no manager. The relationship is specified in the values of the manager_id column. If a staff does not report to any staff (in case of the top manager), the value in the manager_id is NULL.

This example uses a recursive CTE to get all subordinates of the top manager who does not have a manager (or the value in the manager_id column is NULL):

WITH cte_org AS (
    SELECT       
        staff_id, 
        first_name,
        manager_id
        
    FROM       
        sales.staffs
    WHERE manager_id IS NULL
    UNION ALL
    SELECT 
        e.staff_id, 
        e.first_name,
        e.manager_id
    FROM 
        sales.staffs e
        INNER JOIN cte_org o 
            ON o.staff_id = e.manager_id
)
SELECT * FROM cte_org;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Recursive CTE query hierarchical data
In this example, the anchor member gets the top manager and the recursive query returns subordinates of the top managers and subordinates of the top manager, and so on.

In this tutorial, you have learned how to use the SQL Server recursive CTE to query hierarchical data.

Was this tutorial helpful? 

SQL Server PIVOT
Summary: in this tutorial, you will learn how to use the SQL Server PIVOT operator to convert rows to columns.

Setting up the goals 
For the demonstration, we will use the production.products and production.categories tables from the sample database:


The following query finds the number of products for each product category:

SELECT 
    category_name, 
    COUNT(product_id) product_count
FROM 
    production.products p
    INNER JOIN production.categories c 
        ON c.category_id = p.category_id
GROUP BY 
    category_name;
Code language: SQL (Structured Query Language) (sql)
Here is the output:


Our goal is to turn the category names from the first column of the output into multiple columns and count the number of products for each category name as the following picture:


In addition, we can add the model year to group the category by model year as shown in the following output:


Introduction to SQL Server PIVOT operator 
SQL Server PIVOT operator rotates a table-valued expression. It turns the unique values in one column into multiple columns in the output and performs aggregations on any remaining column values.

You follow these steps to make a query a pivot table:

First, select a base dataset for pivoting.
Second, create a temporary result by using a derived table or common table expression (CTE)
Third, apply the PIVOT operator.
Let’s apply these steps in the following example.

First, select category name and product id from the production.products and production.categories tables as the base data for pivoting:

SELECT 
    category_name, 
    product_id
FROM 
    production.products p
    INNER JOIN production.categories c 
        ON c.category_id = p.category_id
Code language: SQL (Structured Query Language) (sql)
Second, create a temporary result set using a derived table:

SELECT * FROM (
    SELECT 
        category_name, 
        product_id
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
) t
Code language: SQL (Structured Query Language) (sql)
Third, apply the PIVOT operator:

SELECT * FROM   
(
    SELECT 
        category_name, 
        product_id
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
) t 
PIVOT(
    COUNT(product_id) 
    FOR category_name IN (
        [Children Bicycles], 
        [Comfort Bicycles], 
        [Cruisers Bicycles], 
        [Cyclocross Bicycles], 
        [Electric Bikes], 
        [Mountain Bikes], 
        [Road Bikes])
) AS pivot_table;
Code language: SQL (Structured Query Language) (sql)
This query generates the following output:


Now, any additional column which you add to the select list of the query that returns the base data will automatically form row groups in the pivot table. For example, you can add the model year column to the above query:

SELECT * FROM   
(
    SELECT 
        category_name, 
        product_id,
        model_year
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
) t 
PIVOT(
    COUNT(product_id) 
    FOR category_name IN (
        [Children Bicycles], 
        [Comfort Bicycles], 
        [Cruisers Bicycles], 
        [Cyclocross Bicycles], 
        [Electric Bikes], 
        [Mountain Bikes], 
        [Road Bikes])
) AS pivot_table;
Code language: SQL (Structured Query Language) (sql)
Here is the output:


Generating column values 
In the above query, you had to type each category name in the parentheses after the IN operator manually. To avoid this, you can use the QUOTENAME() function to generate the category name list and copy them over the query.

First, generate the category name list:

DECLARE 
    @columns NVARCHAR(MAX) = '';

SELECT 
    @columns += QUOTENAME(category_name) + ','
FROM 
    production.categories
ORDER BY 
    category_name;

SET @columns = LEFT(@columns, LEN(@columns) - 1);

PRINT @columns;
Code language: SQL (Structured Query Language) (sql)
The output will look like this:

[Children Bicycles],[Comfort Bicycles],[Cruisers Bicycles],[Cyclocross Bicycles],[Electric Bikes],[Mountain Bikes],[Road Bikes]
Code language: CSS (css)
In this snippet:

The QUOTENAME() function wraps the category name by the square brackets e.g., [Children Bicycles]
The LEFT() function removes the last comma from the @columns string.
Second, copy the category name list from the output and paste it to the query.

Dynamic pivot tables 
If you add a new category name to the production.categories table, you need to rewrite your query, which is not ideal. To avoid doing this, you can use dynamic SQL to make the pivot table dynamic.

In this query, instead of passing a fixed list of category names to the PIVOT operator, we construct the category name list and pass it to an SQL statement, and then execute this statement dynamically using the stored procedure sp_executesql.

DECLARE 
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';

-- select the category names
SELECT 
    @columns+=QUOTENAME(category_name) + ','
FROM 
    production.categories
ORDER BY 
    category_name;

-- remove the last comma
SET @columns = LEFT(@columns, LEN(@columns) - 1);

-- construct dynamic SQL
SET @sql ='
SELECT * FROM   
(
    SELECT 
        category_name, 
        model_year,
        product_id 
    FROM 
        production.products p
        INNER JOIN production.categories c 
            ON c.category_id = p.category_id
) t 
PIVOT(
    COUNT(product_id) 
    FOR category_name IN ('+ @columns +')
) AS pivot_table;';

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server PIVOT table to convert rows to columns.

Was this tutorial helpful?

SQL Server INSERT
Summary: in this tutorial, you will learn how to use the INSERT statement to add a new row to a table.

Introduction to SQL Server INSERT statement 
To add one or more rows into a table, you use the INSERT statement. The following illustrates the most basic form of the INSERT statement:

INSERT INTO table_name (column_list)
VALUES (value_list);
Code language: SQL (Structured Query Language) (sql)
Let’s examine this syntax in more detail.

First, you specify the name of the table which you want to insert. Typically, you reference the table name by the schema name e.g., production.products where production is the schema name and products is the table name.

Second, you specify a list of one or more columns in which you want to insert data. You must enclose the column list in parentheses and separate the columns by commas.

If a column of a table does not appear in the column list, SQL Server must be able to provide a value for insertion or the row cannot be inserted.

SQL Server automatically uses the following value for the column that is available in the table but does not appear in the column list of the INSERT statement:

The next incremental value if the column has an IDENTITY property.
The default value if the column has a default value specified.
The current timestamp value if the data type of the column is a timestamp data type.
The NULL if the column is nullable.
The calculated value if the column is a computed column.
Third, you provide a list of values to be inserted in the VALUES clause. Each column in the column list must have a corresponding value in the value list. Also, you must enclose the value list in parentheses.

SQL Server INSERT statement examples 
Let’s create a new table named promotions for the demonstration:

CREATE TABLE sales.promotions (
    promotion_id INT PRIMARY KEY IDENTITY (1, 1),
    promotion_name VARCHAR (255) NOT NULL,
    discount NUMERIC (3, 2) DEFAULT 0,
    start_date DATE NOT NULL,
    expired_date DATE NOT NULL
); 
Code language: SQL (Structured Query Language) (sql)
In this statement, we created a new table named promotions in the sales schema. The promotions table has five columns including promotion identification number, name, discount, start date and expired date.

The promotion identification number is an identity column so its value is automatically populated by the SQL Server when you add a new row to the table.

1) Basic INSERT example 
The following statement inserts a new row into the promotions table:

INSERT INTO sales.promotions (
    promotion_name,
    discount,
    start_date,
    expired_date
)
VALUES
    (
        '2018 Summer Promotion',
        0.15,
        '20180601',
        '20180901'
    );
Code language: SQL (Structured Query Language) (sql)
In this example, we specified values for four columns in the promotions table. We did not specify a value for the promotion_id column because SQL Server provides the value for this column automatically.

If the INSERT statement executes successfully, you will get the number of rows inserted. In this case, SQL Server issued the following message:

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
To verify the insert operation, you use the following query:

SELECT
    *
FROM
    sales.promotions;
Code language: SQL (Structured Query Language) (sql)
Here is the result as you expected.

SQL Server INSERT example
2) Insert and return inserted values 
To capture the inserted values, you use the OUTPUT clause. For example, the following statement inserts a new row into the promotions table and returns the inserted value of the promotion_id column:

INSERT INTO sales.promotions (
    promotion_name,
    discount,
    start_date,
    expired_date
) OUTPUT inserted.promotion_id
VALUES
    (
        '2018 Fall Promotion',
        0.15,
        '20181001',
        '20181101'
    );
Code language: SQL (Structured Query Language) (sql)
SQL Server INSERT OUTPUT example
To capture inserted values from multiple columns, you specify the columns in the output as shown in the following statement:

INSERT INTO sales.promotions (
    promotion_name,
    discount,
    start_date,
    expired_date
) OUTPUT inserted.promotion_id,
 inserted.promotion_name,
 inserted.discount,
 inserted.start_date,
 inserted.expired_date
VALUES
    (
        '2018 Winter Promotion',
        0.2,
        '20181201',
        '20190101'
    );
Code language: SQL (Structured Query Language) (sql)
The following is the output:

SQL Server INSERT OUTPUT multiple columns
3) Insert explicit values into the identity column 
Typically, you don’t specify a value for the identity column because SQL Server will provide the value automatically.

However, in some situations, you may want to insert a value into the identity column such as data migration.

See the following INSERT statement:

INSERT INTO sales.promotions (
    promotion_id,
    promotion_name,
    discount,
    start_date,
    expired_date
) OUTPUT inserted.promotion_id
VALUES
    (
        4,
        '2019 Spring Promotion',
        0.25,
        '20190201',
        '20190301'
    );
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following error:

Cannot insert explicit value for identity column in table 'promotions' when IDENTITY_INSERT is set to OFF.
Code language: Shell Session (shell)
To insert explicit value for the identity column, you must execute the following statement first:

SET IDENTITY_INSERT table_name ON;
Code language: SQL (Structured Query Language) (sql)
To switch the identity insert off, you use the similar statement:

SET IDENTITY_INSERT table_name OFF;
Code language: SQL (Structured Query Language) (sql)
Let’s execute the following statements to insert a value for the identity column in the promotions table:

SET IDENTITY_INSERT sales.promotions ON;

INSERT INTO sales.promotions (
    promotion_id,
    promotion_name,
    discount,
    start_date,
    expired_date
)
VALUES
    (
        4,
        '2019 Spring Promotion',
        0.25,
        '20190201',
        '20190301'
    );


SET IDENTITY_INSERT sales.promotions OFF;
Code language: SQL (Structured Query Language) (sql)
In this example, first, we switched the identity insert on, then inserted a row with an explicit value for the identity column, and finally switched the identity insert off.

The following shows the data of the promotions table after the insertion:

SELECT * FROM sales.promotions;
Code language: SQL (Structured Query Language) (sql)
SQL Server INSERT result
In this tutorial, you have learned how to use the SQL Server INSERT statement to add a new row to a table.

Was this tutorial helpful?

SQL Server INSERT Multiple Rows
Summary: in this tutorial, you will learn how to insert multiple rows into a table using a single SQL Server INSERT statement.

In the previous tutorial, you have learned how to add one row at a time to a table by using the INSERT statement.

To add multiple rows to a table at once, you use the following form of the INSERT statement:

INSERT INTO table_name (column_list)
VALUES
    (value_list_1),
    (value_list_2),
    ...
    (value_list_n);
Code language: SQL (Structured Query Language) (sql)
In this syntax, instead of using a single list of values, you use multiple comma-separated lists of values for insertion.

The number of rows that you can insert at a time is 1,000 rows using this form of the INSERT statement. If you want to insert more rows than that, you should consider using multiple INSERT statements, BULK INSERT or a derived table.

Note that this INSERT multiple rows syntax is only supported in SQL Server 2008 or later.

To insert multiple rows returned from a SELECT statement, you use the INSERT INTO SELECT statement.

SQL Server INSERT multiple rows – examples 
We will use the sales.promotions table created in the previous tutorial for the demonstration.

If you have not yet created the sales.promotions table, you can use the following CREATE TABLE statement:

CREATE TABLE sales.promotions (
    promotion_id INT PRIMARY KEY IDENTITY (1, 1),
    promotion_name VARCHAR (255) NOT NULL,
    discount NUMERIC (3, 2) DEFAULT 0,
    start_date DATE NOT NULL,
    expired_date DATE NOT NULL
); 
Code language: SQL (Structured Query Language) (sql)
1) Inserting multiple rows example 
The following statement inserts multiple rows to the sales.promotions table:

INSERT INTO sales.promotions (
    promotion_name,
    discount,
    start_date,
    expired_date
)
VALUES
    (
        '2019 Summer Promotion',
        0.15,
        '20190601',
        '20190901'
    ),
    (
        '2019 Fall Promotion',
        0.20,
        '20191001',
        '20191101'
    ),
    (
        '2019 Winter Promotion',
        0.25,
        '20191201',
        '20200101'
    );
Code language: SQL (Structured Query Language) (sql)
SQL server issued the following message indicating that three rows have been inserted successfully.

(3 rows affected)
Code language: SQL (Structured Query Language) (sql)
Let’s verify the insert by executing the following query:

SELECT
    *
FROM
    sales.promotions;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server INSERT multiple rows example
2) Inserting multiple rows and returning the inserted id list example 
This example inserts three rows into the sales.promotions table and returns the promotion identity list:

INSERT INTO 
	sales.promotions ( 
		promotion_name, discount, start_date, expired_date
	)
OUTPUT inserted.promotion_id
VALUES
	('2020 Summer Promotion',0.25,'20200601','20200901'),
	('2020 Fall Promotion',0.10,'20201001','20201101'),
	('2020 Winter Promotion', 0.25,'20201201','20210101');

Code language: SQL (Structured Query Language) (sql)
SQL Server Insert Multiple Rows
In this example, we added the OUTPUT clause with the column that we want to return using the inserted.column_name syntax. If you want to return values from multiple columns, you can use the following syntax:

OUTPUT inserted.column1, inserted.column2...
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use another form of the SQL Server INSERT statement to insert multiple rows into a table using one INSERT statement.

Was this tutorial helpful?

SQL Server INSERT INTO SELECT
Summary: in this tutorial, you will learn how to use the SQL Server INSERT INTO SELECT statement to add data from other tables to a table.

Introduction to SQL Server INSERT INTO SELECT statement 
To insert data from other tables into a table, you use the following SQL Server INSERT INTO SELECT statement:

INSERT  [ TOP ( expression ) [ PERCENT ] ] 
INTO target_table (column_list)
query
Code language: SQL (Structured Query Language) (sql)
In this syntax, the statement inserts rows returned by the query into the target_table.

The query is any valid SELECT statement that retrieves data from other tables. It must return the values that are corresponding to the columns specified in the column_list.

The TOP clause part is optional. It allows you to specify the number of rows returned by the query to be inserted into the target table. If you use the PERCENT option, the statement will insert the percent of rows instead. Note that it is a best practice to always use the TOP clause with the ORDER BY clause.

SQL Server INSERT INTO SELECT examples 
Let’s create a table named addresses for the demonstration:

CREATE TABLE sales.addresses (
    address_id INT IDENTITY PRIMARY KEY,
    street VARCHAR (255) NOT NULL,
    city VARCHAR (50),
    state VARCHAR (25),
    zip_code VARCHAR (5)
);   
Code language: SQL (Structured Query Language) (sql)
1) Insert all rows from another table example 
The following statement inserts all addresses from the customers table into the addresses table:

INSERT INTO sales.addresses (street, city, state, zip_code) 
SELECT
    street,
    city,
    state,
    zip_code
FROM
    sales.customers
ORDER BY
    first_name,
    last_name; 
Code language: SQL (Structured Query Language) (sql)
To verify the insert, you use the following query:

SELECT
    *
FROM
    sales.addresses;
Code language: SQL (Structured Query Language) (sql)
Here is the result:

SQL Server INTO INTO SELECT example
2) Insert some rows from another table example 
Sometimes, you just need to insert some rows from another table into a table. In this case, you limit the number of rows returned from the query by using conditions in the WHERE clause.

The following statement adds the addresses of the stores located in Santa Cruz and Baldwin to the addresses table:

INSERT INTO 
    sales.addresses (street, city, state, zip_code) 
SELECT
    street,
    city,
    state,
    zip_code
FROM
    sales.stores
WHERE
    city IN ('Santa Cruz', 'Baldwin')
Code language: SQL (Structured Query Language) (sql)
SQL Server returned the following message indicating that two rows have been inserted successfully.

(2 rows affected)
Code language: SQL (Structured Query Language) (sql)
3) Insert the top N of rows 
First, you use the following statement to delete all rows from the addresses table:

TRUNCATE TABLE sales.addresses;
Code language: SQL (Structured Query Language) (sql)
Second, to insert the top 10 customers sorted by their first names and last names, you use the INSERT TOP INTO SELECT statement as follows:

INSERT TOP (10) 
INTO sales.addresses (street, city, state, zip_code) 
SELECT
    street,
    city,
    state,
    zip_code
FROM
    sales.customers
ORDER BY
    first_name,
    last_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server returned the following message showing that ten rows have been inserted successfully.

(10 rows affected)
Code language: SQL (Structured Query Language) (sql)
4) Insert the top percent of rows 
Instead of using an absolute number of rows, you can insert a percent number of rows into a table.

First, truncate all rows from the addresses table:

TRUNCATE TABLE sales.addresses;
Code language: SQL (Structured Query Language) (sql)
Second, insert the top 10 percent of rows from the customers table sorted by first names and last names into the addresses table:

INSERT TOP (10) PERCENT  
INTO sales.addresses (street, city, state, zip_code) 
SELECT
    street,
    city,
    state,
    zip_code
FROM
    sales.customers
ORDER BY
    first_name,
    last_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following message indicating that 145 rows have been inserted successfully.

(145 rows affected)
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server INSERT INTO SELECT statement to insert rows from other tables into a table.

Was this tutorial helpful?

SQL Server UPDATE Statement
Summary: in this tutorial, you will learn how to use the SQL Server UPDATE statement to change existing data in a table.

Introduction to the SQL Server UPDATE statement 
To modify existing data in a table, you use the following UPDATE statement:

UPDATE 
    table_name
SET 
    c1 = v1, 
    c2 = v2, 
    ...,
    cn = vn
[WHERE condition]
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the table you want to update data after the UPDATE keyword.
Second, specify a list of columns c1, c2, …, cn and new values v1, v2, … vn in the SET clause.
Third, filter the rows to update by specifying a condition in the WHERE clause. The WHERE clause is optional. If you skip the WHERE clause, the statement will update all rows in the table.
SQL Server UPDATE examples 
First, create a new table named taxes for demonstration.

CREATE TABLE sales.taxes (
	tax_id INT PRIMARY KEY IDENTITY (1, 1),
	state VARCHAR (50) NOT NULL UNIQUE,
	state_tax_rate DEC (3, 2),
	avg_local_tax_rate DEC (3, 2),
	combined_rate AS state_tax_rate + avg_local_tax_rate,
	max_local_tax_rate DEC (3, 2),
	updated_at datetime
);
Code language: SQL (Structured Query Language) (sql)
Second, execute the following statements to insert data into the taxes table:

Insert Statements
1) Update a single column in all rows of a table 
The following statement uses the UPDATE statement to change the values of the updated_at column in the taxes table to the system date time:

UPDATE sales.taxes
SET updated_at = GETDATE();
Code language: SQL (Structured Query Language) (sql)
Output:

(51 rows affected)
Code language: SQL (Structured Query Language) (sql)
The output shows that 51 rows have been updated successfully.

Let’s verify the update:

SELECT * FROM sales.taxes;
Code language: SQL (Structured Query Language) (sql)
Here is the partial output:

SQL Server UPDATE example
The output shows that the updated_at column has been updated with the date and time when we ran the statement.

2) Update multiple columns 
The following statement increases the max local tax rate by 2% and the average local tax rate by 1% in the states that have a max local tax rate of 1%.

UPDATE sales.taxes
SET max_local_tax_rate += 0.02,
    avg_local_tax_rate += 0.01
WHERE
    max_local_tax_rate = 0.01;
Code language: SQL (Structured Query Language) (sql)
Output:

(7 rows affected)
Code language: SQL (Structured Query Language) (sql)
The output shows that the taxes of 7 states have been updated.

Summary 
Use the SQL Server UPDATE statement to modify data in the existing table.
Was this tutorial helpful?

SQL Server UPDATE JOIN
Summary: in this tutorial, you will learn how to use the SQL Server UPDATE JOIN statement to perform a cross-table update.

SQL Server UPDATE JOIN syntax 
To query data from related tables, you often use the join clauses, either inner join or left join. In SQL Server, you can use these join clauses in the UPDATE statement to perform a cross-table update.

The following illustrates the syntax of the UPDATE JOIN clause:

UPDATE 
    t1
SET 
    t1.c1 = t2.c2,
    t1.c2 = expression,
    ...   
FROM 
    t1
    [INNER | LEFT] JOIN t2 ON join_predicate
WHERE 
    where_predicate;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the table (t1) that you want to update in the UPDATE clause.
Next, specify the new value for each column of the updated table.
Then, again specify the table from which you want to update in the FROM clause.
After that, use either INNER JOIN or LEFT JOIN to join to another table (t2) using a join predicate specified after the ON keyword.
Finally, add an optional WHERE clause to specify rows to be updated.
SQL Server UPDATE JOIN examples 
Let’s take a look at some examples of using the UPDATE JOIN statement.

Setting up sample tables 
First, create a new table named sales.targets to store the sales targets:

DROP TABLE IF EXISTS sales.targets;

CREATE TABLE sales.targets
(
    target_id  INT	PRIMARY KEY, 
    percentage DECIMAL(4, 2) 
        NOT NULL DEFAULT 0
);

INSERT INTO 
    sales.targets(target_id, percentage)
VALUES
    (1,0.2),
    (2,0.3),
    (3,0.5),
    (4,0.6),
    (5,0.8);
Code language: SQL (Structured Query Language) (sql)
If sales staffs achieved the target 1, they will get the ratio of 0.2 or 20% sales commission and so on.

Second, create another table named sales.commissions to store the sales commissions:

CREATE TABLE sales.commissions
(
    staff_id    INT PRIMARY KEY, 
    target_id   INT, 
    base_amount DECIMAL(10, 2) 
        NOT NULL DEFAULT 0, 
    commission  DECIMAL(10, 2) 
        NOT NULL DEFAULT 0, 
    FOREIGN KEY(target_id) 
        REFERENCES sales.targets(target_id), 
    FOREIGN KEY(staff_id) 
        REFERENCES sales.staffs(staff_id),
);

INSERT INTO 
    sales.commissions(staff_id, base_amount, target_id)
VALUES
    (1,100000,2),
    (2,120000,1),
    (3,80000,3),
    (4,900000,4),
    (5,950000,5);
Code language: SQL (Structured Query Language) (sql)
The sales.commissions table stores sales staff identification, target_id, base_amount, and commission. This table links to the sales.targets table via the target_id column.

Our goal is to calculate the commissions of all sales staffs based on their sales targets.

A) SQL Server UPDATE INNER JOIN example 
The following statement uses the UPDATE INNER JOIN to calculate the sales commission for all sales staffs:

UPDATE
    sales.commissions
SET
    sales.commissions.commission = 
        c.base_amount * t.percentage
FROM 
    sales.commissions c
    INNER JOIN sales.targets t
        ON c.target_id = t.target_id;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

(5 rows affected)
Code language: SQL (Structured Query Language) (sql)
If you query the sales.commissions table again, you will see that the values in the commission column are updated:

SELECT 
    *
FROM 
    sales.commissions;
Code language: SQL (Structured Query Language) (sql)
SQL Server UPDATE JOIN - INNER JOIN example
B) SQL Server UPDATE LEFT JOIN example 
Suppose we have two more new sales staffs that have just joined and they don’t have any target yet:

INSERT INTO 
    sales.commissions(staff_id, base_amount, target_id)
VALUES
    (6,100000,NULL),
    (7,120000,NULL);
Code language: SQL (Structured Query Language) (sql)
We assume that the commission for the new sales staffs is 0.1 or 10%, we can update the commission of all sales staffs using the UPDATE LEFT JOIN as follows:

UPDATE 
    sales.commissions
SET  
    sales.commissions.commission = 
        c.base_amount  * COALESCE(t.percentage,0.1)
FROM  
    sales.commissions c
    LEFT JOIN sales.targets t 
        ON c.target_id = t.target_id;
Code language: SQL (Structured Query Language) (sql)
In this example, we used COALESCE() to return 0.1 if the percentage is NULL.

Note that if you use the UPDATE INNER JOIN clause, just the five rows of the table whose targets are not NULL will be updated.

Let’s examine the data in the sales.commissions table:

SELECT 
  * 
FROM 
    sales.commissions;
Code language: SQL (Structured Query Language) (sql)
The result set is as follows:

SQL Server UPDATE JOIN - LEFT JOIN example
In this tutorial, you have learned how to use the SQL Server UPDATE JOIN statement to perform a cross-table update.

Was this tutorial helpful?

SQL Server DELETE
Summary: in this tutorial, you will learn how to use the SQL Server DELETE statement to remove one or more rows from a table.

Introduction to SQL Server DELETE statement 
To remove one or more rows from a table completely, you use the DELETE statement. The following illustrates its syntax:

DELETE [ TOP ( expression ) [ PERCENT ] ]  
FROM table_name
[WHERE search_condition];
Code language: SQL (Structured Query Language) (sql)
First, you specify the name of the table from which the rows are to be deleted in the FROM clause.

For example, the following statement will delete all rows from the target_table:

DELETE FROM target_table;
Code language: SQL (Structured Query Language) (sql)
Second, to specify the number or percent of random rows that will be deleted, you use the TOP clause.

For example, the following DELETE statement removes 10 random rows from the target_table:

DELETE TOP 10 FROM target_table;  
Code language: SQL (Structured Query Language) (sql)
Because the table stores its rows in unspecified order, we do not know which rows will be deleted but we know for sure that the number of rows will be deleted is 10.

Similarly, you can delete the 10 percent of random rows by using the following DELETE statement:

DELETE TOP 10 PERCENT FROM target_table;
Code language: SQL (Structured Query Language) (sql)
Third, practically speaking, you will rarely remove all rows from a table but only one or several rows. In this case, you need to specify the search_condition in the WHERE clause to limit the number of rows that are deleted.

The rows that cause the search_condition evaluates to true will be deleted.

The WHERE clause is optional. If you skip it, the DELETE statement will remove all rows from the table.

SQL Server DELETE statement examples 
Let’s create a new table for the demonstration.

The following statement creates a table named production.product_history with the data copied from the production.products table:

SELECT * 
INTO production.product_history
FROM
    production.products;
Code language: SQL (Structured Query Language) (sql)
The following query returns all rows from the product_history table:

SELECT * FROM production.product_history;
Code language: SQL (Structured Query Language) (sql)
As can be seen clearly in the output, we have 321 rows in total.

1) Delete the number of random rows example 
The following DELETE statement removes 21 random rows from the product_history table:

DELETE TOP (21)
FROM production.product_history;
Code language: SQL (Structured Query Language) (sql)
Here is the message issued by the SQL Server:

(21 rows affected)
Code language: SQL (Structured Query Language) (sql)
It means that 21 rows have been deleted.

2) Delete the percent of random rows example 
The following DELETE statement removes 5 percent of random rows from the product_history table:

DELETE TOP (5) PERCENT
FROM production.product_history;
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following message indicating that 15 rows (300 x 5% = 15) have been deleted.

(15 rows affected)
Code language: SQL (Structured Query Language) (sql)
3) Delete some rows with a condition example 
The following DELETE statement removes all products whose model year is 2017:

DELETE
FROM
    production.product_history
WHERE
    model_year = 2017;
Code language: SQL (Structured Query Language) (sql)
Here is the output message:

(75 rows affected)
Code language: SQL (Structured Query Language) (sql)
4) Delete all rows from a table example 
The following DELETE statement removes all rows from the product_history table:

DELETE FROM  production.product_history;
Code language: SQL (Structured Query Language) (sql)
Note that if you want to remove all rows from a big table, you should use the TRUNCATE TABLE statement which is faster and more efficient.

In this tutorial, you have learned how to use the SQL Server DELETE statement to remove one or more rows from a table.

Was this tutorial helpful?

SQL Server MERGE
Summary: in this tutorial, you will learn how to use the SQL Server MERGE statement to update data in a table based on values matched from another table.

Introduction SQL Server MERGE Statement 
Suppose, you have two table called source and target tables, and you need to update the target table based on the values matched from the source table. There are three cases:

The source table has some rows that do not exist in the target table. In this case, you need to insert rows that are in the source table into the target table.
The target table has some rows that do not exist in the source table. In this case, you need to delete rows from the target table.
The source table has some rows with the same keys as the rows in the target table. However, these rows have different values in the non-key columns. In this case, you need to update the rows in the target table with the values coming from the source table.
The following picture illustrates the source and target tables with the corresponding actions: insert, update, and delete:

SQL Server MERGE
If you use the INSERT, UPDATE, and DELETE statement individually, you have to construct three separate statements to update the data to the target table with the matching rows from the source table.

However, SQL Server provides the MERGE statement that allows you to perform three actions at the same time. The following shows the syntax of the MERGE statement:

MERGE target_table USING source_table
ON merge_condition
WHEN MATCHED
    THEN update_statement
WHEN NOT MATCHED
    THEN insert_statement
WHEN NOT MATCHED BY SOURCE
    THEN DELETE;
Code language: SQL (Structured Query Language) (sql)
First, you specify the target table and the source table in the MERGE clause.

Second, the merge_condition determines how the rows from the source table are matched to the rows from the target table. It is similar to the join condition in the join clause. Typically, you use the key columns either primary key or unique key for matching.

Third, the merge_condition results in three states: MATCHED, NOT MATCHED, and NOT MATCHED BY SOURCE.

MATCHED: these are the rows that match the merge condition. In the diagram, they are shown as blue. For the matching rows, you need to update the rows columns in the target table with values from the source table.
NOT MATCHED: these are the rows from the source table that does not have any matching rows in the target table. In the diagram, they are shown as orange. In this case, you need to add the rows from the source table to the target table. Note that NOT MATCHED is also known as NOT MATCHED BY TARGET.
NOT MATCHED BY SOURCE: these are the rows in the target table that does not match any rows in the source table. They are shown as green in the diagram. If you want to synchronize the target table with the data from the source table, then you will need to use this match condition to delete rows from the target table.
SQL Server MERGE statement example 
Suppose we have two table sales.category and sales.category_staging that store the sales by product category.

CREATE TABLE sales.category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10 , 2 )
);

INSERT INTO sales.category(category_id, category_name, amount)
VALUES(1,'Children Bicycles',15000),
    (2,'Comfort Bicycles',25000),
    (3,'Cruisers Bicycles',13000),
    (4,'Cyclocross Bicycles',10000);


CREATE TABLE sales.category_staging (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10 , 2 )
);


INSERT INTO sales.category_staging(category_id, category_name, amount)
VALUES(1,'Children Bicycles',15000),
    (3,'Cruisers Bicycles',13000),
    (4,'Cyclocross Bicycles',20000),
    (5,'Electric Bikes',10000),
    (6,'Mountain Bikes',10000);
Code language: SQL (Structured Query Language) (sql)
To update data to the sales.category (target table) with the values from the sales.category_staging (source table), you use the following MERGE statement:

MERGE sales.category t 
    USING sales.category_staging s
ON (s.category_id = t.category_id)
WHEN MATCHED
    THEN UPDATE SET 
        t.category_name = s.category_name,
        t.amount = s.amount
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (category_id, category_name, amount)
         VALUES (s.category_id, s.category_name, s.amount)
WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;
Code language: SQL (Structured Query Language) (sql)
SQL Server MERGE Example
In this example, we used the values in the category_id columns in both tables as the merge condition.

First, the rows with id 1, 3, 4 from the sales.category_staging table matches with the rows from the target table, therefore, the MERGE statement updates the values in category name and amount columns in the sales.category table.
Second, the rows with id 5 and 6 from the sales.category_staging table do not exist in the sales.category table, so the MERGE statement inserts these rows into the target table.
Third, the row with id 2 from the sales.category table does not exist in the sales.sales_staging table, therefore, the MERGE statement deletes this row.
As a result of the merger, the data in the sales.category table is fully synchronized with the data in the sales.category_staging table.

In this tutorial, you have learned how to use the SQL Server MERGE statement to make changes in a table based on matching values from another table.

Was this tutorial helpful?

SQL Server Transaction
Summary: in this tutorial, you’ll learn about SQL Server transactions and how to use T-SQL to execute transactions.

Introduction to the SQL Server Transaction 
A transaction is a single unit of work that typically contains multiple T-SQL statements.

If a transaction is successful, the changes are committed to the database. However, if a transaction has an error, the changes have to be rolled back.

When executing a single statement such as INSERT, UPDATE, and DELETE, SQL Server uses the autocommit transaction. In this case, each statement is a transaction.

To start a transaction explicitly, you use the BEGIN TRANSACTION or BEGIN TRAN statement first:

BEGIN TRANSACTION;
Code language: SQL (Structured Query Language) (sql)
Then, execute one or more statements including INSERT, UPDATE, and DELETE.

Finally, commit the transaction using the COMMIT statement:

COMMIT;
Code language: SQL (Structured Query Language) (sql)
Or roll back the transaction using the ROLLBACK statement:

ROLLBACK;
Code language: SQL (Structured Query Language) (sql)
Here’s the sequence of statements for starting a transaction explicitly and committing it:

-- start a transaction
BEGIN TRANSACTION;

-- other statements

-- commit the transaction
COMMIT;
Code language: SQL (Structured Query Language) (sql)
SQL Server Transaction example 
We’ll create two tables: invoices and invoice_items for the demonstration:

CREATE TABLE invoices (
  id int IDENTITY PRIMARY KEY,
  customer_id int NOT NULL,
  total decimal(10, 2) NOT NULL DEFAULT 0 CHECK (total >= 0)
);

CREATE TABLE invoice_items (
  id int,
  invoice_id int NOT NULL,
  item_name varchar(100) NOT NULL,
  amount decimal(10, 2) NOT NULL CHECK (amount >= 0),
  tax decimal(4, 2) NOT NULL CHECK (tax >= 0),
  PRIMARY KEY (id, invoice_id),
  FOREIGN KEY (invoice_id) REFERENCES invoices (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);
Code language: SQL (Structured Query Language) (sql)
The invoices table stores the header of the invoice while the invoice_items table stores the line items. The total field in the invoices table is calculated from the line items.

The following example uses the BEGIN TRANSACTION and COMMIT statements to create a transaction:

BEGIN TRANSACTION;

INSERT INTO invoices (customer_id, total)
VALUES (100, 0);

INSERT INTO invoice_items (id, invoice_id, item_name, amount, tax)
VALUES (10, 1, 'Keyboard', 70, 0.08),
       (20, 1, 'Mouse', 50, 0.08);

UPDATE invoices
SET total = (SELECT
  SUM(amount * (1 + tax))
FROM invoice_items
WHERE invoice_id = 1);

COMMIT;
Code language: SQL (Structured Query Language) (sql)
In this example:

First, start a transaction explicitly using the BEGIN TRANSACTION statement:

BEGIN TRANSACTION;
Code language: SQL (Structured Query Language) (sql)
Next, insert a row into the invoices table and return the invoice id:

DECLARE @invoice TABLE (
  id int
);

DECLARE @invoice_id int;

INSERT INTO invoices (customer_id, total)
OUTPUT INSERTED.id INTO @invoice
VALUES (100, 0);

SELECT
  @invoice_id = id
FROM @invoice;
Code language: SQL (Structured Query Language) (sql)
Then, insert two rows into the invoice_items table:

INSERT INTO invoice_items (id, invoice_id, item_name, amount, tax)
VALUES (10, @invoice_id, 'Keyboard', 70, 0.08),
       (20, @invoice_id, 'Mouse', 50, 0.08);
Code language: SQL (Structured Query Language) (sql)
After that, calculate the total using the invoice_items table and update it to the invoices table:

UPDATE invoices
SET total = (
    SELECT SUM(amount * (1 + tax))
    FROM invoice_items
    WHERE invoice_id = @invoice_id
);
Code language: SQL (Structured Query Language) (sql)
Finally, commit the transaction using the COMMIT statement:

COMMIT;
Code language: SQL (Structured Query Language) (sql)
Summary 
Use the BEGIN TRANSACTION statement to start a transaction explicitly.
Use the COMMIT statement to commit the transaction and ROLLBACK statement to roll back the transaction.
Was this tutorial helpful?

SQL Server CREATE DATABASE
Summary: in this tutorial, you will learn how to create a new database in SQL Server using CREATE DATABASE statement or SQL Server Management Studio.

Creating a new database using the CREATE DATABASE statement 
The CREATE DATABASE statement creates a new database. The following shows the minimal syntax of the CREATE DATABASE statement:

CREATE DATABASE database_name;
In this syntax, you specify the name of the database after the CREATE DATABASE keyword.

The database name must be unique within an instance of SQL Server. It must also comply with the SQL Server identifier’s rules. Typically, the database name has a maximum of 128 characters.

The following statement creates a new database named TestDb:

CREATE DATABASE TestDb;
Code language: SQL (Structured Query Language) (sql)
Once the statement executes successfully, you can view the newly created database in the Object Explorer. If the new database does not appear, you can click the Refresh button or press F5 keyboard to update the object list.

SQL Server CREATE DATABASE example
This statement lists all databases in the SQL Server:

SELECT 
    name
FROM 
    master.sys.databases
ORDER BY 
    name;
Code language: SQL (Structured Query Language) (sql)
SQL Server CREATE DATABASE list all databases
Or you can execute the stored procedure sp_databases:

EXEC sp_databases;
Code language: SQL (Structured Query Language) (sql)
Creating a new database using SQL Server Management Studio 
First, right-click the Database and choose New Database… menu item.

SQL Server CREATE DATABASE using SSMS step 1
Second, enter the name of the database e.g., SampleDb and click the OK button.

SQL Server CREATE DATABASE using SSMS step 2
Third, view the newly created database from the Object Explorer:

SQL Server CREATE DATABASE using SSMS step 3
In this tutorial, you have learned how to create a new database using SQL Server CREATE DATABASE statement and SQL Server Management Studio.

Was this tutorial helpful?

SQL Server DROP DATABASE
Summary: in this tutorial, you will learn how to delete a database in a SQL Server instance using the DROP DATABASE statement and SQL Server Management Studio.

Note that this tutorial uses the TestDb and SampleDb created in the CREATE DATABASE tutorial for the demonstration.

Using the SQL Server DROP DATABASE statement to delete a database 
To remove an existing database from a SQL Server instance, you use the DROP DATABASE statement.

The DROP DATABASE statement allows you to delete one or more databases with the following syntax:

DROP DATABASE  [ IF EXISTS ]
    database_name 
    [,database_name2,...];
Code language: SQL (Structured Query Language) (sql)
In this syntax, you specify the name of the database that you want to drop after the DROP DATABASE keywords. If you want to drop multiple databases using a single statement, you can use a comma-separated list of database names after the DROP DATABASE clause.

The IF EXISTS option is available from SQL Server 2016 (13.x). It allows you to conditionally delete a database only if the database already exists. If you attempt to delete a nonexisting database without specifying the IF EXISTS option, SQL Server will issue an error.

Before deleting a database, you must ensure the following important points:

First, the DROP DATABASE statement deletes the database and also the physical disk files used by the database. Therefore, you should have a backup of the database in case you want to restore it in the future.
Second, you cannot drop the database that is currently being used.
Trying to drop a database currently being used causes the following error:

Cannot drop database "database_name" because it is currently in use.
Code language: PHP (php)
The following example uses the DROP DATABASE statement to delete the TestDb database:

DROP DATABASE IF EXISTS TestDb;
Code language: SQL (Structured Query Language) (sql)
Using the SQL Server Management Studio to drop a database 
You can follow these steps to delete the SampleDb database:

First, right-click on the database name that you want to delete and choose Delete menu item:

SQL Server DROP DATABASE step 1
Second, uncheck the Delete backup and restore history information for databases check box, check the Close existing connections check box, and click the OK button to delete the database.


Third, verify that the database has been dropped from the Object Explorer.


In this tutorial, you have learned how to use the SQL Server DROP DATABASE statement and SQL Server Management Studio to delete databases in an SQL Server instance.

Was this tutorial helpful?

SQL Server CREATE SCHEMA
Summary: in this tutorial, you will learn how to use the SQL Server CREATE SCHEMA to create a new schema in the current database.

What is a schema in SQL Server 
A schema is a collection of database objects including tables, views, triggers, stored procedures, indexes, etc. A schema is associated with a username which is known as the schema owner, who is the owner of the logically related database objects.

A schema always belongs to one database. On the other hand, a database may have one or multiple schemas. For example, in our BikeStores sample database, we have two schemas: sales and production. An object within a schema is qualified using the schema_name.object_name format like sales.orders. Two tables in two schemas can share the same name so you may have hr.employees and sales.employees.

Built-in schemas in SQL Server 
SQL Server provides us with some pre-defined schemas which have the same names as the built-in database users and roles, for example: dbo, guest, sys, and INFORMATION_SCHEMA.

Note that SQL Server reserves the sys and INFORMATION_SCHEMA schemas for system objects, therefore, you cannot create or drop any objects in these schemas.

The default schema for a newly created database is dbo, which is owned by the dbo user account. By default, when you create a new user with the CREATE USER command, the user will take dbo as its default schema.

SQL Server CREATE SCHEMA statement overview 
The CREATE SCHEMA statement allows you to create a new schema in the current database.

The following illustrates the simplified version of the CREATE SCHEMA statement:

CREATE SCHEMA schema_name
    [AUTHORIZATION owner_name]
Code language: SQL (Structured Query Language) (sql)
In this syntax,

First, specify the name of the schema that you want to create in the CREATE SCHEMA clause.
Second, specify the owner of the schema after the AUTHORIZATION keyword.
SQL Server CREATE SCHEMA statement example 
The following example shows how to use the CREATE SCHEMA statement to create the customer_services schema:

CREATE SCHEMA customer_services;
GO
Code language: SQL (Structured Query Language) (sql)
Note that GO command instructs the SQL Server Management Studio to send the SQL statements up to the GO statement to the server to be executed.

Once you execute the statement, you can find the newly created schema under the Security > Schemas of the database name.

SQL Server CREATE SCHEMA
If you want to list all schemas in the current database, you can query schemas from the sys.schemas as shown in the following query:

SELECT 
    s.name AS schema_name, 
    u.name AS schema_owner
FROM 
    sys.schemas s
INNER JOIN sys.sysusers u ON u.uid = s.principal_id
ORDER BY 
    s.name;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server List Schemas
After having the customer_services schema, you can create objects for the schema. For example, the following statement creates a new table named jobs in the customer_services schema:

CREATE TABLE customer_services.jobs(
    job_id INT PRIMARY KEY IDENTITY,
    customer_id INT NOT NULL,
    description VARCHAR(200),
    created_at DATETIME2 NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server CREATE SCHEMA statement to create a new schema in the current database.

Was this tutorial helpful?

SQL Server ALTER SCHEMA
Summary: in this tutorial, you will learn how to use the SQL Server ALTER SCHEMA statement to transfer a securable from one schema to another.

SQL Server ALTER SCHEMA statement overview 
The ALTER SCHEMA statement allows you to transfer a securable from one schema to another within the same database.

Note that a securable is a resource to which the Database Engine authorization system controls access. For instance, a table is a securable.

The following shows the syntax of the ALTER SCHEMA statement:

ALTER SCHEMA target_schema_name   
    TRANSFER [ entity_type :: ] securable_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

target_schema_name is the name of a schema in the current database, into which you want to move the object. Note that it cannot be SYS or INFORMATION_SCHEMA.
The entity_type can be Object, Type, or XML Schema Collection. It defaults to Object. The entity_type represents the class of the entity for which the owner is being changed.
object_name is the name of the securable that you want to move into the target_schema_name.
If you move a stored procedure, function, view, or trigger, SQL Server will not change the schema name of these securables. Therefore, it is recommended that you drop and re-create these objects in the new schema instead of using the ALTER SCHEMA statement for moving.

If you move an object e.g., table or synonym, SQL Server will not update the references for these objects automatically. You must manually modify the references to reflect the new schema name.

For example, if you move a table referenced in a stored procedure, you need to change the stored procedure to reflect the new schema name.

SQL Server ALTER SCHEMA statement example 
First, create a new table named offices in the dbo schema:

CREATE TABLE dbo.offices
(
    office_id      INT
    PRIMARY KEY IDENTITY, 
    office_name    NVARCHAR(40) NOT NULL, 
    office_address NVARCHAR(255) NOT NULL, 
    phone          VARCHAR(20),
);
Code language: SQL (Structured Query Language) (sql)
Next, insert some rows into the dob.offices table:

INSERT INTO 
    dbo.offices(office_name, office_address)
VALUES
    ('Silicon Valley','400 North 1st Street, San Jose, CA 95130'),
    ('Sacramento','1070 River Dr., Sacramento, CA 95820');
Code language: SQL (Structured Query Language) (sql)
Then, create a stored procedure that finds the office by an ID:

CREATE PROC usp_get_office_by_id(
    @id INT
) AS
BEGIN
    SELECT 
        * 
    FROM 
        dbo.offices
    WHERE 
        office_id = @id;
END;
Code language: SQL (Structured Query Language) (sql)
After that, transfer this dbo.offices table to the sales schema:

ALTER SCHEMA sales TRANSFER OBJECT::dbo.offices;  
Code language: SQL (Structured Query Language) (sql)
If you execute the usp_get_office_by_id stored procedure:

exec usp_get_office_by_id @id=1;
Code language: CSS (css)
SQL Server will issue an error:

Msg 208, Level 16, State 1, Procedure usp_get_office_by_id, Line 5 [Batch Start Line 30]
Invalid object name 'dbo.offices'.
Code language: SQL (Structured Query Language) (sql)
Finally, manually modify the dbo.offices to sales.offices inside the stored procedure to reflect the new schema:

CREATE PROC usp_get_office_by_id(
    @id INT
) AS
BEGIN
    SELECT 
        * 
    FROM 
        sales.offices
    WHERE 
        office_id = @id;
END;
Code language: SQL (Structured Query Language) (sql)
Summary 
Use the SQL Server ALTER SCHEMA statement to transfer a securable from one schema to another within the same database.
Was this tutorial helpful?

SQL Server DROP SCHEMA
Summary: in this tutorial, you will learn how to use the SQL Server DROP SCHEMA statement to remove a schema from a database.

SQL Server DROP SCHEMA statement overview 
The DROP SCHEMA statement allows you to delete a schema from a database. The following shows the syntax of the DROP SCHEMA statement:

DROP SCHEMA [IF EXISTS] schema_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the schema that you want to drop. If the schema contains any objects, the statement will fail. Therefore, you must delete all objects in the schema before removing the schema.
Second, use the IF EXISTS option to conditionally remove the schema only if the schema exists. Attempting to drop a nonexisting schema without the IF EXISTS option will result in an error.
SQL Server DROP SCHEMA statement example 
First, create a new schema named logistics:

CREATE SCHEMA logistics;
GO
Code language: SQL (Structured Query Language) (sql)
Next, create a new table named deliveries inside the logistics schema:

CREATE TABLE logistics.deliveries
(
    order_id        INT
    PRIMARY KEY, 
    delivery_date   DATE NOT NULL, 
    delivery_status TINYINT NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Then, drop the schema logistics:

DROP SCHEMA logistics;
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following error because the schema is not empty.

Msg 3729, Level 16, State 1, Line 1
Cannot drop schema 'logistics' because it is being referenced by object 'deliveries'.
Code language: SQL (Structured Query Language) (sql)
After that, drop the table logistics.deliveries:

DROP TABLE logistics.deliveries;
Code language: SQL (Structured Query Language) (sql)
Finally, issue the DROP SCHEMA again to drop the logistics schema:

DROP SCHEMA IF EXISTS logistics;
Code language: SQL (Structured Query Language) (sql)
Now, you will find that the logistics schema has been deleted from the database.

In this tutorial, you have learned how to use the SQL Server DROP SCHEMA statement to remove a schema from a database.

Was this tutorial helpful?

SQL Server DROP SCHEMA
Summary: in this tutorial, you will learn how to use the SQL Server DROP SCHEMA statement to remove a schema from a database.

SQL Server DROP SCHEMA statement overview 
The DROP SCHEMA statement allows you to delete a schema from a database. The following shows the syntax of the DROP SCHEMA statement:

DROP SCHEMA [IF EXISTS] schema_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the schema that you want to drop. If the schema contains any objects, the statement will fail. Therefore, you must delete all objects in the schema before removing the schema.
Second, use the IF EXISTS option to conditionally remove the schema only if the schema exists. Attempting to drop a nonexisting schema without the IF EXISTS option will result in an error.
SQL Server DROP SCHEMA statement example 
First, create a new schema named logistics:

CREATE SCHEMA logistics;
GO
Code language: SQL (Structured Query Language) (sql)
Next, create a new table named deliveries inside the logistics schema:

CREATE TABLE logistics.deliveries
(
    order_id        INT
    PRIMARY KEY, 
    delivery_date   DATE NOT NULL, 
    delivery_status TINYINT NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Then, drop the schema logistics:

DROP SCHEMA logistics;
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following error because the schema is not empty.

Msg 3729, Level 16, State 1, Line 1
Cannot drop schema 'logistics' because it is being referenced by object 'deliveries'.
Code language: SQL (Structured Query Language) (sql)
After that, drop the table logistics.deliveries:

DROP TABLE logistics.deliveries;
Code language: SQL (Structured Query Language) (sql)
Finally, issue the DROP SCHEMA again to drop the logistics schema:

DROP SCHEMA IF EXISTS logistics;
Code language: SQL (Structured Query Language) (sql)
Now, you will find that the logistics schema has been deleted from the database.

In this tutorial, you have learned how to use the SQL Server DROP SCHEMA statement to remove a schema from a database.

SQL Server CREATE TABLE
Summary: in this tutorial, you will learn how to use the SQL Server CREATE TABLE statement to create a new table.

Introduction to the SQL Server CREATE TABLE statement 
Tables are used to store data in the database. Tables are uniquely named within a database and schema. Each table contains one or more columns. And each column has an associated data type that defines the kind of data it can store e.g., numbers, strings, or temporal data.

To create a new table, you use the CREATE TABLE statement as follows:

CREATE TABLE [database_name.][schema_name.]table_name (
    pk_column data_type PRIMARY KEY,
    column_1 data_type NOT NULL,
    column_2 data_type,
    ...,
    table_constraints
);
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the database in which the table is created. The database_name must be the name of an existing database. If you don’t specify it, the database_name defaults to the current database.
Second, specify the schema to which the new table belongs.
Third, specify the name of the new table.
Fourth, each table should have a primary key which consists of one or more columns. Typically, you list the primary key columns first and then other columns. If the primary key contains only one column, you can use the PRIMARY KEY keywords after the column name. If the primary key consists of two or more columns, you need to specify the PRIMARY KEY constraint as a table constraint. Each column has an associated data type specified after its name in the statement. A column may have one or more column constraints such as NOT NULL and UNIQUE.
Fifth, a table may have some constraints specified in the table constraints section such as FOREIGN KEY, PRIMARY KEY, UNIQUE and CHECK.
Note that CREATE TABLE is complex and has more options than the syntax above. We will gradually introduce you to each individual options in the subsequent tutorials.

SQL Server CREATE TABLE example 
The following statement creates a new table named sales.visits to track the customer in-store visits:

CREATE TABLE sales.visits (
    visit_id INT PRIMARY KEY IDENTITY (1, 1),
    first_name VARCHAR (50) NOT NULL,
    last_name VARCHAR (50) NOT NULL,
    visited_at DATETIME,
    phone VARCHAR(20),
    store_id INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
);
Code language: SQL (Structured Query Language) (sql)
In this example:

Because we do not specify the name of the database explicitly in which the table is created, the visits table is created in the BikeStores database. For the schema, we specify it explicitly, therefore, the visits table is created in the sales schema.

The visits table contains six columns:

The visit_id column is the primary key column of the table. The IDENTITY(1,1) instructs SQL Server to automatically generate integer numbers for the column starting from one and increasing by one for each new row.
The first_name and last_name columns are character string columns with VARCHAR type. These columns can store up to 50 characters.
The visited_at is a DATETIME column that records the date and time at which the customer visits the store.
The phone column is a varying character string column which accepts NULL.
The store_id column stores the identification numbers which identify the store where the customer visited.
At the end of the table’s definition is a FOREIGN KEY constraint. This foreign key ensures that the values in the store_id column of the visits table must be available in the store_id column in the  stores table. You will learn more about the FOREIGN KEY constraint in the next tutorial.
In this tutorial, you have learned how to use the SQL Server CREATE TABLE statement to create a new table in a database.

SQL Server IDENTITY
Summary: in this tutorial, you will learn how to use the SQL Server IDENTITY property to create an identity column for a table.

Introduction to SQL Server IDENTITY column 
To create an identity column for a table, you use the IDENTITY property as follows:

IDENTITY[(seed,increment)]
Code language: SQL (Structured Query Language) (sql)
In this syntax:

The seed is the value of the first row loaded into the table.
The increment is the incremental value added to the identity value of the previous row.
The default value of seed and increment is 1 i.e., (1,1). It means that the first row will have the value of one, the second row will have the value of 2, and so on.

If you want the value of the identity column of the first row to be 10 and the incremental value is 10, you can use the following syntax:

IDENTITY (10,10)
Code language: SQL (Structured Query Language) (sql)
In SQL Server, each table has one and only one identity column. Typically, it is the primary key column of the table.

SQL Server IDENTITY column example 
Let’s create a new schema named hr for practicing:

CREATE SCHEMA hr;
Code language: SQL (Structured Query Language) (sql)
The following statement creates a new table using the IDENTITY property for the personal identification number column:

CREATE TABLE hr.person (
    person_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
First, insert a new row into the person table:

INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES('John','Doe', 'M');
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server Identity Column Example
The output shows that the first row has been loaded with the value of one in the person_id column.

Second, insert another row into the person table:

INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES('Jane','Doe','F');
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server Identity Column Example 2
The output shows that the second row has the value of two in the person_id column.

Reusing of identity values 
SQL Server does not reuse the identity values. If you insert a row into the identity column and the insert statement fails or is rolled back, then the identity value is lost and will not be generated again. This results in gaps in the identity column.

Consider the following example:

First, create two more tables in the hr schema named position and person_position:

CREATE TABLE hr.position (
    position_id INT IDENTITY (1, 1) PRIMARY KEY,
    position_name VARCHAR (255) NOT NULL,

);

CREATE TABLE hr.person_position (
    person_id INT,
    position_id INT,
    PRIMARY KEY (person_id, position_id),
    FOREIGN KEY (person_id) REFERENCES hr.person (person_id),
    FOREIGN KEY (position_id) REFERENCES hr. POSITION (position_id)
);
Code language: SQL (Structured Query Language) (sql)
Second, insert a new person and assign this new person a position by inserting a new row into the person_position table:

BEGIN TRANSACTION
    BEGIN TRY
        -- insert a new person
        INSERT INTO hr.person(first_name,last_name, gender)
        VALUES('Joan','Smith','F');

        -- assign the person a position
        INSERT INTO hr.person_position(person_id, position_id)
        VALUES(@@IDENTITY, 1);
    END TRY
    BEGIN CATCH
         IF @@TRANCOUNT > 0  
            ROLLBACK TRANSACTION;  
    END CATCH

    IF @@TRANCOUNT > 0  
        COMMIT TRANSACTION;
GO
Code language: SQL (Structured Query Language) (sql)
In this example, the first insert statement is executed successfully. However, the second one failed due to no position with id one in the position table. Because of the error, the whole transaction was rolled back.

Because the first INSERT statement consumed the identity value of three and the transaction was rolled back, the next identity value will be four as shown in the following statement:

INSERT INTO hr.person(first_name,last_name,gender)
OUTPUT inserted.person_id
VALUES('Peter','Drucker','F');
Code language: SQL (Structured Query Language) (sql)
The output of the statement is:


Resetting the identity column value 
To reset the identity’s counter, you use the DBCC CHECKIDENT management command:

DBCC CHECKIDENT ('[TableName]', RESEED, 0);
GO
Code language: JavaScript (javascript)
For example:

First, delete all rows from the hr.person table:

DELETE FROM hr.person;
Code language: CSS (css)
Second, reset the identity’s counter to zero:

DBCC CHECKIDENT ('hr.person', RESEED, 0);
GO
Code language: JavaScript (javascript)
Output:

Checking identity information: current identity value '4'.
DBCC execution completed. If DBCC printed error messages, contact your system administrator.
Code language: JavaScript (javascript)
The output shows that the current identity value is 4. It reset the value to zero.

Third, insert a new row into the hr.person table:

INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES('Jhoan','Smith','F');
Code language: JavaScript (javascript)
Output:

person_id
-----------
1

(1 row affected)
The person_id value is 1.

Summary 
Use the SQL Server IDENTITY property to create an identity column for a table.
Was this tutorial helpful?

SQL Server Sequence
Summary: in this tutorial, you will learn about the SQL Server Sequence objects to generate a sequence of numeric values based on a specified specification.

What is a sequence 
A sequence is simply a list of numbers, in which their orders are important. For example, the {1,2,3} is a sequence while the {3,2,1} is an entirely different sequence.

In SQL Server, a sequence is a user-defined schema-bound object that generates a sequence of numbers according to a specified specification. A sequence of numeric values can be in ascending or descending order at a defined interval and may cycle if requested.

SQL Server CREATE SEQUENCE statement 
To create a new sequence object, you use the CREATE SEQUENCE statement as follows:

CREATE SEQUENCE [schema_name.] sequence_name  
    [ AS integer_type ]  
    [ START WITH start_value ]  
    [ INCREMENT BY increment_value ]  
    [ { MINVALUE [ min_value ] } | { NO MINVALUE } ]  
    [ { MAXVALUE [ max_value ] } | { NO MAXVALUE } ]  
    [ CYCLE | { NO CYCLE } ]  
    [ { CACHE [ cache_size ] } | { NO CACHE } ];
Code language: SQL (Structured Query Language) (sql)
Let’s examine the syntax in detail:

sequence_name 
Specify a name for the sequence which is uniquely in the current database.

AS integer_type 
Use any valid integer type for the sequence e.g., TINYINT, SMALLINT, INT, BIGINT, or DECIMAL and NUMERIC with a scale of 0. By default, the sequence object uses BIGINT.

START WITH start_value 
Specify the first value that the sequence returns. The start_value must be between the range (min_value, max_value).

The start_value defaults to the min_value in an ascending sequence and max_value in a descending sequence.

INCREMENT BY increment_value 
Specify the increment_value of the sequence object when you call the NEXT VALUE FOR function.

If increment_value is negative, the sequence object is descending; otherwise, the sequence object is ascending. Note that the increment_value cannot be zero.

[ MINVALUE min_value | NO MINVALUE ] 
Specify the lower bound for the sequence object. It defaults to the minimum value of the data type of the sequence object i.e., zero for TINYINT and a negative number for all other data types.

[ MAXVALUE max_value | NO MAXVALUE] 
Specify the upper bound for the sequence object. It defaults to the maximum value of the data type of the sequence object.

[ CYCLE | NO CYCLE ] 
Use CYCLE if you want the value of the sequence object to restart from the min_value for the ascending sequence object, or max_value for the descending sequence object or throw an exception when its min_value or max_value is exceeded. SQL Server uses NO CYCLE by default for new sequence objects.

[ CACHE cache_size ] | NO CACHE ] 
Specify the number of values to cache to improve the performance of the sequence by minimizing the number of disk I/O required to generate sequence numbers. By default, SQL Server uses NO CACHE for new sequence objects.

SQL Server Sequence examples 
Let’s take some examples of creating sequences.

A) Creating a simple sequence example 
The following statement uses the CREATE SEQUENCE statement to create a new sequence named item_counter with the type of integer (INT), which starts from 10 and increments by 10:

CREATE SEQUENCE item_counter
    AS INT
    START WITH 10
    INCREMENT BY 10;
Code language: SQL (Structured Query Language) (sql)
You can view the sequence object under in the Programmability > Sequences as shown in the following picture:

SQL Server Sequence example
The following statement returns the current value of the item_counter sequence:

SELECT NEXT VALUE FOR item_counter;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Current_value
-------------
10

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
In this example, the NEXT VALUE FOR function generates a sequence number from the item_counter sequence object.

Each time you execute the following statement again, you will see that the value of the item_counter will be incremented by 10:

SELECT NEXT VALUE FOR item_counter;
Code language: SQL (Structured Query Language) (sql)
This time the output is:

Current_value
-------------
20

(1 row affected)    
Code language: SQL (Structured Query Language) (sql)
B) Using a sequence object in a single table example 
First, create a new schema named procurement:

CREATE SCHEMA procurement;
GO
Code language: SQL (Structured Query Language) (sql)
Next, create a new table named orders:

CREATE TABLE procurement.purchase_orders(
    order_id INT PRIMARY KEY,
    vendor_id int NOT NULL,
    order_date date NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Then, create a new sequence object named order_number that starts with 1 and is incremented by 1:

CREATE SEQUENCE procurement.order_number 
AS INT
START WITH 1
INCREMENT BY 1;
Code language: SQL (Structured Query Language) (sql)
After that, insert three rows into the procurement.purchase_orders table and uses values generated by the procurement.order_number sequence:

INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,1,'2019-04-30');


INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,2,'2019-05-01');


INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,3,'2019-05-02');
Code language: SQL (Structured Query Language) (sql)
Finally, view the content of the procurement.purchase_orders table:

SELECT 
    order_id, 
    vendor_id, 
    order_date
FROM 
    procurement.purchase_orders;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Sequence - use sequence for a table
C) Using a sequence object in multiple tables example 
First, create a new sequence object:

CREATE SEQUENCE procurement.receipt_no
START WITH 1
INCREMENT BY 1;
Code language: SQL (Structured Query Language) (sql)
Second, create procurement.goods_receipts and procurement.invoice_receipts tables:

CREATE TABLE procurement.goods_receipts
(
    receipt_id   INT	PRIMARY KEY 
        DEFAULT (NEXT VALUE FOR procurement.receipt_no), 
    order_id     INT NOT NULL, 
    full_receipt BIT NOT NULL,
    receipt_date DATE NOT NULL,
    note NVARCHAR(100),
);


CREATE TABLE procurement.invoice_receipts
(
    receipt_id   INT PRIMARY KEY
        DEFAULT (NEXT VALUE FOR procurement.receipt_no), 
    order_id     INT NOT NULL, 
    is_late      BIT NOT NULL,
    receipt_date DATE NOT NULL,
    note NVARCHAR(100)
);
Code language: SQL (Structured Query Language) (sql)
Note that both tables have the receipt_id whose values are derived from the procurement.receipt_no sequence.

Third, insert some rows into both tables without supplying the values for the receipt_id columns:

INSERT INTO procurement.goods_receipts(
    order_id, 
    full_receipt,
    receipt_date,
    note
)
VALUES(
    1,
    1,
    '2019-05-12',
    'Goods receipt completed at warehouse'
);
INSERT INTO procurement.goods_receipts(
    order_id, 
    full_receipt,
    receipt_date,
    note
)
VALUES(
    1,
    0,
    '2019-05-12',
    'Goods receipt has not completed at warehouse'
);

INSERT INTO procurement.invoice_receipts(
    order_id, 
    is_late,
    receipt_date,
    note
)
VALUES(
    1,
    0,
    '2019-05-13',
    'Invoice duly received'
);
INSERT INTO procurement.invoice_receipts(
    order_id, 
    is_late,
    receipt_date,
    note
)
VALUES(
    2,
    0,
    '2019-05-15',
    'Invoice duly received'
);
Code language: SQL (Structured Query Language) (sql)
Fourth, query data from both tables:

SELECT * FROM procurement.goods_receipts;
SELECT * FROM procurement.invoice_receipts;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Sequence - use a sequence for multiple tables
Sequence vs. Identity columns 
Sequences, different from the identity columns, are not associated with a table. The relationship between the sequence and the table is controlled by applications. In addition, a sequence can be shared across multiple tables.

The following table illustrates the main differences between sequences and identity columns:

Property/Feature	Identity	Sequence Object
Allow specifying minimum and/or maximum increment values	No	Yes
Allow resetting the increment value	No	Yes
Allow caching increment value generating	No	Yes
Allow specifying starting increment value	Yes	Yes
Allow specifying increment value	Yes	Yes
Allow using in multiple tables	No	Yes
When to use sequences 
You use a sequence object instead of an identity column in the following cases:

The application requires a number before inserting values into the table.
The application requires sharing a sequence of numbers across multiple tables or multiple columns within the same table.
The application requires to restart the number when a specified value is reached.
The application requires multiple numbers to be assigned at the same time. Note that you can call the stored procedure sp_sequence_get_range to retrieve several numbers in a sequence at once.
The application needs to change the specification of the sequence like maximum value.
Getting sequences information 
You use the view sys.sequences to get the detailed information of sequences.

SELECT 
    * 
FROM 
    sys.sequences;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned about the SQL Server sequences to generate a sequence of numbers by a specified specification.

Was this tutorial helpful?

SQL Server ALTER TABLE ADD Column
Summary: in this tutorial, you will learn how to use SQL Server ALTER TABLE ADD statement to add one or more columns to a table.

The following ALTER TABLE ADD statement appends a new column to a table:

ALTER TABLE table_name
ADD column_name data_type column_constraint;
Code language: SQL (Structured Query Language) (sql)
In this statement:

First, specify the name of the table in which you want to add the new column.
Second, specify the name of the column, its data type, and constraint if applicable.
If you want to add multiple columns to a table at once using a single ALTER TABLE statement, you use the following syntax:

ALTER TABLE table_name
ADD 
    column_name_1 data_type_1 column_constraint_1,
    column_name_2 data_type_2 column_constraint_2,
    ...,
    column_name_n data_type_n column_constraint_n;
Code language: SQL (Structured Query Language) (sql)
In this syntax, you specify a comma-separated list of columns that you want to add to a table after the ADD clause.

Note that SQL Server doesn’t support the syntax for adding a column to a table after an existing column as MySQL does.

SQL Server ALTER TABLE ADD column examples 
The following statement creates a new table named sales.quotations:

CREATE TABLE sales.quotations (
    quotation_no INT IDENTITY PRIMARY KEY,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
To add a new column named description to the sales.quotations table, you use the following statement:

ALTER TABLE sales.quotations 
ADD description VARCHAR (255) NOT NULL;
Code language: SQL (Structured Query Language) (sql)
The following statement adds two new columns named amount and customer_name to the sales.quotations table:

ALTER TABLE sales.quotations 
    ADD 
        amount DECIMAL (10, 2) NOT NULL,
        customer_name VARCHAR (50) NOT NULL;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server ALTER TABLE ADD statement to add one or more columns to a table.

Was this tutorial helpful?

----------------------------

SQL Server ALTER TABLE ALTER COLUMN
Summary: in this tutorial, you will learn how to use the SQL Server ALTER TABLE ALTER COLUMN statement to modify a column of a table.

SQL Server allows you to perform the following changes to an existing column of a table:

Modify the data type
Change the size
Add a NOT NULL constraint
Modify column’s data type 
To modify the data type of a column, you use the following statement:

ALTER TABLE table_name 
ALTER COLUMN column_name new_data_type(size);
Code language: SQL (Structured Query Language) (sql)
The new data type must be compatible with the old one, otherwise, you will get a conversion error in case the column has data and it fails to convert.

See the following example.

First, create a new table with one column whose data type is INT:

CREATE TABLE t1 (c INT);
Code language: SQL (Structured Query Language) (sql)
Second, insert some rows into the table:

    INSERT INTO t1
    VALUES
        (1),
        (2),
        (3);
Code language: SQL (Structured Query Language) (sql)
Second, modify the data type of the column from INT to VARCHAR:

ALTER TABLE t1 ALTER COLUMN c VARCHAR (2);
Code language: SQL (Structured Query Language) (sql)
Third, insert a new row with a character string data:

INSERT INTO t1
VALUES ('@');
Code language: SQL (Structured Query Language) (sql)
Fourth, modify the data type of the column from VARCHAR back to INT:

ALTER TABLE t1 ALTER COLUMN c INT;
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following error:

Conversion failed when converting the varchar value '@' to data type int.
Code language: SQL (Structured Query Language) (sql)
Change the size of a column 
The following statement creates a new table with one column whose data type is VARCHAR(10):

CREATE TABLE t2 (c VARCHAR(10));
Code language: SQL (Structured Query Language) (sql)
Let’s insert some sample data into the t2 table:

INSERT INTO t2
VALUES
    ('SQL Server'),
    ('Modify'),
    ('Column')
Code language: SQL (Structured Query Language) (sql)
You can increase the size of the column as follows:

ALTER TABLE t2 ALTER COLUMN c VARCHAR (50);
Code language: SQL (Structured Query Language) (sql)
However, when you decrease the size of the column, SQL Server checks the existing data to see if it can convert data based on the new size. If the conversion fails, SQL Server terminates the statement and issues an error message.

For example, if you decrease the size of column c to 5 characters:

ALTER TABLE t2 ALTER COLUMN c VARCHAR (5);
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following error:

String or binary data would be truncated.
Code language: SQL (Structured Query Language) (sql)
Add a NOT NULL constraint to a nullable column 
The following statement creates a new table with a nullable column:

CREATE TABLE t3 (c VARCHAR(50));
Code language: SQL (Structured Query Language) (sql)
The following statement inserts some rows into the table:

INSERT INTO t3
VALUES
    ('Nullable column'),
    (NULL);
Code language: SQL (Structured Query Language) (sql)
If you want to add the NOT NULL constraint to the column c, you must update NULL to non-null first for example:

UPDATE t3
SET c = ''
WHERE
    c IS NULL;
Code language: SQL (Structured Query Language) (sql)
And then add the NOT NULL constraint:

ALTER TABLE t3 ALTER COLUMN c VARCHAR (20) NOT NULL;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server ALTER TABLE ALTER COLUMN to modify some properties of an existing column.

-----------------------

SQL Server ALTER TABLE DROP COLUMN
Summary: in this tutorial, you will learn how to use the SQL Server ALTER TABLE DROP column statement to remove one or more columns from existing table.

Introduction to SQL Server ALTER TABLE DROP COLUMN 
Sometimes, you need to remove one or more unused or obsolete columns from a table. To do this, you use the ALTER TABLE DROP COLUMN statement as follows:

ALTER TABLE table_name
DROP COLUMN column_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the table from which you want to delete the column.
Second, specify the name of the column that you want to delete.
If the column that you want to delete has a CHECK constraint, you must delete the constraint first before removing the column. Also, SQL Server does not allow you to delete a column that has a PRIMARY KEY or a FOREIGN KEY constraint.

If you want to delete multiple columns at once, you use the following syntax:

ALTER TABLE table_name
DROP COLUMN column_name_1, column_name_2,...;
Code language: SQL (Structured Query Language) (sql)
In this syntax, you specify columns that you want to drop as a list of comma-separated columns in the DROP COLUMN clause.

SQL Server ALTER TABLE DROP COLUMN examples 
Let’s create a new table named sales.price_lists for the demonstration.

CREATE TABLE sales.price_lists(
    product_id int,
    valid_from DATE,
    price DEC(10,2) NOT NULL CONSTRAINT ck_positive_price CHECK(price >= 0),
    discount DEC(10,2) NOT NULL,
    surcharge DEC(10,2) NOT NULL,
    note VARCHAR(255),
    PRIMARY KEY(product_id, valid_from)
); 
Code language: SQL (Structured Query Language) (sql)
The following statement drops the note column from the price_lists table:

ALTER TABLE sales.price_lists
DROP COLUMN note;
Code language: SQL (Structured Query Language) (sql)
The price column has a CHECK constraint, therefore, you cannot delete it. If you try to execute the following statement, you will get an error:

ALTER TABLE sales.price_lists
DROP COLUMN price;
Code language: SQL (Structured Query Language) (sql)
Here is the error message:

The object 'ck_positive_price' is dependent on column 'price'.
Code language: SQL (Structured Query Language) (sql)
To drop the price column, first, delete its CHECK constraint:

ALTER TABLE sales.price_lists
DROP CONSTRAINT ck_positive_price;
Code language: SQL (Structured Query Language) (sql)
And then, delete the price column:

ALTER TABLE sales.price_lists
DROP COLUMN price;
Code language: SQL (Structured Query Language) (sql)
The following example deletes two columns discount and surcharge at once:

ALTER TABLE sales.price_lists
DROP COLUMN discount, surcharge;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server ALTER TABLE DROP COLUMN statement to remove one or more columns from a table.

Was this tutorial helpful?

SQL Server Computed Columns
Summary: in this tutorial, you will learn how to use the SQL Server computed columns to reuse the calculation logic in multiple queries.

Introduction to SQL Server computed columns 
Let’s create a new table named persons for the demonstrations:

CREATE TABLE persons
(
    person_id  INT PRIMARY KEY IDENTITY, 
    first_name NVARCHAR(100) NOT NULL, 
    last_name  NVARCHAR(100) NOT NULL, 
    dob        DATE
);
Code language: SQL (Structured Query Language) (sql)
And insert two rows into the the persons table:

INSERT INTO 
    persons(first_name, last_name, dob)
VALUES
    ('John','Doe','1990-05-01'),
    ('Jane','Doe','1995-03-01');
Code language: SQL (Structured Query Language) (sql)
To query the full names of people in the persons table, you normally use the CONCAT() function or the + operator as follows:

SELECT
    person_id,
    first_name + ' ' + last_name AS full_name,
    dob
FROM
    persons
ORDER BY
    full_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server Computed Column - expression in query
Adding the full_name expression first_name + ' ' + last_name in every query is not convenient.

Fortunately, SQL Server provides us with a feature called computed columns that allows you to add a new column to a table with the value derived from the values of other columns in the same table.

For example, you can add the full_name column to the persons table by using the ALTER TABLE ADD column as follows:

ALTER TABLE persons
ADD full_name AS (first_name + ' ' + last_name);
Code language: SQL (Structured Query Language) (sql)
Every time you query data from the persons table, SQL Server computes the value for the full_name column based on the expression first_name + ' ' + last_name and returns the result.

Here is the new query, which is more compact:

SELECT 
    person_id, 
    full_name, 
    dob
FROM 
    persons
ORDER BY 
    full_name;
Code language: SQL (Structured Query Language) (sql)
If you examine the persons table, you can see the new full_name column appears in the column list:

SQL Server Computed Column example
Persisted computed columns 
Computed columns can be persisted. It means that SQL Server physically stores the data of the computed columns on disk.

When you change data in the table, SQL Server computes the result based on the expression of the computed columns and stores the results in these persisted columns physically. When you query the data from the persisted computed columns, SQL Server just needs to retrieve data without doing any calculation. This avoids calculation overhead with the cost of extra storage.

Consider the following example.

First, drop the full_name column of the persons table:

ALTER TABLE persons
DROP COLUMN full_name;
Code language: SQL (Structured Query Language) (sql)
Then, add the new full_name column to the persons table with the PERSISTED property:

ALTER TABLE persons
ADD full_name AS (first_name + ' ' + last_name) PERSISTED;
Code language: SQL (Structured Query Language) (sql)
Note that a computed column is persisted only if its expression is deterministic. It means that for a set of inputs, the expression always returns the same result.

For example, the expression first_name + ' ' + last_name is deterministic. However, the GETDATE() function is a non-deterministic function because it returns a different value on a different day.

This formula returns the age in years based on the date of birth and today:

(CONVERT(INT,CONVERT(CHAR(8),GETDATE(),112))-CONVERT(CHAR(8),dob,112))/10000
Code language: SQL (Structured Query Language) (sql)
We can use this expression for defining the age in year computed column.

The following statement attempts to define the age_in_yearcomputed column as a persisted computed column:

ALTER TABLE persons
ADD age_in_years 
    AS (CONVERT(INT,CONVERT(CHAR(8),GETDATE(),112))-CONVERT(CHAR(8),dob,112))/10000 
PERSISTED;
Code language: SQL (Structured Query Language) (sql)
SQL server issues the following error:

Computed column 'age_in_years' in table 'persons' cannot be persisted because the column is non-deterministic.
Code language: SQL (Structured Query Language) (sql)
If you remove the PERSISTED property, it should work:

ALTER TABLE persons
ADD age_in_years 
    AS (CONVERT(INT,CONVERT(CHAR(8),GETDATE(),112))-CONVERT(CHAR(8),dob,112))/10000;
Code language: SQL (Structured Query Language) (sql)
Now, you can query the age in years of people in the persons table as follows:

SELECT 
    person_id, 
    full_name, 
    age_in_years
FROM 
    persons
ORDER BY 
    age_in_years DESC;
Code language: SQL (Structured Query Language) (sql)
Here is the result set:

SQL Server Computed Column - non-deterministic expression
The syntax for adding computed columns to a table 
To add a new computed column to an existing table, you use the following syntax:

ALTER TABLE table_name
ADD column_name AS expression [PERSISTED];
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the table to which you want to add the computed column.
Second, specify the computed column name with the expression that returns the values for the column.
Third, if the expression is deterministic and you want to store the data of the computed column physically, you can use the PERSISTED property.
Note that you can create an index on a persisted computed column to improve the speed of data retrieval from the computed column. It is a good alternative solution for function-based indexes of Oracle or indexes on expressions of PostgreSQL.

The syntax for defining computed columns when creating a new table 
To define a computed column when you create a table, you use the following syntax:

CREATE TABLE table_name(
    ...,
    column_name AS expression [PERSISTED],
    ...
);
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use SQL Server computed columns to reuse the calculation logic in multiple queries.

Was this tutorial helpful?

SQL Server DROP TABLE
Summary: in this tutorial, you will learn how to use the SQL Server DROP TABLE statement to remove one or more tables from a database.

Sometimes, you want to remove a table that is no longer in use. To do this, you use the following DROP TABLE statement:

DROP TABLE [IF EXISTS]  [database_name.][schema_name.]table_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the table to be removed.
Second, specify the name of the database in which the table was created and the name of the schema to which the table belongs. The database name is optional. If you skip it, the DROP TABLE statement will drop the table in the currently connected database.
Third, use IF EXISTS clause to remove the table only if it exists. The IF EXISTS clause has been supported since SQL Server 2016 13.x. If you remove a table that does not exist, you will get an error. The IF EXISTS clause conditionally removes the table if it already exists.
When SQL Server drops a table, it also deletes all data, triggers, constraints, permissions of that table. Moreover, SQL Server does not explicitly drop the views and stored procedures that reference the dropped table. Therefore, to explicitly drop these dependent objects, you must use the DROP VIEW and DROP PROCEDURE statement.

SQL Server allows you to remove multiple tables at once using a single DROP TABLE statement as follows:

DROP TABLE [database_name.][schema_name.]table_name_1,
             
Code language: SQL (Structured Query Language) (sql)
[schema_name.]table_name_2, …

[schema_name.]table_name_n;

SQL Server DROP TABLE examples 
Let’s see some examples of using the SQL Server DROP TABLE statement.

A) Drop a table that does not exist 
The following statement removes a table named revenues in the sales schema:

DROP TABLE IF EXISTS sales.revenues;
Code language: SQL (Structured Query Language) (sql)
In this example, the revenues table does not exist. Because it uses the IF EXISTS clause, the statement executes successfully with no table deleted.

B) Drop a single table example 
The following statement creates a new table named delivery in the sales schema:

CREATE TABLE sales.delivery (
    delivery_id INT PRIMARY KEY,
    delivery_note VARCHAR (255) NOT NULL,
    delivery_date DATE NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
To remove the delivery table, you use the following statement:

DROP TABLE sales.delivery;
Code language: SQL (Structured Query Language) (sql)
C) Drop a table with a foreign key constraint example 
The following statement creates two new tables named supplier_groups and suppliers in the procurement schema:

CREATE SCHEMA procurement;
GO

CREATE TABLE procurement.supplier_groups (
    group_id INT IDENTITY PRIMARY KEY,
    group_name VARCHAR (50) NOT NULL
);

CREATE TABLE procurement.suppliers (
    supplier_id INT IDENTITY PRIMARY KEY,
    supplier_name VARCHAR (50) NOT NULL,
    group_id INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES procurement.supplier_groups (group_id)
);
Code language: SQL (Structured Query Language) (sql)
Let’s try to drop the supplier_groups table:

DROP TABLE procurement.supplier_groups;
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following error:

Could not drop object 'procurement.supplier_groups' because it is referenced by a FOREIGN KEY constraint.
Code language: SQL (Structured Query Language) (sql)
SQL Server does not allow you to delete a table that is referenced by a foreign constraint. To delete this table, you must drop the referencing foreign key constraint or referencing table first. In this case, you have to drop the foreign key constraint in the  suppliers table or the  suppliers table first before removing the supplier_groups table.

DROP TABLE procurement.supplier_groups;
DROP TABLE procurement.suppliers;
Code language: SQL (Structured Query Language) (sql)
If you use a single DROP TABLE statement to remove both tables, the referencing table must be listed first as shown in the query below:

DROP TABLE procurement.suppliers, procurement.supplier_groups;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server DROP TABLE statement to remove one or more tables from a database.

Was this tutorial helpful?

-SQL Server TRUNCATE TABLE
Summary: in this tutorial, you will learn how to use the SQL Server TRUNCATE TABLE statement to remove all rows from a table faster and more efficiently.

Introduction to SQL Server TRUNCATE TABLE statement 
Sometimes, you want to delete all rows from a table. In this case, you typically use the DELETE statement without a WHERE clause.

The following example creates a new table named customer_groups and inserts some rows into the table:

CREATE TABLE sales.customer_groups (
    group_id INT PRIMARY KEY IDENTITY,
    group_name VARCHAR (50) NOT NULL
);

INSERT INTO sales.customer_groups (group_name)
VALUES
    ('Intercompany'),
    ('Third Party'),
    ('One time');
Code language: SQL (Structured Query Language) (sql)
To delete all rows from the customer_groups table, you use the DELETE statement as follows:

DELETE FROM sales.customer_groups;
Code language: SQL (Structured Query Language) (sql)
Besides the DELETE FROM statement, you can use the TRUNCATE TABLE statement to delete all rows from a table.

The following illustrates the syntax of the TRUNCATE TABLE statement:

TRUNCATE TABLE [database_name.][schema_name.]table_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax, first, you specify the name of the table from which you want to delete all rows. Second, the database name is the name of the database in which the table was created. The database name is optional. If you skip it, the statement will delete the table in the currently connected database.

The following statements first insert some rows into the customer_groups table and then delete all rows from it using the TRUNCATE TABLE statement:

INSERT INTO sales.customer_groups (group_name)
VALUES
    ('Intercompany'),
    ('Third Party'),
    ('One time');   

TRUNCATE TABLE sales.customer_groups;
Code language: SQL (Structured Query Language) (sql)
The TRUNCATE TABLE is similar to the DELETE statement without a WHERE clause. However, the TRUNCATE statement executes faster and uses a fewer system and transaction log resources.

TRUNCATE TABLE vs. DELETE 
The TRUNCATE TABLE has the following advantages over the DELETE statement:

1) Use less transaction log 
The DELETE statement removes rows one at a time and inserts an entry in the transaction log for each removed row. On the other hand, the TRUNCATE TABLE statement deletes the data by deallocating the data pages used to store the table data and inserts only the page deallocations in the transaction logs.

2) Use fewer locks 
When the DELETE statement is executed using a row lock, each row in the table is locked for removal. The TRUNCATE TABLE locks the table and pages, not each row.

3) Identity reset 
If the table to be truncated has an identity column, the counter for that column is reset to the seed value when data is deleted by the TRUNCATE TABLE statement but not the DELETE statement.

In this tutorial, you have learned how to use the TRUNCATE TABLE statement to delete all rows from a table faster and more efficiently.

Was this tutorial helpful?  

SQL Server SELECT INTO
Summary: in this tutorial, you will learn how to use the SQL Server SELECT INTO statement to copy a table.

Introduction to SQL Server SELECT INTO statement 
The SELECT INTO statement creates a new table and inserts rows from the query into it.

The following SELECT INTO statement creates the destination table and copies rows, which satisfy the WHERE condition, from the source table to the destination table:

SELECT 
    select_list
INTO 
    destination
FROM 
    source
[WHERE condition]
Code language: SQL (Structured Query Language) (sql)
If you want to copy the partial data from the source table, you use the WHERE clause to specify which rows to copy. Similarly, you can specify which columns from the the source table to copy to the destination table by specifying them in the select list.

Note that SELECT INTO statement does not copy constraints such as primary key and indexes from the source table to the destination table.

SQL Server SELECT INTO examples 
Let’s take some examples of using the SELECT INTO statement.

A) Using SQL Server SELECT INTO to copy table within the same database example 
First, create a new schema for storing the new table.

CREATE SCHEMA marketing;
GO
Code language: SQL (Structured Query Language) (sql)
Second, create the marketing.customers table like the sales.customers table and copy all rows from the sales.customers table to the marketing.customers table:

SELECT 
    *
INTO 
    marketing.customers
FROM 
    sales.customers;
Code language: SQL (Structured Query Language) (sql)
Third, query data from the the marketing.customers table to verify the copy:

SELECT 
    *
FROM 
    marketing.customers;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial output:

SQL Server SELECT INTO example 1
B) Using SQL Server SELECT INTO statement to copy table across databases 
First, create a new database named TestDb for testing:

CREATE DATABASE TestDb;
GO
Code language: SQL (Structured Query Language) (sql)
Second, copy the sales.customers from the current database (BikeStores) to the TestDb.dbo.customers table. This time, we just copy the customer identification, first name, last name, and email of customers who locate in California:

SELECT    
    customer_id, 
    first_name, 
    last_name, 
    email
INTO 
    TestDb.dbo.customers
FROM    
    sales.customers
WHERE 
    state = 'CA';
Code language: SQL (Structured Query Language) (sql)
Third, query data from the TestDb.dbo.customers to verify the copy:

SELECT 
    * 
FROM 
    TestDb.dbo.customers;
Code language: SQL (Structured Query Language) (sql)
Here is the partial result set:

SQL Server SELECT INTO example 2
In this tutorial, you have learned how to use the SQL Server SELECT INTO statement to copy a table within the same database or across databases.

Was this tutorial helpful?

SQL Server Rename Table
Summary: in this tutorial, you will learn how to rename a table using Transact SQL and SQL Server Management Studio.

SQL Rename table using Transact SQL 
SQL Server does not have any statement that directly renames a table. However, it does provide you with a stored procedure named sp_rename that allows you to change the name of a table.

The following shows the syntax of using the sp_rename stored procedure for changing the name of a table:

EXEC sp_rename 'old_table_name', 'new_table_name'
Code language: SQL (Structured Query Language) (sql)
Note that both the old and new name of the table whose name is changed must be enclosed in single quotations.

Let’s see the following example.

First, create a new table named sales.contr for storing sales contract’s data:

CREATE TABLE sales.contr (
    contract_no INT IDENTITY PRIMARY KEY,
    start_date DATE NOT NULL,
    expired_date DATE,
    customer_id INT,
    amount DECIMAL (10, 2)
); 
Code language: SQL (Structured Query Language) (sql)
Second, use the sp_rename stored procedure to rename the sales.contr table to contracts in the sales schema:

EXEC sp_rename 'sales.contr', 'contracts';
Code language: SQL (Structured Query Language) (sql)
SQL Server returns the following message:

Caution: Changing any part of an object name could break scripts and stored procedures.
Code language: Shell Session (shell)
However, it renamed the table successfully.

SQL Server rename table using SSMS 
Another way to rename a table is to use the function provided by SQL Server Management Studio.

The following example illustrates how to rename the product_history table to product_archive.

First, right-click on the table name and choose Rename menu item:



Second, type the new name of the table e.g., product_archive and press Enter:


In this tutorial, you have learned how to rename a table in a database using the sp_rename stored procedure and SQL Server Management Studio.

Was this tutorial helpful?

SQL Server Temporary Tables
Summary: in this tutorial, you will learn how to create SQL Server temporary tables and how to manipulate them effectively.

Temporary tables are tables that exist temporarily on the SQL Server.

The temporary tables are useful for storing the immediate result sets that are accessed multiple times.

Creating temporary tables 
SQL Server provided two ways to create temporary tables via SELECT INTO and CREATE TABLE statements.

Create temporary tables using SELECT INTO statement 
The first way to create a temporary table is to use the SELECT INTO statement as shown below:

SELECT 
    select_list
INTO 
    temporary_table
FROM 
    table_name
....
Code language: SQL (Structured Query Language) (sql)
The name of the temporary table starts with a hash symbol (#). For example, the following statement creates a temporary table using the SELECT INTO statement:

SELECT
    product_name,
    list_price
INTO #trek_products --- temporary table
FROM
    production.products
WHERE
    brand_id = 9;
Code language: SQL (Structured Query Language) (sql)
In this example, we created a temporary table named #trek_products with two columns derived from the select list of the SELECT statement. The statement created the temporary table and populated data from the production.products table into the temporary table.

Once you execute the statement, you can find the temporary table name created in the system database named tempdb, which can be accessed via the SQL Server Management Studio using the following path System Databases > tempdb > Temporary Tables as shown in the following picture:

SQL Server Temporary Tables Example
As you can see clearly from the picture, the temporary table also consists of a sequence of numbers as a postfix. This is a unique identifier for the temporary table. Because multiple database connections can create temporary tables with the same name, SQL Server automatically appends this unique number at the end of the temporary table name to differentiate between the temporary tables.

Create temporary tables using CREATE TABLE statement 
The second way to create a temporary table is to use the CREATE TABLE statement:

CREATE TABLE #haro_products (
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);
Code language: SQL (Structured Query Language) (sql)
This statement has the same syntax as creating a regular table. However, the name of the temporary table starts with a hash symbol (#)

After creating the temporary table, you can insert data into this table as a regular table:

INSERT INTO #haro_products
SELECT
    product_name,
    list_price
FROM 
    production.products
WHERE
    brand_id = 2;
Code language: SQL (Structured Query Language) (sql)
Of course, you can query data against it within the current session:

SELECT
    *
FROM
    #haro_products;
Code language: SQL (Structured Query Language) (sql)
SQL Server Temporary Tables - Querying Data
However, if you open another connection and try the query above query, you will get the following error:

Invalid object name '#haro_products'.
Code language: SQL (Structured Query Language) (sql)
This is because the temporary tables are only accessible within the session that created them.

Global temporary tables 
Sometimes, you may want to create a temporary table that is accessible across connections. In this case, you can use global temporary tables.

Unlike a temporary table, the name of a global temporary table starts with a double hash symbol (##).

The following statements first create a global temporary table named ##heller_products and then populate data from the production.products table into this table:

CREATE TABLE ##heller_products (
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);

INSERT INTO ##heller_products
SELECT
    product_name,
    list_price
FROM 
    production.products
WHERE
    brand_id = 3;
Code language: SQL (Structured Query Language) (sql)
Now, you can access the ##heller_products table from any session.

Dropping temporary tables 
Automatic removal 
SQL Server drops a temporary table automatically when you close the connection that created it.

SQL Server drops a global temporary table once the connection that created it closed and the queries against this table from other connections completes.

Manual Deletion 
From the connection in which the temporary table created, you can manually remove the temporary table by using the DROP TABLE statement:

DROP TABLE ##table_name;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned about SQL Server temporary tables and how to create and remove them effectively.

Was this tutorial helpful?

SQL Server Synonym
Summary: in this tutorial, you will learn about SQL Server synonym and how to create synonyms for database objects.

What is a synonym in SQL Server 
In SQL Server, a synonym is an alias or alternative name for a database object such as a table, view, stored procedure, user-defined function, and sequence. A synonym provides you with many benefits if you use it properly.

SQL Server CREATE SYNONYM statement syntax 
To create a synonym, you use the CREATE SYNONYM statement as follows:

CREATE SYNONYM [ schema_name_1. ] synonym_name 
FOR object;
Code language: SQL (Structured Query Language) (sql)
The object is in the following form:

[ server_name.[ database_name ] . [ schema_name_2 ]. object_name   
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the target object that you want to assign a synonym in the FOR clause
Second, provide the name of the synonym after the CREATE SYNONYM keywords
Note that the object for which you create the synonym does not have to exist at the time the synonym is created.

SQL Server CREATE SYNONYM statement examples 
Let’s take some examples of using the CREATE SYNONYM statement to get a better understanding.

A) Creating a synonym within the same database example 
The following example uses the CREATE SYNONYM statement to create a synonym for the sales.orders table:

CREATE SYNONYM orders FOR sales.orders;
Code language: SQL (Structured Query Language) (sql)
Once the orders synonym is created, you can reference it in anywhere which you use the target object (sales.orders table).

For example, the following query uses the orders synonym instead of sales.orders table:

SELECT * FROM orders;
Code language: SQL (Structured Query Language) (sql)
B) Creating a synonym for a table in another database 
First, create a new database named test and set the current database to test:

CREATE DATABASE test;
GO

USE test;
GO
Code language: SQL (Structured Query Language) (sql)
Next, create a new schema named purchasing inside the test database:

CREATE SCHEMA purchasing;
GO
Code language: SQL (Structured Query Language) (sql)
Then, create a new table in the purchasing schema of the test database:

CREATE TABLE purchasing.suppliers
(
    supplier_id   INT
    PRIMARY KEY IDENTITY, 
    supplier_name NVARCHAR(100) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
After that, from the BikeStores database, create a synonym for the purchasing.suppliers table in the test database:

CREATE SYNONYM suppliers 
FOR test.purchasing.suppliers;
Code language: SQL (Structured Query Language) (sql)
Finally, from the BikeStores database, refer to the test.purchasing.suppliers table using the suppliers synonym:

SELECT * FROM suppliers;
Code language: SQL (Structured Query Language) (sql)
Listing all synonyms of a database 
You can view all synonyms of a database by using Transact-SQL and SQL Server Management Studio.

A) Listing synonyms using Transact-SQL command 
To list all synonyms of the current database, you query from the sys.synonyms catalog view as shown in the following query:

SELECT 
    name, 
    base_object_name, 
    type
FROM 
    sys.synonyms
ORDER BY 
    name;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Synonym Example
B) Listing synonyms using SQL Server Management Studio 
From the SQL Server Management Studio, you can view all synonym of the current database via Synonyms node as shown in the following picture:

SQL Server Synonym using SSMS
Removing a synonym 
To remove a synonym, you use the DROP SYNONYM statement with the following syntax:

DROP SYNONYM [ IF EXISTS ] [schema.] synonym_name  
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the synonym name that you want to remove after the DROP SYNONYM keywords.
Second, use the IF EXISTS to conditionally drop the synonym only if it exists. Removing a non-existing synonym without the IF EXISTS option will result in an error.
Removing synonyms example 
The following example uses the DROP SYNONYM statement to drop the orders synonym:

DROP SYNONYM IF EXISTS orders;
Code language: SQL (Structured Query Language) (sql)
When to use synonyms 
You will find some situations which you can effectively use synonyms.

1) Simplify object names 
If you refer to an object from another database (even from a remote server), you can create a synonym in your database and reference to this object as it is in your database.

2) Enable seamless object name changes 
When you want to rename a table or any other object such as a view, stored procedure, user-defined function, or a sequence, the existing database objects that reference to this table need to be manually modified to reflect the new name. In addition, all current applications that use this table need to be changed and possibly to be recompiled. To avoid all of these hard work, you can rename the table and create a synonym for it to keep existing applications function properly.

Benefits of synonyms 
Synonym provides the following benefit if you use them properly:

Provide a layer of abstraction over the base objects.
Shorten the lengthy name e.g., a very_long_database_name.with_schema.and_object_name with a simplified alias.
Allow backward compatibility for the existing applications when you rename database objects such as tables, views, stored procedures, user-defined functions, and sequences.
In this tutorial, you have learned how to about the SQL Server synonyms and how to use them effectively in your applications.

Was this tutorial helpful?

SQL Server Data Types
Summary: in this tutorial, you will learn about SQL Server data types including numeric, character string, binary string, date & time, and other data types.

SQL Server data types Overview 
In SQL Server, a column, variable, and parameter holds a value that associated with a type, or also known as a data type. A data type is an attribute that specifies the type of data that these objects can store. It can be an integer, character string, monetary, date and time, and so on.

SQL Server provides a list of data types that define all types of data that you can use e.g., defining a column or declaring a variable.

The following picture illustrates the SQL Server data types system:

SQL Server Data Types
Notice that SQL Server will remove ntext, text, and image data types in its future version. Therefore, you should avoid using these data types and use nvarchar(max), varchar(max), and varbinary(max) data types instead.

Exact numeric data types 
Exact numeric data types store exact numbers such as integer, decimal, or monetary amount.

The bit store one of three values 0, 1, and NULL
The int, bigint, smallint, and tinyint data types store integer data.
The decimal and numeric data types store numbers that have fixed precision and scale. Note that decimal and numeric are synonyms.
The money and smallmoney data type store currency values.
The following table illustrates the characteristics of the exact numeric data types:

Data Type	Lower limit	Upper limit	Memory
bigint	−2^63 (−9,223,372, 036,854,775,808)	2^63−1 (−9,223,372, 036,854,775,807)	8 bytes
int	−2^31 (−2,147, 483,648)	2^31−1 (−2,147, 483,647)	4 bytes
smallint	−2^15 (−32,767)	2^15 (−32,768)	2 bytes
tinyint	0	255	1 byte
bit	0	1	1 byte/8bit column
decimal	−10^38+1	10^381−1	5 to 17 bytes
numeric	−10^38+1	10^381−1	5 to 17 bytes
money	−922,337, 203, 685,477.5808	+922,337, 203, 685,477.5807	8 bytes
smallmoney	−214,478.3648	+214,478.3647	4 bytes
Approximate numeric data types 
The approximate numeric data type stores floating point numeric data. They are often used in scientific calculations.

Data Type	Lower limit	Upper limit	Memory	Precision
float(n)	−1.79E+308	1.79E+308	Depends on the value of n	7 Digit
real	−3.40E+38	3.40E+38	4 bytes	15 Digit
Date & Time data types 
The date and time data types store data and time data, and the date time offset.

Data Type	Storage size	Accuracy	Lower Range	Upper Range
datetime	8 bytes	Rounded to increments of .000, .003, .007	1753-01-01	9999-12-31
smalldatetime	4 bytes, fixed	1 minute	1900-01-01	2079-06-06
date	3 bytes, fixed	1 day	0001-01-01	9999-12-31
time	5 bytes	100 nanoseconds	00:00:00.0000000	23:59:59.9999999
datetimeoffset	10 bytes	100 nanoseconds	0001-01-01	9999-12-31
datetime2	6 bytes	100 nanoseconds	0001-01-01	9999-12-31
If you develop a new application, you should use the time, date, datetime2 and datetimeoffset data types. Because these types align with the SQL Standard and more portable. In addition, the time, datetime2 and datetimeoffset have more seconds precision and datetimeoffset supports time zone.

Character strings data types 
Character strings data types allow you to store either fixed-length (char) or variable-length data (varchar). The text data type can store non-Unicode data in the code page of the server.

Data Type	Lower limit	Upper limit	Memory
char	0 chars	8000 chars	n bytes
varchar	0 chars	8000 chars	n bytes + 2 bytes
varchar (max)	0 chars	2^31 chars	n bytes + 2 bytes
text	0 chars	2,147,483,647 chars	n bytes + 4 bytes
Unicode character string data types 
Unicode character string data types store either fixed-length (nchar) or variable-length (nvarchar) Unicode character data.

Data Type	Lower limit	Upper limit	Memory
nchar	0 chars	4000 chars	2 times n bytes
nvarchar	0 chars	4000 chars	2 times n bytes + 2 bytes
ntext	0 chars	1,073,741,823 char	2 times the string length
Binary string data types 
The binary data types stores fixed and variable length binary data.

Data Type	Lower limit	Upper limit	Memory
binary	0 bytes	8000 bytes	n bytes
varbinary	0 bytes	8000 bytes	The actual length of data entered + 2 bytes
image	0 bytes	2,147,483,647 bytes	
Other data types 
Data Type	Description
cursor	for variables or stored procedure OUTPUT parameter that contains a reference to a cursor
rowversion	expose automatically generated, unique binary numbers within a database.
hierarchyid	represent a tree position in a tree hierarchy
uniqueidentifier	16-byte GUID
sql_variant	store values of other data types
XML	store XML data in a column, or a variable of XML type
Spatial Geometry type	represent data in a flat coordinate system.
Spatial Geography type	store ellipsoidal (round-earth) data, such as GPS latitude and longitude coordinates.
table	store a result set temporarily for processing at a later time
In this tutorial, you have learned about the brief overview of SQL Server data types. We will examine each data type in detail in the next tutorials.

Was this tutorial helpful?

SQL Server BIT
Summary: in this tutorial, you will learn how to use the SQL Server BIT data type to store bit data in the database.

Overview of BIT data type 
SQL Server BIT data type is an integer data type that can take a value of 0, 1, or NULL.

The following illustrates the syntax of the BIT data type:

BIT
Code language: SQL (Structured Query Language) (sql)
SQL Server optimizes storage of BIT columns. If a table has 8 or fewer bit columns, SQL Server stores them as 1 byte. If a table has 9 up to 16 bit columns, SQL Server stores them as 2 bytes, and so on.

SQL Server converts a string value TRUE to 1 and FALSE to 0. It also converts any nonzero value to 1.

SQL Server BIT examples 
The following statement creates a new table with one BIT column:

CREATE TABLE test.sql_server_bit (
    bit_col BIT
);
Code language: SQL (Structured Query Language) (sql)
To insert a bit 1 into the bit column, you use the following statement:

INSERT INTO test.sql_server_bit (bit_col)
OUTPUT inserted.bit_col
VALUES(1);
Code language: SQL (Structured Query Language) (sql)
The output is:

bit_col
-------
1

(1 row affected)
To insert a bit 0 into the bit column, you use the following statement:

INSERT INTO test.sql_server_bit (bit_col)
OUTPUT inserted.bit_col
VALUES(0);
Code language: SQL (Structured Query Language) (sql)
Here is the output:

bit_col
-------
0

(1 row affected)
If you insert a string value of True into the bit column, SQL server converts it to bit 1:

INSERT INTO test.sql_server_bit (bit_col)
OUTPUT inserted.bit_col
VALUES
    ('True');
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

bit_col
-------
1

(1 row affected)
Similarly, SQL Server converts a string value of false to bit 0:

INSERT INTO test.sql_server_bit (bit_col)
OUTPUT inserted.bit_col
VALUES
    ('False');
Code language: SQL (Structured Query Language) (sql)
The following is the output:

bit_col
-------
0

(1 row affected)
SQL Server converts any nonzero value to bit 1. For example:

INSERT INTO test.sql_server_bit (bit_col)
OUTPUT inserted.bit_col
VALUES
    (0.5); 
Code language: SQL (Structured Query Language) (sql)
The following is the output:

bit_col
-------
1

(1 row affected)
In this tutorial, you have learned how to use the SQL Server BIT data type to store bit data in a table.

Was this tutorial helpful?

SQL Server INT
Summary: in this tutorial, you will learn how about the integer data types and how to use them effectively to store integer values in the database.

SQL Server support standard SQL integer types including BIGINT, INT, SMALLINT, and TINYINT. The following table illustrates the range and storage of each integer type:

Data type	Range	Storage
BIGINT	-263 (-9,223,372,036,854,775,808) to 263-1 (9,223,372,036,854,775,807)	8 Bytes
INT	-231 (-2,147,483,648) to 231-1 (2,147,483,647)	4 Bytes
SMALLINT	-215 (-32,768) to 215-1 (32,767)	2 Bytes
TINYINT	0 to 255	1 Byte
It is a good practice to use the smallest integer data type that can reliably contain all possible values. For example, to store the number of children in a family, TINYINT is sufficient because nowadays no one could have more than 255 children. However, TINYINT is would not be sufficient for storing the stories of a building because a building can have more than 255 stories.

SQL Server Integers example 
The following statement creates a new table that consists of four integer columns:

CREATE TABLE test.sql_server_integers (
	bigint_col bigint,
	int_col INT,
	smallint_col SMALLINT,
	tinyint_col tinyint
);
Code language: SQL (Structured Query Language) (sql)
The following INSERT statement adds the maximum integers of BIGINT, INT, SMALLINT, and TINYINT to the corresponding columns of the table:

INSERT INTO test.sql_server_integers (
	bigint_col,
	int_col,
	smallint_col,
	tinyint_col
)
VALUES
	(
		9223372036854775807,
		2147483647,
		32767,
		255
	);
Code language: SQL (Structured Query Language) (sql)
To show the values stored in the test.sql_server_integers table, you use the following SELECT statement:

SELECT
	bigint_col,
	int_col,
	smallint_col,
	tinyint_col
FROM
	test.sql_server_integers;
Code language: SQL (Structured Query Language) (sql)
Converting integer data 
SQL Server converts the integer constant greater than 2,147,483,647 to DECIMAL data type, not BIGINT data type as shown in the following example:

SELECT 2147483647 / 3 AS r1, 
	   2147483649 / 3 AS r2;
Code language: SQL (Structured Query Language) (sql)
The query example showed when the threshold value was exceeded, the data type of the result changed from INT to a DECIMAL.

In this tutorial, you have learned various SQL Server integer data types and how to use them to store integers in the database.


SQL Server Decimal
Summary: in this tutorial, you will learn about the SQL Server DECIMAL data type and how to use it to store exact numeric values.

Overview of SQL Server DECIMAL Data Type 
To store numbers that have fixed precision and scale, you use the DECIMAL data type.

The following shows the syntax of the DECIMAL data type:

DECIMAL(p,s)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

p is the precision which is the maximum total number of decimal digits that will be stored, both to the left and to the right of the decimal point. The precision has a range from 1 to 38. The default precision is 38.
s is the scale which is the number of decimal digits that will be stored to the right of the decimal point. The scale has a range from 0 to p (precision). The scale can be specified only if the precision is specified. By default, the scale is zero.
The maximum storage sizes vary, depending on the precision as illustrated in the following table:

Precision	Storage bytes
1 – 9	5
10-19	9
20-28	13
29-38	17
The NUMERIC and DECIMAL are synonyms, therefore, you can use them interchangeably.

The following declarations are equivalent:

DECIMAL(10,2)
NUMERIC(10,2)
Code language: SQL (Structured Query Language) (sql)
Because the ISO synonyms for DECIMAL are DEC and DEC(p,s), you can use either DECIMAL or DEC:

DECIMAL(10,2)
DEC(10,2)
Code language: SQL (Structured Query Language) (sql)
SQL Server DECIMAL example 
Let’s take an example of using the DECIMAL and NUMERIC data types.

First, create a new table that consists of two columns: one decimal and one numeric:

CREATE TABLE test.sql_server_decimal (
    dec_col DECIMAL (4, 2),
    num_col NUMERIC (4, 2)
);
Code language: SQL (Structured Query Language) (sql)
Second, insert a new row into the test.sql_server_decimal table:

INSERT INTO test.sql_server_decimal (dec_col, num_col)
VALUES
    (10.05, 20.05);
Code language: SQL (Structured Query Language) (sql)
Third, query data from the table:

SELECT
    dec_col,
    num_col
FROM
    test.sql_server_decimal;
Code language: SQL (Structured Query Language) (sql)
Fourth, the following example attempts to insert a new row into the table with values that exceed the precision and scale specified in the column definition:

INSERT INTO test.sql_server_decimal (dec_col, num_col)
VALUES
    (99.999, 12.345);
Code language: SQL (Structured Query Language) (sql)
SQL Server issued an error and terminated the statement:

Arithmetic overflow error converting numeric to data type numeric.
The statement has been terminated
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server DECIMAL data type to store exact numeric values.

Was this tutorial helpful?

SQL Server NCHAR
Summary: in this tutorial, you will learn how to use the SQL Server NCHAR data type to store fixed-length, Unicode character string data.

To store fixed-length, Unicode character string data in the database, you use the SQL Server NCHAR data type:

NCHAR(n)
Code language: SQL (Structured Query Language) (sql)
In this syntax, n specifies the string length that ranges from 1 to 4,000. The storage size of a NCHAR value is two times n bytes.

The ISO synonyms for NCHAR are NATIONAL CHAR and NATIONAL CHARACTER, therefore, you can use them interchangeably.

Similar to the CHAR data type, you use the NCHAR for storing fixed-length character string only. If the lengths of data values are variable, you should consider using VARCHAR or NVARCHAR data type.

CHAR vs. NCHAR 
The following are the major differences between CHAR and NCHAR data types

CHAR
NCHAR
Store only non-Unicode characters.	Store Unicode characters in the form of UNICODE UCS-2 characters.
Need 1 byte to store a character	Need 2 bytes to store a character.
The storage size equals the size specified in the column definition or variable declaration.	The storage size equals double the size specified in the column definition or variable declaration.
Store up to 8000 characters.	Store up to 4000 characters.
SQL Server NCHAR example 
The following statement creates a new table with one NCHAR column:

CREATE TABLE test.sql_server_nchar (
    val NCHAR(1) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
The following INSERT statement inserts the character a (あ) in Japanese into the NCHAR column:

INSERT INTO test.sql_server_nchar (val)
VALUES
    (N'あ');
Code language: SQL (Structured Query Language) (sql)
Notice that you must prefix the Unicode character string constants with the letter N. Otherwise, SQL Server will convert the string to the default code page of the database which may not recognize some certain Unicode characters.

If you insert a character string whose length is greater than the length specified in the column definition, SQL Server issues an error and terminates the statement.

For example, the following statement attempts to insert a string with two characters into the  val column of test.sql_server_nchar table:

INSERT INTO test.sql_server_nchar (val)
VALUES
    (N'いえ'); 
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following error message:

String or binary data would be truncated.
The statement has been terminated. 
Code language: SQL (Structured Query Language) (sql)
To find the number of characters and the number of bytes of the values the val column, you use the LEN and DATALENGTH functions as follows:

SELECT
    val,
    len(val) length,
    DATALENGTH(val) data_length
FROM
    test.sql_server_nchar;
Code language: SQL (Structured Query Language) (sql)
SQL Server NCHAR data type example
In this tutorial, you have learned how to use the SQL Server NCHAR data type to store fixed-length, Unicode character strings in the database.

SQL Server VARCHAR
Summary: in this tutorial, you will learn how to use the SQL Server VARCHAR data type to store variable-length, non-Unicode string data.

Overview of SQL Server VARCHAR data type 
SQL Server VARCHAR data type is used to store variable-length, non-Unicode string data. The following illustrates the syntax:

VARCHAR(n)
Code language: SQL (Structured Query Language) (sql)
In this syntax, n defines the string length that ranges from 1 to 8,000. If you don’t specify n, its default value is 1.

Another way to declare a VARCHAR column is to use the following syntax:

VARCHAR(max)
Code language: SQL (Structured Query Language) (sql)
In this syntax, max defines the maximum storage size which is 231-1 bytes (2 GB).

In general, the storage size of a VARCHAR value is the actual length of the data stored plus 2 bytes.

The ISO synonyms of VARCHAR are CHARVARYING or CHARACTERVARYING, therefore, you can use them interchangeably.

SQL Server VARCHAR example 
The following statement creates a new table that contains one VARCHAR column:

CREATE TABLE test.sql_server_varchar (
    val VARCHAR NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Because we did not specify the string length of the  val column, it defaults to one.

To change the string length of the  val column, you use the ALTER TABLE ALTER COLUMN statement:

ALTER TABLE test.sql_server_varchar 
ALTER COLUMN val VARCHAR (10) NOT NULL;
Code language: SQL (Structured Query Language) (sql)
The following statement inserts a new string into the  val column of the test.sql_server_varchar table:

INSERT INTO test.sql_server_varchar (val)
VALUES
    ('SQL Server');
Code language: SQL (Structured Query Language) (sql)
The statement worked as expected because the string value has a length equals to the one defined in the column definition.

The following statement attempts to insert a new string data whose length is greater than the string length of the column:

INSERT INTO test.sql_server_varchar (val)
VALUES
    ('SQL Server VARCHAR');
Code language: SQL (Structured Query Language) (sql)
SQL Server issued an error and terminated the statement:

String or binary data would be truncated.
The statement has been terminated.
Code language: SQL (Structured Query Language) (sql)
To find the number of characters and the number of bytes of values stored in the VARCHAR column, you use the LEN and DATALENGTH functions as shown in the following query:

SELECT
    val,
    LEN(val) len,
    DATALENGTH(val) data_length
FROM
    test.sql_server_varchar;
Code language: SQL (Structured Query Language) (sql)
SQL Server VARCHAR example
In this tutorial, you have learned how to use the SQL Server VARCHAR data type to store variable-length, non-Unicode data in the database.

SQL Server NVARCHAR
Summary: in this tutorial, you will learn how to use the SQL Server NVARCHAR data type to store variable-length, Unicode string data.

Overview of SQL Server NVARCHAR data type 
SQL Server NVARCHAR data type is used to store variable-length, Unicode string data. The following shows the syntax of NVARCHAR:

NVARCHAR(n)
Code language: SQL (Structured Query Language) (sql)
In this syntax, n defines the string length that ranges from 1 to 4,000. If you don’t specify the string length, its default value is 1.

Another way to declare a NVARCHAR column is to use the following syntax:

NVARCHAR(max)
Code language: SQL (Structured Query Language) (sql)
In this syntax, max is the maximum storage size in bytes which is 2^31-1 bytes (2 GB).

In general, the actual storage size in bytes of a NVARCHAR value is two times the number of characters entered plus 2 bytes.

The ISO synonyms of NVARCHAR are NATIONAL CHAR VARYING or NATIONAL CHARACTER VARYING, so you can use them interchangeably in the variable declaration or column data definition.

VARCHAR vs. NVARCHAR 
The following table illustrates the main differences between VARCHAR and NVARCHAR data types:

VARCHAR

NVARCHAR
Character Data Type	Variable-length, non-Unicode characters	Variable-length, both Unicode and non-Unicode characters such as Japanese, Korean, and Chinese.
Maximum Length	Up to 8,000 characters	Up to 4,000 characters
Character Size	Takes up 1 byte per character	Takes up 2 bytes per Unicode/Non-Unicode character
Storage Size	Actual Length (in bytes)	2 times Actual Length (in bytes)
Usage	Used when data length is variable or variable length columns and if actual data is always way less than capacity	Due to storage only, used only if you need Unicode support such as the Japanese Kanji or Korean Hangul characters.
SQL Server NVARCHAR example 
The following statement creates a new table that contains one NVARCHAR column:

CREATE TABLE test.sql_server_nvarchar (
    val NVARCHAR NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
In this example, the string length of the NVARCHAR column is one by default.

To change the string length of the  val column, you use the ALTER TABLE ALTER COLUMN statement:

ALTER TABLE test.sql_server_Nvarchar 
ALTER COLUMN val NVARCHAR (10) NOT NULL;
Code language: SQL (Structured Query Language) (sql)
The following statement inserts a new string into the  val column of the test.sql_server_nvarchar table:

INSERT INTO test.sql_server_varchar (val)
VALUES
    (N'こんにちは');
Code language: SQL (Structured Query Language) (sql)
The statement worked as expected because the string value has a length that is less than to the string length defined in the column definition.

The following statement attempts to insert a new string data whose length is greater than the string length of the  val column:

INSERT INTO test.sql_server_nvarchar (val)
VALUES
    (N'ありがとうございました');
Code language: SQL (Structured Query Language) (sql)
SQL Server issued an error and terminated the statement:

String or binary data would be truncated.
The statement has been terminated.
Code language: SQL (Structured Query Language) (sql)
To find the number of characters and the storage size in bytes of the values stored in the NVARCHAR column, you use the LEN and DATALENGTH functions as follows:

SELECT
    val,
    LEN(val) len,
    DATALENGTH(val) data_length
FROM
    test.sql_server_nvarchar;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server NVARCHAR data type to store variable-length, Unicode data in the database.

Was this tutorial helpful? 


SQL Server DATETIME2
Summary: in this tutorial, you will learn how to use the SQL Server DATETIME2 to store both date and time data in a table.

Introduction to SQL Server DATETIME2 
To store both date and time in the database, you use the SQL Server DATETIME2 data type.

The syntax of DATETIME2 is as follows:

DATETIME2(fractional seconds precision)
Code language: SQL (Structured Query Language) (sql)
The fractional seconds precision is optional. It ranges from 0 to 7.

The following statement illustrates how to create a table that consists of a DATETIME2 column:

CREATE TABLE table_name (
    ...
    column_name DATETIME2(3),
    ...
);
Code language: SQL (Structured Query Language) (sql)
The DATETIME2 has two components: date and time.

The date has a range from January 01, 01 (0001-01-01) to December 31, 9999 (9999-12-31)
The time has a range from 00:00:00 to 23:59:59.9999999.
The storage size of a DATETIME2 value depends on the fractional seconds precision. It requires 6 bytes for the precision that is less than 3, 7 bytes for the precision that is between 3 and 4, and 8 bytes for all other precisions.

The default string literal format of the DATETIME2 is as follows:

YYYY-MM-DD hh:mm:ss[.fractional seconds]
Code language: SQL (Structured Query Language) (sql)
In this format:

YYYY is a four-digit number that represents a year e.g., 2018. It ranges from 0001 through 9999.
MM is a two-digit number that represents a month in a year e.g., 12. It ranges from 01 to 12.
DD is a two-digit number that represents a day of a specified month e.g., 23. It ranges from 01 to 31.
hh is a two-digit number that represents the hour. It ranges from 00 to 23.
mm is a two-digit number that represents the minute. It ranges from 00 to 59.
ss is a two-digit number that represents the second. It ranges from 00 to 59.
The fractional seconds is zero to a seven-digit number that ranges from 0 to 9999999.
SQL Server DATETIME2 example 
The following statement creates a new table that has a created_at column whose data type is DATETIME2:

CREATE TABLE production.product_colors (
    color_id INT PRIMARY KEY IDENTITY,
    color_name VARCHAR (50) NOT NULL,
    created_at DATETIME2
);
Code language: SQL (Structured Query Language) (sql)
To insert the current date and time into the created_at column, you use the following INSERT statement with the GETDATE() function:

INSERT INTO production.product_colors (color_name, created_at)
VALUES
    ('Red', GETDATE()); 
Code language: SQL (Structured Query Language) (sql)
The GETDATE() function is similar to the NOW() function in other database systems such as MySQL

To insert a literal value into the DATETIME2 column, you use the following statement:

INSERT INTO production.product_colors (color_name, created_at)
VALUES
    ('Green', '2018-06-23 07:30:20');
Code language: SQL (Structured Query Language) (sql)
If you want to set the default value of the created_at column to the current date and time, you use the following ALTER TABLE statement:

ALTER TABLE production.product_colors 
ADD CONSTRAINT df_current_time 
DEFAULT CURRENT_TIMESTAMP FOR created_at;
Code language: SQL (Structured Query Language) (sql)
In this statement, we use CURRENT_TIMESTAMP as the default value for the created_at column. Note that the CURRENT_TIMESTAMP returns the same value as the GETDATE() function.

Now, when you insert a new row to the table without specifying the value for the created_at column, SQL Server will use the current date and time value for that column:

INSERT INTO production.product_colors (color_name)
VALUES
    ('Blue');
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server DATETIME2 data type to store both date and time data in a table.

Was this tutorial helpful?
SQL Server DATE
Summary: in this tutorial, you will learn how to use the SQL Server DATE to store date data in a table.

Introduction to SQL Server DATE 
To store the date data in the database, you use the SQL Server DATE data type. The syntax of DATE is as follows:

DATE
Code language: SQL (Structured Query Language) (sql)
Unlike the DATETIME2 data type, the DATE data type has only the date component. The range of a DATE value is from January 1, 1 CE (0001-01-01) through December 31, 9999 CE (9999-12-31).

It takes 3 bytes to store a DATE value. The default literal string format of a DATE value is as follows:

YYYY-MM-DD
Code language: SQL (Structured Query Language) (sql)
In this format:

YYYY is four digits that represent a year, which ranges from 0001 to 9999.
MM is two digits that represent a month of a year, which ranges from 01 to 12.
DD is two digits that represent a day of the specified month, which ranges from 01 to 31, depending on the month.
SQL Server DATE examples 
A) Query data from a table based on DATE values 
Let’s see the sales.orders table from the sample database:


The following example returns all orders whose ordered date is earlier than January 05 2016:

SELECT    
	order_id, 
	customer_id, 
	order_status, 
	order_date
FROM    
	sales.orders
WHERE order_date < '2016-01-05'
ORDER BY 
	order_date DESC;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Date Example
B) Using DATE to define the table columns example 
The following statement creates a table named sales.list_prices that has two DATE columns:

CREATE TABLE sales.list_prices (
    product_id INT NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,
    amount DEC (10, 2) NOT NULL,
    PRIMARY KEY (
        product_id,
        valid_from,
        valid_to
    ),
    FOREIGN KEY (product_id) 
      REFERENCES production.products (product_id)
);
Code language: SQL (Structured Query Language) (sql)
The following INSERT statement illustrates how to insert a row with literal date values into the table:

INSERT INTO sales.list_prices (
    product_id,
    valid_from,
    valid_to,
    amount
)
VALUES
    (
        1,
        '2019-01-01',
        '2019-12-31',
        400
    );
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server DATE data type to store date data in a table.

Was this tutorial helpful?


SQL Server TIME
Summary: in this tutorial, you will learn how to store the time of a day in the database by using SQL Server TIME data type.

Introduction to SQL Server TIME data type 
The SQL Server TIME data type defines a time of a day based on 24-hour clock. The syntax of the TIME data type is as follows:

TIME[ (fractional second scale) ]
Code language: SQL (Structured Query Language) (sql)
The fractional second scale specifies the number of digits for the fractional part of the seconds. The fractional second scale ranges from 0 to 7. By default, the fractional second scale is 7 if you don’t explicitly specify it.

The following example illustrates how to create a table with a TIME column:

CREATE TABLE table_name(
    ...,
    start_at TIME(0),
    ...
);
Code language: SQL (Structured Query Language) (sql)
The default literal format for a TIME value is

hh:mm:ss[.nnnnnnn]
Code language: SQL (Structured Query Language) (sql)
In this format:

hh is two digits that represent the hour with a range from 0 to 23.
mm is two digits that represent the minute with a range from 0 to 59.
ss is two digits that represent the second with the range from 0 to 59.
The fractional seconds part can be zero to seven digits that has a range from 0 to 9999999.
A time value with the default of 100ms fractional second precision requires 5 bytes storage.

Note that the TIME data type is not the time zone-awareness.

SQL Server TIME data type example 
The following statement creates a table named sales.visits with two TIME columns that record the visit time of the customers to a particular store:

CREATE TABLE sales.visits (
    visit_id INT PRIMARY KEY IDENTITY,
    customer_name VARCHAR (50) NOT NULL,
    phone VARCHAR (25),
    store_id INT NOT NULL,
    visit_on DATE NOT NULL,
    start_at TIME (0) NOT NULL,
    end_at TIME (0) NOT NULL,
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
);
Code language: SQL (Structured Query Language) (sql)
The following INSERT statement adds a row to the sales.visits table:

INSERT INTO sales.visits (
    customer_name,
    phone,
    store_id,
    visit_on,
    start_at,
    end_at
)
VALUES
    (
        'John Doe',
        '(408)-993-3853',
        1,
        '2018-06-23',
        '09:10:00',
        '09:30:00'
    );
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server TIME data type to store time values in a table.

Was this tutorial helpful?

SQL Server DATETIMEOFFSET
Summary: in this tutorial, you will learn how to use the SQL Server DATETIMEOFFSET data type to manipulate datetime with time zone.

Introduction to DATETIMEOFFSET data type 
The DATETIMEOFFSET allows you to manipulate any single point in time, which is a datetime value, along with an offset that specifies how much that datetime differs from UTC.

DATETIMEOFFSET syntax 
The syntax of the DATETIMEOFFSET is as follows:

DATETIMEOFFSET [ (fractional seconds precision) ]
Code language: SQL (Structured Query Language) (sql)
To declare a DATETIMEOFFSET variable, you use the following syntax:

DECLARE @dt DATETIMEOFFSET(7)
Code language: SQL (Structured Query Language) (sql)
To create a table column whose data type is DATETIMEOFFSET, you use the following form:

CREATE TABLE table_name (
    ...,
    column_name DATETIMEOFFSET(7)
    ...
);
Code language: SQL (Structured Query Language) (sql)
The DATETIMEOFFSET has a range from January 1, 1 CE to December 31, 999 CE. The time ranges from 00:00:00 through 23:59:59.9999999.

Literal formats 
The literal formats of DATETIMEOFFSET is as follows:

YYYY-MM-DDThh:mm:ss[.nnnnnnn][{+|-}hh:mm]
Code language: SQL (Structured Query Language) (sql)
For example:

2020-12-12 11:30:30.12345 
Code language: SQL (Structured Query Language) (sql)
or by ISO

YYYY-MM-DDThh:mm:ss[.nnnnnnn]Z
Code language: SQL (Structured Query Language) (sql)
For example:

2020-12-12 19:30:30.12345Z.
Code language: SQL (Structured Query Language) (sql)
Time zone offset 
For a datetime or time value, a time zone offset specifies the zone offset from UTC. A time zone offset is represented as [+|-] hh:mm:

hh is two digits that range from 00 to 14, which represents the number of hour in the time zone offset.
mm is two digits that range from 00 to 59, which represents the number of additional minutes in the time zone offset.
+(plus) or -(minus) specifies whether the time zone offset is added or subtracted from the UTC time to return the local time.
The valid range of a time zone offset is -14:00 to +14:00

DATETIMEOFFSET examples 
First, create a table named messages, which has a DATETIMEOFFSET column:

CREATE TABLE messages(
    id         INT PRIMARY KEY IDENTITY, 
    message    VARCHAR(255) NOT NULL, 
    created_at DATETIMEOFFSET NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Second, insert a new row with a DATETIMEOFFSET value into the messages table:

INSERT INTO messages(message,created_at)
VALUES('DATETIMEOFFSET demo',
        CAST('2019-02-28 01:45:00.0000000 -08:00' AS DATETIMEOFFSET));
Code language: SQL (Structured Query Language) (sql)
Third, query data from the messages table and use the AT TIME ZONE to convert the stored DATETIMEOFFSET value to  'SE Asia Standard Time' timezone.

SELECT 
    id, 
    message, 
	created_at 
        AS 'Pacific Standard Time'
    created_at AT TIME ZONE 'SE Asia Standard Time' 
        AS 'SE Asia Standard Time',
FROM 
    messages;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server DATETIMEOFFSET Example
In this tutorial, you have learned how to use the DATETIMEOFFSET data type to manipulate the DATETIMEOFFSET value.



SQL Server GUID
Summary: in this tutorial, you will learn about the SQL Server GUID and how to use the NEWID() function to generate GUID values.

Introduction to SQL Server GUID 
All things in our world are numbered e.g., books have ISBNs, cars have VINs, and people have social security numbers (SSN).

The numbers, or identifiers, help us reference things unambiguously. For example, we can identify John Doe by using his unique social security number 123-45-6789.

A globally unique identifier or GUID is a broader version of this type of ID numbers.

A GUID is guaranteed to be unique across tables, databases, and even servers.

In SQL Server, GUID is 16-byte binary data type, which is generated by using the NEWID() function:

SELECT 
    NEWID() AS GUID;
Code language: SQL (Structured Query Language) (sql)
If you execute the above statement several times, you will see different value every time. Here is one of them:

GUID
------------------------------------
3297F0F2-35D3-4231-919D-1CFCF4035975

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
In SQL Server, the UNIQUEIDENTIFIER data type holds GUID values.

The following statements declare a variable with type UNIQUEIDENTIFIER and assign it a GUID value generated by the NEWID() function.

DECLARE 
    @id UNIQUEIDENTIFIER;

SET @id = NEWID();

SELECT 
    @id AS GUID;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

GUID
------------------------------------
69AA3BA5-D51E-465E-8447-ECAA1939739A

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Using SQL Server GUID as primary key 
Sometimes, it prefers using GUID values for the primary key column of a table than using integers.

Using GUID as the primary key of a table brings the following advantages:

GUID values are globally unique across tables, databases, and even servers. Therefore, it allows you to merge data from different servers with ease.
GUID values do not expose the information so they are safer to use in public interface such as a URL. For example, if you have the URL https://www.example.com/customer/100/ URL, it is not so difficult to find that there will have customers with id 101, 102, and so on. However, with GUID, it is not possible: https://www.example.com/customer/F4AB02B7-9D55-483D-9081-CC4E3851E851/
Besides these advantages, storing GUID in the primary key column of a table has the following disadvantages:

GUID values (16 bytes) takes more storage than INT (4 bytes) or even BIGINT(8 bytes)
GUID values make it difficult to troubleshoot and debug, comparing WHERE id = 100 with WHERE id = 'F4AB02B7-9D55-483D-9081-CC4E3851E851'.
SQL Server GUID example 
First, create a new table named customers in the marketing schema:

CREATE SCHEMA marketing;
GO

CREATE TABLE marketing.customers(
    customer_id UNIQUEIDENTIFIER DEFAULT NEWID(),
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email VARCHAR(200) NOT NULL
);
GO
Code language: SQL (Structured Query Language) (sql)
Second, insert new rows into the marketing.customers table:

INSERT INTO 
    marketing.customers(first_name, last_name, email)
VALUES
    ('John','Doe','john.doe@example.com'),
    ('Jane','Doe','jane.doe@example.com');
Code language: SQL (Structured Query Language) (sql)
Third, query data from the marketing.customers table:

SELECT 
    customer_id, 
    first_name, 
    last_name, 
    email
FROM 
    marketing.customers;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server GUID example
In this tutorial, you have learned about the SQL Server GUID and how to use the NEWID() function to generate GUID values.

Was this tutorial helpful? 


SQL Server PRIMARY KEY
Summary: in this tutorial, you will learn how to use the SQL Server PRIMARY KEY constraint to create a primary key for a table.

Introduction to SQL Server PRIMARY KEY constraint 
A primary key is a column or a group of columns that uniquely identifies each row in a table. You create a primary key for a table by using the PRIMARY KEY constraint.

If the primary key consists of only one column, you can define use PRIMARY KEY constraint as a column constraint:

CREATE TABLE table_name (
    pk_column data_type PRIMARY KEY,
    ...
);
Code language: SQL (Structured Query Language) (sql)
In case the primary key has two or more columns, you must use the PRIMARY KEY constraint as a table constraint:

CREATE TABLE table_name (
    pk_column_1 data_type,
    pk_column_2 data type,
    ...
    PRIMARY KEY (pk_column_1, pk_column_2)
);
Code language: SQL (Structured Query Language) (sql)
Each table can contain only one primary key. All columns that participate in the primary key must be defined as NOT NULL. SQL Server automatically sets the NOT NULL constraint for all the primary key columns if the NOT NULL constraint is not specified for these columns.

SQL Server also automatically creates a unique clustered index (or a non-clustered index if specified as such) when you create a primary key.

SQL Server PRIMARY KEY constraint examples 
The following example creates a table with a primary key that consists of one column:

CREATE TABLE sales.activities (
    activity_id INT PRIMARY KEY IDENTITY,
    activity_name VARCHAR (255) NOT NULL,
    activity_date DATE NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
In this sales.activities table, the activity_id column is the primary key column. It means the activity_id column contains unique values.

The IDENTITY property is used for the activity_id column to automatically generate unique integer values.

The following statement creates a new table named sales.participants whose primary key consists of two columns:

CREATE TABLE sales.participants(
    activity_id int,
    customer_id int,
    PRIMARY KEY(activity_id, customer_id)
);
Code language: SQL (Structured Query Language) (sql)
In this example, the values in either activity_id or customer_id column can be duplicate, but each combination of values from both columns must be unique.

Typically, a table always has a primary key defined at the time of creation. However, sometimes, an existing table may not have a primary key defined. In this case, you can add a primary key to the table by using the ALTER TABLE statement. Consider the following example:

The following statement creates a table without a primary key:

CREATE TABLE sales.events(
    event_id INT NOT NULL,
    event_name VARCHAR(255),
    start_date DATE NOT NULL,
    duration DEC(5,2)
);
Code language: SQL (Structured Query Language) (sql)
To make the event_id column as the primary key, you use the following ALTER TABLE statement:

ALTER TABLE sales.events 
ADD PRIMARY KEY(event_id);
Code language: SQL (Structured Query Language) (sql)
Note that if the sales.events table already has data, before promoting the event_id column as the primary key, you must ensure that the values in the event_id are unique.

In this tutorial, you have learned how to use the SQL Server PRIMARY KEY constraint to create a primary key for a table.

Was this tutorial helpful?

SQL Server FOREIGN KEY
Summary: In this tutorial, you will learn how to use the SQL Server foreign key constraint to enforce a link between the data in two tables.

Introduction to the SQL Server foreign key constraint 
Consider the following vendor_groups and vendors tables:

CREATE TABLE procurement.vendor_groups (
    group_id INT IDENTITY PRIMARY KEY,
    group_name VARCHAR (100) NOT NULL
);

CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
);
Code language: SQL (Structured Query Language) (sql)
Each vendor belongs to a vendor group and each vendor group may have zero or more vendors. The relationship between the vendor_groups and vendors tables is one-to-many.

For each row in the  vendors table, you can always find a corresponding row in the vendor_groups table.

However, with the current tables setup, you can insert a row into the  vendors table without a corresponding row in the vendor_groups table. Similarly, you can also delete a row in the vendor_groups table without updating or deleting the corresponding rows in the  vendors table that results in orphaned rows in the  vendors table.

To enforce the link between data in the vendor_groups and vendors tables, you need to establish a foreign key in the vendors table.

A foreign key is a column or a group of columns in one table that uniquely identifies a row of another table (or the same table in case of self-reference).

To create a foreign key, you use the FOREIGN KEY constraint.

The following statements drop the  vendors table and recreate it with a FOREIGN KEY constraint:

DROP TABLE vendors;

CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
        CONSTRAINT fk_group FOREIGN KEY (group_id) 
        REFERENCES procurement.vendor_groups(group_id)
);
Code language: SQL (Structured Query Language) (sql)
The vendor_groups table now is called the parent table that is the table to which the foreign key constraint references. The vendors table is called the child table that is the table to which the foreign key constraint is applied.

In the statement above, the following clause creates a FOREIGN KEY constraint named fk_group that links the group_id in the  vendors table to the group_id in the vendor_groups table:

CONSTRAINT fk_group FOREIGN KEY (group_id) REFERENCES procurement.vendor_groups(group_id)
Code language: SQL (Structured Query Language) (sql)
SQL Server FOREIGN KEY constraint syntax 
The general syntax for creating a FOREIGN KEY constraint is as follows:

CONSTRAINT fk_constraint_name 
FOREIGN KEY (column_1, column2,...)
REFERENCES parent_table_name(column1,column2,..)
Code language: SQL (Structured Query Language) (sql)
Let’s examine this syntax in detail.

First, specify the FOREIGN KEY constraint name after the CONSTRAINT keyword. The constraint name is optional therefore it is possible to define a FOREIGN KEY constraint as follows:

FOREIGN KEY (column_1, column2,...)
REFERENCES parent_table_name(column1,column2,..)
Code language: SQL (Structured Query Language) (sql)
In this case, SQL Server will automatically generate a name for the FOREIGN KEY constraint.

Second, specify a list of comma-separated foreign key columns enclosed by parentheses after the FOREIGN KEY keyword.

Third, specify the name of the parent table to which the foreign key references and a list of comma-separated columns that has a link with the column in the child table.

SQL Server FOREIGN KEY constraint example 
First, insert some rows into the vendor_groups table:

INSERT INTO procurement.vendor_groups(group_name)
VALUES('Third-Party Vendors'),
      ('Interco Vendors'),
      ('One-time Vendors');
Code language: SQL (Structured Query Language) (sql)
Second, insert a new vendor with a vendor group into the  vendors table:

INSERT INTO procurement.vendors(vendor_name, group_id)
VALUES('ABC Corp',1);
Code language: SQL (Structured Query Language) (sql)
The statement worked as expected.

Third, try to insert a new vendor whose vendor group does not exist in the vendor_groups table:

INSERT INTO procurement.vendors(vendor_name, group_id)
VALUES('XYZ Corp',4);
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following error:

The INSERT statement conflicted with the FOREIGN KEY constraint "fk_group". The conflict occurred in database "BikeStores", table "procurement.vendor_groups", column 'group_id'.
Code language: SQL (Structured Query Language) (sql)
In this example, because of the FOREIGN KEY constraint, SQL Server rejected the insert and issued an error.

Referential actions 
The foreign key constraint ensures referential integrity. It means that you can only insert a row into the child table if there is a corresponding row in the parent table.

Besides, the foreign key constraint allows you to define the referential actions when the row in the parent table is updated or deleted as follows:

FOREIGN KEY (foreign_key_columns)
    REFERENCES parent_table(parent_key_columns)
    ON UPDATE action 
    ON DELETE action;
Code language: SQL (Structured Query Language) (sql)
The ON UPDATE and ON DELETE specify which action will execute when a row in the parent table is updated and deleted. The following are permitted actions : NO ACTION, CASCADE, SET NULL, and SET DEFAULT

Delete actions of rows in the parent table 
If you delete one or more rows in the parent table, you can set one of the following actions:

ON DELETE NO ACTION: SQL Server raises an error and rolls back the delete action on the row in the parent table.
ON DELETE CASCADE: SQL Server deletes the rows in the child table that is corresponding to the row deleted from the parent table.
ON DELETE SET NULL: SQL Server sets the rows in the child table to NULL if the corresponding rows in the parent table are deleted. To execute this action, the foreign key columns must be nullable.
ON DELETE SET DEFAULT SQL Server sets the rows in the child table to their default values if the corresponding rows in the parent table are deleted. To execute this action, the foreign key columns must have default definitions. Note that a nullable column has a default value of NULL if no default value specified.
By default, SQL Server appliesON DELETE NO ACTION if you don’t explicitly specify any action.

Update action of rows in the parent table 
If you update one or more rows in the parent table, you can set one of the following actions:

ON UPDATE NO ACTION: SQL Server raises an error and rolls back the update action on the row in the parent table.
ON UPDATE CASCADE: SQL Server updates the corresponding rows in the child table when the rows in the parent table are updated.
ON UPDATE SET NULL: SQL Server sets the rows in the child table to NULL when the corresponding row in the parent table is updated. Note that the foreign key columns must be nullable for this action to execute.
ON UPDATE SET DEFAULT: SQL Server sets the default values for the rows in the child table that have the corresponding rows in the parent table updated.
In this tutorial, you have learned how to use the SQL Server foreign key constraint to enforce the referential integrity between tables.

Was this tutorial helpful?

SQL Server NOT NULL Constraint
Summary: in this tutorial, you will learn how to use the SQL Server NOT NULL constraint to ensure data contained in a column is not NULL.

Introduction to SQL Server NOT NULL constraint 
The SQL Server NOT NULL constraints simply specify that a column must not assume the NULL.

The following example creates a table with NOT NULL constraints for the columns: first_name, last_name, and email:

CREATE SCHEMA hr;
GO

CREATE TABLE hr.persons(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20)
);
Code language: SQL (Structured Query Language) (sql)
Note that the NOT NULL constraints are always written as column constraints.

By default, if you don’t specify the NOT NULL constraint, SQL Server will allow the column to accepts NULL. In this example, the phone column can accept NULL.

Add NOT NULL constraint to an existing column 
To add the NOT NULL constraint to an existing column, you follow these steps:

First, update the table so there is no NULL in the column:

UPDATE table_name
SET column_name = <value>
WHERE column_name IS NULL;
Code language: SQL (Structured Query Language) (sql)
Second, alter the table to change the property of the column:

ALTER TABLE table_name
ALTER COLUMN column_name data_type NOT NULL;
Code language: SQL (Structured Query Language) (sql)
For example, to add the NOT NULL constraint to the phone column of the hr.persons table, you use the following statements:

First, if a person does not have a phone number, then update the phone number to the company phone number e.g., (408) 123 4567:

UPDATE hr.persons
SET phone = "(408) 123 4567"
WHER phone IS NULL;
Code language: SQL (Structured Query Language) (sql)
Second, modify the property of the phone column:

ALTER TABLE hr.persons
ALTER COLUMN phone VARCHAR(20) NOT NULL;
Code language: SQL (Structured Query Language) (sql)
Removing NOT NULL constraint 
To remove the NOT NULL constraint from a column, you use the ALTER TABLE ALTER COLUMN statement as follows:

ALTER TABLE table_name
ALTER COLUMN column_name data_type NULL;
Code language: SQL (Structured Query Language) (sql)
For example, to remove the NOT NULL constraint from the phone column, you use the following statement:

ALTER TABLE hr.pesons
ALTER COLUMN phone VARCHAR(20) NULL;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server NOT NULL constraint to enforce a column not accept NULL.

Was this tutorial helpful?

SQL Server UNIQUE Constraint
Summary: in this tutorial, you will learn how to use the SQL Server UNIQUE constraint to ensure the uniqueness of data contained in a column or a group of columns.

Introduction to SQL Server UNIQUE constraint 
SQL Server UNIQUE constraints allow you to ensure that the data stored in a column, or a group of columns, is unique among the rows in a table.

The following statement creates a table whose data in the email column is unique among the rows in the hr.persons table:

CREATE SCHEMA hr;
GO

CREATE TABLE hr.persons(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE
);
Code language: SQL (Structured Query Language) (sql)
In this syntax, you define the UNIQUE constraint as a column constraint. You can also define the UNIQUE constraint as a table constraint, like this:

CREATE TABLE hr.persons(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE(email)
);
Code language: SQL (Structured Query Language) (sql)
Behind the scenes, SQL Server automatically creates a UNIQUE index to enforce the uniqueness of data stored in the columns that participate in the UNIQUE constraint. Therefore, if you attempt to insert a duplicate row, SQL Server rejects the change and returns an error message stating that the UNIQUE constraint has been violated.

The following statement inserts a new row into the hr.persons table:

INSERT INTO hr.persons(first_name, last_name, email)
VALUES('John','Doe','j.doe@bike.stores');
Code language: SQL (Structured Query Language) (sql)
The statement works as expected. However, the following statement fails due to the duplicate email:

INSERT INTO hr.persons(first_name, last_name, email)
VALUES('Jane','Doe','j.doe@bike.stores');
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following error message:

Violation of UNIQUE KEY constraint 'UQ__persons__AB6E616417240E4E'. Cannot insert duplicate key in object 'hr.persons'. The duplicate key value is (j.doe@bike.stores).
Code language: Shell Session (shell)
If you don’t specify a separate name for the UNIQUE constraint, SQL Server will automatically generate a name for it. In this example, the constraint name is UQ__persons__AB6E616417240E4E, which is not quite readable.

To assign a particular name to a UNIQUE constraint, you use the CONSTRAINT keyword as follows:

CREATE TABLE hr.persons (
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    CONSTRAINT unique_email UNIQUE(email)
);
Code language: SQL (Structured Query Language) (sql)
The following are the benefits of assigning a UNIQUE constraint a specific name:

It easier to classify the error message.
You can reference the constraint name when you want to modify it.
UNIQUE constraint vs. PRIMARY KEY constraint 
Although both UNIQUE and PRIMARY KEY constraints enforce the uniqueness of data, you should use the UNIQUE constraint instead of PRIMARY KEY constraint when you want to enforce the uniqueness of a column, or a group of columns, that are not the primary key columns.

Different from PRIMARY KEY constraints, UNIQUE constraints allow NULL. Moreover, UNIQUE constraints treat the NULL as a regular value, therefore, it only allows one NULL per column.

The following statement inserts a row whose value in the email column is NULL:

INSERT INTO hr.persons(first_name, last_name)
VALUES('John','Smith');
Code language: SQL (Structured Query Language) (sql)
Now, if you try to insert one more NULL into the email column, you will get an error:

INSERT INTO hr.persons(first_name, last_name)
VALUES('Lily','Bush');
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Violation of UNIQUE KEY constraint 'UQ__persons__AB6E616417240E4E'. Cannot insert duplicate key in object 'hr.persons'. The duplicate key value is (<NULL>).
Code language: SQL (Structured Query Language) (sql)
UNIQUE constraints for a group of columns 
To define a UNIQUE constraint for a group of columns, you write it as a table constraint with column names separated by commas as follows:

CREATE TABLE table_name (
    key_column data_type PRIMARY KEY,
    column1 data_type,
    column2 data_type,
    column3 data_type,
    ...,
    UNIQUE (column1,column2)
);
Code language: SQL (Structured Query Language) (sql)
The following example creates a UNIQUE constraint that consists of two columns person_id and skill_id:

CREATE TABLE hr.person_skills (
    id INT IDENTITY PRIMARY KEY,
    person_id int,
    skill_id int,
    updated_at DATETIME,
    UNIQUE (person_id, skill_id)
);
Code language: SQL (Structured Query Language) (sql)
Add UNIQUE constraints to existing columns 
When you add a UNIQUE constraint to an existing column or a group of columns in a table, SQL Server first examines the existing data in these columns to ensure that all values are unique. If SQL Server finds the duplicate values, then it returns an error and does not add the UNIQUE constraint.

The following shows the syntax of adding a UNIQUE constraint to a table:

ALTER TABLE table_name
ADD CONSTRAINT constraint_name 
UNIQUE(column1, column2,...);
Code language: SQL (Structured Query Language) (sql)
Suppose you have the following hr.persons table:

CREATE TABLE hr.persons (
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
);  
Code language: SQL (Structured Query Language) (sql)
The following statement adds a UNIQUE constraint to the email column:

ALTER TABLE hr.persons
ADD CONSTRAINT unique_email UNIQUE(email);
Code language: SQL (Structured Query Language) (sql)
Similarly, the following statement adds a UNIQUE constraint to the phone column:

ALTER TABLE hr.persons
ADD CONSTRAINT unique_phone UNIQUE(phone); 
Code language: SQL (Structured Query Language) (sql)
Delete UNIQUE constraints 
To define a UNIQUE constraint, you use the ALTER TABLE DROP CONSTRAINT statement as follows:

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
Code language: SQL (Structured Query Language) (sql)
The following statement removes the unique_phone constraint from the hr.person table:

ALTER TABLE hr.persons
DROP CONSTRAINT unique_phone;
Code language: SQL (Structured Query Language) (sql)
Modify UNIQUE constraints 
SQL Server does not have any direct statement to modify a UNIQUE constraint, therefore, you need to drop the constraint first and recreate it if you want to change the constraint.

In this tutorial, you have learned how to use the SQL Server UNIQUE constraint to make sure that the data contained in a column or a group of columns is unique.

Was this tutorial helpful?

SQL Server CHECK Constraint
Summary: in this tutorial, you will learn how to use the SQL Server CHECK constraint to enforce domain integrity.

Introduction to SQL Server CHECK constraint 
The CHECK constraint allows you to specify the values in a column that must satisfy a Boolean expression.

For example, to require positive unit prices, you can use:

CREATE SCHEMA test;
GO

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) CHECK(unit_price > 0)
);
Code language: SQL (Structured Query Language) (sql)
As you can see, the CHECK constraint definition comes after the data type. It consists of the keyword CHECK followed by a logical expression in parentheses:

CHECK(unit_price > 0)
Code language: SQL (Structured Query Language) (sql)
You can also assign the constraint a separate name by using the CONSTRAINT keyword as follows:

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) CONSTRAINT positive_price CHECK(unit_price > 0)
);
Code language: SQL (Structured Query Language) (sql)
The explicit names help classify the error messages and allow you to refer to the constraints when you want to modify them.

If you don’t specify a constraint name this way, SQL Server automatically generates a name for you.

See the following insert statement:

INSERT INTO test.products(product_name, unit_price)
VALUES ('Awesome Free Bike', 0);
Code language: SQL (Structured Query Language) (sql)
SQL Server issued the following error:

The INSERT statement conflicted with the CHECK constraint "positive_price". The conflict occurred in database "BikeStores", table "test.products", column 'unit_price'.
Code language: SQL (Structured Query Language) (sql)
The error occurred because the unit price is not greater than zero as specified in the CHECK constraint.

The following statement works fine because the logical expression defined in the CHECK constraint evaluates to TRUE:

INSERT INTO test.products(product_name, unit_price)
VALUES ('Awesome Bike', 599);
Code language: SQL (Structured Query Language) (sql)
SQL Server CHECK constraint and NULL 
The CHECK constraints reject values that cause the Boolean expression evaluates to FALSE.

Because NULL evaluates to UNKNOWN, it can be used in the expression to bypass a constraint.

For example, you can insert a product whose unit price is NULL as shown in the following query:

INSERT INTO test.products(product_name, unit_price)
VALUES ('Another Awesome Bike', NULL);
Code language: SQL (Structured Query Language) (sql)
Here is the output:

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
SQL Server inserted NULL into the unit_price column and did not return an error.

To fix this, you need to use a NOT NULL constraint for the unit_price column.

CHECK constraint referring to multiple columns 
A CHECK constraint can refer to multiple columns. For instance, you store a regular and discounted prices in the  test.products table and you want to ensure that the discounted price is always lower than the regular price:

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) CHECK(unit_price > 0),
    discounted_price DEC(10,2) CHECK(discounted_price > 0),
    CHECK(discounted_price < unit_price)
);
Code language: SQL (Structured Query Language) (sql)
The first two constraints for unit_price and discounted_price should look familiar.

The third constraint uses a new syntax which is not attached to a particular column. Instead, it appears as a separate line item in the comma-separated column list.

The first two column constraints are column constraints, whereas the third one is a table constraint.

Note that you can write column constraints as table constraints. However, you cannot write table constraints as column constraints. For example, you can rewrite the above statement as follows:

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2),
    discounted_price DEC(10,2),
    CHECK(unit_price > 0),
    CHECK(discounted_price > 0),
    CHECK(discounted_price > unit_price)
);
Code language: SQL (Structured Query Language) (sql)
or even:

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2),
    discounted_price DEC(10,2),
    CHECK(unit_price > 0),
    CHECK(discounted_price > 0 AND discounted_price > unit_price)
);
Code language: SQL (Structured Query Language) (sql)
You can also assign a name to a table constraint in the same way as a column constraint:

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2),
    discounted_price DEC(10,2),
    CHECK(unit_price > 0),
    CHECK(discounted_price > 0),
    CONSTRAINT valid_prices CHECK(discounted_price > unit_price)
);
Code language: SQL (Structured Query Language) (sql)
Add CHECK constraints to an existing table 
To add a CHECK constraint to an existing table, you use the ALTER TABLE ADD CONSTRAINT statement.

Suppose you have the following test.products table:

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
To add a CHECK constraint to the test.products table, you use the following statement:

ALTER TABLE test.products
ADD CONSTRAINT positive_price CHECK(unit_price > 0);
Code language: SQL (Structured Query Language) (sql)
To add a new column with a CHECK constraint, you use the following statement:

ALTER TABLE test.products
ADD discounted_price DEC(10,2)
CHECK(discounted_price > 0);
Code language: SQL (Structured Query Language) (sql)
To add a CHECK constraint named valid_price, you use the following statement:

ALTER TABLE test.products
ADD CONSTRAINT valid_price 
CHECK(unit_price > discounted_price);
Code language: SQL (Structured Query Language) (sql)
Remove CHECK constraints 
To remove a CHECK constraint, you use the ALTER TABLE DROP CONSTRAINT statement:

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
Code language: SQL (Structured Query Language) (sql)
If you assign a CHECK constraint a specific name, you can refer the name in the statement.

However, in case you did not assign the CHECK constraint a particular name, then you need to find it using the following statement:

EXEC sp_help 'table_name';
Code language: SQL (Structured Query Language) (sql)
For example:

EXEC sp_help 'test.products';
Code language: SQL (Structured Query Language) (sql)
This statement issues a lot of information including constraint names:

SQL Server CHECK constraint example
The following statement drops the positive_price constraint:

ALTER TABLE test.products
DROP CONSTRAINT positive_price;
Code language: SQL (Structured Query Language) (sql)
Disable CHECK constraints for insert or update 
To disable a CHECK constraint for insert or update, you use the following statement:

ALTER TABLE table_name
NOCHECK CONSTRAINT constraint_name;
Code language: SQL (Structured Query Language) (sql)
The following statement disables the valid_price constraint:

ALTER TABLE test.products
NO CHECK CONSTRAINT valid_price;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server CHECK constraint to limit the values that can be inserted or updated to one or more columns in a table.

Was this tutorial helpful?

SQL Server CASE
Summary: in this tutorial, you will learn how to use the SQL Server CASE expression to add if-else logic to SQL queries.

SQL Server CASE expression evaluates a list of conditions and returns one of the multiple specified results. The CASE expression has two formats: simple CASE expression and searched CASE expression. Both of CASE expression formats support an optional ELSE statement.

Because CASE is an expression, you can use it in any clause that accepts an expression such as SELECT, WHERE, GROUP BY, and HAVING.

SQL Server simple CASE expression 
The following shows the syntax of the simple CASE expression:

CASE input   
    WHEN e1 THEN r1
    WHEN e2 THEN r2
    ...
    WHEN en THEN rn
    [ ELSE re ]   
END  
Code language: SQL (Structured Query Language) (sql)
The simple CASE expression compares the input expression (input) to an expression (ei) in each WHEN clause for equality. If the input expression equals an expression (ei) in the WHEN clause, the result (ri) in the corresponding THEN clause is returned.

If the input expression does not equal to any expression and the ELSE clause is available, the CASE expression will return the result in the ELSE clause (re).

In case the ELSE clause is omitted and the input expression does not equal to any expression in the WHEN clause, the CASE expression will return NULL.

A) Using simple CASE expression in the SELECT clause example 
See the following sales.orders table from the sample database:


This example uses the COUNT() function with the GROUP BY clause to return the number orders for each order’s status:

SELECT    
    order_status, 
    COUNT(order_id) order_count
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    order_status;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server CASE Expression - Order count by status
The values in the order_status column are numbers, which is not meaningful in this case. To make the output more understandable, you can use the simple CASE expression as shown in the following query:

SELECT    
    CASE order_status
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Processing'
        WHEN 3 THEN 'Rejected'
        WHEN 4 THEN 'Completed'
    END AS order_status, 
    COUNT(order_id) order_count
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    order_status;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server CASE Expression - Using Simple CASE in SELECT clause
B) Using simple CASE expression in aggregate function example 
See the following query:

SELECT    
    SUM(CASE
            WHEN order_status = 1
            THEN 1
            ELSE 0
        END) AS 'Pending', 
    SUM(CASE
            WHEN order_status = 2
            THEN 1
            ELSE 0
        END) AS 'Processing', 
    SUM(CASE
            WHEN order_status = 3
            THEN 1
            ELSE 0
        END) AS 'Rejected', 
    SUM(CASE
            WHEN order_status = 4
            THEN 1
            ELSE 0
        END) AS 'Completed', 
    COUNT(*) AS Total
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server CASE Expression in Aggregate Functions example
In this example:

First, the condition in the WHERE clause includes sales order in 2018.
Second, the CASE expression returns either 1 or 0 based on the order status.
Third, the SUM() function adds up the number of order for each order status.
Fourth, the COUNT() function returns the total orders.
SQL Server searched CASE expression 
The following shows the syntax of the searched CASE expression:

CASE  
    WHEN e1 THEN r1
    WHEN e2 THEN r2
    ...
    WHEN en THEN rn
    [ ELSE re ]   
END 
Code language: SQL (Structured Query Language) (sql)
In this syntax:

e1, e2, …ei, … en are Boolean expressions.
r1, r2, …ri,…, or rn is one of the possible results.
The searched CASE expression evaluates the Boolean expression in each WHEN clause in the specified order and returns the result (ri) if the Boolean expression (ei) evaluates to TRUE.

If no Boolean expression evaluates to TRUE, the searched CASE expression returns the result (re) in the ELSE clause or NULL if the ELSE clause is not specified.

A) Using searched CASE expression in the SELECT clause 
See the following sales.orders and sales.order_items from the sample database:

Sample Tables
The following statement uses the searched CASE expression to classify sales order by order value:

SELECT    
    o.order_id, 
    SUM(quantity * list_price) order_value,
    CASE
        WHEN SUM(quantity * list_price) <= 500 
            THEN 'Very Low'
        WHEN SUM(quantity * list_price) > 500 AND 
            SUM(quantity * list_price) <= 1000 
            THEN 'Low'
        WHEN SUM(quantity * list_price) > 1000 AND 
            SUM(quantity * list_price) <= 5000 
            THEN 'Medium'
        WHEN SUM(quantity * list_price) > 5000 AND 
            SUM(quantity * list_price) <= 10000 
            THEN 'High'
        WHEN SUM(quantity * list_price) > 10000 
            THEN 'Very High'
    END order_priority
FROM    
    sales.orders o
INNER JOIN sales.order_items i ON i.order_id = o.order_id
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    o.order_id;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial output:

SQL Server CASE Expression - Searched CASE Expression Example
In this tutorial, you will learn how to use the SQL Server CASE expression to add if-else logic to the SQL queries.

Was this tutorial helpful?


SQL Server COALESCE
Summary: in this tutorial, you will learn how to use the SQL Server COALESCE expression to deal with NULL in queries.

Introduction to SQL Server COALESCE expression 
The SQL Server COALESCE expression accepts a number of arguments, evaluates them in sequence, and returns the first non-null argument.

The following illustrates the syntax of the COALESCE expression:

COALESCE(e1,[e2,...,en])
Code language: SQL (Structured Query Language) (sql)
In this syntax, e1, e2, … en are scalar expressions that evaluate to scalar values. The COALESCE expression returns the first non-null expression. If all expressions evaluate to NULL, then the COALESCE expression return NULL;

Because the COALESCE is an expression, you can use it in any clause that accepts an expression such as SELECT, WHERE, GROUP BY, and HAVING.

SQL Server COALESCE expression examples 
Let’s see practical examples of using the COALESCE expression

A) Using SQL Server COALESCE expression with character string data example 
The following example uses the COALESCE expression to return the string 'Hi' because it is the first non-null argument:

SELECT 
    COALESCE(NULL, 'Hi', 'Hello', NULL) result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
------
Hi

(1 row affected)
B) Using SQL Server COALESCE expression with the numeric data example 
This example uses the COALESCE expression to evaluate a list of arguments and to return the first number:

SELECT 
    COALESCE(NULL, NULL, 100, 200) result;
Code language: SQL (Structured Query Language) (sql)
The output is as follows:

result
-----------
100

(1 row affected)
C) Using SQL Server COALESCE expression to substitute NULL by new values 
See the following sales.customers table from the sample database.

customers
The following query returns first name, last name, phone, and email of all customers:

SELECT 
    first_name, 
    last_name, 
    phone, 
    email
FROM 
    sales.customers
ORDER BY 
    first_name, 
    last_name;
Code language: SQL (Structured Query Language) (sql)
Here is the partial output:

SQL Server COALESCE expression sample result set
The phone column will have NULL if the customer does not have the phone number recorded in the sales.customers table.

To make the output more business friendly, you can use the COALESCE expression to substitute NULL by the string N/A (not available) as shown in the following query:

SELECT 
    first_name, 
    last_name, 
    COALESCE(phone,'N/A') phone, 
    email
FROM 
    sales.customers
ORDER BY 
    first_name, 
    last_name;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial output:

SQL Server COALESCE expression NULL substitution example
D) Using SQL Server COALESCE expression to use the available data 
First, create a new table named salaries that stores the employee’s salaries:

CREATE TABLE salaries (
    staff_id INT PRIMARY KEY,
    hourly_rate decimal,
    weekly_rate decimal,
    monthly_rate decimal,
    CHECK(
        hourly_rate IS NOT NULL OR 
        weekly_rate IS NOT NULL OR 
        monthly_rate IS NOT NULL)
);
Code language: SQL (Structured Query Language) (sql)
Each staff can have only one rate either hourly, weekly, or monthly.

Second, insert some rows into the salaries table:

INSERT INTO 
    salaries(
        staff_id, 
        hourly_rate, 
        weekly_rate, 
        monthly_rate
    )
VALUES
    (1,20, NULL,NULL),
    (2,30, NULL,NULL),
    (3,NULL, 1000,NULL),
    (4,NULL, NULL,6000);
    (5,NULL, NULL,6500);
Code language: SQL (Structured Query Language) (sql)
Third, query data from the salaries table:

SELECT
    staff_id, 
    hourly_rate, 
    weekly_rate, 
    monthly_rate
FROM
    salaries
ORDER BY
    staff_id;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server COALESCE expression sample table
Fourth, calculate monthly for each staff using the COALESCE expression as shown in the following query:

SELECT
    staff_id,
    COALESCE(
        hourly_rate*22*8, 
        weekly_rate*4, 
        monthly_rate
    ) monthly_salary
FROM
    salaries;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server COALESCE expression complex example
In this example, we used the COALESCE expression to use only non-NULL value found in the hourly_rate, weekly_rate, and monthly_rate columns.

COALESCE vs. CASE expression 
The COALESCE expression is a syntactic sugar of the CASE expression.

The following expressions return the same result:

COALESCE(e1,e2,e3)

CASE
    WHEN e1 IS NOT NULL THEN e1
    WHEN e2 IS NOT NULL THEN e2
    ELSE e3
END
Code language: SQL (Structured Query Language) (sql)
Note that the query optimizer may use the CASE expression to rewrite the COALESCE expression.

In this tutorial, you have learned how to use the SQL Server COALESCE expression to handle NULL values in queries.

Was this tutorial helpful?SQL Server COALESCE
Summary: in this tutorial, you will learn how to use the SQL Server COALESCE expression to deal with NULL in queries.

Introduction to SQL Server COALESCE expression 
The SQL Server COALESCE expression accepts a number of arguments, evaluates them in sequence, and returns the first non-null argument.

The following illustrates the syntax of the COALESCE expression:

COALESCE(e1,[e2,...,en])
Code language: SQL (Structured Query Language) (sql)
In this syntax, e1, e2, … en are scalar expressions that evaluate to scalar values. The COALESCE expression returns the first non-null expression. If all expressions evaluate to NULL, then the COALESCE expression return NULL;

Because the COALESCE is an expression, you can use it in any clause that accepts an expression such as SELECT, WHERE, GROUP BY, and HAVING.

SQL Server COALESCE expression examples 
Let’s see practical examples of using the COALESCE expression

A) Using SQL Server COALESCE expression with character string data example 
The following example uses the COALESCE expression to return the string 'Hi' because it is the first non-null argument:

SELECT 
    COALESCE(NULL, 'Hi', 'Hello', NULL) result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
------
Hi

(1 row affected)
B) Using SQL Server COALESCE expression with the numeric data example 
This example uses the COALESCE expression to evaluate a list of arguments and to return the first number:

SELECT 
    COALESCE(NULL, NULL, 100, 200) result;
Code language: SQL (Structured Query Language) (sql)
The output is as follows:

result
-----------
100

(1 row affected)
C) Using SQL Server COALESCE expression to substitute NULL by new values 
See the following sales.customers table from the sample database.

customers
The following query returns first name, last name, phone, and email of all customers:

SELECT 
    first_name, 
    last_name, 
    phone, 
    email
FROM 
    sales.customers
ORDER BY 
    first_name, 
    last_name;
Code language: SQL (Structured Query Language) (sql)
Here is the partial output:

SQL Server COALESCE expression sample result set
The phone column will have NULL if the customer does not have the phone number recorded in the sales.customers table.

To make the output more business friendly, you can use the COALESCE expression to substitute NULL by the string N/A (not available) as shown in the following query:

SELECT 
    first_name, 
    last_name, 
    COALESCE(phone,'N/A') phone, 
    email
FROM 
    sales.customers
ORDER BY 
    first_name, 
    last_name;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial output:

SQL Server COALESCE expression NULL substitution example
D) Using SQL Server COALESCE expression to use the available data 
First, create a new table named salaries that stores the employee’s salaries:

CREATE TABLE salaries (
    staff_id INT PRIMARY KEY,
    hourly_rate decimal,
    weekly_rate decimal,
    monthly_rate decimal,
    CHECK(
        hourly_rate IS NOT NULL OR 
        weekly_rate IS NOT NULL OR 
        monthly_rate IS NOT NULL)
);
Code language: SQL (Structured Query Language) (sql)
Each staff can have only one rate either hourly, weekly, or monthly.

Second, insert some rows into the salaries table:

INSERT INTO 
    salaries(
        staff_id, 
        hourly_rate, 
        weekly_rate, 
        monthly_rate
    )
VALUES
    (1,20, NULL,NULL),
    (2,30, NULL,NULL),
    (3,NULL, 1000,NULL),
    (4,NULL, NULL,6000);
    (5,NULL, NULL,6500);
Code language: SQL (Structured Query Language) (sql)
Third, query data from the salaries table:

SELECT
    staff_id, 
    hourly_rate, 
    weekly_rate, 
    monthly_rate
FROM
    salaries
ORDER BY
    staff_id;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server COALESCE expression sample table
Fourth, calculate monthly for each staff using the COALESCE expression as shown in the following query:

SELECT
    staff_id,
    COALESCE(
        hourly_rate*22*8, 
        weekly_rate*4, 
        monthly_rate
    ) monthly_salary
FROM
    salaries;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server COALESCE expression complex example
In this example, we used the COALESCE expression to use only non-NULL value found in the hourly_rate, weekly_rate, and monthly_rate columns.

COALESCE vs. CASE expression 
The COALESCE expression is a syntactic sugar of the CASE expression.

The following expressions return the same result:

COALESCE(e1,e2,e3)

CASE
    WHEN e1 IS NOT NULL THEN e1
    WHEN e2 IS NOT NULL THEN e2
    ELSE e3
END
Code language: SQL (Structured Query Language) (sql)
Note that the query optimizer may use the CASE expression to rewrite the COALESCE expression.

In this tutorial, you have learned how to use the SQL Server COALESCE expression to handle NULL values in queries.

Was this tutorial helpful?

SQL Server NULLIF
Summary: in this tutorial, you will learn how to use the SQL Server NULLIF expression to return NULL if the first argument equals to the second one.

SQL Server NULLIF expression overview 
The NULLIF expression accepts two arguments and returns NULL if two arguments are equal. Otherwise, it returns the first expression.

The following shows the syntax of the NULLIF expression:

NULLIF(expression1, expression2)
Code language: SQL (Structured Query Language) (sql)
In this syntax, the expression1 and expression2 are scalar expressions. It means each of them evaluates to a scalar value.

It is recommended that you not use the time-dependent functions such as RAND() function in the NULLIF function. Because this may cause the function to be evaluated twice and to yield different results from the two function calls.

SQL Server NULLIF examples 
Let’s take some examples of using the NULLIF expression

Using NULLIF expression with numeric data examples 
This example returns NULL because the first argument equals the second one:

SELECT 
    NULLIF(10, 10) result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
------
NULL

(1 row affected)
Code language: PHP (php)
However, the following example returns the first argument because two arguments are not equal:

SELECT 
    NULLIF(20, 10) result;
Code language: SQL (Structured Query Language) (sql)
The output is as follows:

result
------
20

(1 row affected)
Using NULLIF expression with character string data example 
The following example uses the NULLIF expression. It returns NULL because the first character string is equal to the second one:

SELECT 
    NULLIF('Hello', 'Hello') result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
------
NULL

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
This example returns the first argument because both arguments are not the same:

SELECT 
    NULLIF('Hello', 'Hi') result;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

result
------
Hello

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Using NULLIF expression to translate a blank string to NULL 
The NULLIF expression comes in handy when you’re working with legacy data that contains a mixture of null and empty strings in a column. Consider the following example.

First, create a new table named sales.leads to store the sales leads:

CREATE TABLE sales.leads
(
    lead_id    INT	PRIMARY KEY IDENTITY, 
    first_name VARCHAR(100) NOT NULL, 
    last_name  VARCHAR(100) NOT NULL, 
    phone      VARCHAR(20), 
    email      VARCHAR(255) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Second, insert three rows into the sales.leads table:

INSERT INTO sales.leads
(
    first_name, 
    last_name, 
    phone, 
    email
)
VALUES
(
    'John', 
    'Doe', 
    '(408)-987-2345', 
    'john.doe@example.com'
),
(
    'Jane', 
    'Doe', 
    '', 
    'jane.doe@example.com'
),
(
    'David', 
    'Doe', 
    NULL, 
    'david.doe@example.com'
);
Code language: SQL (Structured Query Language) (sql)
Third, query data from the sales.leads table:

SELECT 
    lead_id, 
    first_name, 
    last_name, 
    phone, 
    email
FROM 
    sales.leads
ORDER BY
    lead_id;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server NULLIF Sample Table
The phone column is a nullable column. If the phone of a lead is not known at the time of recording, the phone column will have NULL.

However, from the output, the second row has an empty string in the phone column due to the data entry mistake. Note that you may encounter a situation like this a lot if you are working with legacy databases.

To find the leads who do not have the phone number, you use the following query:

SELECT    
    lead_id, 
    first_name, 
    last_name, 
    phone, 
    email
FROM    
    sales.leads
WHERE 
    phone IS NULL;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server NULLIF with IS NULL example
The output missed one row which has the empty string in the phone column. To fix this you can use the NULLIF expression:

SELECT    
    lead_id, 
    first_name, 
    last_name, 
    phone, 
    email
FROM    
    sales.leads
WHERE 
    NULLIF(phone,'') IS NULL;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server NULLIF expression example
NULLIF and CASE expression 
This expression that uses NULLIF:

SELECT 
    NULLIF(a,b)
Code language: SQL (Structured Query Language) (sql)
is equivalent to the following expression that uses the CASE expression:

CASE 
    WHEN a=b THEN NULL 
    ELSE a 
END
Code language: SQL (Structured Query Language) (sql)
See the following example:

DECLARE @a int = 10, @b int = 20;
SELECT
    NULLIF(@a,@b) AS result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
-----------
10

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
The following example returns the same result, but use the CASE expression instead:

DECLARE @a int = 10, @b int = 20;
SELECT
    CASE
        WHEN @a = @b THEN null
        ELSE 
            @a
    END AS result;
Code language: SQL (Structured Query Language) (sql)
The CASE expression is verbose while the NULLIF expression is much shorter and more readable.

In this tutorial, you have learned how to use the SQL Server NULLIF expression to return NULL if the first argument equals to the second one.

Was this tutorial helpful?


Find Duplicates From a Table in SQL Server
Summary: in this tutorial, you will learn how to use the GROUP BY clause or ROW_NUMBER() function to find duplicate values in a table.

Technically, you use the UNIQUE constraints to enforce the uniqueness of rows in one or more columns of a table. However, sometimes you may find duplicate values in a table due to the poor database design, application bugs, or uncleaned data from external sources. Your job is to identify these duplicate values in effective ways.

To find the duplicate values in a table, you follow these steps:

First, define criteria for duplicates: values in a single column or multiple columns.
Second, write a query to search for duplicates.
If you want to also delete the duplicate rows, you can go to the deleting duplicates from a table tutorial.

Let’s set up a sample table for the demonstration.

Setting up a sample table 
First, create a new table named t1 that contains three columns id, a, and b.

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (
    id INT IDENTITY(1, 1), 
    a  INT, 
    b  INT, 
    PRIMARY KEY(id)
);
Code language: SQL (Structured Query Language) (sql)
Then, insert some rows into the t1 table:

INSERT INTO
    t1(a,b)
VALUES
    (1,1),
    (1,2),
    (1,3),
    (2,1),
    (1,2),
    (1,3),
    (2,1),
    (2,2);
Code language: SQL (Structured Query Language) (sql)
The t1 table contains the following duplicate rows:

(1,2)
(2,1)
(1,3)
Code language: SQL (Structured Query Language) (sql)
Your goal is to write a query to find the above duplicate rows.

Using GROUP BY clause to find duplicates in a table 
This statement uses the GROUP BY clause to find the duplicate rows in both a and b columns of the t1 table:

SELECT 
    a, 
    b, 
    COUNT(*) occurrences
FROM t1
GROUP BY
    a, 
    b
HAVING 
    COUNT(*) > 1;
Code language: SQL (Structured Query Language) (sql)
Here is the result:

SQL Server Find Duplicates using GROUP BY clause
How it works:

First, the GROUP BY clause groups the rows into groups by values in both a and b columns.
Second, the COUNT() function returns the number of occurrences of each group (a,b).
Third, the HAVING clause keeps only duplicate groups, which are groups that have more than one occurrence.
To return the entire row for each duplicate row, you join the result of the above query with the t1 table using a common table expression (CTE):

WITH cte AS (
    SELECT
        a, 
        b, 
        COUNT(*) occurrences
    FROM t1
    GROUP BY 
        a, 
        b
    HAVING 
        COUNT(*) > 1
)
SELECT 
    t1.id, 
    t1.a, 
    t1.b
FROM t1
    INNER JOIN cte ON 
        cte.a = t1.a AND 
        cte.b = t1.b
ORDER BY 
    t1.a, 
    t1.b;
Code language: SQL (Structured Query Language) (sql)
Here is the output:


Generally, the query for finding the duplicate values in one column using the GROUP BY clause is as follows:

SELECT 
    col, 
    COUNT(col)
FROM 
    table_name
GROUP BY 
    col
HAVING 
    COUNT(col) > 1;
Code language: SQL (Structured Query Language) (sql)
The query for finding the duplicate values in multiple columns using the GROUP BY clause :

SELECT 
    col1,col2,...
    COUNT(*)
FROM 
    table_name
GROUP BY 
    col1,col2,...
HAVING 
    COUNT(*) > 1;
Code language: SQL (Structured Query Language) (sql)
Using ROW_NUMBER() function to find duplicates in a table 
The following statement uses the ROW_NUMBER() function to find duplicate rows based on both a and b columns:

WITH cte AS (
    SELECT 
        a, 
        b, 
        ROW_NUMBER() OVER (
            PARTITION BY a,b
            ORDER BY a,b) rownum
    FROM 
        t1
) 
SELECT 
  * 
FROM 
    cte 
WHERE 
    rownum > 1;
Code language: SQL (Structured Query Language) (sql)
Here is the result:

SQL Server Find Duplicates using ROW_NUMBER
How it works:

First, the ROW_NUMBER() distributes rows of the t1 table into partitions by values in the a and b columns. The duplicate rows will have repeated values in the a and b columns, but different row numbers as shown in the following picture:


Second, the outer query removes the first row in each group.

Generally, This statement uses the ROW_NUMBER() function to find the duplicate values in one column of a table:

WITH cte AS (
    SELECT 
        col,
        ROW_NUMBER() OVER (
            PARTITION BY col
            ORDER BY col) row_num
    FROM 
        t1
) 
SELECT * FROM cte 
WHERE row_num > 1;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the GROUP BY clause or ROW_NUMBER() function to find duplicate values in SQL Server.

Was this tutorial helpful?


Delete Duplicates From a Table in SQL Server
Summary: in this tutorial, you will learn how to delete duplicate rows from a table in SQL Server.

To delete the duplicate rows from the table in SQL Server, you follow these steps:

Find duplicate rows using GROUP BY clause or ROW_NUMBER() function.
Use DELETE statement to remove the duplicate rows.
Let’s set up a sample table for the demonstration.

Setting up a sample table 
First, create a new table named sales.contacts as follows:

DROP TABLE IF EXISTS sales.contacts;

CREATE TABLE sales.contacts(
    contact_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL,
);
Code language: SQL (Structured Query Language) (sql)
Second, insert some rows into the sales.contacts table:

INSERT INTO sales.contacts
    (first_name,last_name,email) 
VALUES
    ('Syed','Abbas','syed.abbas@example.com'),
    ('Catherine','Abel','catherine.abel@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Hazem','Abolrous','hazem.abolrous@example.com'),
    ('Hazem','Abolrous','hazem.abolrous@example.com'),
    ('Humberto','Acevedo','humberto.acevedo@example.com'),
    ('Humberto','Acevedo','humberto.acevedo@example.com'),
    ('Pilar','Ackerman','pilar.ackerman@example.com');
Code language: SQL (Structured Query Language) (sql)
Third, query data from the sales.contacts table:

SELECT 
   contact_id, 
   first_name, 
   last_name, 
   email
FROM 
   sales.contacts;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output of the query:

SQL Server Delete Duplicates
There are many duplicate rows (3,4,5), (6,7), and (8,9) for the contacts that have the same first name, last name, and email.

Delete duplicate rows from a table example 
The following statement uses a common table expression (CTE) to delete duplicate rows:

WITH cte AS (
    SELECT 
        contact_id, 
        first_name, 
        last_name, 
        email, 
        ROW_NUMBER() OVER (
            PARTITION BY 
                first_name, 
                last_name, 
                email
            ORDER BY 
                first_name, 
                last_name, 
                email
        ) row_num
     FROM 
        sales.contacts
)
DELETE FROM cte
WHERE row_num > 1;
Code language: SQL (Structured Query Language) (sql)
In this statement:

First, the CTE uses the ROW_NUMBER() function to find the duplicate rows specified by values in the first_name, last_name, and email columns.
Then, the DELETE statement deletes all the duplicate rows but keeps only one occurrence of each duplicate group.
SQL Server issued the following message indicating that the duplicate rows have been removed.

(4 rows affected)
If you query data from the sales.contacts table again, you will find that all duplicate rows are deleted.

SELECT contact_id, 
       first_name, 
       last_name, 
       email
FROM sales.contacts
ORDER BY first_name, 
         last_name, 
         email;
Code language: SQL (Structured Query Language) (sql)
SQL Server Delete Duplicate Rows Result
In this tutorial, you have learned how to delete duplicate rows from a table in SQL Server