SQL Server Aggregate Functions
Summary: in this tutorial, you will learn about the SQL Server aggregate functions and how to use them to calculate aggregates.

An aggregate function operates on a set of values and returns a single value. In practice, you often use aggregate functions with the GROUP BY clause and HAVING clause to aggregate values within groups.

The following table shows the most commonly used SQL Server aggregate functions:

Type a function name to search...
Aggregate function	Description
AVG	Calculate the average of non-NULL values in a set of values.
CHECKSUM_AGG	Calculate a checksum value based on a group of rows.
COUNT	Return the number of rows in a group that satisfy a condition.
COUNT(*)	Return the number of rows from a table, which meets a certain condition.
COUNT(DISTINCT)	Return the number of unique values in a column that meets a certain condition.
COUNT IF	Show you how to use the COUNT function with the IIF function to form a COUNT IF function that returns the total number of values based on a condition.
COUNT_BIG	The COUNT_BIG() function returns the number of rows (with BIGINT data type) in a group, including rows with NULL values.
MAX	Return the highest value (maximum) in a set of non-NULL values.
MIN	Return the lowest value (minimum) in a set of non-NULL values.
STDEV	Calculate the sample standard deviation of a set of values.
STDEVP	Return the population standard deviation of a set of values.
SUM	Return the summation of all non-NULL values in a set.
SUM IF	Use the SUM function with the IIF function to form a SUM IF function that returns the total of values based on a condition.
STRING_AGG 	Concatenate strings by a specified separator
VAR	Return the sample variance of a set of values.
VARP	Return the population variance of a set of values.
SQL Server aggregate function syntax 
Here’s is the general syntax of an aggregate function:

aggregate_function_name( [DISTINCT | ALL] expression)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of an aggregate function that you want to use such as AVG, SUM, and MAX.
Second, use DISTINCT to apply aggregate distinct values in a set; or use the ALL option to apply the aggregate function to all values including duplicates.
Third, specify the expression which can be a column of a table or an expression that consists of multiple columns with arithmetic operators.
SQL Server aggregate function examples 
We will use the products table from the sample database for the demonstration.

products
The AVG function example 
The following statement uses the AVG() function to return the average list price of all products in the products table:

SELECT
    AVG(list_price) avg_product_price
FROM
    production.products;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

avg_product_price
-----------------
1520.591401
Code language: CSS (css)
Because the list price is in USD, it should have at most two decimal places. Therefore, you need to round the result to a number with two decimal places.

To achieve this, you use the ROUND and CAST functions as demonstrated in the following query:

SELECT
    CAST(ROUND(AVG(list_price),2) AS DEC(10,2))
    avg_product_price
FROM
    production.products;
Code language: SQL (Structured Query Language) (sql)
Output:

avg_product_price
-----------------
1520.59
Code language: CSS (css)
In this query:

First, the ROUND function returns the rounded average list price.
Then the CAST function converts the result to a decimal number with two decimal places.
The COUNT function example 
The following statement uses the COUNT() function to return the number of products whose price is greater than 500:

SELECT
    COUNT(*) product_count
FROM
    production.products
WHERE
    list_price > 500;
Code language: SQL (Structured Query Language) (sql)
Output:

product_count
-------------
213
In this example:

First, the WHERE clause gets products whose list price is greater than 500.
Second, the COUNT function returns the number of products with list prices greater than 500.
The MAX function example 
The following statement uses the MAX() function to return the highest list price of all products:

SELECT
    MAX(list_price) max_list_price
FROM
    production.products;
Code language: SQL (Structured Query Language) (sql)
Output:

max_list_price
--------------
11999.99
Code language: CSS (css)
The MIN function example 
Similarly, the following statement uses the MIN() function to return the lowest list price of all products:

SELECT
    MIN(list_price) min_list_price
FROM
    production.products;     
Code language: SQL (Structured Query Language) (sql)
Output:

min_list_price
--------------
89.99
Code language: CSS (css)
The SUM function example 
To demonstrate the SUM() function, we will use the stocks table from the sample database.


The following statement uses the SUM() function to calculate the total stock by product id in all warehouses:

SELECT 
    product_id, 
    SUM(quantity) stock_count
FROM 
    production.stocks
GROUP BY
    product_id
ORDER BY 
    stock_count DESC;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial output:

SQL Server Aggregate Functions - SUM function example
How the statement works:

First, the GROUP BY clause summarized the rows by product id into groups.
Second, the SUM() function calculated the sum of quantity for each group.
The STDEV function example 
The following statement uses the STDEV() function to calculate the statistical standard deviation of all list prices:

SELECT
    CAST(ROUND(STDEV(list_price),2) as DEC(10,2)) stdev_list_price
FROM
    production.products;
Code language: SQL (Structured Query Language) (sql)
Output:

stdev_list_price
----------------
1612.15
Code language: CSS (css)
Summary 
Aggregate functions operate on rows and return a single row.
Use aggregate functions with the GROUP BY clause to aggregate values within groups.
Use the AVG() function to calculate the average of values.
Use the SUM() function to calculate the total of values.
Use the COUNT() function to count the number of values in a column.
Use the MIN() function to get the minimum value in a set.
Use the MAX() function to get the maximum value in a set.



SQL Server AVG() Function
Summary: in this tutorial, you will learn how to use the SQL Server AVG() function to calculate the average value from a group of values.

Introduction to SQL Server AVG() function 
SQL Server AVG() function is an aggregate function that returns the average value of a group.

The following illustrates the syntax of the AVG() function:

AVG([ALL | DISTINCT] expression)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

ALL instructs the AVG() function to take all values for calculation. ALL is used by default.
DISTINCT instructs the AVG() function to operate only on unique values.
expression is a valid expression that returns a numeric value.
The AVG() function ignores NULL values.

SQL Server AVG() function: ALL vs. DISTINCT 
The following statements create a new table, insert some values into the table, and query data against it:

CREATE TABLE t(
    val dec(10,2)
);
INSERT INTO t(val) 
VALUES(1),(2),(3),(4),(4),(5),(5),(6);

SELECT val FROM t;
Code language: SQL (Structured Query Language) (sql)
Output:

val
----
1.00
2.00
3.00
4.00
4.00
5.00
5.00
6.00
(8 rows)
Code language: CSS (css)
The following statement uses the AVG() function to calculate the average of all values in the t table:

SELECT AVG(ALL val) avg 
FROM t;
Code language: SQL (Structured Query Language) (sql)
Output:

avg
--------
3.750000
(1 row)
Code language: CSS (css)
In this example, we use the ALL modifier, therefore, the average function considers all eight values in the val column in the calculation:

(1 + 2 + 3 + 4 + 4 + 5 + 5 + 6) /  8 = 3.75
Code language: SQL (Structured Query Language) (sql)
The following statement uses the AVG() function with DISTINCT modifier:

SELECT AVG(DISTINCT val) avg
FROM t;
Code language: SQL (Structured Query Language) (sql)
Here is the result:

avg
--------
3.500000
(1 row)
Code language: CSS (css)
Because of the DISTINCT modifier, the AVG() function performs the calculation on distinct values:

(1 + 2 + 3 + 4 + 5 + 6) / 6 = 3.5
Code language: SQL (Structured Query Language) (sql)
SQL Server AVG() function examples 
Let’s take some examples to see how the AVG() function works.

1) Basic SQL Server AVG() function example 
The following example returns the average list price of all products:

SELECT
    AVG(list_price) avg
FROM
    production.products;
Code language: SQL (Structured Query Language) (sql)
In this example, the AVG() function returns a single value for the whole table.

Output:

avg
-----------
1520.591401
Code language: CSS (css)
To make the average price easier to read, you can round it using the ROUND() function and cast the result to a number with two decimal places:

