SQL Server Stored Procedures
SQL Server stored procedures are used to group one or more Transact-SQL statements into logical units. The stored procedure is stored as a named object in the SQL Server Database Server.

When you call a stored procedure for the first time, SQL Server creates an execution plan and stores it in the cache. In the subsequent executions of the stored procedure, SQL Server reuses the plan to execute the stored procedure very fast with reliable performance.

This tutorial series introduces you to the stored procedures and shows you how to develop flexible stored procedures to optimize database access.

Section 1. Getting started with SQL Server Stored Procedures 
A basic guide to stored procedures – show you how to create, execute, modify, and drop a stored procedure in SQL Server.
Parameters – learn how to create stored procedures with parameters, including optional parameters.
Variables  –  introduce you to Transact-SQL variables and how to manipulate variables in stored procedures.
Output Parameters  – guide you on how to return data from a stored procedure back to the calling program using the output parameters.
Section 2. Control-of-flow statements 
BEGIN…END – create a statement block that consists of multiple Transact-SQL statements that execute together.
IF ELSE – execute a statement block based on a condition.
WHILE – repeatedly execute a set of statements based on a condition as long as the condition is true.
BREAK – exit the loop immediately and skip the rest of the code after it within a loop.
CONTINUE – skip the current iteration of the loop immediately and continue the next one.
Section 3. Cursors 
Cursor  – show you how to handle cursors.
Section 4. Handling Exceptions 
TRY CATCH – learn how to handle exceptions gracefully in stored procedures.
RAISERROR – show you how to generate user-defined error messages and return it back to the application using the same format as the system error.
THROW – walk you through the steps of raising an exception and transferring the execution to the CATCH block of a TRY CATCH construct.
Section 5. Dynamic SQL 
Dynamic SQL – learn how to construct general-purpose and flexible SQL statements using the dynamic SQL technique.

A Basic Guide to SQL Server Stored Procedures
Summary: in this tutorial, you will learn how to manage stored procedures in SQL Server including creating, executing, modifying, and deleting stored procedures.

Creating a simple stored procedure 
The following SELECT statement returns a list of products from the products table in the BikeStores sample database:

SELECT 
	product_name, 
	list_price
FROM 
	production.products
ORDER BY 
	product_name;
Code language: SQL (Structured Query Language) (sql)
To create a stored procedure that wraps this query, you use the CREATE PROCEDURE statement as follows:

CREATE PROCEDURE uspProductList
AS
BEGIN
    SELECT 
        product_name, 
        list_price
    FROM 
        production.products
    ORDER BY 
        product_name;
END;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

The uspProductList is the name of the stored procedure.
The AS keyword separates the heading and the body of the stored procedure.
If the stored procedure has one statement, the BEGIN and END keywords surrounding the statement are optional. However, it is a good practice to include them to make the code clear.
Note that in addition to the CREATE PROCEDURE keywords, you can use the CREATE PROC keywords to make the statement shorter.

To compile this stored procedure, you execute it as a normal SQL statement in SQL Server Management Studio as shown in the following picture:


If everything is correct, then you will see the following message:

Commands completed successfully.
Code language: SQL (Structured Query Language) (sql)
It means that the stored procedure has been successfully compiled and saved into the database catalog.

You can find the stored procedure in the Object Explorer, under Programmability > Stored Procedures as shown in the following picture:


Sometimes, you need to click the Refresh button to manually update the database objects in the Object Explorer.

Executing a stored procedure 
To execute a stored procedure, you use the EXECUTE or EXEC statement followed by the name of the stored procedure:

EXECUTE sp_name;
Code language: SQL (Structured Query Language) (sql)
Or

EXEC sp_name;
Code language: SQL (Structured Query Language) (sql)
where sp_name is the name of the stored procedure that you want to execute.

For example, to execute the uspProductList stored procedure, you use the following statement:

EXEC uspProductList;
Code language: SQL (Structured Query Language) (sql)
The stored procedure returns the following output:

SQL Server Stored Procedure output
Modifying a stored procedure 
To modify an existing stored procedure, you use the ALTER PROCEDURE statement.

First, open the stored procedure to view its contents by right-clicking the stored procedure name and select Modify menu item:

SQL Server Stored Procedure modifying
Second, change the body of the stored procedure by sorting the products by list prices instead of product names:

 ALTER PROCEDURE uspProductList
    AS
    BEGIN
        SELECT 
            product_name, 
            list_price
        FROM 
            production.products
        ORDER BY 
            list_price 
    END;
Code language: SQL (Structured Query Language) (sql)
Third, click the Execute button, SQL Server modifies the stored procedure and returns the following output:

Commands completed successfully.
Code language: SQL (Structured Query Language) (sql)
Now, if you execute the stored procedure again, you will see the changes taking effect:

EXEC uspProductList;
Code language: SQL (Structured Query Language) (sql)
The following shows the partial output:

SQL Server Stored Procedure output changes
Deleting a stored procedure 
To delete a stored procedure, you use the DROP PROCEDURE or DROP PROC statement:

DROP PROCEDURE sp_name;
Code language: SQL (Structured Query Language) (sql)
or

DROP PROC sp_name;    
Code language: SQL (Structured Query Language) (sql)
where sp_name is the name of the stored procedure that you want to delete.

For example, to remove the uspProductList stored procedure, you execute the following statement:

DROP PROCEDURE uspProductList;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to manage SQL Server stored procedures including creating, executing, modifying, and deleting stored procedures.

Was this tutorial helpful?

SQL Server Stored Procedure Parameters
In the previous tutorial, you have learned how to create a simple stored procedure that wraps a SELECT statement. When you call this stored procedure, it just simply runs the query and returns a result set.

In this tutorial, we will extend the stored procedure which allows you to pass one or more values to it. The result of the stored procedure will change based on the values of the parameters.

Creating a stored procedure with one parameter 
The following query returns a product list from the products table in the sample database:

SELECT
    product_name,
    list_price
FROM 
    production.products
ORDER BY
    list_price;
Code language: SQL (Structured Query Language) (sql)
You can create a stored procedure that wraps this query using the CREATE PROCEDURE statement:

CREATE PROCEDURE uspFindProducts
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    ORDER BY
        list_price;
END;
Code language: SQL (Structured Query Language) (sql)
However, this time we can add a parameter to the stored procedure to find the products whose list prices are greater than an input price:

ALTER PROCEDURE uspFindProducts(@min_list_price AS DECIMAL)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price
    ORDER BY
        list_price;
END;
Code language: SQL (Structured Query Language) (sql)
In this example:

First, we added a parameter named @min_list_price to the uspFindProducts stored procedure. Every parameter must start with the @ sign. The AS DECIMAL keywords specify the data type of the @min_list_price parameter. The parameter must be surrounded by the opening and closing brackets.
Second, we used @min_list_price parameter in the WHERE clause of the SELECT statement to filter only the products whose list prices are greater than or equal to the @min_list_price.
Executing a stored procedure with one parameter 
To execute the uspFindProducts stored procedure, you pass an argument to it as follows:

EXEC uspFindProducts 100;
Code language: SQL (Structured Query Language) (sql)
SQL Server Stored Procedure Parameters - One parameter example
The stored procedure returns all products whose list prices are greater than or equal to 100.

If you change the argument to 200, you will get a different result set:

EXEC uspFindProducts 200;
Code language: SQL (Structured Query Language) (sql)
SQL Server Stored Procedure Parameters - one parameter change argument example
Creating a stored procedure with multiple parameters 
Stored procedures can take one or more parameters. The parameters are separated by commas.

