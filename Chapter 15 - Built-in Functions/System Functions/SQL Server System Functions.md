SQL Server System Functions
This page provides you with the commonly used system functions in SQL Server that return objects, values, and settings in SQL Server:

CAST – Cast a value of one type to another.
CONVERT – Convert a value of one type to another.
CHOOSE – Return one of the two values based on the result of the first argument.
ISNULL – Replace NULL with a specified value.
ISNUMERIC – Check if an expression is a valid numeric type.
IIF – Add if-else logic to a query.
TRY_CAST – Cast a value of one type to another and return NULL if the cast fails.
TRY_CONVERT – Convert a value of one type to another and return the value to be translated into the specified type. It returns NULL if the cast fails.
TRY_PARSE – Convert a string to a date/time or a number and return NULL if the conversion fails.
Convert datetime to string – Show you how to convert a datetime value to a string in a specified format.
Convert string to datetime – Describe how to convert a string to a datetime value.
Convert datetime to date – Convert a datetime to a date.
GENERATE_SERIES() – Generate a series of numbers within a specific range.

SQL Server CAST Function
Summary: in this tutorial, you will learn how to use the SQL Server CAST() function to convert a value or an expression from one type to another.

Introduction to SQL Server CAST() function 
Let’s see the following query:

SELECT 1 + '1' AS result;
Code language: PHP (php)
It returns 2 as a number:

result
-----------
2

(1 row affected)
In this statement, SQL Server implicitly converts the character string '1' to the number 1.

When you use two values with different data types, SQL Server will try to convert the lower data type to the higher one before it can process the calculation. This is known as an implicit conversion in SQL Server.

In contrast to implicit conversions, we have explicit conversions where you call the CAST() function to explicitly convert a value of one type to another:

SELECT 1 + CAST(1 AS INT) result;
Code language: PHP (php)
The syntax of the CAST() function is as follows:

CAST ( expression AS target_type [ ( length ) ] )  
Code language: CSS (css)
In this syntax:

expression can be a literal value or a valid expression of any type that will be converted.
target_type is the target data type to which you want to convert the expression. It includes INT, BIT, SQL_VARIANT, etc. Note that it cannot be an alias data type.
length is an optional integer that specifies the length of the target type. The length defaults to 30.
The CAST() function returns the expression converted to the target data type.

SQL Server CAST() function examples 
Let’s take some examples of using the CAST() function.

A) Using the CAST() function to convert a decimal to an integer example 
This example uses the CAST() function to convert the decimal number 5.95 to an integer:

SELECT CAST(5.95 AS INT) result;
Code language: CSS (css)
Here is the output:

result
-----------
5

(1 row affected)
B) Using the CAST() function to convert a decimal to another decimal with different length 
The following example uses the CAST() function to convert the decimal number 5.95 to another decimal number with the zero scale:

SELECT CAST(5.95 AS DEC(3,0)) result;
Code language: CSS (css)
The output is as follows:

result
-------
6
When you convert a value of the data types in different places, SQL Server will return a truncated result or a rounded value based on the following rules:

From Data Type	To Data Type	Behavior
numeric	numeric	Round
numeric	int	Truncate
numeric	money	Round
money	int	Round
money	numeric	Round
float	int	Truncate
float	numeric	Round
float	datetime	Round
datetime	int	Round
C) Using the CAST() function to convert a string to a datetime value example 
This example uses the CAST() function to convert the string '2019-03-14' to a datetime:

SELECT 
    CAST('2019-03-14' AS DATETIME) result;
Code language: PHP (php)
The output is:

result
-----------------------
2019-03-14 00:00:00.000

(1 row affected)
Code language: CSS (css)
D) Using CAST() function with arithmetic operators 
We will use the sales.orders and sales.order_items tables from the sample database for the demonstration:

Sample Tables
The following statement uses the CAST() function to convert the monthly sales in 2017 to integer values.

SELECT 
    MONTH(order_date) month, 
    CAST(SUM(quantity * list_price * (1 - discount)) AS INT) amount
FROM sales.orders o
    INNER JOIN sales.order_items i ON o.order_id = i.order_id
WHERE 
    YEAR(order_date) = 2017
GROUP BY 
    MONTH(order_date)
ORDER BY 
    month;
Code language: PHP (php)
The following picture shows the output:

SQL Server CAST Function example
In this tutorial, you have learned how to use the SQL Server CAST() function to convert a value from one type to another.

Was this tutorial helpful?

SQL Server CONVERT Function
Summary: in this tutorial, you will learn how to use the SQL Server CONVERT() function to convert a value of one type to another.

Introduction to SQL Server CONVERT() function 
The CONVERT() function allows you to convert a value of one type to another.

The following shows the syntax of the CONVERT() function:

CONVERT ( target_type [ ( length ) ] , expression [ , style ] )  
Code language: SQL (Structured Query Language) (sql)
In this syntax:

target_type is the target data type to which you wan to convert the expression. It includes INT, BIT, SQL_VARIANT, etc. Note that it cannot be an alias data type.
length is an integer that specifies the length of the target type. The length is optional and defaults to 30.
expression is a valid expression of any type that will be converted.
style is an optional integer that determines how the CONVERT() function will translate expression. If style is NULL, the CONVERT() function will return NULL.
The CONVERT() function returns the value of expression translated to the target_type with a specified style.