SELECT
    CAST(ROUND(AVG(list_price),2) AS DEC(10,2)) avg
FROM
    production.products;
Code language: SQL (Structured Query Language) (sql)
Output:

avg
-------
1520.59
Code language: CSS (css)
2) Using SQL Server AVG() with GROUP BY example 
If you use the AVG() function with a GROUP BY clause, the AVG() function returns a single value for each group instead of a single value for the whole table.

The following example uses the AVG() function with the GROUP BY clause to retrieve the average list price for each product category:

SELECT
    category_name,
    CAST(ROUND(AVG(list_price),2) AS DEC(10,2))  avg_product_price
FROM
    production.products p
    INNER JOIN production.categories c 
        ON c.category_id = p.category_id
GROUP BY
    category_name
ORDER BY
    category_name;
Code language: SQL (Structured Query Language) (sql)
Output:

category_name       | avg_product_price
--------------------+------------------
Children Bicycles   | 287.79
Comfort Bicycles    | 682.12
Cruisers Bicycles   | 730.41
Cyclocross Bicycles | 2542.79
Electric Bikes      | 3281.66
Mountain Bikes      | 1649.76
Road Bikes          | 3175.36
(7 rows)
3) Using SQL Server AVG() in HAVING clause example 
The following example uses the AVG() function in the HAVING clause to retrieve only brands whose average list prices are more than 500:

SELECT
    brand_name,
    CAST(ROUND(AVG(list_price),2) AS DEC(10,2)) avg_product_price
FROM
    production.products p
    INNER JOIN production.brands c ON c.brand_id = p.brand_id
GROUP BY
    brand_name
HAVING
    AVG(list_price) > 500
ORDER BY
    avg_product_price;
Code language: SQL (Structured Query Language) (sql)
Output:

brand_name   | avg_product_price
-------------+-------------------
Sun Bicycles | 524.47
Haro         | 621.99
Ritchey      | 749.99
Electra      | 761.01
Surly        | 1331.75
Heller       | 2173.00
Trek         | 2500.06
(7 rows)
In this example:

First, the GROUP BY clause divides the products by brands into groups.
Second, the AVG() function calculates the average list price for each group.
Third, the HAVING clause removes the brand whose average list price is less than 500.
Summary 
Use the AVG() function to calculate the average value from a group of values.
Use the AVG() function with the GROUP BY clause to calculate the average of each group.
Was this tutorial helpful?

SQL Server CHECKSUM_AGG() Function
Summary: in this tutorial, you will learn how to use the SQL Server CHECKSUM_AGG() function to detect the data changes in a column.

Introduction to SQL Server CHECKSUM_AGG() function 
The CHECKSUM_AGG() function is an aggregate function that returns the checksum of the values in a set.

The following shows the syntax of the CHECKSUM_AGG() function:

CHECKSUM_AGG ( [ ALL | DISTINCT ] expression)  
Code language: SQL (Structured Query Language) (sql)
In this syntax:

ALL instructs the function to return the checksum of all values including duplicates.
DISTINCT forces the function to calculate the checksum of distinct values.
expression is an integer expression. The function does not accept subqueries or aggregate functions.
The CHECKSUM_AGG() function ignores null values.

Because of the hashing algorithm, the CHECKSUM_AGG() function may return the same value with different input data. Therefore, you should use this function when your application can tolerate occasionally missing a change.

SQL Server CHECKSUM_AGG() function example 
The following statement creates a new table called sales.inventory with the data retrieved from the production.stocks table in the sample database. The new table stores products and their quantities:

SELECT
    product_id, 
    SUM(quantity) quantity
INTO 
    sales.inventory
FROM
    production.stocks
GROUP BY 
    product_id;
Code language: SQL (Structured Query Language) (sql)
The following statement uses the CHECKSUM_AGG() function to get the aggregate checksum of the quantity column:

SELECT 
    CHECKSUM_AGG(quantity) qty_checksum_agg
FROM
    sales.inventory;
Code language: SQL (Structured Query Language) (sql)
Output:

qty_checksum_agg
----------------
29

(1 row affected)
Let’s change the data in the sales.inventory table:

UPDATE 
    sales.inventory
SET
    quantity = 10
WHERE
    product_id = 1;
Code language: SQL (Structured Query Language) (sql)
And apply the CHECKSUM_AGG() function to the quantity column:

SELECT 
    CHECKSUM_AGG(quantity) qty_checksum_agg
FROM
    sales.inventory;
Code language: SQL (Structured Query Language) (sql)
Output:

qty_checksum_agg
----------------
32

(1 row affected)
The output indicates the result of the CHECKSUM_AGG() changes. It means that the data in the quantity column has been changed since the last checksum calculation.

Summary 
Use the CHECKSUM_AGG() function to detect the data changes in a column.
Was this tutorial helpful?

SQL Server COUNT() Function
Summary: in this tutorial, you will learn how to use the SQL Server COUNT() function to get the number of items in a set.

Introduction to SQL Server COUNT() function 
SQL Server COUNT() is an aggregate function that returns the number of items in a set.

The following shows the syntax of the COUNT() function:

COUNT([ALL | DISTINCT  ] expression)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

ALL instructs the COUNT() function to apply to all values. ALL is the default.
DISTINCT instructs the COUNT() function to return the number of unique non-null values.
 expression is an expression of any type but image, text, or ntext. Note that you cannot use a subquery or an aggregate function in the expression.
The COUNT() function has another form as follows:

COUNT(*)
Code language: SQL (Structured Query Language) (sql)
In this form, the COUNT(*) returns the number of rows that satisfy a certain condition. The COUNT(*) does not support DISTINCT and takes no parameters. It counts each row separately and includes rows that contain NULL values.

In summary:

COUNT(*) counts the number of items in a set. It includes NULL and duplicate values.
COUNT(ALL expression) evaluates the expression for each row in a set and returns the number of non-null values.
COUNT(DISTINCT expression) evaluates the expression for each row in a set, and returns the number of unique, non-null values.
SQL Server COUNT() function examples 
The following statement creates a new table named t, insert some data into the table, and query data against it:

CREATE TABLE t(
    val INT
);

INSERT INTO t(val)
VALUES(1),(2),(2),(3),(null),(null),(4),(5);

SELECT val FROM t;
Code language: SQL (Structured Query Language) (sql)
Output:

val
-----------
1
2
2
3
NULL
NULL
4
5
Code language: PHP (php)
Basic SQL Server COUNT(*) example 
The following example uses the COUNT(*) function to return the number of rows in the t table:

SELECT COUNT(*) val_count
FROM t;
Code language: SQL (Structured Query Language) (sql)
Output:

val_count
---------
8
SQL Server COUNT(DISTINCT expression) example 
The following example uses the COUNT(DISTINCT expression) to return the number of unique, non-null values in the t table:

SELECT
    COUNT(DISTINCT val) val_count
FROM
    t;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

val_count
-----------
5
Warning: Null value is eliminated by an aggregate or other SET operation.

(1 row affected)
Code language: PHP (php)
SQL Server COUNT( expression ) example 
The following example uses the COUNT(expression) to return the number of non-null values in the t table:

SELECT
    COUNT(val)
FROM
    t;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

val_count
-----------
6
Warning: Null value is eliminated by an aggregate or other SET operation.

(1 row affected)
Code language: PHP (php)
Practical examples of COUNT() function 
We’ll use the tables in the sample database for the demonstration.

The following statement uses the COUNT(*) function to return the number of rows in the products table:

SELECT 
    COUNT(*) product_count
FROM
    production.products;
Code language: SQL (Structured Query Language) (sql)
Output:

product_count
-------------
321