The following statement modifies the uspFindProducts stored procedure by adding one more parameter named @max_list_price to it:

ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL
    ,@max_list_price AS DECIMAL
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price
    ORDER BY
        list_price;
END;
Code language: SQL (Structured Query Language) (sql)
Once the stored procedure is modified successfully, you can execute it by passing two arguments, one for @min_list_price and the other for @max_list_price:

EXECUTE uspFindProducts 900, 1000;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

SQL Server Stored Procedure Parameters - multiple parameters example
Using named parameters 
In case stored procedures have multiple parameters, it is better and more clear to execute the stored procedures using named parameters.

For example, the following statement executes the uspFindProducts stored procedure using the named parameters @min_list_priceand @max_list_price:

EXECUTE uspFindProducts 
    @min_list_price = 900, 
    @max_list_price = 1000;
Code language: SQL (Structured Query Language) (sql)
The result of the stored procedure is the same however the statement is more obvious.

Creating text parameters 
The following statement adds the @name parameter as a character string parameter to the stored procedure.

ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL
    ,@max_list_price AS DECIMAL
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;
Code language: SQL (Structured Query Language) (sql)
In the WHERE clause of the SELECT statement, we added the following condition:

product_name LIKE '%' + @name + '%'
Code language: SQL (Structured Query Language) (sql)
By doing this, the stored procedure returns the products whose list prices are in the range of min and max list prices and the product names also contain a piece of text that you pass in.

Once the stored procedure is altered successfully, you can execute it as follows:

EXECUTE uspFindProducts 
    @min_list_price = 900, 
    @max_list_price = 1000,
    @name = 'Trek';
Code language: SQL (Structured Query Language) (sql)
In this statement, we used the uspFindProducts stored procedure to find the product whose list prices are in the range of 900 and 1,000 and their names contain the word Trek.

The following picture shows the output:

SQL Server Stored Procedure Parameters - text parameter example
Creating optional parameters 
When you execute the uspFindProducts stored procedure, you must pass all three arguments corresponding to the three parameters.

SQL Server allows you to specify default values for parameters so that when you call stored procedures, you can skip the parameters with default values.

See the following stored procedure:

ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL = 0
    ,@max_list_price AS DECIMAL = 999999
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;
Code language: SQL (Structured Query Language) (sql)
In this stored procedure, we assigned 0 as the default value for the @min_list_price parameter and 999,999 as the default value for the @max_list_price parameter.

Once the stored procedure is compiled, you can execute it without passing the arguments to @min_list_price and @max_list_price parameters:

EXECUTE uspFindProducts 
    @name = 'Trek';
Code language: SQL (Structured Query Language) (sql)
SQL Server Stored Procedure Parameters - Optional Parameters
In this case, the stored procedure used 0 for @min_list_price parameter and 999,999 for the @max_list_price parameter when it executed the query.

The @min_list_price and @max_list_price parameters are called optional parameters.

Of course, you can also pass the arguments to the optional parameters. For example, the following statement returns all products whose list prices are greater or equal to 6,000 and the names contain the word Trek:

EXECUTE uspFindProducts 
    @min_list_price = 6000,
    @name = 'Trek';
Code language: SQL (Structured Query Language) (sql)
SQL Server Stored Procedure Parameters - Pass Optional Parameters
Using NULL as the default value 
In the uspFindProducts stored procedure, we used 999,999 as the default maximum list price. This is not robust because in the future you may have products with the list prices that are greater than that.

A typical technique to avoid this is to use NULL as the default value for the parameters:

ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL = 0
    ,@max_list_price AS DECIMAL = NULL
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        (@max_list_price IS NULL OR list_price <= @max_list_price) AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;
Code language: SQL (Structured Query Language) (sql)
In the WHERE clause, we changed the condition to handle NULL value for the @max_list_price parameter:

(@max_list_price IS NULL OR list_price <= @max_list_price) 
Code language: SQL (Structured Query Language) (sql)
The following statement executes the uspFindProducts stored procedure to find the product whose list prices are greater or equal to 500 and names contain the word Haro.

EXECUTE uspFindProducts 
    @min_list_price = 500,
    @name = 'Haro';
Code language: SQL (Structured Query Language) (sql)
SQL Server Stored Procedure Parameters - NULL as default values
In this tutorial, you have learned how to create and execute stored procedures with one or more parameters. You also learned how to create optional parameters and use NULL as the default values for the parameters.

Was this tutorial helpful?

Variables
Summary: in this tutorial, you will learn about variables including declaring variables, setting their values, and assigning value fields of a record to variables.

What is a variable 
A variable is an object that holds a single value of a specific type e.g., integer, date, or varying character string.

We typically use variables in the following cases:

As a loop counter to count the number of times a loop is performed.
To hold a value to be tested by a control-of-flow statement such as WHILE.
To store the value returned by a stored procedure or a function
Declaring a variable 
To declare a variable, you use the DECLARE statement. For example, the following statement declares a variable named @model_year:

DECLARE @model_year SMALLINT;
Code language: SQL (Structured Query Language) (sql)
The DECLARE statement initializes a variable by assigning it a name and a data type. The variable name must start with the @ sign. In this example, the data type of the @model_year variable is SMALLINT.

By default, when a variable is declared, its value is set to NULL.

Between the variable name and data type, you can use the optional AS keyword as follows:

DECLARE @model_year AS SMALLINT;
Code language: SQL (Structured Query Language) (sql)
To declare multiple variables, you separate variables by commas:

DECLARE @model_year SMALLINT, 
        @product_name VARCHAR(MAX);
Code language: SQL (Structured Query Language) (sql)
Assigning a value to a variable 
To assign a value to a variable, you use the SET statement. For example, the following statement assigns 2018 to the @model_year variable:

SET @model_year = 2018;
Code language: SQL (Structured Query Language) (sql)
Using variables in a query 
The following SELECT statement uses the @model_year variable in the WHERE clause to find the products of a specific model year:

SELECT
    product_name,
    model_year,
    list_price 
FROM 
    production.products
WHERE 
    model_year = @model_year
ORDER BY
    product_name;
Code language: SQL (Structured Query Language) (sql)
Now, you can put everything together and execute the following code block to get a list of products whose model year is 2018:

DECLARE @model_year SMALLINT;

SET @model_year = 2018;

SELECT
    product_name,
    model_year,
    list_price 
FROM 
    production.products
WHERE 
    model_year = @model_year
ORDER BY
    product_name;
Code language: SQL (Structured Query Language) (sql)
Note that to execute the code, you click the Execute button as shown in the following picture:

Stored Procedure Variables - execute a code block
The following picture shows the output:

Stored Procedure Variables - output
Storing query result in a variable 
The following steps describe how to store the query result in a variable:

First, declare a variable named @product_count with the integer data type:

DECLARE @product_count INT;
Code language: SQL (Structured Query Language) (sql)
Second, use the SET statement to assign the query’s result set to the variable:

SET @product_count = (
    SELECT 
        COUNT(*) 
    FROM 
        production.products 
);
Code language: SQL (Structured Query Language) (sql)
Third, output the content of the @product_count variable:

SELECT @product_count;
Code language: SQL (Structured Query Language) (sql)
Or you can use the PRINT statement to print out the content of a variable:

PRINT @product_count;
Code language: SQL (Structured Query Language) (sql)
or

PRINT 'The number of products is ' + CAST(@product_count AS VARCHAR(MAX));
Code language: SQL (Structured Query Language) (sql)
The output in the messages tab is as follows:

The number of products is 204
Code language: SQL (Structured Query Language) (sql)
To hide the number of rows affected messages, you use the following statement:

SET NOCOUNT ON;    
Code language: SQL (Structured Query Language) (sql)
Selecting a record into variables 
The following steps illustrate how to declare two variables, assign a record to them, and output the contents of the variables:

First, declare variables that hold the product name and list price:

DECLARE 
    @product_name VARCHAR(MAX),
    @list_price DECIMAL(10,2);
Code language: SQL (Structured Query Language) (sql)
Second, assign the column names to the corresponding variables:

SELECT 
    @product_name = product_name,
    @list_price = list_price
FROM
    production.products
WHERE
    product_id = 100;
Code language: SQL (Structured Query Language) (sql)
Third, output the content of the variables:

SELECT 
    @product_name AS product_name, 
    @list_price AS list_price;
Code language: SQL (Structured Query Language) (sql)
Stored Procedure Variables - assign a record to a variable
Accumulating values into a variable 
The following stored procedure takes one parameter and returns a list of products as a string:

CREATE  PROC uspGetProductList(
    @model_year SMALLINT
) AS 
BEGIN
    DECLARE @product_list VARCHAR(MAX);

    SET @product_list = '';

    SELECT
        @product_list = @product_list + product_name 
                        + CHAR(10)
    FROM 
        production.products
    WHERE
        model_year = @model_year
    ORDER BY 
        product_name;

    PRINT @product_list;
END;
Code language: SQL (Structured Query Language) (sql)
In this stored procedure:

First, we declared a variable named @product_list with varying character string type and set its value to blank.
Second, we selected the product name list from the products table based on the input @model_year. In the select list, we accumulated the product names to the @product_list variable. Note that the CHAR(10) returns the line feed character.
Third, we used the PRINT statement to print out the product list.
The following statement executes the uspGetProductList stored procedure:

EXEC uspGetProductList 2018
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial output:

Stored Procedure Variables - Stored Procedure Example
In this tutorial, you have learned about variables including declaring variables, setting their values, and assigning value fields of a record to the variables.

Was this tutorial helpful?

Stored Procedure Output Parameters
Summary: in this tutorial, you will learn how to use the output parameters to return data back to the calling program.

Creating output parameters 
To create an output parameter for a stored procedure, you use the following syntax:

parameter_name data_type OUTPUT
Code language: SQL (Structured Query Language) (sql)
A stored procedure can have many output parameters. In addition, the output parameters can be in any valid data type e.g., integer, date, and varying character.

For example, the following stored procedure finds products by model year and returns the number of products via the @product_count output parameter:

CREATE PROCEDURE uspFindProductByModel (
    @model_year SMALLINT,
    @product_count INT OUTPUT
) AS
BEGIN
    SELECT 
        product_name,
        list_price
    FROM
        production.products
    WHERE
        model_year = @model_year;

    SELECT @product_count = @@ROWCOUNT;
END;
Code language: SQL (Structured Query Language) (sql)
In this stored procedure:

First, we created an output parameter named @product_count to store the number of products found:

@product_count INT OUTPUT
Code language: SQL (Structured Query Language) (sql)
Second, after the SELECT statement, we assigned the number of rows returned by the query(@@ROWCOUNT) to the @product_count parameter.

Note that the @@ROWCOUNT is a system variable that returns the number of rows read by the previous statement.

Once you execute the CREATE PROCEDURE statement above, the uspFindProductByModel stored procedure is compiled and saved in the database catalog.

If everything is fine, SQL Server issues the following output:

Commands completed successfully.
Code language: SQL (Structured Query Language) (sql)
Calling stored procedures with output parameters 
To call a stored procedure with output parameters, you follow these steps:

First, declare variables to hold the values returned by the output parameters
Second, use these variables in the stored procedure call.
For example, the following statement executes the uspFindProductByModel stored procedure:

DECLARE @count INT;

EXEC uspFindProductByModel
    @model_year = 2018,
    @product_count = @count OUTPUT;

SELECT @count AS 'Number of products found';
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server Stored Procedure Output Parameter Example
In this example:

First, declare the @count variable to hold the the value of the output parameter of the stored procedure:

DECLARE @count INT;
Code language: SQL (Structured Query Language) (sql)
Then, execute the uspFindProductByModel stored procedure and passing the parameters:

EXEC uspFindProductByModel 
     @model_year = 2018, 
     @product_count = @count OUTPUT;
Code language: SQL (Structured Query Language) (sql)
In this statement, the model_year is 2018 and the @count variable assigns the value of the output parameter @product_count.

You can call the uspFindProductByModel stored procedure as follows:

EXEC uspFindProductByModel 2018, @count OUTPUT;
Code language: SQL (Structured Query Language) (sql)
Note that if you forget the OUTPUT keyword after the @count variable, the @count variable will be NULL.

Finally, show the value of the @count variable:

SELECT @count AS 'Number of products found';
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the output parameter to pass data from the stored procedure back to the calling program.

Was this tutorial helpful?

SQL Server BEGIN END
Summary: in this tutorial, you will learn how to use the BEGIN...END statement to wrap a set of Transact-SQL statements into a statement block.

Overview of the BEGIN...END statement 
The BEGIN...END statement is used to define a statement block. A statement block consists of a set of SQL statements that execute together. A statement block is also known as a batch.

In other words, if statements are sentences, the BEGIN...END statement allows you to define paragraphs.

The following illustrates the syntax of the BEGIN...END statement:

BEGIN
    { sql_statement | statement_block}
END
Code language: SQL (Structured Query Language) (sql)
In this syntax, you place a set of SQL statements between the BEGIN and END keywords, for example:

BEGIN
    SELECT
        product_id,
        product_name
    FROM
        production.products
    WHERE
        list_price > 100000;

    IF @@ROWCOUNT = 0
        PRINT 'No product with price greater than 100000 found';
END
Code language: SQL (Structured Query Language) (sql)
Output:

SQL Server BEGIN END example
To view the messages generated by the PRINT statement, in SQL Server Management Studio, you need to click the Messages tab. By default, the Messages tab is hidden.

In this example:

First, we have a block starting with the BEGIN keyword and ending with the END
keyword.
Second, inside the block, we have a SELECT statement that finds products whose list prices are greater than 100,000. Then, we have the IF statement to check if the query returns any product and print out a message if no product returns.
Note that the @@ROWCOUNT is a system variable that returns the number of rows affected by the last previous statement.

The BEGIN... END statement bounds a logical block of SQL statements. We often use the BEGIN...END at the start and end of a stored procedure and function. But it is not strictly necessary.

However, the BEGIN...END is required for the IF ELSE statements, WHILE statements, etc., where you need to wrap multiple statements.

Nesting BEGIN... END 
The statement block can be nested. It simply means that you can place a BEGIN...END statement within another BEGIN... END statement.

Consider the following example:

BEGIN
    DECLARE @name VARCHAR(MAX);

    SELECT TOP 1
        @name = product_name
    FROM
        production.products
    ORDER BY
        list_price DESC;
    
    IF @@ROWCOUNT <> 0
    BEGIN
        PRINT 'The most expensive product is ' + @name
    END
    ELSE
    BEGIN
        PRINT 'No product found';
    END;
END
Code language: SQL (Structured Query Language) (sql)
In this example, we used the BEGIN...END statement to wrap the whole statement block. Inside this block, we also used the BEGIN...END for the IF...ELSE statement.

In this tutorial, you have learned about SQL Server BEGIN...END statement to wrap Transact-SQL statements into blocks.

Was this tutorial helpful?


SQL Server IF ELSE
Summary: in this tutorial, you will learn SQL Server IF...ELSE statement to control the flow of program.