The CONVERT() is similar to the CAST() function. However, it is specific to SQL Server. In contrast, the CAST() function is a part of ANSI-SQL functions, which is widely available in many other database products.

SQL Server CONVERT() function examples 
Let’s take some examples of using the CONVERT() function.

A) Using the CONVERT() function to convert a decimal to an integer example 
This example uses the CONVERT() function to convert the decimal number 9.95 to an integer:

SELECT CONVERT(INT, 9.95) result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
-----------
9

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
B) Using the CONVERT() function to convert a decimal to another decimal with different length example 
This example uses the CONVERT() function to convert the decimal number 9.95 to another decimal number with zero scales:

SELECT CAST(9.95 AS DEC(2,0)) result;
Code language: SQL (Structured Query Language) (sql)
The output is as follows:

result
-----------
10

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Notice that the rounding and truncation behaviors of the CONVERT() function are the same as the CAST() functions’.

C) Using the CONVERT() function to convert a string to a datetime value example 
This example uses the CONVERT() function to convert the string '2019-03-14' to a datetime value:

SELECT 
    CONVERT(DATETIME, '2019-03-14') result;
Code language: SQL (Structured Query Language) (sql)
The output is:

result
-----------------------
2019-03-14 00:00:00.000

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
D) Using the CONVERT() function to convert a datetime value to a string value example 
This example uses the CONVERT() function to convert the current date and time to a string with a specific style:

SELECT 
    CONVERT(VARCHAR, GETDATE(),13) result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
------------------------------
14 Mar 2019 08:59:01:380

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server CONVERT() function to convert a value from one type to another.

Was this tutorial helpful?  


SQL Server CHOOSE Function
Summary: in this tutorial, you will learn how to use the SQL Server CHOOSE() function to return an item based on its index in a list of values.

SQL Server CHOOSE() function overview 
The CHOOSE() function returns the item from a list of items at a specified index.

The following shows the syntax of the CHOOSE() function:

CHOOSE ( index, elem_1, elem_2 [, elem_n ] )
Code language: SQL (Structured Query Language) (sql)
In this syntax:

The index is an integer expression that specifies the index of the element to be returned. Note that the indexes of the elements are 1-based. It means that the first element has an index of 1, the second element has an index of 2, and so on.
The elem_1, elem_2,… elem_n is a list of comma-separated values of any type.
If the index is 1, the CHOOSE() function returns elem_1. If the index is 2, the CHOOSE() function returns elem_2, etc.

If index is not an integer, it will be converted to an integer. In case the index is out of the boundary of the list, the CHOOSE() function will return NULL.

SQL Server CHOOSE() function examples 
Let’s take some examples of the CHOOSE() function.

A) Using SQL Server CHOOSE() function with literal values example 
This example returns the second item from the list of values:

SELECT 
    CHOOSE(2, 'First', 'Second', 'Third') Result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Result
------
Second

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
B) Using SQL Server CHOOSE() function for table column example 
See the following sales.orders  table from the sample database:


The following example uses the CHOOSE() function to return the order status based on the value in the order_status column of the sales.orders table:

SELECT
    order_id, 
    order_date, 
    status,
    CHOOSE(order_status,
        'Pending', 
        'Processing', 
        'Rejected', 
        'Completed') AS order_status
FROM 
    sales.orders
ORDER BY 
    order_date DESC;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial result:

SQL Server CHOOSE Function example with table column
In this example, the status of an order is pending, processing, rejected and completed if the value in the order_status is 1, 2, 3, and 4.

C) Using SQL Server CHOOSE() function with the MONTH function 
The following example uses the MONTH() function to return the seasons in which the customers buy products. The result of the MONTH() function is used in the CHOOSE() function to return the corresponding season:

SELECT 
    order_id,
    order_date,
    customer_id,
    CHOOSE(
        MONTH(order_date), 
        'Winter', 
        'Winter', 
        'Spring', 
        'Spring', 
        'Spring', 
        'Summer', 
        'Summer', 
        'Summer', 
        'Autumn', 
        'Autumn', 
        'Autumn', 
        'Winter') month
FROM 
    sales.orders
ORDER BY 
    customer_id;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial result set:

SQL Server CHOOSE Function example
In this tutorial, you have learned how to use the SQL Server CHOOSE() function to return an element on its index in a list of values.

Was this tutorial helpful?


SQL Server ISNULL Function
Summary: in this tutorial, you will learn how to use the SQL Server ISNULL() function to replace NULL with a specified value.

SQL Server ISNULL() function overview 
The SQL Server ISNULL() function replaces NULL with a specified value. The following shows the syntax of the ISNULL() function:

ISNULL(expression, replacement)
Code language: SQL (Structured Query Language) (sql)
The ISNULL() function accepts two arguments:

expression is an expression of any type that is checked for NULL.
replacement is the value to be returned if the expression is NULL. The replacement must be convertible to a value of the type of the expression.
The ISNULL() function returns the replacement if the expression evaluates to NULL. Before returning a value, it implicitly converts the type of replacement to the type of the expression if the types of the two arguments are different.

In case the expression is not NULL, the ISNULL() function returns the value of the expression.

SQL Server ISNULL() function examples 
Let’s take some examples of using the ISNULL() function.