(1 row affected)
The following example uses the COUNT(*) function to retrieve the number of products whose model year is 2016 and the list price is higher than 999.99:

SELECT 
   COUNT(*)
FROM 
    production.products
WHERE 
    model_year = 2016
    AND list_price > 999.99;
Code language: SQL (Structured Query Language) (sql)
Output:

Result
-----------
7

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Using SQL Server COUNT() function with GROUP BY clause 
The following statement uses the COUNT(*) function to find the number of products in each product category:

SELECT 
    category_name,
    COUNT(*) product_count
FROM
    production.products p
    INNER JOIN production.categories c 
    ON c.category_id = p.category_id
GROUP BY 
    category_name
ORDER BY
    product_count DESC;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

category_name        product_count
-------------------- -------------
Cruisers Bicycles    78
Mountain Bikes       60
Road Bikes           60
Children Bicycles    59
Comfort Bicycles     30
Electric Bikes       24
Cyclocross Bicycles  10

(7 rows affected)
In this example, first, the GROUP BY clause divided the products into groups using category names then the COUNT() function is applied to each group.

Using SQL Server COUNT() with HAVING clause example 
The following statement returns the brand and the number of products for each. In addition, it returns only the brands that have the number of products greater than 20:

SELECT 
    brand_name,
    COUNT(*) product_count
FROM
    production.products p
    INNER JOIN production.brands c 
    ON c.brand_id = p.brand_id
GROUP BY 
    brand_name
HAVING
    COUNT(*) > 20
ORDER BY
    product_count DESC;
Code language: SQL (Structured Query Language) (sql)
The output is as follows:

brand_name           product_count
-------------------- -------------
Trek                 135
Electra              118
Surly                25
Sun Bicycles         23

(4 rows affected)
Summary 
Use the COUNT(*) to retrieve the number of rows in a table.
Use the COUNT(ALL expression) to count the number of non-null values.
Use the COUNT(DISTINCT expression) to obtain the number of unique, non-null values.
Was this tutorial helpful?

SQL Server COUNT(*) Function
Summary: in this tutorial, you will learn how to use the SQL Server COUNT(*) to obtain the number of rows that meet certain criteria.

Introduction to the SQL Server COUNT(*) function 
In SQL Server, the COUNT() function is an aggregate function that returns the number of values in a set of values.

The COUNT(*) is a form of the COUNT() function that returns the total number of rows that meet certain criteria.

In practice, you often use the COUNT(*) to count rows in a table, whether any columns contain NULL or duplicate values or not.

Here’s the basic syntax of the COUNT(*) function:

SELECT 
  COUNT(*) 
FROM 
  table_name;
Code language: SQL (Structured Query Language) (sql)
The query may include other clauses such as JOIN, WHERE, GROUP BY, and HAVING clauses.

SQL Server COUNT(*) function examples 
Let’s take some examples of using the SQL Server COUNT(*) function.

We’ll use the production.products and production.brands tables from the sample database for the demonstration:

Sample Tables for SQL Server COUNT(*)
1) Basic SQL Server COUNT(*) function example 
The following example uses the COUNT(*) function to return the number of rows in the production.products table:

SELECT 
  COUNT(*) product_count 
FROM 
  production.products;
Code language: SQL (Structured Query Language) (sql)
Output:

product_count
-------------
321
Code language: SQL (Structured Query Language) (sql)
The output indicates that the products table has 321 rows.

2) Using the COUNT(*) function with a condition 
The following example uses the COUNT(*) to retrieve the number of products whose list prices are greater than 900:

SELECT 
  COUNT(*) product_count 
FROM 
  production.products 
WHERE 
  list_price > 900;
Code language: SQL (Structured Query Language) (sql)
Output:

product_count
-------------
139
Code language: SQL (Structured Query Language) (sql)
In this example:

The WHERE clause includes only products whose list price is greater than 900.
The COUNT(*) returns the number of filtered rows.
3) Using the COUNT(*) function with JOIN clause example 
The following example uses the COUNT(*) to retrieve the total number of products with the brand “Electra”:

SELECT 
  COUNT(*) product_count 
FROM 
  production.products p 
  INNER JOIN production.brands b ON b.brand_id = p.brand_id 
WHERE 
  b.brand_name = 'Electra';
Code language: SQL (Structured Query Language) (sql)
Output:

product_count
-------------
118
Code language: SQL (Structured Query Language) (sql)
In this example:

First, join the production.products table with the production.brands table using the values in the brand_id column.
Second, filter only products with the brand name "Electra" using a WHERE clause.
Third, return the number of rows using the COUNT(*) function.
The output indicates that there are 118 rows in the products table with the brand "Electra".

4) Using the COUNT(*) function with GROUP BY clause 
The following example uses the COUNT(*) function with the GROUP BY clause to return the number of products per brand:

SELECT 
  b.brand_name, 
  COUNT(*) product_count 
FROM 
  production.products p 
  INNER JOIN production.brands b ON b.brand_id = p.brand_id 
GROUP BY 
  b.brand_name 
ORDER BY 
  b.brand_name;
Code language: SQL (Structured Query Language) (sql)
Output:

brand_name   | product_count
-------------+------------
Electra      | 118
Haro         | 10
Heller       | 3
Pure Cycles  | 3
Ritchey      | 1
Strider      | 3
Sun Bicycles | 23
Surly        | 25
Trek         | 135
(9 rows)
Code language: SQL (Structured Query Language) (sql)
In this example:

First, join the production.products table with the production.brand table by matching values in the brand_id column.
Second, group rows by brand names using the GROUP BY clause.
Third, count the number of rows for each group.
5) Using the COUNT(*) function with HAVING clause 
The following example uses the COUNT(*) function in the HAVING clause to retrieve the brands that have more than 100 products:

SELECT 
  b.brand_name, 
  COUNT(*) product_count 
FROM 
  production.products p 
  INNER JOIN production.brands b ON b.brand_id = p.brand_id 
GROUP BY 
  b.brand_name 
HAVING 
  COUNT(*) > 100 
ORDER BY 
  b.brand_name;
Code language: SQL (Structured Query Language) (sql)
Output:

brand_name | product_count
-----------+------------
Electra    | 118
Trek       | 135
(2 rows)
Code language: SQL (Structured Query Language) (sql)
Summary 
Use the COUNT(*) function to get the number of rows that satisfy a certain condition.
Was this tutorial helpful?


SQL Server COUNT DISTINCT
Summary: in this tutorial, you will learn how to use the SQL Server COUNT DISTINCT to get the total number of unique values in a column of a table.

Introduction to the SQL Server COUNT DISTINCT 
In SQL Server, the COUNT() function is an aggregate function that returns the total number of rows that meet a certain condition.

Sometimes, you may want to count the number of distinct values in a column that meets a condition. To do that, you can use the DISTINCT option:

COUNT(DISTINCT column_name)
Code language: SQL (Structured Query Language) (sql)
The COUNT DISTINCT will count duplicate values as one. It’s important to note that the COUNT(DISTINCT) function completely ignores NULL when counting.

In practice, you often use the COUNT DISTINCT to get the total number of unique values in a column that satisfies a certain condition.

SQL Server COUNT DISTINCT examples 
Let’s explore some examples of using the SQL Server COUNT DISTINCT.

1) Basic SQL Server COUNT DISTINCT example 
First, create a new table called numbers that has an id column:

CREATE TABLE numbers(
   id INT
);
Code language: SQL (Structured Query Language) (sql)
Second, insert some rows into the numbers table:

INSERT INTO numbers(id) 
VALUES 
  (1), 
  (2), 
  (3), 
  (3), 
  (NULL), 
  (NULL);
Code language: SQL (Structured Query Language) (sql)
The numbers table has duplicate values 3 and NULL.