The IF...ELSE statement is a control-flow statement that allows you to execute or skip a statement block based on a specified condition.

The IF statement 
The following illustrates the syntax of the IF statement:

IF boolean_expression   
BEGIN
    { statement_block }
END
Code language: SQL (Structured Query Language) (sql)
In this syntax, if the Boolean_expression evaluates to TRUE then the statement_block in the BEGIN...END block is executed. Otherwise, the statement_block is skipped and the control of the program is passed to the statement after the END keyword.

Note that if the Boolean expression contains a SELECT statement, you must enclose the SELECT statement in parentheses.

The following example first gets the sales amount from the sales.order_items table in the sample database and then prints out a message if the sales amount is greater than 1 million.

BEGIN
    DECLARE @sales INT;

    SELECT 
        @sales = SUM(list_price * quantity)
    FROM
        sales.order_items i
        INNER JOIN sales.orders o ON o.order_id = i.order_id
    WHERE
        YEAR(order_date) = 2018;

    SELECT @sales;

    IF @sales > 1000000
    BEGIN
        PRINT 'Great! The sales amount in 2018 is greater than 1,000,000';
    END
END
Code language: SQL (Structured Query Language) (sql)
The output of the code block is:

Great! The sales amount in 2018 is greater than 1,000,000
Code language: SQL (Structured Query Language) (sql)
Note that you have to click the Messages tab to see the above output message:


The IF ELSE statement 
When the condition in the IF clause evaluates to FALSE and you want to execute another statement block, you can use the ELSE clause.

The following illustrates the IF ELSE statement:

IF Boolean_expression
BEGIN
    -- Statement block executes when the Boolean expression is TRUE
END
ELSE
BEGIN
    -- Statement block executes when the Boolean expression is FALSE
END
Code language: SQL (Structured Query Language) (sql)
Each IF statement has a condition. If the condition evaluates to TRUE then the statement block in the IF clause is executed. If the condition is FALSE, then the code block in the ELSE clause is executed.

See the following example:

BEGIN
    DECLARE @sales INT;

    SELECT 
        @sales = SUM(list_price * quantity)
    FROM
        sales.order_items i
        INNER JOIN sales.orders o ON o.order_id = i.order_id
    WHERE
        YEAR(order_date) = 2017;

    SELECT @sales;

    IF @sales > 10000000
    BEGIN
        PRINT 'Great! The sales amount in 2018 is greater than 10,000,000';
    END
    ELSE
    BEGIN
        PRINT 'Sales amount in 2017 did not reach 10,000,000';
    END
END
Code language: SQL (Structured Query Language) (sql)
In this example:

First, the following statement sets the total sales in 2017 to the @sales variable:

    SELECT 
        @sales = SUM(list_price * quantity)
    FROM
        sales.order_items i
        INNER JOIN sales.orders o ON o.order_id = i.order_id
    WHERE
        YEAR(order_date) = 2017;
Code language: SQL (Structured Query Language) (sql)
Second, this statement returns the sales to the output:

    SELECT @sales;
Code language: SQL (Structured Query Language) (sql)
Finally, the IF clause checks if the sales amount in 2017 is greater than 10 million. Because the sales amount is less than that, the statement block in the ELSE clause executes.

    IF @sales > 10000000
    BEGIN
        PRINT 'Great! The sales amount in 2018 is greater than 10,000,000';
    END
    ELSE
    BEGIN
        PRINT 'Sales amount in 2017 did not reach 10,000,000';
    END
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

Sales amount did not reach 10,000,000
Code language: SQL (Structured Query Language) (sql)
Nested IF...ELSE 
SQL Server allows you to nest an IF...ELSE statement within inside another IF...ELSE statement, see the following example:

BEGIN
    DECLARE @x INT = 10,
            @y INT = 20;

    IF (@x > 0)
    BEGIN
        IF (@x < @y)
            PRINT 'x > 0 and x < y';
        ELSE
            PRINT 'x > 0 and x >= y';
    END			
END
Code language: SQL (Structured Query Language) (sql)
In this example:

First, declare two variables @x and @y and set their values to 10 and 20 respectively:

DECLARE @x INT = 10,
        @y INT = 20;
Code language: SQL (Structured Query Language) (sql)
Second, the output IF statement check if @x is greater than zero. Because @x is set to 10, the condition (@x > 10) is true. Therefore, the nested IF statement executes.

Finally, the nested IF statement check if @x is less than @y ( @x < @y). Because @y is set to 20,  the condition (@x < @y) evaluates to true. The PRINT 'x > 0 and x < y'; statement in the IF branch executes.

Here is the output:

x > 0 and x < y
It is a good practice to not nest an IF statement inside another statement because it makes the code difficult to read and hard to maintain.

In this tutorial, you have learned how to use the SQL Server IF...ELSE statement to control the flow of code execution.

Was this tutorial helpful?

SQL Server WHILE
Summary: in this tutorial, you will learn how to use the SQL Server WHILE statement to execute a statement block repeatedly based on a specified condition.

Overview of WHILE statement 
The WHILE statement is a control-flow statement that allows you to execute a statement block repeatedly as long as a specified condition is TRUE.

The following illustrates the syntax of the WHILE statement:

WHILE Boolean_expression   
     { sql_statement | statement_block}  
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, the Boolean_expression is an expression that evaluates to TRUE or FALSE.

Second, sql_statement | statement_block is any Transact-SQL statement or a set of Transact-SQL statements. A statement block is defined using the BEGIN...END statement.

If the Boolean_expression evaluates to FALSE when entering the loop, no statement inside the WHILE loop will be executed.

Inside the WHILE loop, you must change some variables to make the Boolean_expression returns FALSE at some points. Otherwise, you will have an indefinite loop.

Note that if the Boolean_expression contains a SELECT statement, it must be enclosed in parentheses.

To exit the current iteration of the loop immediately, you use the BREAK statement. To skip the current iteration of the loop and start the new one, you use the CONTINUE statement.

SQL Server WHILE example 
Let’s take an example of using the SQL Server WHILE statement to understand it better.

The following example illustrates how to use the WHILE statement to print out numbers from 1 to 5:

DECLARE @counter INT = 1;

WHILE @counter <= 5
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END
Code language: SQL (Structured Query Language) (sql)
Output:

1
2
3
4
5
In this example:

First, we declared the @counter variable and set its value to one.
Then, in the condition of the WHILE statement, we checked if the @counteris less than or equal to five. If it was not, we printed out the @counter and increased its value by one. After five iterations, the @counter is 6 which caused the condition of the WHILE clause evaluates to FALSE, the loop stopped.
To learn how to use the WHILE loop to process row by row, check it out the cursor tutorial.

In this tutorial, you have learned how to use the SQL Server WHILE statement to repeat the execution of a statement block based on a specified condition.

Was this tutorial helpful?

SQL Server BREAK
Summary: in this tutorial, you will learn how to use the SQL Server BREAK statement to immediately exit a WHILE loop.

SQL Server BREAK statement overview 
In the previous tutorial, you have learned how to use the WHILE statement to create a loop. To exit the current iteration of a loop, you use the BREAK statement.

The following illustrates the typical syntax of the BREAK statement:

WHILE Boolean_expression
BEGIN
    -- statements
   IF condition
        BREAK;
    -- other statements    
END
Code language: SQL (Structured Query Language) (sql)
In this syntax, the BREAK statement exit the WHILE loop immediately once the condition  specified in the IF statement is met. All the statements between the BREAK and END keywords are skipped.

Suppose we have a WHILE loop nested inside another WHILE loop:

WHILE Boolean_expression1
BEGIN
    -- statement
    WHILE Boolean_expression2
    BEGIN
        IF condition
            BREAK;
    END
END
Code language: SQL (Structured Query Language) (sql)
In this case, the BREAK statement only exits the innermost loop in the WHILE statement.

Note that the BREAK statement can be used only inside the WHILE loop. The IF statement is often used with the BREAK statement but it is not required.

SQL Server BREAK statement example 
The following example illustrates how to use the BREAK statement:

DECLARE @counter INT = 0;

WHILE @counter <= 5
BEGIN
    SET @counter = @counter + 1;
    IF @counter = 4
        BREAK;
    PRINT @counter;
END
Code language: SQL (Structured Query Language) (sql)
Output:

1
2
3
In this example:

First, we declared a variable named @counter and set its value to zero.

Then, we used the WHILE statement to increases the @counter by one in each iteration and print out the @counter‘s value as long as the value of the @counter is less than or equal to five.

Inside the loop, we also checked if the value of @counter equals four, then we exited the loop. In the fourth iteration, the value of the counter reached 4, then the loop is terminated. Also, the PRINT statement after the BREAK statement was skipped.

In this tutorial, you have learned how to use the SQL Server BREAK statement to exit a loop immediately.

Was this tutorial helpful?

SQL Server CONTINUE
Summary: in this tutorial, you will learn how to use the SQL Server CONTINUE statement to control the flow of the loop.

Introduction to the SQL Server CONTINUE statement 
The CONTINUE statement stops the current iteration of the loop and starts the new one. The following illustrates the syntax of the CONTINUE statement:

WHILE Boolean_expression
BEGIN
    -- code to be executed
    IF condition
        CONTINUE;
    -- code will be skipped if the condition is met
END
Code language: SQL (Structured Query Language) (sql)
In this syntax, the current iteration of the loop is stopped once the condition evaluates to TRUE. The next iteration of the loop will continue until the Boolean_expression evaluates to FALSE.

Similar to the BREAK statement, the CONTINUE statement is often used in conjunction with an IF statement. Note that this is not mandatory though.

SQL Server CONTINUE example 
The following example illustrates how the CONTINUE statement works.

DECLARE @counter INT = 0;

WHILE @counter < 5
BEGIN
    SET @counter = @counter + 1;
    IF @counter = 3
        CONTINUE;	
    PRINT @counter;
END
Code language: SQL (Structured Query Language) (sql)
Here is the output:

1
2
4
5
Code language: SQL (Structured Query Language) (sql)
In this example:

First, we declared a variable named @counter and set its value to zero.
Then, the WHILE loop started. Inside the WHILE loop, we increased the counter by one in each iteration. If the @counter was three, we skipped printing out the value using the CONTINUE statement. That’s why in the output, you do not see the number three is showing up.
In this tutorial, you have learned how to use the SQL Server CONTINUE statement to skip the current loop iteration and continue the next.

Was this tutorial helpful?

SQL Server CURSOR
Summary: in this tutorial, you will learn how to use the SQL Server cursor to process a result set, one row at a time.

SQL works based on set e.g., SELECT statement returns a set of rows which is called a result set. However, sometimes, you may want to process a data set on a row by row basis. This is where cursors come into play.

What is a database cursor 
A database cursor is an object that enables traversal over the rows of a result set. It allows you to process individual row returned by a query.

SQL Server cursor life cycle 
These are steps for using a cursor:

SQL Server Cursor
First, declare a cursor.

DECLARE cursor_name CURSOR
    FOR select_statement;
Code language: SQL (Structured Query Language) (sql)
To declare a cursor, you specify its name after the DECLARE keyword with the CURSOR data type and provide a SELECT statement that defines the result set for the cursor.

Next, open and populate the cursor by executing the SELECT statement:

OPEN cursor_name;
Code language: SQL (Structured Query Language) (sql)
Then, fetch a row from the cursor into one or more variables:

FETCH NEXT FROM cursor INTO variable_list;
Code language: SQL (Structured Query Language) (sql)
SQL Server provides the @@FETCHSTATUS function that returns the status of the last cursor FETCH statement executed against the cursor; If @@FETCHSTATUS returns 0, meaning the FETCH statement was successful. You can use the WHILE statement to fetch all rows from the cursor as shown in the following code:

WHILE @@FETCH_STATUS = 0  
    BEGIN
        FETCH NEXT FROM cursor_name;  
    END;
Code language: SQL (Structured Query Language) (sql)
After that, close the cursor:

CLOSE cursor_name;
Code language: SQL (Structured Query Language) (sql)
Finally, deallocate the cursor:

DEALLOCATE cursor_name;
Code language: SQL (Structured Query Language) (sql)
SQL Server cursor example 
We’ll use the prodution.products table from the sample database to show you how to use a cursor:

products
First, declare two variables to hold product name and list price, and a cursor to hold the result of a query that retrieves product name and list price from the production.products table:

DECLARE 
    @product_name VARCHAR(MAX), 
    @list_price   DECIMAL;

DECLARE cursor_product CURSOR
FOR SELECT 
        product_name, 
        list_price
    FROM 
        production.products;
Code language: SQL (Structured Query Language) (sql)
Next, open the cursor:

OPEN cursor_product;
Code language: SQL (Structured Query Language) (sql)
Then, fetch each row from the cursor and print out the product name and list price:

FETCH NEXT FROM cursor_product INTO 
    @product_name, 
    @list_price;

WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @product_name + CAST(@list_price AS varchar);
        FETCH NEXT FROM cursor_product INTO 
            @product_name, 
            @list_price;
    END;
Code language: SQL (Structured Query Language) (sql)
After that, close the cursor:

CLOSE cursor_product;
Code language: SQL (Structured Query Language) (sql)
Finally, deallocate the cursor to release it.

DEALLOCATE cursor_product;
Code language: SQL (Structured Query Language) (sql)
The following code snippets put everything together:

DECLARE 
    @product_name VARCHAR(MAX), 
    @list_price   DECIMAL;

DECLARE cursor_product CURSOR
FOR SELECT 
        product_name, 
        list_price
    FROM 
        production.products;

OPEN cursor_product;

FETCH NEXT FROM cursor_product INTO 
    @product_name, 
    @list_price;

WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @product_name + CAST(@list_price AS varchar);
        FETCH NEXT FROM cursor_product INTO 
            @product_name, 
            @list_price;
    END;

CLOSE cursor_product;

DEALLOCATE cursor_product;
Code language: SQL (Structured Query Language) (sql)
Here is the partial output:

SQL Server Cursor Example
In practice, you will rarely use the cursor to process a result set in a row-by-row manner.

In this tutorial, you have learned how to use the SQL Server cursor to process a result set, each row at a time.

Was this tutorial helpful?

SQL Server TRY CATCH
Summary: in this tutorial, you will learn how to use the SQL Server TRY CATCH construct to handle exceptions in stored procedures.

SQL Server TRY CATCH overview 
The TRY CATCH construct allows you to gracefully handle exceptions in SQL Server. To use the TRY CATCH construct, you first place a group of Transact-SQL statements that could cause an exception in a BEGIN TRY...END TRY block as follows:

BEGIN TRY  
   -- statements that may cause exceptions
END TRY  
Code language: SQL (Structured Query Language) (sql)
Then you use a BEGIN CATCH...END CATCH block immediately after the TRY block:

BEGIN CATCH  
   -- statements that handle exception
END CATCH  
Code language: SQL (Structured Query Language) (sql)
The following illustrates a complete TRY CATCH construct:

BEGIN TRY  
   -- statements that may cause exceptions
END TRY 
BEGIN CATCH  
   -- statements that handle exception
END CATCH  
Code language: SQL (Structured Query Language) (sql)
If the statements between the TRY block complete without an error, the statements between the CATCH block will not execute. However, if any statement inside the TRY block causes an exception, the control transfers to the statements in the CATCH block.

The CATCH block functions 
Inside the CATCH block, you can use the following functions to get the detailed information on the error that occurred:

ERROR_LINE() returns the line number on which the exception occurred.
ERROR_MESSAGE() returns the complete text of the generated error message.
ERROR_PROCEDURE() returns the name of the stored procedure or trigger where the error occurred.
ERROR_NUMBER() returns the number of the error that occurred.
ERROR_SEVERITY() returns the severity level of the error that occurred.
ERROR_STATE() returns the state number of the error that occurred.
Note that you only use these functions in the CATCH block. If you use them outside of the CATCH block, all of these functions will return NULL.

Nested TRY CATCH constructs 
You can nest TRY CATCH construct inside another TRY CATCH construct. However, either a TRY block or a CATCH block can contain a nested TRY CATCH, for example:

BEGIN TRY
    --- statements that may cause exceptions
END TRY
BEGIN CATCH
    -- statements to handle exception
    BEGIN TRY
        --- nested TRY block
    END TRY
    BEGIN CATCH
        --- nested CATCH block
    END CATCH
END CATCH
Code language: SQL (Structured Query Language) (sql)
SQL Server TRY CATCH examples 
First, create a stored procedure named usp_divide that divides two numbers:

CREATE PROC usp_divide(
    @a decimal,
    @b decimal,
    @c decimal output
) AS
BEGIN
    BEGIN TRY
        SET @c = @a / @b;
    END TRY
    BEGIN CATCH
        SELECT  
            ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH
END;
GO
Code language: SQL (Structured Query Language) (sql)
In this stored procedure, we placed the formula inside the TRY block and called the CATCH block functions ERROR_* inside the CATCH block.

Second, call the usp_divide stored procedure to divide 10 by 2:

DECLARE @r decimal;
EXEC usp_divide 10, 2, @r output;
PRINT @r;
Code language: SQL (Structured Query Language) (sql)
Here is the output

5
Code language: SQL (Structured Query Language) (sql)
Because no exception occurred in the TRY block, the stored procedure completed at the TRY block.

Third, attempt to divide 20 by zero by calling the usp_divide stored procedure:

DECLARE @r2 decimal;
EXEC usp_divide 10, 0, @r2 output;
PRINT @r2;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server TRY CATCH Example
Because of division by zero error which was caused by the formula, the control was passed to the statement inside the CATCH block which returned the error’s detailed information.

SQL Serer TRY CATCH with transactions 
Inside a CATCH block, you can test the state of transactions by using the XACT_STATE() function.

If the XACT_STATE() function returns -1, it means that an uncommittable transaction is pending, you should issue a ROLLBACK TRANSACTION statement.
In case the XACT_STATE() function returns 1, it means that a committable transaction is pending. You can issue a COMMIT TRANSACTION statement in this case.
If the XACT_STATE() function return 0, it means no transaction is pending, therefore, you don’t need to take any action.
It is a good practice to test your transaction state before issuing a COMMIT TRANSACTION or ROLLBACK TRANSACTION statement in a CATCH block to ensure consistency.

Using TRY CATCH with transactions example 
First, set up two new tables sales.persons and sales.deals for demonstration:

CREATE TABLE sales.persons
(
    person_id  INT
    PRIMARY KEY IDENTITY, 
    first_name NVARCHAR(100) NOT NULL, 
    last_name  NVARCHAR(100) NOT NULL
);

CREATE TABLE sales.deals
(
    deal_id   INT
    PRIMARY KEY IDENTITY, 
    person_id INT NOT NULL, 
    deal_note NVARCHAR(100), 
    FOREIGN KEY(person_id) REFERENCES sales.persons(
    person_id)
);

insert into 
    sales.persons(first_name, last_name)
values
    ('John','Doe'),
    ('Jane','Doe');

insert into 
    sales.deals(person_id, deal_note)
values
    (1,'Deal for John Doe');
Code language: SQL (Structured Query Language) (sql)
Next, create a new stored procedure named usp_report_error that will be used in a CATCH block to report the detailed information of an error:

CREATE PROC usp_report_error
AS
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_LINE () AS ErrorLine  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;  
GO
Code language: SQL (Structured Query Language) (sql)
Then, develop a new stored procedure that deletes a row from the sales.persons table:

CREATE PROC usp_delete_person(
    @person_id INT
) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        -- delete the person
        DELETE FROM sales.persons 
        WHERE person_id = @person_id;
        -- if DELETE succeeds, commit the transaction
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        -- report exception
        EXEC usp_report_error;
        
        -- Test if the transaction is uncommittable.  
        IF (XACT_STATE()) = -1  
        BEGIN  
            PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'  
            ROLLBACK TRANSACTION;  
        END;  
        
        -- Test if the transaction is committable.  
        IF (XACT_STATE()) = 1  
        BEGIN  
            PRINT N'The transaction is committable.' +  
                'Committing transaction.'  
            COMMIT TRANSACTION;     
        END;  
    END CATCH
END;
GO
Code language: SQL (Structured Query Language) (sql)
In this stored procedure, we used the XACT_STATE() function to check the state of the transaction before performing COMMIT TRANSACTION or ROLLBACK TRANSACTION inside the CATCH block.

After that, call the usp_delete_person stored procedure to delete the person id 2:

EXEC usp_delete_person 2;
Code language: SQL (Structured Query Language) (sql)
There was no exception occurred.

Finally, call the stored procedure usp_delete_person to delete person id 1:

EXEC usp_delete_person 1;
Code language: SQL (Structured Query Language) (sql)
The following error occurred:

SQL Server TRY CATCH Transaction Example
In this tutorial, you have learned how to use the SQL Server TRY CATCH construct to handle exceptions in stored procedures.

Was this tutorial helpful?

SQL Server RAISERROR
Summary: in this tutorial, you will learn how to use the SQL Server RAISERROR statement to generate user-defined error messages.

If you develop a new application, you should use the THROW statement instead.

SQL Server RAISEERROR statement overview 
The RAISERROR statement allows you to generate your own error messages and return these messages back to the application using the same format as a system error or warning message generated by SQL Server Database Engine. In addition, the RAISERROR statement allows you to set a specific message id, level of severity, and state for the error messages.

The following illustrates the syntax of the RAISERROR statement:

RAISERROR ( { message_id | message_text | @local_variable }  
    { ,severity ,state }  
    [ ,argument [ ,...n ] ] )  
    [ WITH option [ ,...n ] ];
Code language: SQL (Structured Query Language) (sql)
Let’s examine the syntax of the RAISERROR for better understanding.

message_id 
The message_id is a user-defined error message number stored in the sys.messages catalog view.

To add a new user-defined error message number, you use the stored procedure sp_addmessage. A user-defined error message number should be greater than 50,000. By default, the RAISERROR statement uses the message_id 50,000 for raising an error.

The following statement adds a custom error message to the sys.messages view:

EXEC sp_addmessage 
    @msgnum = 50005, 
    @severity = 1, 
    @msgtext = 'A custom error message';
Code language: SQL (Structured Query Language) (sql)
To verify the insert, you use the following query:

SELECT    
    *
FROM    
    sys.messages
WHERE 
    message_id = 50005;