Using SQL Server ISNULL() function with the numeric data example 
This example uses the ISNULL() function to return the second argument because the first argument is NULL:

SELECT 
    ISNULL(NULL,20) result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Result
-----------
20

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Using SQL Server ISNULL() function with character string example 
The following example uses the ISNULL() function to return the string 'Hello' because it is the first argument and not NULL:

SELECT 
    ISNULL('Hello', 'Hi') Result;
Code language: SQL (Structured Query Language) (sql)
The output is:

Result
------
Hello

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Using SQL Server ISNULL() function to replace NULL values with meaningful values 
First, create a new table named divisions that stores athlete’s divisions by ages:

CREATE TABLE divisions
(
    id      INT
    PRIMARY KEY IDENTITY, 
    min_age INT DEFAULT 0, 
    max_age INT
);
Code language: SQL (Structured Query Language) (sql)
Second, insert some rows into the divisions table:

INSERT INTO divisions(min_age, max_age)
VALUES(5,null),
        (20,null),
        (null,30);
Code language: SQL (Structured Query Language) (sql)
Third, query data from the divisions table:

SELECT
    id,
    min_age,
    max_age 
FROM 
    divisions;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server ISNULL sample table
If a division does not require minimum age, the min_age column will have NULL. Similarly, if a division does not require maximum age, the max_age column will also have NULL.

Last, use the ISNULL() function to convert NULL in the min_age column to 0 and NULL in the max_age column to 99:

SELECT 
    id, 
    ISNULL(min_age,0) min_age, 
    ISNULL(max_age,99) max_age
FROM
    divisions;
Code language: SQL (Structured Query Language) (sql)
The following picture shows output:

SQL Server ISNULL Function example
In this tutorial, you have learned how to use the SQL Server ISNULL() function to replace NULL with a specified value.

Was this tutorial helpful?


SQL Server ISNUMERIC Function
Summary: in this tutorial, you will learn how to use the SQL Server ISNUMERIC() function to check if a value is a valid numeric type.

Introduction to SQL Server ISNUMERIC() function 
The ISNUMERIC() accepts an expression and returns 1 if the expression is a valid numeric type; otherwise, it returns 0.

The following shows the syntax of the ISNUMERIC() function:

ISNUMERIC ( expression )  
Code language: SQL (Structured Query Language) (sql)
In this syntax, the expression is any valid expression to be evaluated.

Note that a valid numeric type is one of the following:

Exact numbers: BIGINT, INT, SMALLINT, TINYINT, and BIT
Fixed precision: DECIMAL, NUMERIC
Approximate: FLOAT, REAL
Monetary values: MONEY, SMALLMONEY
The ISNUMERIC() actually checks if a value can be converted to a numeric data type and returns the right answer. However, it doesn’t tell you which datatype and properly handle the overflow.

This was why the TRY_CAST(), TRY_PARSE(), and TRY_CONVERT() function was introduced since SQL Server 2012.

SQL Server ISNUMERIC() examples 
Let’s take some examples o fusing the ISNUMERIC() function.

This example uses the ISNUMERIC() function to check if the string '$10' can be converted to a number or not:

SELECT 
    ISNUMERIC('$10') result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
-----------
1

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
The following example checks whether the '-2.23E-308' string is a number:

SELECT 
    ISNUMERIC('-2.23E-308') result;
Code language: SQL (Structured Query Language) (sql)
The output is:

result
-----------
1

(1 row affected)        
Code language: SQL (Structured Query Language) (sql)
The following example returns 0 indicating that the string '+ABC' is not a number:

SELECT 
    ISNUMERIC('+ABC') result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
-----------
0

(1 row affected)        
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server ISNUMERIC() to check if an expression is a valid numeric type.

Was this tutorial helpful?

SQL Server IIF Function
Summary: in this tutorial, you will learn how to use the SQL Server IIF() function to add if-else logic to queries.

Introduction to SQL Server IIF() function 
The IIF() function accepts three arguments. It evaluates the first argument and returns the second argument if the first argument is true; otherwise, it returns the third argument.

The following shows the syntax of the IIF() function:

IIF(boolean_expression, true_value, false_value)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

boolean_expression is an expression to be evaluated. It must be a valid Boolean expression, or the function will raise an error.
true_value is the value to be returned if the boolean_expression evaluates to true.
false_value is the value to be returned if the boolean_expression evaluates to false.
In fact, the IIF() function is shorthand of a CASE expression:

CASE 
    WHEN boolean_expression 
        THEN true_value
    ELSE
        false_value
END
Code language: SQL (Structured Query Language) (sql)
SQL Server IIF() function examples 
Let’s take some examples of using the SQL Server IIF() function.

A) Using SQL Server IIF() function with a simple example 
This example uses the IIF() function to check if 10 < 20 and returns the True string:

SELECT 
    IIF(10 < 20, 'True', 'False') Result ;
Code language: SQL (Structured Query Language) (sql)
Here is the result:

Result
------
True

(1 row affected)
Code language: PHP (php)
B) Using SQL Server IIF() function with table column example 
The following example nests IIF()function inside IIF() functions and returns the corresponding order status based on the status number:

SELECT    
    IIF(order_status = 1,'Pending', 
        IIF(order_status=2, 'Processing',
            IIF(order_status=3, 'Rejected',
                IIF(order_status=4,'Completed','N/A')
            )
        )
    ) order_status,
    COUNT(order_id) order_count
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    order_status;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server IIF Function Example
C) Using SQL Server IIF() function with aggregate functions 
This example uses the IIF() function with the SUM() function to get the number of orders by order status in 2018.

SELECT    
    SUM(IIF(order_status = 1, 1, 0)) AS 'Pending', 
    SUM(IIF(order_status = 2, 1, 0)) AS 'Processing', 
    SUM(IIF(order_status = 3, 1, 0)) AS 'Rejected', 
    SUM(IIF(order_status = 4, 1, 0)) AS 'Completed', 
    COUNT(*) AS Total
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2017;
Code language: SQL (Structured Query Language) (sql)
In this example, the IIF() function returns 1 or zero if the status is matched. The SUM() function returns the number of orders for each status.

Here is the output:

SQL Server IIF Function Pivot example
In this tutorial, you have learned how to use the SQL Server IIF() function to return one of two values, based on the result of the first argument.

Was this tutorial helpful?

SQL Server TRY_CAST Function
Summary: in this tutorial, you will learn how to use the SQL Server TRY_CAST() function to cast a value of one type to another.

SQL Server TRY_CAST() function overview 
The TRY_CAST() function casts a value of one type to another. It returns NULL if the conversion fails.

The following shows the syntax of the TRY_CAST() function:

TRY_CAST ( expression AS data_type [ ( length ) ] )  
Code language: SQL (Structured Query Language) (sql)
The TRY_CAST() accepts two arguments:

data_type is any valid data type into which the function will cast the expression.
expression is the value to cast.
The TRY_CAST() function takes the input value and tries to cast it to a value of the specified data type. It returns the value in the specified data if the cast succeeds; Otherwise, it returns NULL. But, if you request a conversion that is explicitly not allowed, the TRY_CAST() function will fail with an error.

TRY_CAST() vs. CAST() 
If the cast fails, the TRY_CAST() function returns NULL while the CAST() function raises an error.

You use the NULL handling functions or expressions such as ISNULL(), COALESCE, or CASE to handle the result of the TRY_CAST() function in case the cast fails. On the other hand, you use the TRY...CATCH statement to handle the result of the CAST() function if the cast fails.

SQL Server TRY_CAST() function examples 
Let’s take some examples of using the TRY_CAST() function.

A) TRY_CAST() returns NULL example 
The following example shows how the TRY_CAST() function returns NULL when the cast fails:

SELECT 
    CASE
        WHEN TRY_CAST('test' AS INT) IS NULL
        THEN 'Cast failed'
        ELSE 'Cast succeeded'
    END AS Result;
Code language: SQL (Structured Query Language) (sql)
Here is the output.

Result
-----------
Cast failed

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
B)TRY_CAST() raises an error example 
This example returns an error because a number cannot be cast into an XML data type:

SELECT 
    TRY_CAST(30.5 AS XML);
Code language: SQL (Structured Query Language) (sql)
Here is the error:

Explicit conversion from data type numeric to xml is not allowed.
Code language: SQL (Structured Query Language) (sql)
C) Using TRY_CAST() function to CAST string to decimal examples 
The following example uses the TRY_CAST() function to convert a string to a decimal:

SELECT 
    TRY_CAST('12.34' AS DECIMAL(4, 2)) Result
Code language: SQL (Structured Query Language) (sql)
Here is the result:

Result
----------
12.34
Code language: SQL (Structured Query Language) (sql)
Here is another example:

SELECT 
    TRY_CAST('12.345' AS DECIMAL(4,2))  Result;
Code language: SQL (Structured Query Language) (sql)
The result is rounded up to 12.35:

Result
-----------
12.35

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
This example returns NULL because the TRY_CAST() function cannot cast the string '1234.5' to a DECIMAL(4, 2):

SELECT 
    TRY_CAST('1234.5' AS DECIMAL(4, 2)) Result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Result
-----------
NULL

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
D) Using TRY_CAST() function to convert string to integer examples 
The following example uses the TRY_CAST() function to convert a string to an integer:

SELECT 
    TRY_CAST('100' AS INT) Result;
Code language: SQL (Structured Query Language) (sql)
Here is the result set:

Result
-----------
100

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
This example returns NULL because the cast fails:

SELECT 
    TRY_CAST('100.5' AS INT) Result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Result
-----------
NULL

(1 row affected)        
Code language: SQL (Structured Query Language) (sql)
E) Using TRY_CAST() function to convert datetime to date or time example 
The following example uses the TRY_CAST() function to convert the current system date and time to a date value:

SELECT 
	TRY_CAST(GETDATE() AS DATE) Result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Result
----------
2019-04-28

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Likewise, you can use the TRY_CAST() funtion to convert the current system date and time to a time value:

SELECT 
	TRY_CAST(GETDATE() AS TIME) Result;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

Result
----------------
17:36:37.5900000

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server TRY_CAST() function to cast a value of one type to another.

Was this tutorial helpful?

SQL Server TRY_CONVERT Function
Summary: in this tutorial, you will learn how to use the SQL Server TRY_CONVERT() function to convert a value of one type to another.

SQL Server TRY_CONVERT() function overview 
The TRY_CONVERT() function converts a value of one type to another. It returns NULL if the conversion fails.