Third, use the COUNT DISTINCT to return the total number of distinct values in the id column:

SELECT 
  COUNT(DISTINCT id) 
FROM 
  numbers;
Code language: SQL (Structured Query Language) (sql)
Output:

id_count
-----------
3
Code language: SQL (Structured Query Language) (sql)
In this example, the query returns 3 which includes the numbers 1, 2, and 3. It counts the duplicate number 3 as 1 and ignores the NULL.

In the upcoming examples, we’ll use the production.products and production.brands tables from the sample database:

SQL Server COUNT DISTINCT Sample Tables
2) Counting distinct values in a column 
The following example uses the COUNT DISTINCT to get the total number of model years in the production.products table:

SELECT 
  COUNT(DISTINCT model_year) model_year_count 
FROM 
  production.products;
Code language: SQL (Structured Query Language) (sql)
Output:

model_year_count
----------------
4
Code language: SQL (Structured Query Language) (sql)
The output indicates that the production.products table has four unique model year values.

3) Counting distinct values with a condition 
The following example uses the COUNT DISTINCT to get the total number of model years that are greater than 2017 from the production.products table:

SELECT 
  COUNT(DISTINCT model_year) model_year_count 
FROM 
  production.products 
WHERE 
  model_year > 2017;
Code language: SQL (Structured Query Language) (sql)
Output:

model_year_count
----------------
2
Code language: SQL (Structured Query Language) (sql)
In this example:

First, include only products whose model years are greater than 2017 using the WHERE clause.
Second, count the distinct model year of the filtered rows.
4) Using COUNT DISTINCT with the GROUP BY clause example 
The following example uses the COUNT DISTINCT to obtain the total number of model years for each brand name:

SELECT
  brand_name,
  COUNT(DISTINCT model_year) distinct_model_year
FROM
  production.products p
  INNER JOIN production.brands b ON b.brand_id = p.brand_id
GROUP BY
  brand_name
ORDER BY
  brand_name;
Code language: SQL (Structured Query Language) (sql)
Output:

brand_name   | distinct_model_year
-------------+------------------
Electra      | 3
Haro         | 1
Heller       | 2
Pure Cycles  | 1
Ritchey      | 1
Strider      | 1
Sun Bicycles | 1
Surly        | 3
Trek         | 4
(9 rows)
Code language: SQL (Structured Query Language) (sql)
In this example:

Join the production.products table with the production.brands table using the values in the brand_id column.
Group the rows by brand names using the GROUP BY clause.
Count the distinct model year for each brand name using the COUNT DISTINCT.
Sort the groups by the brand names using ORDER BY clause.
Summary 
Use the COUNT DISTINCT to count unique values in a column of a table.
Was this tutorial helpful? 

SQL Server COUNT IF
Summary: in this tutorial, you will learn how to use the SQL Server COUNT IF function to count values in a set based on conditions.

How to form a SQL Server COUNT IF 
In SQL Server, the IIF function allows you to evaluate an expression and returns a value if the expression is true or another value if the expression is false.

Here’s the syntax of the IFF function:

IIF(expression, value_if_true, value_if_false)
Code language: SQL (Structured Query Language) (sql)
The COUNT function is an aggregate function that allows you to calculate the total number of values in a set. The COUNT function ignores NULL when counting.

To count values based on a specific condition, you can combine the COUNT with the IIF function:

COUNT(IIF(expression, 1 , NULL))
Code language: SQL (Structured Query Language) (sql)
In this expression, the COUNT will calculate the total number of values when the expression is true. If the expression is false, the IIF function returns NULL. Hence, the COUNT function will not count it.

SQL Server COUNT IF examples 
Let’s explore some examples of using the SQL Server COUNT IF.

1) Setting up a sample table 
First, create a table called employees that stores the employee data:

CREATE TABLE employees(
  id INT IDENTITY PRIMARY KEY, 
  full_name VARCHAR(255) NOT NULL, 
  employee_type varchar(25) not null
);
Code language: SQL (Structured Query Language) (sql)
Second, insert some rows into the employees table:

INSERT INTO employees (full_name, employee_type) 
VALUES 
  ('John Doe', 'Full-time'), 
  ('Jane Smith', 'Full-time'), 
  ('Michael Johnson', 'Full-time'), 
  ('Emily Brown', 'Full-time'), 
  ('David Lee', 'Contractor'), 
  ('Sarah Williams', 'Temp'), 
  ('Matthew Taylor', 'Full-time'), 
  ('Jessica Martinez', 'Contractor');
Code language: SQL (Structured Query Language) (sql)
Third, retrieve data from the employees table:

SELECT 
  full_name, 
  employee_type 
FROM 
  employees;
Code language: SQL (Structured Query Language) (sql)
Output:

full_name        | employee_type
------------------------------
John Doe         | Full-time
Jane Smith       | Full-time
Michael Johnson  | Full-time
Emily Brown      | Full-time
David Lee        | Contractor
Sarah Williams   | Temp
Matthew Taylor   | Full-time
Jessica Martinez | Contractor
(8 rows)
Code language: SQL (Structured Query Language) (sql)
2) SQL Server COUNT IF example 
The following statement uses the COUNT with the IIF function to get the total number of full-time employees:

SELECT COUNT(IIF(employee_type='Full-time',1,NULL)) full_time_employee_count
FROM employees;
Code language: SQL (Structured Query Language) (sql)
Output:

full_time_employee_count
------------------------
5
Code language: SQL (Structured Query Language) (sql)
The following example uses the COUNT with the IIF function to get the total number of each employee type:

SELECT 
   COUNT(IIF(employee_type='Full-time',1,NULL)) full_time,
   COUNT(IIF(employee_type='Contractor',1,NULL)) contractor,
   COUNT(IIF(employee_type='Temp',1,NULL)) temp
FROM 
   employees;
Code language: SQL (Structured Query Language) (sql)
Output:

full_time | contractor | temp
----------+------------+------
5         | 5          | 1
(1 row)
Code language: SQL (Structured Query Language) (sql)
Note that if you use the GROUP BY clause, you’ll get the rows arranged vertically:

SELECT 
  employee_type, 
  COUNT(*) employee_count 
FROM 
  employees 
GROUP BY 
  employee_type;
Code language: SQL (Structured Query Language) (sql)
Output:

employee_type             employee_count
------------------------- --------------
Contractor                2
Full-time                 5
Temp                      1

(3 rows affected)
Code language: SQL (Structured Query Language) (sql)
Summary 
Use the COUNT with the IIF function to obtain the total number of rows based on a condition.
Was this tutorial helpful?

SQL Server COUNT() Function
Summary: in this tutorial, you will learn how to use the SQL Server COUNT() function to get the number of items in a set.

Introduction to SQL Server COUNT() function 
SQL Server COUNT() is an aggregate function that returns the number of items in a set.

The following shows the syntax of the COUNT() function:

COUNT([ALL | DISTINCT  ] expression)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

ALL instructs the COUNT() function to apply to all values. ALL is the default.
DISTINCT instructs the COUNT() function to return the number of unique non-null values.
 expression is an expression of any type but image, text, or ntext. Note that you cannot use a subquery or an aggregate function in the expression.
The COUNT() function has another form as follows:

COUNT(*)
Code language: SQL (Structured Query Language) (sql)
In this form, the COUNT(*) returns the number of rows that satisfy a certain condition. The COUNT(*) does not support DISTINCT and takes no parameters. It counts each row separately and includes rows that contain NULL values.

In summary:

COUNT(*) counts the number of items in a set. It includes NULL and duplicate values.
COUNT(ALL expression) evaluates the expression for each row in a set and returns the number of non-null values.
COUNT(DISTINCT expression) evaluates the expression for each row in a set, and returns the number of unique, non-null values.
SQL Server COUNT() function examples 
The following statement creates a new table named t, insert some data into the table, and query data against it:

CREATE TABLE t(
    val INT
);

INSERT INTO t(val)
VALUES(1),(2),(2),(3),(null),(null),(4),(5);

SELECT val FROM t;
Code language: SQL (Structured Query Language) (sql)
Output:

val
-----------
1
2
2
3
NULL
NULL
4
5
Code language: PHP (php)
Basic SQL Server COUNT(*) example 
The following example uses the COUNT(*) function to return the number of rows in the t table:

SELECT COUNT(*) val_count
FROM t;
Code language: SQL (Structured Query Language) (sql)
Output:

val_count
---------
8
SQL Server COUNT(DISTINCT expression) example 
The following example uses the COUNT(DISTINCT expression) to return the number of unique, non-null values in the t table:

SELECT
    COUNT(DISTINCT val) val_count
FROM
    t;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

val_count
-----------
5
Warning: Null value is eliminated by an aggregate or other SET operation.

(1 row affected)
Code language: PHP (php)
SQL Server COUNT( expression ) example 
The following example uses the COUNT(expression) to return the number of non-null values in the t table:

SELECT
    COUNT(val)
FROM
    t;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

val_count
-----------
6
Warning: Null value is eliminated by an aggregate or other SET operation.

(1 row affected)
Code language: PHP (php)
Practical examples of COUNT() function 
We’ll use the tables in the sample database for the demonstration.

The following statement uses the COUNT(*) function to return the number of rows in the products table:

SELECT 
    COUNT(*) product_count
FROM
    production.products;
Code language: SQL (Structured Query Language) (sql)
Output:

product_count
-------------
321

(1 row affected)
The following example uses the COUNT(*) function to retrieve the number of products whose model year is 2016 and the list price is higher than 999.99:

SELECT 
   COUNT(*)
FROM 
    production.products
WHERE 
    model_year = 2016
    AND list_price > 999.99;
Code language: SQL (Structured Query Language) (sql)
Output:

Result
-----------
7

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Using SQL Server COUNT() function with GROUP BY clause 
The following statement uses the COUNT(*) function to find the number of products in each product category:

SELECT 
    category_name,
    COUNT(*) product_count
FROM
    production.products p
    INNER JOIN production.categories c 
    ON c.category_id = p.category_id
GROUP BY 
    category_name
ORDER BY
    product_count DESC;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

category_name        product_count
-------------------- -------------
Cruisers Bicycles    78
Mountain Bikes       60
Road Bikes           60
Children Bicycles    59
Comfort Bicycles     30
Electric Bikes       24
Cyclocross Bicycles  10

(7 rows affected)
In this example, first, the GROUP BY clause divided the products into groups using category names then the COUNT() function is applied to each group.

Using SQL Server COUNT() with HAVING clause example 
The following statement returns the brand and the number of products for each. In addition, it returns only the brands that have the number of products greater than 20:

SELECT 
    brand_name,
    COUNT(*) product_count
FROM
    production.products p
    INNER JOIN production.brands c 
    ON c.brand_id = p.brand_id
GROUP BY 
    brand_name
HAVING
    COUNT(*) > 20
ORDER BY
    product_count DESC;
Code language: SQL (Structured Query Language) (sql)
The output is as follows:

brand_name           product_count
-------------------- -------------
Trek                 135
Electra              118
Surly                25
Sun Bicycles         23

(4 rows affected)
Summary 
Use the COUNT(*) to retrieve the number of rows in a table.
Use the COUNT(ALL expression) to count the number of non-null values.
Use the COUNT(DISTINCT expression) to obtain the number of unique, non-null values.
Was this tutorial helpful?


SQL Server MAX() Function
Summary: in this tutorial, you will learn how to use the SQL Server MAX() function to find the maximum value in a set.

Introduction to the SQL Server MAX() function 
In SQL Server, the MAX() function is an aggregate function that returns the maximum value in a set.

Here’s the syntax of the MAX() function:

MAX(expression)
Code language: SQL (Structured Query Language) (sql)
The MAX() function accepts an expression that can be a column or a valid expression.

Similar to the MIN() function, the MAX() function ignores NULL and considers all values including duplicates.

SQL Server MAX() function examples 
We will use the products and brands tables for the demonstration:

products brands
1) Basic SQL Server MAX() function example 
The following statement uses the MAX() function to find the highest list price of all products in the products table:

SELECT
    MAX(list_price) max_list_price
FROM
    production.products;
Code language: SQL (Structured Query Language) (sql)
Output:

max_list_price
--------------
11999.99
Code language: CSS (css)
The following example uses the MAX() function in a subquery to find the highest list price and outer query to retrieve the products with the highest prices:

SELECT
  product_id,
  product_name,
  list_price
FROM
  production.products
WHERE
  list_price = (
    SELECT
      MAX(list_price)
    FROM
      production.products
  );
Code language: SQL (Structured Query Language) (sql)
Output:

product_id | product_name                  | list_price
-----------+-------------------------------+-----------
155        | Trek Domane SLR 9 Disc - 2018 | 11999.99
(1 row)
In this example:

First, use the MAX() function in the subquery to return the highest list price of all products.
Then, retrieve the products whose list prices equal the highest price returned from the subquery in the outer query.
2) Using the MAX() with GROUP BY clause example 
The following statement uses the MAX() function with the GROUP BY clause to retrieve the brand names and the highest list price for each brand:

SELECT
  brand_name,
  MAX(list_price) max_list_price
FROM
  production.products p
  INNER JOIN production.brands b ON b.brand_id = p.brand_id
GROUP BY
  brand_name
ORDER BY
  brand_name;
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server MAX function with GROUP BY clause
In this example:

First, divide the products into groups by the brand names using the GROUP BY clause.
Then, apply the MAX() function to each group to get the highest list price for each brand name.
3) Using the MAX() with HAVING clause example 
The following example retrieves brand names and their corresponding highest list prices and filters out brands with the highest list prices less than or equal to 1000:

SELECT
    brand_name,
    MAX(list_price) max_list_price
FROM
    production.products p
    INNER JOIN production.brands b
        ON b.brand_id = p.brand_id 
GROUP BY
    brand_name
HAVING 
    MAX(list_price) > 1000
ORDER BY
    max_list_price DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

brand_name   | max_list_price
-------------+--------------
Trek         | 11999.99
Electra      | 2999.99
Heller       | 2599.00
Surly        | 2499.99
Sun Bicycles | 1559.99
Haro         | 1469.99
(6 rows)
4) Using the MAX() function with date columns 
The following example uses the MAX() function to find the orders with the latest required date:

SELECT
  MAX(required_date) latest_required_date
FROM
  sales.orders;
Code language: SQL (Structured Query Language) (sql)
Output:

latest_required_date
--------------------
2018-12-28
The following example uses the MAX() function with the GROUP BY clause to find the latest required date of all orders grouped by staff names:

SELECT
  s.first_name,
  MAX(required_date) latest_required_date
FROM
  sales.orders o
  INNER JOIN sales.staffs s ON s.staff_id = o.order_id
GROUP BY
  s.first_name
ORDER BY
  latest_required_date;
Code language: SQL (Structured Query Language) (sql)
Output:

first_name | latest_required_date
-----------+---------------------
Fabiola    | 2016-01-03
Mireya     | 2016-01-04
Virgie     | 2016-01-04
Genna      | 2016-01-05
Kali       | 2016-01-05
Jannette   | 2016-01-06
Bernardine | 2016-01-06
Marcelene  | 2016-01-07
Venita     | 2016-01-07
Layla      | 2016-01-08
(10 rows)
5) Using the MAX() function with text column 
The following statement uses the MAX() function to return the last product names sorted alphabetically within each category:

SELECT
  c.category_name   category_name,
  MIN(product_name) product_name
FROM
  production.products p
  INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
  c.category_name;
Code language: SQL (Structured Query Language) (sql)
Output:

category_name       | product_name
--------------------+------------------------------------------------
Children Bicycles   | Electra Cruiser 1 (24-Inch) - 2016
Comfort Bicycles    | Electra Townie Balloon 3i EQ - 2017/2018
Cruisers Bicycles   | Electra Amsterdam Fashion 3i Ladies' - 2017/2018
Cyclocross Bicycles | Surly Straggler - 2016
Electric Bikes      | Electra Loft Go! 8i - 2018
Mountain Bikes      | Haro Flightline One ST - 2017
Road Bikes          | Surly ECR - 2018
(7 rows)
Summary 
Use the MAX() function to find the maximum value in a set of values.
The MAX() function ignores NULL.
Was this tutorial helpful?

SQL Server MIN() Function
Summary: in this tutorial, you will learn how to use the SQL Server MIN() function to find the minimum value in a set.

Introduction to SQL Server MIN() function 
In SQL Server, the MIN() function is an aggregate function that allows you to find the minimum value in a set.

The following illustrates the syntax of the MIN() function:

MIN(expression)
Code language: SQL (Structured Query Language) (sql)
The MIN() function accepts an expression that can be a column or a valid expression.

The MIN() function applies to all values including duplicates. It means that the DISTINCT modifier does not affect the MIN() function. Note that the MIN() function ignores NULL.

SQL Server MIN() function examples 
We will use the products and categories tables from the sample database for the demonstration.

SQL Server MIN Function - Products & Categories Tables
1) Basic SQL Server MIN() function example 
The following example uses the MIN() function to find the lowest list price of all products in the production.products table:

SELECT
    MIN(list_price) min_list_price
FROM
    production.products;
Code language: SQL (Structured Query Language) (sql)
Output:

min_list_price
--------------
89.99
(1 row)
Code language: CSS (css)
The following example uses the MIN() function in a subquery to find the products with the lowest prices:

SELECT
  product_id,
  product_name,
  list_price
FROM
  production.products
WHERE
  list_price = (
    SELECT
      MIN(list_price)
    FROM
      production.products
  );
Code language: SQL (Structured Query Language) (sql)
Output:

product_id | product_name                           | list_price
-----------+----------------------------------------+-----------
263        | Strider Classic 12 Balance Bike - 2018 | 89.99
(1 row)
In this example:

First, the subquery uses the MIN() function to return the lowest list price.
Then, the outer query finds the products whose list prices equal the lowest price.
Note that the query will return multiple rows if the products table has multiple rows whose values in the list_price column are 89.99.

2) Using the MIN() function with GROUP BY clause example 
The following statement uses the MIN() function with the GROUP BY clause to find the lowest list price within each product category:

SELECT
  category_name,
  MIN(list_price) min_list_price
FROM
  production.products p
  INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
  category_name
ORDER BY
  category_name;
Code language: SQL (Structured Query Language) (sql)
Output:

category_name       | min_list_price
--------------------+----------------
Children Bicycles   | 89.99
Comfort Bicycles    | 416.99
Cruisers Bicycles   | 250.99
Cyclocross Bicycles | 1549.00
Electric Bikes      | 1559.99
Mountain Bikes      | 379.99
Road Bikes          | 749.99
(7 rows)
In this example:

First, the GROUP BY clause divides the products into groups by category name.
Second, apply the MIN() function to each group to find the lowest list price in each category.
3) Using the MIN() function with HAVING clause example 
The following example uses the MIN() function in the HAVING clause to retrieve the product category with a minimum list price greater than 500:

SELECT
  category_name,
  MIN(list_price) min_list_price
FROM
  production.products p
  INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
  category_name
HAVING
  MIN(list_price) > 500
ORDER BY
  category_name;
Code language: SQL (Structured Query Language) (sql)
Output:

category_name       | min_list_price
--------------------+---------------
Cyclocross Bicycles | 1549.00
Electric Bikes      | 1559.99
Road Bikes          | 749.99
(3 rows)
4) Using the MIN() function with a date column 
The following statement uses the MIN() function with the required_date column of the sales.orders table to get the earliest required date of all orders:

SELECT
  MIN(required_date) earliest_required_date
FROM
  sales.orders;
Code language: SQL (Structured Query Language) (sql)
Output:

earliest_required_date
----------------------
2016-01-03
The following example uses the MIN() function to find the earliest order dates by sales staff:

SELECT
  s.first_name,
  MIN(required_date) earliest_required_date
FROM
  sales.orders o
  INNER JOIN sales.staffs s ON s.staff_id = o.order_id
GROUP BY
  s.first_name
ORDER BY
  earliest_required_date;
Code language: SQL (Structured Query Language) (sql)
Output:

first_name | earliest_required_date
-----------+-----------------------
Fabiola    | 2016-01-03
Mireya     | 2016-01-04
Virgie     | 2016-01-04
Genna      | 2016-01-05
Kali       | 2016-01-05
Jannette   | 2016-01-06
Bernardine | 2016-01-06
Marcelene  | 2016-01-07
Venita     | 2016-01-07
Layla      | 2016-01-08
(10 rows)
5) Using the MIN() function with the text column 
The following example uses the MIN() function to return the first product name sorted alphabetically within each category:

SELECT
  c.category_name category_name,
  MIN(product_name) product_name
FROM
  production.products p
  INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
  c.category_name;
Code language: SQL (Structured Query Language) (sql)
Output:

category_name       | product_name
--------------------+------------------------------------------------
Children Bicycles   | Electra Cruiser 1 (24-Inch) - 2016
Comfort Bicycles    | Electra Townie Balloon 3i EQ - 2017/2018
Cruisers Bicycles   | Electra Amsterdam Fashion 3i Ladies' - 2017/2018
Cyclocross Bicycles | Surly Straggler - 2016
Electric Bikes      | Electra Loft Go! 8i - 2018
Mountain Bikes      | Haro Flightline One ST - 2017
Road Bikes          | Surly ECR - 2018
(7 rows)
Summary 
Use the MIN() function to find the minimum value in a set of values.
The MIN() function ignores NULL.
Was this tutorial helpful?

SQL Server STDEV() Function
Summary: in this tutorial, you will learn how to use the SQL Server STDEV() function to calculate the sample standard deviation of a set of values.

Introduction to the SQL Server STDEV() function 
Standard deviation measures the variation or dispersion of values in a set of values.

A low standard deviation indicates that values tend to be close to the mean whereas a high standard deviation shows the values are spread out over a wider range.

There are two types of standard deviations:

Population standard deviation analyzes the entire population.
Sample standard deviation analyzes a subset (sample) of the population.
In SQL Server, you can use the STDEV() function to calculate the sample standard deviation of a set of values.

Here’s the syntax of the STDEV function:

STDEV ( [ ALL | DISTINCT ] expression )  
Code language: SQL (Structured Query Language) (sql)
In this syntax:

The ALL option instructs the function to apply to all values including duplicates. The default value is ALL.
The DISTINCT option instructs the function to apply to unique values instead.
The expression is a table column or an expression that contains the values to which the function applies.
The STDEV() function returns the standard deviation of values in the table column specified by the expression as a float number.

SQL Server STDEV() function example 
First, create a new table called salaries that stores the salaries of employees:

CREATE TABLE salaries (
    id INT IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    salary DEC(10, 2) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Second, insert some rows into the salaries table:

INSERT INTO
  salaries (name, salary)
VALUES
  ('John', 60000.00),
  ('Alice', 65000.00),
  ('Bob', 70000.00),
  ('Emily', 55000.00),
  ('Michael', 75000.00),
  ('Sophia', 80000.00),
  ('David', 50000.00),
  ('Emma', 75000.00),
  ('James', 110000.00),
  ('Olivia', 120000.00);
Code language: SQL (Structured Query Language) (sql)
Third, retrieve data from the salaries table:

SELECT * FROM salaries;
Code language: SQL (Structured Query Language) (sql)
Output:

id | name    | salary
---+---------+---------
1  | John    | 60000.00
2  | Alice   | 65000.00
3  | Bob     | 70000.00
4  | Emily   | 55000.00
5  | Michael | 75000.00
6  | Sophia  | 80000.00
7  | David   | 50000.00
8  | Emma    | 75000.00
9  | James   | 110000.00
10 | Olivia  | 120000.00
(10 rows)
Code language: plaintext (plaintext)
Fourth, use the STDEV() function to calculate the sample standard deviation of the salaries:

SELECT STDEV(salary) salary_stdev
FROM salaries;
Code language: SQL (Structured Query Language) (sql)
Output:

salary_stdev
-----------------
22705.84848790187
Code language: plaintext (plaintext)
To make the standard deviation more readable, you can round it using the ROUND() function:

SELECT
  ROUND(STDEV (salary), 0) salary_stdev
FROM
  salaries;
Code language: SQL (Structured Query Language) (sql)
Output:

salary_stdev
------------
22706.00
Code language: plaintext (plaintext)
Fifth, calculate the differences between the standard deviation and the mean:

SELECT
  ROUND(AVG(salary) - STDEV (salary), 0) low,
  ROUND(AVG(salary) + STDEV (salary), 0) high
FROM
  salaries;
Code language: SQL (Structured Query Language) (sql)
Output:

low      | high
---------+---------
53294.00 | 98706.00
(1 row)
Code language: plaintext (plaintext)
The low is 53,294 and the high is 98,706.

Based on the standard deviation, we can show which salary is within one standard deviation of the mean. In other words, we have a “standard” way of knowing what is low, normal, and high salary:

SQL Server STDEV() Function
The chart shows that:

John, Alice, Bob, Emily, Michael, Sophia, and Emma have the normal salary.
David has a low salary.
James and Olivia have a high salary.
Summary 
Use the STDEV() function to calculate the sample standard deviation of a set of values.
Was this tutorial helpful?

SQL Server SUM() Function
Summary: in this tutorial, you will learn how to use SQL Server SUM() function to calculate the sum of values.

Introduction to SQL Server SUM() function 
The SQL Server SUM() function is an aggregate function that calculates the sum of all or distinct values in an expression.

Here’s the syntax of the SUM() function:

SUM([ALL | DISTINCT ] expression)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

ALL instructs the SUM() function to return the sum of all values including duplicates. ALL is used by default.
DISTINCT instructs the SUM() function to calculate the sum of the only distinct values.
 expression is any valid expression that returns an exact or approximate numeric value. Note that aggregate functions or subqueries are not accepted in the expression.
The SUM() function ignores NULL values.

ALL vs. DISTINCT 
Let’s create a new table to demonstrate the difference between ALL and DISTINCT options:

CREATE TABLE t(
    val INT
);

INSERT INTO t(val)
VALUES(1),(2),(3),(3),(4),(NULL),(5);

SELECT
    val
FROM
    t;
Code language: SQL (Structured Query Language) (sql)
Output:

val
-----------
1
2
3
3
4
NULL
5

(7 rows affected)
Code language: PHP (php)
The following statement uses the SUM() function to calculate the total of all values in the val column:

SELECT
    SUM(val) total
FROM
    t;
Code language: SQL (Structured Query Language) (sql)
Output:

total
-----------
18
Warning: Null value is eliminated by an aggregate or other SET operation.

(1 row affected)
Code language: PHP (php)
However, when you use the DISTINCT modifier, the SUM() function returns the sum of unique values in the val column:

SELECT
    SUM(DISTINCT val) total
FROM
    t;
Code language: SQL (Structured Query Language) (sql)
Output:

total
-----------
15
Warning: Null value is eliminated by an aggregate or other SET operation.

(1 row affected)
Code language: PHP (php)
SQL Server SUM() function examples 
Let’s take some practical examples of using the SUM() function. We’ll use the tables from the sample database for the demonstration.

1) Basic SQL Server SUM() function example 
The following statement uses the SUM() function to calculate the total stocks of all products in all stores:

SELECT 
    SUM(quantity) total_stocks
FROM 
    production.stocks;
Code language: SQL (Structured Query Language) (sql)
Output:

total_stocks
------------
13511

(1 row affected)
Code language: plaintext (plaintext)
2) Using the SUM() function with GROUP BY example 
The following statement uses the SUM() function with the GROUP BY clause to find total stocks by store id:

SELECT
    store_id,
    SUM(quantity) store_stocks
FROM
    production.stocks
GROUP BY
    store_id;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

store_id | store_stocks
---------+------------
1        | 4532
2        | 4359
3        | 4620
(3 rows)
Code language: plaintext (plaintext)
In this example:

First, the GROUP BY clause divided the stocks by store id into groups.
Second, the SUM() function is applied to each group to calculate the total stocks for each.
If you want to display the store name instead of store id, you can use the following statement:

SELECT
    store_name,
    SUM(quantity) store_stocks
FROM
    production.stocks w
    INNER JOIN sales.stores s
        ON s.store_id = w.store_id
GROUP BY
    store_name;
Code language: SQL (Structured Query Language) (sql)
Output:

store_name       | store_stocks
-----------------+------------
Baldwin Bikes    | 4359
Rowlett Bikes    | 4620
Santa Cruz Bikes | 4532
(3 rows)
Code language: plaintext (plaintext)
3) Using the SUM() function with HAVING clause example 
The following statement uses the SUM() function in the HAVING clause to find stocks for each product and return only products whose stocks are greater than 100:

SELECT
    product_name,
    SUM(quantity) total_stocks
FROM
    production.stocks s
    INNER JOIN production.products p
        ON p.product_id = s.product_id
GROUP BY
    product_name
HAVING
    SUM(quantity) > 100
ORDER BY
    total_stocks DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

product_name                                          | total_stocks
------------------------------------------------------+--------------
Electra Townie Original 7D - 2017                     | 125
Electra Townie Balloon 8D EQ Ladies' - 2016/2017/2018 | 121
Electra Townie Go! 8i - 2017/2018                     | 120
Electra Townie Commute 8D - 2018                      | 119
Sun Bicycles Cruz 7 - 2017                            | 115
Surly Straggler - 2018                                | 109
Sun Bicycles Cruz 3 - 2017                            | 109
Electra Townie Original 21D - 2018                    | 109
Electra Girl's Hawaii 1 16" - 2017                    | 107
(9 rows)\
Code language: plaintext (plaintext)
4) Using the SUM() function with expression example 
The following example uses an expression in the SUM() function to calculate the net value for each sales order:

SELECT
    order_id,
    SUM(
        quantity * list_price * (1 - discount)
    ) net_value
FROM
    sales.order_items
GROUP BY
    order_id
ORDER BY
    net_value DESC;
Code language: SQL (Structured Query Language) (sql)
Output:

order_id | net_value
---------+------------
1541     | 29147.0264
937      | 27050.7182
1506     | 25574.9555
1482     | 25365.4344
...
Code language: plaintext (plaintext)
Summary 
Use the SUM() function to calculate the sum of values.
Use the DISTINCT option to calculate the sum of distinct values.
Use the ALL option to calculate the sum of all values including duplicates.
Was this tutorial helpful?

