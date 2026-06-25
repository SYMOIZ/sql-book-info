In this section, you will learn about SQL Server user-defined functions including scalar-valued functions which return a single value and table-valued function which return rows of data.

The SQL Server user-defined functions help you simplify your development by encapsulating complex business logic and make them available for reuse in every query.

User-defined scalar functions – cover the user-defined scalar functions that allow you to encapsulate complex formula or business logic and reuse them in every query.
Table variables – learn how to use table variables as a return value of user-defined functions.
Table-valued functions – introduce you to inline table-valued function and multi-statement table-valued function to develop user-defined functions that return data of table types.
Removing user-defined functions – learn how to drop one or more existing user-defined functions from the database.  
SQL Server Scalar Functions
Summary: in this tutorial, you will learn about SQL Server scalar functions and how to use them to encapsulate formulas or business logic and reuse them in the queries.

What are scalar functions 
SQL Server scalar function takes one or more parameters and returns a single value.

The scalar functions help you simplify your code. For example, you may have a complex calculation that appears in many queries. Instead of including the formula in every query, you can create a scalar function that encapsulates the formula and uses it in each query.

Creating a scalar function 
To create a scalar function, you use the CREATE FUNCTION statement as follows:

CREATE FUNCTION [schema_name.]function_name (parameter_list)
RETURNS data_type AS
BEGIN
    statements
    RETURN value
END
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the function after the CREATE FUNCTION keywords. The schema name is optional. If you don’t explicitly specify it, SQL Server uses dbo by default.
Second, specify a list of parameters surrounded by parentheses after the function name.
Third, specify the data type of the return value in the RETURNS statement.
Finally, include a RETURN statement to return a value inside the body of the function.
The following example creates a function that calculates the net sales based on the quantity, list price, and discount:

CREATE FUNCTION sales.udfNetSale(
    @quantity INT,
    @list_price DEC(10,2),
    @discount DEC(4,2)
)
RETURNS DEC(10,2)
AS 
BEGIN
    RETURN @quantity * @list_price * (1 - @discount);
END;
Code language: SQL (Structured Query Language) (sql)
Later on, we can use this to calculate net sales of any sales order in the order_items from the sample database.

order_items table
After creating the scalar function, you can find it under Programmability > Functions > Scalar-valued Functions as shown in the following picture:

SQL Server Scalar Function
Calling a scalar function 
You call a scalar function like a built-in function. For example, the following statement demonstrates how to call the udfNetSale function:

SELECT 
    sales.udfNetSale(10,100,0.1) net_sale;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Scalar Function example
The following example illustrates how to use the sales.udfNetSale function to get the net sales of the sales orders in the order_items table:

SELECT 
    order_id, 
    SUM(sales.udfNetSale(quantity, list_price, discount)) net_amount
FROM 
    sales.order_items
GROUP BY 
    order_id
ORDER BY
    net_amount DESC;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial output:

SQL Server Scalar Function - calling function
Modifying a scalar function 
To modify a scalar function, you use the ALTER instead of the CREATE keyword. The rest statements remain the same:

ALTER FUNCTION [schema_name.]function_name (parameter_list)
    RETURN data_type AS
    BEGIN
        statements
        RETURN value
    END
Code language: SQL (Structured Query Language) (sql)
Note that you can use the CREATE OR ALTER statement to create a user-defined function if it does not exist or to modify an existing scalar function:

CREATE OR ALTER FUNCTION [schema_name.]function_name (parameter_list)
        RETURN data_type AS
        BEGIN
            statements
            RETURN value
        END
Code language: SQL (Structured Query Language) (sql)
Removing a scalar function 
To remove an existing scalar function, you use the DROP FUNCTION statement:

DROP FUNCTION [schema_name.]function_name;
Code language: SQL (Structured Query Language) (sql)
For example, to remove the sales.udfNetSale function, you use the following statement:

DROP FUNCTION sales.udfNetSale;
Code language: SQL (Structured Query Language) (sql)
SQL Server scalar function notes 
The following are some key takeaway of the scalar functions:

Scalar functions can be used almost anywhere in T-SQL statements.
Scalar functions accept one or more parameters but return only one value, therefore, they must include a RETURN statement.
Scalar functions can use logic such as IF blocks or WHILE loops.
Scalar functions cannot update data. They can access data but this is not a good practice.
Scalar functions can call other functions.
In this tutorial, you have learned how to use SQL Server scalar functions to encapsulate complex formulas or complex business logic and reuse them in queries.