The following illustrates the syntax of the TRY_CONVERT() function:

TRY_CONVERT (
    data_type[(length)], 
    expression 
    [,style]
)
Code language: SQL (Structured Query Language) (sql)
The TRY_CONVERT() accepts three arguments:

data_type is a valid data type into which the function will cast the expression.
expression is the value to cast.
style is a provided integer that specifies how the function will translate the expression.
The TRY_CONVERT() function tries to convert the value passed to it to a specified data type. It returns the value as the specified data if the cast succeeds; Otherwise, it returns. However, if you request a conversion that is explicitly not permitted, the TRY_CONVERT() function will fail with an error.

TRY_CONVERT() vs. CONVERT() 
If the cast fails, the TRY_CONVERT() function returns NULL while the CONVERT() function raises an error. This is the main difference between the two functions.

You can use the NULL handling functions or expressions such as ISNULL() and COALESCE to handle the result of the TRY_CONVERT() function in case the cast fails.

To handle the result of the CONVERT() function if the cast fails, you use the TRY...CATCH statement.

SQL Server TRY_CONVERT() function examples 
Let’s take some examples of using the TRY_CONVERT() function.

A) TRY_CONVERT() returns NULL example 
This example shows how the TRY_CONVERT() function returns NULL when the cast fails:

SELECT 
    CASE
        WHEN TRY_CONVERT( INT, 'test') IS NULL
        THEN 'Cast failed'
        ELSE 'Cast succeeded'
    END AS Result;
Code language: SQL (Structured Query Language) (sql)
Here is the result.

Result
-----------
Cast failed

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
B) TRY_CONVERT() raises an error example 
The following example returns an error because the integer cannot be cast into an XML data type:

SELECT 
    TRY_CONVERT( XML, 20);
Code language: SQL (Structured Query Language) (sql)
Here is the error:

Explicit conversion from data type int to xml is not allowed.
Code language: SQL (Structured Query Language) (sql)
C) Using TRY_CONVERT() function to convert string to decimal examples 
This example uses the TRY_CONVERT() function to convert a string to decimal:

SELECT 
    TRY_CONVERT(DECIMAL(4,2), '12.34');
Code language: SQL (Structured Query Language) (sql)
Here is the result:

Result
----------
12.34
Code language: SQL (Structured Query Language) (sql)
The following shows another example:

SELECT 
    TRY_CONVERT(DECIMAL(4,2), '12.345')  Result;
Code language: SQL (Structured Query Language) (sql)
The result is rounded:

Result
-----------
12.35

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
The following example returns NULL because the TRY_CONVERT() function cannot convert the string '1234.5' to a DECIMAL(4, 2):

SELECT 
    TRY_CONVERT( DECIMAL(4, 2), '1234.5') Result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Result
-----------
NULL

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
D) Using TRY_CONVERT() function to convert string to integer examples 
This example uses the TRY_CONVERT() function to convert a string to an integer:

SELECT 
    TRY_CONVERT( INT, '100') Result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Result
-----------
100

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
This example, on the other hand, returns NULL because the cast fails:

SELECT 
    TRY_CONVERT( INT, '100.5') Result;
Code language: SQL (Structured Query Language) (sql)
Output:

Result
-----------
NULL

(1 row affected)        
Code language: SQL (Structured Query Language) (sql)
E) Using TRY_CONVERT() function to convert datetime to date or time example 
This example uses the TRY_CONVERT() function to convert the current system date and time to a date value:

SELECT 
	TRY_CONVERT( DATE, GETDATE()) Result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

Result
----------
2019-04-28

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Similarly, you can use the TRY_CONVERT() function to convert the current system date and time to a time value:

SELECT 
	TRY_CONVERT( TIME, GETDATE()) Result;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

Result
----------------
17:10:19.1700000

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server TRY_CONVERT() function to convert a value of one type to another.

Was this tutorial helpful?

SQL Server TRY_PARSE Function
Summary: in this tutorial, you will learn how to use the SQL Server TRY_PARSE() function to convert a string to date/time and number types.

SQL Server TRY_PARSE() function overview 
The TRY_PARSE() function is used to translate the result of an expression to the requested data type. It returns NULL if the cast fails.

Here is the syntax of the TRY_PARSE() function:

TRY_PARSE ( expression AS data_type [ USING culture ] )  
Code language: SQL (Structured Query Language) (sql)
In this syntax:

expression evaluates to a string value of NVARCHAR(4000).
data_type represents the data type requested for the result.
culture is an optional string that specifies the culture in which expression is formatted. It defaults to the language of the current session. Note that the culture is not limited to the ones supported by SQL; It can accept any culture supported by .NET Framework.
SQL Server TRY_PARSE() function examples 
Let’s take some examples of using the TRY_PARSE() function.

1) Using SQL Server TRY_PARSE() function to convert a string to a date example 
This example uses the TRY_PARSE() function to convert the string '14 April 2019' to a date:

SELECT 
    TRY_PARSE('14 April 2019' AS date) result;
Code language: SQL (Structured Query Language) (sql)
Here is the result set:

result
----------
2019-04-14

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
2) Using SQL Server TRY_PARSE() function to convert a string to a number example 
The following example uses the TRY_PARSE() function to convert the string '-1250' to an integer:

SELECT 
    TRY_PARSE('-1250' AS INT) result;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

result
-----------
-1250

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
This statement returns NULL because the TRY_PARSE() function fails to convert the string 'ABC' to a decimal.

SELECT 
    TRY_PARSE('ABC' AS DEC) result;
Code language: SQL (Structured Query Language) (sql)
The output will look like this:

result
-----------
NULL

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
3) Using SQL Server TRY_PARSE() function with CASE expression example 
This example uses the TRY_PARSE() function with the CASE to test expression and return the corresponding message if the cast is failed or succeeded.

SELECT 
    CASE
        WHEN TRY_PARSE('Last year' AS DATE) IS NULL
        THEN 'Cast failed'
        ELSE 'Cast succeeded'
    END AS result;
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

result
--------------------
Cast failed

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server TRY_PARSE() function to convert a string to date/time and number types.

Was this tutorial helpful?


Convert String to Datetime
Summary: in this tutorial, you will learn how to convert a string to a datetime in SQL Server using the CONVERT() and TRY_CONVERT() function.

Introduction to CONVERT() and TRY_CONVERT() functions 
SQL Server provides the CONVERT() function that converts a value of one type to another:

CONVERT(target_type, expression [, style])
Code language: SQL (Structured Query Language) (sql)
Besides the CONVERT() function, you can also use the TRY_CONVERT() function:

TRY_CONVERT(target_type, expression [, style])
Code language: SQL (Structured Query Language) (sql)
The main difference between CONVERT() and TRY_CONVERT() is that in case of conversion fails, the CONVERT() function raises an error while the TRY_CONVERT() function returns NULL.

This example uses the CONVERT() function to convert a string in ANSI date format to a datetime:

  SELECT 
    CONVERT(DATETIME, '2019-08-15', 102) result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
-----------------------
2019-08-15 00:00:00.000

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
If the conversion fails, the CONVERT() function will raise an error:

SELECT 
    CONVERT(DATETIME, '2019-18-15', 102) result;
Code language: SQL (Structured Query Language) (sql)
The following is the error message:

The conversion of a varchar data type to a datetime data type resulted in an out-of-range value.
Code language: SQL (Structured Query Language) (sql)
The TRY_CONVERT() function, on the other hand, returns NULL instead of raising an error if the conversion fails:

SELECT 
    TRY_CONVERT(DATETIME, '2019-18-15', 102) result;
Code language: SQL (Structured Query Language) (sql)
The output is:

result
-----------------------
NULL

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Converting a string in ANSI/ISO and US date format to a datetime 
Both CONVERT() and TRY_CONVERT() function can recognize ANSI/ISO and US formats with various delimiters by default so you don’t have to add the style parameter.

This example shows how to use the CONVERT() function to convert strings in ISO date format to datetime values:

SELECT CONVERT(DATETIME, '2019-09-25');
SELECT CONVERT(DATETIME, '2019/09/25');
SELECT CONVERT(DATETIME, '2019.09.25');
SELECT CONVERT(DATETIME, '2019-09-25 12:11');
SELECT CONVERT(DATETIME, '2019-09-25 12:11:09');
SELECT CONVERT(DATETIME, '2019-09-25 12:11:09.555');
SELECT CONVERT(DATETIME, '2019/09/25 12:11:09.555');
SELECT CONVERT(DATETIME, '2019.09.25 12:11:09.555');
Code language: SQL (Structured Query Language) (sql)
Note that the CONVERT() function can also convert an ISO date string without delimiters to a date value as shown in the following example:

SELECT 
    CONVERT(DATETIME, '20190731') result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
-----------------------
2019-07-31 00:00:00.000

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
The CONVERT() and TRY_CONVERT() functions can convert United States datetime format (month, day, year and time) by default, therefore, you don’t need to specify style 101:

SELECT TRY_CONVERT( DATETIME, '12-31-2019');
SELECT TRY_CONVERT( DATETIME, '12/31/2019');
SELECT TRY_CONVERT( DATETIME, '12.31.2019');
SELECT TRY_CONVERT( DATETIME, '12-31-2019 12:15');
SELECT TRY_CONVERT( DATETIME, '12/31/2019 12:15:10');
SELECT TRY_CONVERT( DATETIME, '12.31.2019 12:15:10.333');
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to convert a string to a datetime using the CONVERT() and TRY_CONVERT() functions.

Was this tutorial helpful?

Convert String to Datetime
Summary: in this tutorial, you will learn how to convert a string to a datetime in SQL Server using the CONVERT() and TRY_CONVERT() function.

Introduction to CONVERT() and TRY_CONVERT() functions 
SQL Server provides the CONVERT() function that converts a value of one type to another:

CONVERT(target_type, expression [, style])
Code language: SQL (Structured Query Language) (sql)
Besides the CONVERT() function, you can also use the TRY_CONVERT() function:

TRY_CONVERT(target_type, expression [, style])
Code language: SQL (Structured Query Language) (sql)
The main difference between CONVERT() and TRY_CONVERT() is that in case of conversion fails, the CONVERT() function raises an error while the TRY_CONVERT() function returns NULL.

This example uses the CONVERT() function to convert a string in ANSI date format to a datetime:

  SELECT 
    CONVERT(DATETIME, '2019-08-15', 102) result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