SQL Server SUM IF
Summary: in this tutorial, you will learn about the SQL Server SUM IF function to calculate the sum of values based on a condition.

Introduction to SQL Server SUM IF 
In SQL Server, the SUM is an aggregate function that allows you to calculate the total of values in a set. Here’s the syntax of the SUM function:

SUM(expresion)
Code language: SQL (Structured Query Language) (sql)
The IIF function allows you to return a value when a condition is true or another value when the condition is false. The following shows the syntax for the IIF function:

IIF(condition, value_if_true, value_if_false)
Code language: SQL (Structured Query Language) (sql)
When combining the SUM function with the IIF function, you can calculate the sum of values based on a condition.

The following shows how to use the SUM function with the IIF function:

SUM(IIF(condition, value_to_sum_when_true, value_to_sum_when_false))
Code language: SQL (Structured Query Language) (sql)
In this expression:

condition: Specify the condition that you want to include values for calculating the total.
value_to_sum_when_true: Specify the value that you want to calculate the total if the condition is true.
value_to_sum_when_false: Specify the value that you want to calculate the total when the condition is false.
SQL Server SUM IF example 
Let’s explore an example of using the SUM IF.

We’ll use the sales.orders and sales.order_items tables from the sample database:

SQL Server SUM IF Sample Tables
1) Basic SUM IF example 
The following example uses the SUM function with the IIF function to calculate the total amount of pending orders with the order status 1:

SELECT
  SUM(
    IIF(
      o.order_status = 1, 
      quantity * list_price * (1 - discount), 
      0
    )
  ) total_pending_amount 
FROM
  sales.order_items i 
  INNER JOIN sales.orders o ON o.order_id = i.order_id;
Code language: SQL (Structured Query Language) (sql)
Output:

total_pending_amount
--------------------
388739.5422
Code language: plaintext (plaintext)
The output indicates that the total pending amount is about 388,739.

2) Using multiple SUM IF example 
The following example uses the SUM with the IIF function to calculate the total amount of pending and rejected orders with the order status 1 and 3 respectively:

SELECT
  SUM(
    IIF(
      o.order_status = 1, 
      quantity * list_price * (1 - discount), 
      0
    )
  ) total_pending_amount,
  SUM(
    IIF(
      o.order_status = 3, 
      quantity * list_price * (1 - discount), 
      0
    )
  ) total_rejected_amount 
FROM
  sales.order_items i 
  INNER JOIN sales.orders o ON o.order_id = i.order_id;
Code language: SQL (Structured Query Language) (sql)
Output:

total_pending_amount | total_rejected_amount
---------------------+----------------------
388739.5422          | 208579.4531
Code language: plaintext (plaintext)
Summary 
Use the SUM function with the IIF function to form a SUM IF function that returns the total values based on a condition.
Was this tutorial helpful?

SQL Server VAR() Function
Summary: in this tutorial, you will learn how to use the SQL Server VAR() function to calculate the sample variances of values.

Introduction to the sample variance 
A sample variance measures how far a set of numbers is spread out from their average value (mean). A sample variance allows you to get insights into the variability within a sample dataset.

To calculate a sample variance of a set of n numbers, you follow these steps:

First, calculate the average (or mean) by dividing the sum of all numbers by the number of values in the set.
Second, calculate the total of square differences.
Third, divide the total of square differences by the number of values minus one.
For example, given a sample set {1, 2, 3 }, you can calculate the sample variance as follows:

First, calculate the mean:

(1 + 2 + 3) / 3 = 2

Second, calculate the total square difference between each number and the mean:

(1−2)2+(2−2)2+(3−2)2 = 2

Third, calculate the sample variance:

2 / (3 – 1) = 1

The sample variance is 1.

The SQL Server VAR() aggregate function 
In SQL Server, you can use the VAR() aggregate function to calculate the sample variance of a set of numbers.

Here’s the syntax of the VAR() function:

VAR( [ALL | DISTINCT] expression)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

ALL: This option instructs the function to use all values including duplicate ones for calculating the sample variance.
DISTINCT: This option instructs the function to use unique values for calculating the sample variance.
The VAR() function uses the ALL option by default. Please note that the VAR() function ignores NULL.

The VAR() function returns the sample variance as a float number. It returns NULL if there is one or no row in the sample.

SQL Server VAR() function examples 
Let’s explore some examples that use the SQL Server VAR() function.

1) Basic SQL Server VAR() function examples 
First, create a sample table called t with one column id that has some numbers 1, 2, 2, 3, and NULL:

CREATE TABLE t (id INT);

INSERT INTO
  t (id)
VALUES
  (1),
  (2),
  (2),
  (3),
  (NULL);

SELECT * FROM t;
Code language: SQL (Structured Query Language) (sql)
Output:

id
-----------
1
2
2
3
NULL
Code language: SQL (Structured Query Language) (sql)
Second, calculate the sample variance of unique values in the id column of the t table using the VAR() function with DISTINCT option:

SELECT
  VAR(DISTINCT id) variance
FROM
  t;
Code language: SQL (Structured Query Language) (sql)
Output:

variance
----------------------
1
Warning: Null value is eliminated by an aggregate or other SET operation.

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
The sample variance is 1.

Second, calculate the sample variance of all values including duplicates in the id column of the t table using the VAR() function:

variance
----------------------
0.666666666666667
Warning: Null value is eliminated by an aggregate or other SET operation.

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
The sample variance is 0.666666666666667.

2) Practical VAR() function examples 
We’ll use the tables from the sample database for the demonstration:

products brands
The following example uses the VAR() function to calculate the sample variance of list prices of the brand id 1 and category id 5 in the production.products table:

SELECT
  VAR(list_price) var_list_price
FROM
  production.products
WHERE
  brand_id = 1
  AND category_id = 5;
Code language: SQL (Structured Query Language) (sql)
Output:

var_list_price
----------------------
40000
Code language: SQL (Structured Query Language) (sql)
To interpret the sample variance, we can include the average list price in the result set:

SELECT
  VAR(list_price) var_list_price,
  AVG(list_price) avg_list_price
FROM
  production.products
WHERE
  brand_id = 1
  AND category_id = 5;
Code language: SQL (Structured Query Language) (sql)
Output:

var_list_price | avg_list_price
---------------+---------------
40000.0        | 2799.990000
Code language: SQL (Structured Query Language) (sql)
A sample variance of 40,000.0 means that the list prices of products within the category id 5 and brand 1 have a relatively high degree of variability around the mean list price of 2,799.99.

The following example uses the VAR() function to calculate the sample variances of list prices of products in category id 1 for each brand:

SELECT
  b.brand_name,
  AVG(list_price) avg_list_price,
  VAR(list_price) var_list_price
FROM
  production.products p
INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE
  category_id = 1 
GROUP BY
  b.brand_name;
Code language: SQL (Structured Query Language) (sql)
Output:

brand_name   | avg_list_price | var_list_price
-------------+----------------+--------------------
Electra      | 330.347142     | 3248.015873015962
Haro         | 249.990000     | 3199.9999999999905
Strider      | 209.990000     | 11200.0
Sun Bicycles | 109.990000     | NULL
Trek         | 260.424782     | 8040.7114624506585
(5 rows)
Code language: SQL (Structured Query Language) (sql)
The output indicates that:

The Sun Bicycles brand has a sample variance of the list price NULL because it has one product with a list price of 109.99 as indicated in the avg_list_price column.
The Strider brand has the highest degree of variability around the mean list price of 209.99, compared to other brands.
Electra, Haro, and Trek brands have less spread or dispersion of list prices around their respective means compared with other brands.
Summary 
Use the VAR() function to calculate the sample variances of values.
Was this tutorial helpful?