Code language: SQL (Structured Query Language) (sql)
To use this message_id, you execute the RAISEERROR statement as follows:

RAISERROR ( 50005,1,1)
Code language: SQL (Structured Query Language) (sql)
Here is the output:

A custom error message
Msg 50005, Level 1, State 1
Code language: SQL (Structured Query Language) (sql)
To remove a message from the sys.messages, you use the stored procedure sp_dropmessage. For example, the following statement deletes the message id 50005:

EXEC sp_dropmessage 
    @msgnum = 50005;  
Code language: SQL (Structured Query Language) (sql)
message_text 
The message_text is a user-defined message with formatting like the printf function in C standard library. The message_text can be up to 2,047 characters, 3 last characters are reserved for ellipsis (…). If the message_text contains 2048 or more, it will be truncated and is padded with an ellipsis.

When you specify the message_text, the RAISERROR statement uses message_id 50000 to raise the error message.

The following example uses the RAISERROR statement to raise an error with a message text:

RAISERROR ( 'Whoops, an error occurred.',1,1)
Code language: SQL (Structured Query Language) (sql)
The output will look like this:

Whoops, an error occurred.
Msg 50000, Level 1, State 1
Code language: SQL (Structured Query Language) (sql)
severity 
The severity level is an integer between 0 and 25, with each level representing the seriousness of the error.

0–10 Informational messages
11–18 Errors
19–25 Fatal errors
Code language: SQL (Structured Query Language) (sql)
state 
The state is an integer from 0 through 255. If you raise the same user-defined error at multiple locations, you can use a unique state number for each location to make it easier to find which section of the code is causing the errors. For most implementations, you can use 1.

WITH option 
The option can be LOG, NOWAIT, or SETERROR:

WITH LOG logs the error in the error log and application log for the instance of the SQL Server Database Engine.
WITH NOWAIT sends the error message to the client immediately.
WITH SETERROR sets the ERROR_NUMBER and @@ERROR values to message_id or 50000, regardless of the severity level.
SQL Server RAISERROR examples 
Let’s take some examples of using the RAISERROR statement to get a better understanding.

A) Using SQL Server RAISERROR with TRY CATCH block example 
In this example, we use the RAISERROR inside a TRY block to cause execution to jump to the associated CATCH block. Inside the CATCH block, we use the RAISERROR to return the error information that invoked the CATCH block.

DECLARE 
    @ErrorMessage  NVARCHAR(4000), 
    @ErrorSeverity INT, 
    @ErrorState    INT;

BEGIN TRY
    RAISERROR('Error occurred in the TRY block.', 17, 1);
END TRY
BEGIN CATCH
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(), 
        @ErrorSeverity = ERROR_SEVERITY(), 
        @ErrorState = ERROR_STATE();

    -- return the error inside the CATCH block
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Msg 50000, Level 17, State 1, Line 16
Error occurred in the TRY block.
Code language: SQL (Structured Query Language) (sql)
B) Using SQL Server RAISERROR statement with a dynamic message text example 
The following example shows how to use a local variable to provide the message text for a RAISERROR statement:

DECLARE @MessageText NVARCHAR(100);
SET @MessageText = N'Cannot delete the sales order %s';

RAISERROR(
    @MessageText, -- Message text
    16, -- severity
    1, -- state
    N'2001' -- first argument to the message text
);
Code language: SQL (Structured Query Language) (sql)
The output is as follows:

Msg 50000, Level 16, State 1, Line 5
Cannot delete the sales order 2001
Code language: SQL (Structured Query Language) (sql)
When to use RAISERROR statement 
You use the RAISERROR statement in the following scenarios:

Troubleshoot Transact-SQL code.
Return messages that contain variable text.
Examine the values of data.
Cause the execution to jump from a TRY block to the associated CATCH block.
Return error information from the CATCH block to the callers, either calling batch or application.
In this tutorial, you will learn how to use the SQL Server RAISERROR statement to generate user-defined error messages.

SQL Server THROW
Summary: in this tutorial, you will learn how to use the SQL Server THROW statement to raise an exception.

SQL Server THROW statement overview 
The THROW statement raises an exception and transfers execution to a CATCH block of a TRY CATCH construct.

The following illustrates the syntax of the THROW statement:

THROW [ error_number ,  
        message ,  
        state ];
Code language: SQL (Structured Query Language) (sql)
In this syntax:

error_number 
The error_number is an integer that represents the exception. The error_number must be greater than 50,000 and less than or equal to 2,147,483,647.

message 
The message is a string of type NVARCHAR(2048) that describes the exception.

state 
The state is a TINYINT with the value between 0 and 255. The state indicates the state associated with the message.

If you don’t specify any parameter for the THROW statement, you must place the THROW statement inside a CATCH block:

BEGIN TRY
    -- statements that may cause errors
END TRY
BEGIN CATCH
    -- statement to handle errors 
    THROW;   
END CATCH
Code language: SQL (Structured Query Language) (sql)
In this case, the THROW statement raises the error that was caught by the CATCH block.

Note that the statement before the THROW statement must be terminated by a semicolon (;)

 THROW vs. RAISERROR 
The following table illustrates the difference between the THROW statement and RAISERROR statement:

RAISERROR	THROW
The message_id that you pass to RAISERROR must be defined in sys.messages view.	The error_number parameter does not have to be defined in the sys.messages view.
The message parameter can contain printf formatting styles such as %s and %d.	The message parameter does not accept printf style formatting. Use FORMATMESSAGE() function to substitute parameters.
The severity parameter indicates the severity of the exception.	The severity of the exception is always set to 16.
SQL Server THROW statement examples 
Let’s take some examples of using the THROW statement to get a better understanding.

A) Using THROW statement to raise an exception 
The following example uses the THROW statement to raise an exception:

THROW 50005, N'An error occurred', 1;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Msg 50005, Level 16, State 1, Line 1
An error occurred
Code language: SQL (Structured Query Language) (sql)
B) Using THROW statement to rethrow an exception 
First, create a new table t1 for the demonstration:

CREATE TABLE t1(
    id int primary key
);
GO
Code language: SQL (Structured Query Language) (sql)
Then, use the THROW statement without arguments in the CATCH block to rethrow the caught error:

BEGIN TRY
    INSERT INTO t1(id) VALUES(1);
    --  cause error
    INSERT INTO t1(id) VALUES(1);
END TRY
BEGIN CATCH
    PRINT('Raise the caught error again');
    THROW;
END CATCH
Code language: SQL (Structured Query Language) (sql)
Here is the output:

(1 row affected)

(0 rows affected)
Raise the caught error again
Msg 2627, Level 14, State 1, Line 10
Violation of PRIMARY KEY constraint 'PK__t1__3213E83F906A55AA'. Cannot insert duplicate key in object 'dbo.t1'. The duplicate key value is (1).
Code language: JavaScript (javascript)
In this example, the first INSERT statement succeeded. However, the second one failed due to the primary key constraint. Therefore, the error was caught by the CATCH block was raised again by the THROW statement.

C) Using THROW statement to rethrow an exception 
Unlike the RAISERROR statement, the THROW statement does not allow you to substitute parameters in the message text. Therefore, to mimic this function, you use the FORMATMESSAGE() function.

The following statement adds a custom message to the sys.messages catalog view:

EXEC sys.sp_addmessage 
    @msgnum = 50010, 
    @severity = 16, 
    @msgtext =
    N'The order number %s cannot be deleted because it does not exist.', 
    @lang = 'us_english';   
GO
Code language: SQL (Structured Query Language) (sql)
This statement uses the message_id 50010 and replaces the %s placeholder by an order id ‘1001’:

DECLARE @MessageText NVARCHAR(2048);
SET @MessageText =  FORMATMESSAGE(50010, N'1001');   

THROW 50010, @MessageText, 1; 
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Msg 50010, Level 16, State 1, Line 8
The order number 1001 cannot be deleted because it does not exist.
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server THROW statement to raise an exception.

Was this tutorial helpful?

SQL Server Dynamic SQL
Summary: in this tutorial, you will learn how to use the SQL Server dynamic SQL to construct general purpose and flexible SQL statements.

Introduction to Dynamic SQL 
Dynamic SQL is a programming technique that allows you to construct SQL statements dynamically at runtime. It allows you to create more general purpose and flexible SQL statement because the full text of the SQL statements may be unknown at compilation. For example, you can use the dynamic SQL to create a stored procedure that queries data against a table whose name is not known until runtime.

Creating a dynamic SQL is simple, you just need to make it a string as follows:

'SELECT * FROM production.products';
Code language: SQL (Structured Query Language) (sql)
To execute a dynamic SQL statement, you call the stored procedure sp_executesql as shown in the following statement:

EXEC sp_executesql N'SELECT * FROM production.products';
Code language: SQL (Structured Query Language) (sql)
Because the sp_executesql accepts the dynamic SQL as a Unicode string, you need to prefix it with an N.

Though this dynamic SQL is not very useful, it illustrates a dynamic SQL very well.

Using dynamic SQL to query from any table example 
First, declare two variables, @table for holding the name of the table from which you want to query and @sql for holding the dynamic SQL.

DECLARE 
    @table NVARCHAR(128),
    @sql NVARCHAR(MAX);
Code language: SQL (Structured Query Language) (sql)
Second, set the value of the @table variable to production.products.

SET @table = N'production.products';
Code language: SQL (Structured Query Language) (sql)
Third, construct the dynamic SQL by concatenating the SELECT statement with the table name parameter:

SET @sql = N'SELECT * FROM ' + @table;
Code language: SQL (Structured Query Language) (sql)
Fourth, call the sp_executesql stored procedure by passing the @sql parameter.

EXEC sp_executesql @sql;
Code language: SQL (Structured Query Language) (sql)
Putting it all together:

DECLARE 
    @table NVARCHAR(128),
    @sql NVARCHAR(MAX);

SET @table = N'production.products';

SET @sql = N'SELECT * FROM ' + @table;

EXEC sp_executesql @sql;
Code language: SQL (Structured Query Language) (sql)
The code block above produces the exact result set as the following statement:

SELECT * FROM production.products;
Code language: SQL (Structured Query Language) (sql)
To query data from another table, you change the value of the @table variable. However, it’s more practical if we wrap the above T-SQL block in a stored procedure.

SQL Server dynamic SQL and stored procedures 
This stored procedure accepts any table and returns the result set from a specified table by using the dynamic SQL:

CREATE PROC usp_query (
    @table NVARCHAR(128)
)
AS
BEGIN

    DECLARE @sql NVARCHAR(MAX);
    -- construct SQL
    SET @sql = N'SELECT * FROM ' + @table;
    -- execute the SQL
    EXEC sp_executesql @sql;
    
END;
Code language: SQL (Structured Query Language) (sql)
The following statement calls the usp_query stored procedure to return all rows from the production.brands table:

EXEC usp_query 'production.brands';
Code language: SQL (Structured Query Language) (sql)
This stored procedure returns the top 10 rows from a table by the values of a specified column:

CREATE OR ALTER PROC usp_query_topn(
    @table NVARCHAR(128),
    @topN INT,
    @byColumn NVARCHAR(128)
)
AS
BEGIN
    DECLARE 
        @sql NVARCHAR(MAX),
        @topNStr NVARCHAR(MAX);

    SET @topNStr  = CAST(@topN as nvarchar(max));

    -- construct SQL
    SET @sql = N'SELECT TOP ' +  @topNStr  + 
                ' * FROM ' + @table + 
                    ' ORDER BY ' + @byColumn + ' DESC';
    -- execute the SQL
    EXEC sp_executesql @sql;
    
END;
Code language: SQL (Structured Query Language) (sql)
For example, you can get the top 10 most expensive products from the production.products table:

EXEC usp_query_topn 
        'production.products',
        10, 
        'list_price';
Code language: SQL (Structured Query Language) (sql)
This statement returns the top 10 products with the highest quantity in stock:

EXEC usp_query_topn 
        'production.tocks',
        10, 
        'quantity';
Code language: SQL (Structured Query Language) (sql)
SQL Server Dynamic SQL and SQL Injection 
Let’s create a new table named sales.tests for the demonstration:

CREATE TABLE sales.tests(id INT); 
Code language: SQL (Structured Query Language) (sql)
This statement returns all rows from the production.brands table:

EXEC usp_query 'production.brands';
Code language: SQL (Structured Query Language) (sql)
But it does not prevent users from passing the table name as follows:

EXEC usp_query 'production.brands;DROP TABLE sales.tests';
Code language: SQL (Structured Query Language) (sql)
This technique is called SQL injection. Once the statement is executed, the sales.tests table is dropped, because the stored procedure usp_query executes both statements:

SELECT * FROM production.brands;DROP TABLE sales.tests
Code language: SQL (Structured Query Language) (sql)
To prevent this SQL injection, you can use the QUOTENAME() function as shown in the following query:

CREATE OR ALTER PROC usp_query
(
    @schema NVARCHAR(128), 
    @table  NVARCHAR(128)
)
AS
    BEGIN
        DECLARE 
            @sql NVARCHAR(MAX);
        -- construct SQL
        SET @sql = N'SELECT * FROM ' 
            + QUOTENAME(@schema) 
            + '.' 
            + QUOTENAME(@table);
        -- execute the SQL
        EXEC sp_executesql @sql;
    END;
Code language: SQL (Structured Query Language) (sql)
Now, if you pass the schema and table name to the stored procedure, it will work:

EXEC usp_query 'production','brands';
Code language: SQL (Structured Query Language) (sql)
However, if you try to inject another statement such as:

EXEC usp_query 
        'production',
        'brands;DROP TABLE sales.tests';
Code language: SQL (Structured Query Language) (sql)
It will issue the following error:

Invalid object name 'production.brands;DROP TABLE sales.tests'.
Code language: SQL (Structured Query Language) (sql)
More on sp_executesql stored procedure 
The sp_executesql has the following syntax:

EXEC sp_executesql 
    sql_statement  
    parameter_definition
    @param1 = value1,
    @param2 = value2,
    ...
Code language: SQL (Structured Query Language) (sql)
In this syntax:

sql_statement is a Unicode string that contains a T-SQL statement. The sql_statement can contain parameters such as SELECT * FROM table_name WHERE id=@id
parameter_definition is a string that contains the definition of all parameters embedded in the sql_statement. Each parameter definition consists of a parameter name and its data type e.g., @id INT. The parameter definitions are separated by a comma (,).
@param1 = value1, @param2 = value2,… specify a value for every parameter defined in the parameter_definition string.
This example uses the sp_executesql stored procedure to find products which have list price greater than 100 and category 1:

EXEC sp_executesql
N'SELECT *
    FROM 
        production.products 
    WHERE 
        list_price> @listPrice AND
        category_id = @categoryId
    ORDER BY
        list_price DESC', 
N'@listPrice DECIMAL(10,2),
@categoryId INT'
,@listPrice = 100
,@categoryId = 1;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server dynamic SQL to construct general purpose and flexible SQL statements.

Was this tutorial helpful?