-----------------------
2019-08-15 00:00:00.000

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
If the conversion fails, the CONVERT() function will raise an error:

SELECT 
    CONVERT(DATETIME, '2019-18-15', 102) result;
Code language: SQL (Structured Query Language) (sql)
The following is the error message:

The conversion of a varchar data type to a datetime data type resulted in an out-of-range value.
Code language: SQL (Structured Query Language) (sql)
The TRY_CONVERT() function, on the other hand, returns NULL instead of raising an error if the conversion fails:

SELECT 
    TRY_CONVERT(DATETIME, '2019-18-15', 102) result;
Code language: SQL (Structured Query Language) (sql)
The output is:

result
-----------------------
NULL

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Converting a string in ANSI/ISO and US date format to a datetime 
Both CONVERT() and TRY_CONVERT() function can recognize ANSI/ISO and US formats with various delimiters by default so you don’t have to add the style parameter.

This example shows how to use the CONVERT() function to convert strings in ISO date format to datetime values:

SELECT CONVERT(DATETIME, '2019-09-25');
SELECT CONVERT(DATETIME, '2019/09/25');
SELECT CONVERT(DATETIME, '2019.09.25');
SELECT CONVERT(DATETIME, '2019-09-25 12:11');
SELECT CONVERT(DATETIME, '2019-09-25 12:11:09');
SELECT CONVERT(DATETIME, '2019-09-25 12:11:09.555');
SELECT CONVERT(DATETIME, '2019/09/25 12:11:09.555');
SELECT CONVERT(DATETIME, '2019.09.25 12:11:09.555');
Code language: SQL (Structured Query Language) (sql)
Note that the CONVERT() function can also convert an ISO date string without delimiters to a date value as shown in the following example:

SELECT 
    CONVERT(DATETIME, '20190731') result;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

result
-----------------------
2019-07-31 00:00:00.000

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
The CONVERT() and TRY_CONVERT() functions can convert United States datetime format (month, day, year and time) by default, therefore, you don’t need to specify style 101:

SELECT TRY_CONVERT( DATETIME, '12-31-2019');
SELECT TRY_CONVERT( DATETIME, '12/31/2019');
SELECT TRY_CONVERT( DATETIME, '12.31.2019');
SELECT TRY_CONVERT( DATETIME, '12-31-2019 12:15');
SELECT TRY_CONVERT( DATETIME, '12/31/2019 12:15:10');
SELECT TRY_CONVERT( DATETIME, '12.31.2019 12:15:10.333');
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to convert a string to a datetime using the CONVERT() and TRY_CONVERT() functions.

Was this tutorial helpful?

Convert Datetime to Date
Summary: in this tutorial, you will learn how to convert a datetime to a DATE by using the CONVERT(), TRY_CONVERT(), and CAST() functions.

To convert a datetime to a date, you can use the CONVERT(), TRY_CONVERT(), or CAST() function.

Convert datetime to date using the CONVERT() function 
This statement uses the CONVERT() function to convert a datetime to a date:

CONVERT(DATE, datetime_expression)
Code language: SQL (Structured Query Language) (sql)
In this syntax, the datetime_expresssion is any valid expression that evaluates to a valid datetime value. The CONVERT() function will raise an error if the conversion fails.

The following example uses the CONVERT() function to convert a datetime to a date:

SELECT 
    CONVERT(DATE, GETDATE()) date;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

date
----------
2019-04-23

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Note that the GETDATE() function returns the current database server’s datetime.

Convert datetime to date using the TRY_CONVERT() function 
Similarly, the TRY_CONVERT() can also be used to convert the datetime to a date:

TRY_CONVERT(DATE, datetime_expression)
Code language: SQL (Structured Query Language) (sql)
Unlike the CONVERT() function, the TRY_CONVERT() function returns NULL if the conversion fails.

This example uses the TRY_CONVERT() function to convert the current datetime to a date:

SELECT
    TRY_CONVERT(DATE,GETDATE());
Code language: SQL (Structured Query Language) (sql)
The following shows the output:

date
----------
2019-04-23

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
Convert datetime to date using the CAST() function 
The following statement converts a datetime value to a date using the CAST() function:

CAST(datetime_expression AS DATE)
Code language: SQL (Structured Query Language) (sql)
This example uses the CAST() function to convert the current datetime to a date value:

SELECT 
    CAST(GETDATE() AS DATE) date;
Code language: SQL (Structured Query Language) (sql)
The output is as follows:

date
----------
2019-04-23

(1 row affected)
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use how to convert a datetime to a date using the CONVERT(), TRY_CONVERT(), and CAST() functions.

Was this tutorial helpful?
SQL Server GENERATE_SERIES() Function
Summary: in this tutorial, you will learn how to use the SQL Server GENERATE_SERIES() function to generate a series of numbers within a specific range.

Introduction to the SQL Server GENERATE_SERIES() function 
The GENERATE_SERIES() function allows you to create a series of values within a specified range.

Here’s the syntax of the GENERATE_SERIES() function:

GENERATE_SERIES(start, stop [, step])
Code language: SQL (Structured Query Language) (sql)
In this syntax:

start: The starting value of the series.
stop: The ending value of the series. The series stops when the last generated step value exceeds the stop value.
step: The increment or decrement value between steps in the series. The step can be either positive or negative but can’t be zero.
The start, stop, and step parameters can be a literal, a variable, or a scalar expression of type integers (tinyint, smallint, int, and bigint) or decimal ( or numeric). They must also have the same data type.

If the start is less than the stop, the step will have a default value 1. Otherwise, the step’s default value is -1.

The GENERATE_SERIES() function returns a result set that consists of a single column with the name “value“.

The GENERATE_SERIES() function returns an empty result set in the following cases:

If the start is less than the stop, and the step has a negative value.
If the start is greater than the stop, and the step has a positive value.
If either the start, stop, or step is NULL.
In PostgreSQL, the GENERATE_SERIES() function generates a series of values including numbers, dates, and timestamps. However, in SQL Server, the GENERATE_SERIES() can only create a series of numbers.

SQL Server GENERATE_SERIES() function examples 
Let’s explore some examples of using the GENERATE_SERIES() function.

1) Basic GENERATE_SERIES() function examples 
The following example uses the GENERATE_SERIES() function to generate a series of integers between 1 and 5 in increments of 1:

SELECT value
FROM GENERATE_SERIES(1,5);
Code language: SQL (Structured Query Language) (sql)
Output:

value
-----------
1
2
3
4
5

(5 rows affected)
Code language: SQL (Structured Query Language) (sql)
The following example uses the GENERATE_SERIES() function to generate a series of integers between 1 and 10 in increments of 2:

SELECT value
FROM GENERATE_SERIES(1,10,2);
Code language: SQL (Structured Query Language) (sql)
Output:

value
-----
1
3
5
7
9

(5 rows affected)
Code language: SQL (Structured Query Language) (sql)
The following statement uses the GENERATE_SERIES() function to generate a series of integers between 10 and 1 in decrements of 2:

SELECT value
FROM GENERATE_SERIES(10,1,-2);
Code language: SQL (Structured Query Language) (sql)
Output:

value
------
10
8
6
4
2

(5 rows affected)
Code language: SQL (Structured Query Language) (sql)
The following statement uses the GENERATE_SERIES() function to generate a series of decimal values between 1 and 2 in increments of 0.1:

SELECT value
FROM GENERATE_SERIES(1.0,2.0,0.1);
Code language: SQL (Structured Query Language) (sql)
Output:

value
------
1.0
1.1
1.2
1.3
1.4
1.5
1.6
1.7
1.8
1.9
2.0

(11 rows affected)
Code language: SQL (Structured Query Language) (sql)
2) Using the GENERATE_SERIES() function to a series of dates 
The following example uses the GENERATE_SERIES() function to generate a series of 7 date values starting from 2024-04-01:

SELECT
  CONVERT(DATE, DATEADD (DAY, VALUE, '2024-04-01')) AS DATE
FROM
  GENERATE_SERIES (0, 6);
Code language: SQL (Structured Query Language) (sql)
Output:

Date
----------
2024-04-01
2024-04-02
2024-04-03
2024-04-04
2024-04-05
2024-04-06
2024-04-07

(7 rows affected)
Code language: SQL (Structured Query Language) (sql)
How it works.

First, generate a series of integers from 0 to 6 using the GENERATE_SERIES() function. These numbers represent the number of days that we add to the starting date ('2024-04-01').
Second, for each number generated by the GENERATE_SERIES() function, add the corresponding number of days to the starting date ('2024-04-01') using the DATEADD() function.
Third, convert the DATETIME values to DATE using the CONVERT() function.
3) Using the GENERATE_SERIES() function to calculate compound interest over years 
First, create a new table called savings that stores the principal and annual interest rate:

CREATE TABLE savings(
    id INT IDENTITY PRIMARY KEY,
    principal money NOT NULL,
    interest_rate DEC(19,5) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Second, insert rows into the savings table:

INSERT INTO
  savings (principal, interest_rate)
VALUES
  (1000, 0.05),
  (5000, 0.07);
Code language: SQL (Structured Query Language) (sql)
Third, retrieve data from the savings table:

SELECT * FROM savings;
Output:

id | principal | interest_rate
---+-----------+--------------
1  | 1000.0000 | 0.05000
2  | 5000.0000 | 0.07000
(2 rows)
Finally, cross join the savings table with the series of numbers generated by the GENERATE_SERIES() function to calculate the ending balance each year:

SELECT
  id,
  principal,
  interest_rate,
  VALUE,
  principal * POWER(1 + interest_rate, VALUE) balance
FROM
  savings
  CROSS JOIN GENERATE_SERIES(1, 3);
Code language: SQL (Structured Query Language) (sql)
Output:

id | principal | interest_rate | VALUE | balance
---+-----------+---------------+-------+------------
1  | 1000.0000 | 0.05000       | 1     | 1050.000000
1  | 1000.0000 | 0.05000       | 2     | 1102.500000
1  | 1000.0000 | 0.05000       | 3     | 1157.630000
2  | 5000.0000 | 0.07000       | 1     | 5350.000000
2  | 5000.0000 | 0.07000       | 2     | 5724.500000
2  | 5000.0000 | 0.07000       | 3     | 6125.200000
(6 rows)
Code language: SQL (Structured Query Language) (sql)
Summary 
Use the GENERATE_SERIES() function to generate a series of numbers within a specific range.