Was this tutorial helpful?  


SQL Server Table Variables
Summary: in this tutorial, you will learn about the SQL Server table variables that hold rows of data.

What are table variables 
Table variables are kinds of variables that allow you to hold rows of data, which are similar to temporary tables.

How to declare table variables 
To declare a table variable, you use the DECLARE statement as follows:

DECLARE @table_variable_name TABLE (
    column_list
);
Code language: SQL (Structured Query Language) (sql)
In this syntax, you specify the name of the table variable between the DECLARE and TABLE keywords. The name of the table variables must start with the @ symbol.

Following the TABLE keyword, you define the structure of the table variable which is similar to the structure of a regular table that includes column definitions, data type, size, optional constraint, etc.

The scope of table variables 
Similar to local variables, table variables are out of scope at the end of the batch.

If you define a table variable in a stored procedure or user-defined function, the table variable will no longer exist after the stored procedure or user-defined function exits.

Table variable example 
For example, the following statement declares a table variable named @product_table which consists of three columns: product_name, brand_id, and list_price:

DECLARE @product_table TABLE (
    product_name VARCHAR(MAX) NOT NULL,
    brand_id INT NOT NULL,
    list_price DEC(11,2) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Inserting data into the table variables 
Once declared, the table variable is empty. You can insert rows into the table variables using the INSERT statement:

INSERT INTO @product_table
SELECT
    product_name,
    brand_id,
    list_price
FROM
    production.products
WHERE
    category_id = 1;
Code language: SQL (Structured Query Language) (sql)
Querying data from the table variables 
Similar to a temporary table, you can query data from the table variables using the SELECT statement:

SELECT
    *
FROM
    @product_table;
Code language: SQL (Structured Query Language) (sql)
Note that you need to execute the whole batch or you will get an error:

DECLARE @product_table TABLE (
    product_name VARCHAR(MAX) NOT NULL,
    brand_id INT NOT NULL,
    list_price DEC(11,2) NOT NULL
);

INSERT INTO @product_table
SELECT
    product_name,
    brand_id,
    list_price
FROM
    production.products
WHERE
    category_id = 1;

SELECT
    *
FROM
    @product_table;
GO
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial output:

SQL Server Table Variables Example
Restrictions on table variables 
First, you have to define the structure of the table variable during the declaration. Unlike a regular or temporary table, you cannot alter the structure of the table variables after they are declared.

Second, statistics help the query optimizer to come up with a good query’s execution plan. Unfortunately, table variables do not contain statistics. Therefore, you should use table variables to hold a small number of rows.

Third, you cannot use the table variable as an input or output parameter like other data types. However, you can return a table variable from a user-defined function

Fourth, you cannot create non-clustered indexes for table variables. However, starting with SQL Server 2014, memory-optimized table variables are available with the introduction of the new In-Memory OLTP that allows you to add non-clustered indexes as part of table variable’s declaration.

Fifth, if you are using a table variable with a join, you need to alias the table in order to execute the query. For example:

SELECT
    brand_name,
    product_name,
    list_price
FROM
    brands b
INNER JOIN @product_table pt 
    ON p.brand_id = pt.brand_id;
Code language: SQL (Structured Query Language) (sql)
Performance of table variables 
Using table variables in a stored procedure results in fewer recompilations than using a temporary table.

In addition, a table variable use fewer resources than a temporary table with less locking and logging overhead.

Similar to the temporary table, the table variables do live in the tempdb database, not in the memory.

Using table variables in user-defined functions 
The following user-defined function named ufnSplit() that returns a table variable.

CREATE OR ALTER FUNCTION udfSplit(
    @string VARCHAR(MAX), 
    @delimiter VARCHAR(50) = ' ')
RETURNS @parts TABLE
(    
idx INT IDENTITY PRIMARY KEY,
val VARCHAR(MAX)   
)
AS
BEGIN

DECLARE @index INT = -1;

WHILE (LEN(@string) > 0) 
BEGIN 
    SET @index = CHARINDEX(@delimiter , @string)  ;
    
    IF (@index = 0) AND (LEN(@string) > 0)  
    BEGIN  
        INSERT INTO @parts 
        VALUES (@string);
        BREAK  
    END 

    IF (@index > 1)  
    BEGIN  
        INSERT INTO @parts 
        VALUES (LEFT(@string, @index - 1));
        
        SET @string = RIGHT(@string, (LEN(@string) - @index));  
    END 
    ELSE
    SET @string = RIGHT(@string, (LEN(@string) - @index)); 
    END
RETURN
END
GO
Code language: SQL (Structured Query Language) (sql)
The following statement calls the udfSplit() function:

SELECT 
    * 
FROM 
    udfSplit('foo,bar,baz',',');
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Table Variables - user-defined function example
In this tutorial, you will learn how to use the SQL Server table variables which offer some performance benefits and flexibility in comparison with temporary tables.

Was this tutorial helpful?

SQL Server Table-valued Functions
Summary: in this tutorial, you will learn how to use SQL Server table-valued function including inline table-valued function and multi-statement valued functions.

What is a table-valued function in SQL Server 
A table-valued function is a user-defined function that returns data of a table type. The return type of a table-valued function is a table, therefore, you can use the table-valued function just like you would use a table.

Creating a table-valued function 
The following statement example creates a table-valued function that returns a list of products including product name, model year and the list price for a specific model year:

CREATE FUNCTION udfProductInYear (
    @model_year INT
)
RETURNS TABLE
AS
RETURN
    SELECT 
        product_name,
        model_year,
        list_price
    FROM
        production.products
    WHERE
        model_year = @model_year;
Code language: SQL (Structured Query Language) (sql)
The syntax is similar to the one that creates a user-defined function.

The RETURNS TABLE specifies that the function will return a table. As you can see, there is no BEGIN...END statement. The statement simply queries data from the production.products table.

The udfProductInYear function accepts one parameter named @model_year of type INT. It returns the products whose model years equal @model_year parameter.

Once the table-valued function is created, you can find it under Programmability > Functions > Table-valued Functions as shown in the following picture:

SQL Server Table-valued Function example
The function above returns the result set of a single SELECT statement, therefore, it is also known as an inline table-valued function.

Executing a table-valued function 
To execute a table-valued function, you use it in the FROM clause of the SELECT statement:

SELECT 
    * 
FROM 
    udfProductInYear(2017);
Code language: SQL (Structured Query Language) (sql)
SQL Server Table-valued Function Execution
In this example, we selected the products whose model year is 2017.

You can also specify which columns to be returned from the table-valued function as follows:

SELECT 
    product_name,
    list_price
FROM 
    udfProductInYear(2018);
Code language: SQL (Structured Query Language) (sql)
Here is the partial output:

SQL Server Table-valued Function - Selecting columns
Modifying a table-valued function 
To modify a table-valued function, you use the ALTER instead of CREATE keyword. The rest of the script is the same.

For example, the following statement modifies the udfProductInYear by changing the existing parameter and adding one more parameter:

ALTER FUNCTION udfProductInYear (
    @start_year INT,
    @end_year INT
)
RETURNS TABLE
AS
RETURN
    SELECT 
        product_name,
        model_year,
        list_price
    FROM
        production.products
    WHERE
        model_year BETWEEN @start_year AND @end_year
Code language: SQL (Structured Query Language) (sql)
The udfProductInYear function now returns products whose model year between a starting year and an ending year.

The following statement calls the udfProductInYear function to get the products whose model years are between 2017 and 2018:

SELECT 
    product_name,
    model_year,
    list_price
FROM 
    udfProductInYear(2017,2018)
ORDER BY
    product_name;
Code language: SQL (Structured Query Language) (sql)
Here is the partial output:

SQL Server Table-valued Function Modifying
Multi-statement table-valued functions (MSTVF) 
A multi-statement table-valued function or MSTVF is a table-valued function that returns the result of multiple statements.

The multi-statement-table-valued function is very useful because you can execute multiple queries within the function and aggregate results into the returned table.

To define a multi-statement table-valued function, you use a table variable as the return value. Inside the function, you execute one or more queries and insert data into this table variable.

The following udfContacts() function combines staffs and customers into a single contact list:

CREATE FUNCTION udfContacts()
    RETURNS @contacts TABLE (
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        email VARCHAR(255),
        phone VARCHAR(25),
        contact_type VARCHAR(20)
    )
AS
BEGIN
    INSERT INTO @contacts
    SELECT 
        first_name, 
        last_name, 
        email, 
        phone,
        'Staff'
    FROM
        sales.staffs;

    INSERT INTO @contacts
    SELECT 
        first_name, 
        last_name, 
        email, 
        phone,
        'Customer'
    FROM
        sales.customers;
    RETURN;
END;
Code language: SQL (Structured Query Language) (sql)
The following statement illustrates how to execute a multi-statement table-valued function udfContacts:

SELECT 
    * 
FROM
    udfContacts();
Code language: SQL (Structured Query Language) (sql)
Output:


When to use table-valued functions 
We typically use table-valued functions as parameterized views. In comparison with stored procedures, the table-valued functions are more flexible because we can use them wherever tables are used.

In this tutorial, you have learned about SQL Server table-valued function including inline table-valued functions and multi-statement table-valued functions.

Was this tutorial helpful?

SQL Server DROP FUNCTION
Summary: in this tutorial, you will learn how to remove an existing user-defined function by using the SQL Server DROP FUNCTION statement.

Introduction to SQL Server DROP FUNCTION statement 
To remove an existing user-defined function created by the CREATE FUNCTION statement, you use the DROP FUNCTION statement as follows:

DROP FUNCTION [ IF EXISTS ] [ schema_name. ] function_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

 IF EXISTS 
The IF EXISTS option allows you to drop the function only if it exists. Otherwise, the statement does nothing. If you attempt to remove a non-existing function without specifying the IF EXISTS option, you will get an error.

 schema_name 
The schema_name specifies the name of the schema to which the user-defined function which you wish to remove belongs. The schema name is optional.

 function_name 
The function_name is the name of the function that you want to remove.

Notes 
If the function that you want to remove is referenced by views or other functions created using the WITH SCHEMABINDING option, the DROP FUNCTION will fail.

In addition, if there are constraints like CHECK or DEFAULT and computed columns that refer to the function, the DROP FUNCTION statement will also fail.

To drop multiple user-defined functions, you specify a comma-separated list of function names in after the DROP FUNCTION clause as follows:

DROP FUNCTION [IF EXISTS] 
    schema_name.function_name1, 
    schema_name.function_name2,
    ...;
Code language: SQL (Structured Query Language) (sql)
SQL Server DROP FUNCTION example 
We will use the order_items from the sample database for the demonstration:

order_items
SQL Server DROP FUNCTION – a simple example 
The following example creates a function that calculates discount amount from quantity, list price, and discount percentage:

CREATE FUNCTION sales.udf_get_discount_amount (
    @quantity INT,
    @list_price DEC(10,2),
    @discount DEC(4,2) 
)
RETURNS DEC(10,2) 
AS 
BEGIN
    RETURN @quantity * @list_price * @discount
END
Code language: SQL (Structured Query Language) (sql)
To drop the sales.udf_get_discount_amount function, you use the following statement:

DROP FUNCTION IF EXISTS sales.udf_get_discount_amount;
Code language: SQL (Structured Query Language) (sql)
SQL Server DROP FUNCTION with SCHEMABINDING example 
The following example recreates the function sales.udf_get_discount_amountusing the WITH SCHEMABINDING option:

CREATE FUNCTION sales.udf_get_discount_amount (
    @quantity INT,
    @list_price DEC(10,2),
    @discount DEC(4,2) 
)
RETURNS DEC(10,2) 
WITH SCHEMABINDING
AS 
BEGIN
    RETURN @quantity * @list_price * @discount
END
Code language: SQL (Structured Query Language) (sql)
And the following statement creates a view that uses the sales.udf_get_discount_amount function:

CREATE VIEW sales.discounts
WITH SCHEMABINDING
AS
SELECT
    order_id,
    SUM(sales.udf_get_discount_amount(
        quantity,
        list_price,
        discount
    )) AS discount_amount
FROM
    sales.order_items i
GROUP BY
    order_id;
Code language: SQL (Structured Query Language) (sql)
Now, if you try to remove the sales.udf_get_discount_amount function, you will get an error:

DROP FUNCTION sales.udf_get_discount_amount;
Code language: SQL (Structured Query Language) (sql)
SQL Server returns the following error:

Cannot DROP FUNCTION 'sales.udf_get_discount_amount' because it is being referenced by object 'discounts'.
Code language: SQL (Structured Query Language) (sql)
If you want to remove the function, you must drop the sales.discounts view first:

DROP VIEW sales.discounts;
Code language: SQL (Structured Query Language) (sql)
And then drop the function;

DROP FUNCTION sales.udf_get_discount_amount;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server DROP FUNCTION to remove one or more existing user-defined functions.

Was this tutorial helpful?