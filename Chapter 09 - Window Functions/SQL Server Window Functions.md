SQL Server Window Functions calculate an aggregate value based on a group of rows and return multiple rows for each group.
Type a function name to search...

Name	Description
CUME_DIST	Calculate the cumulative distribution of a value in a set of values
DENSE_RANK	Assign a rank value to each row within a partition of a result, with no gaps in rank values.
FIRST_VALUE	Get the value of the first row in an ordered partition of a result set.
LAG	Provide access to a row at a given physical offset that comes before the current row.
LAST_VALUE	Get the value of the last row in an ordered partition of a result set.
LEAD	Provide access to a row at a given physical offset that follows the current row.
NTILE	Distribute rows of an ordered partition into a number of groups or buckets
PERCENT_RANK	Calculate the percent rank of a value in a set of values.
RANK	Assign a rank value to each row within a partition of a result set
ROW_NUMBER	Assign a unique sequential integer to rows within a partition of a result set, the first row starts from 1.


SQL Server CUME_DIST Function
Summary: in this tutorial, you will learn how to use the SQL Server CUME_DIST() function to calculate a cumulative distribution of a value within a group of values.

Introduction to SQL Server CUME_DIST() function 
Sometimes, you want to make a report that contains the top or bottom x% values from a data set e.g., top 5% sales staffs by net sales. One way to achieve this with SQL Server is to use the CUME_DIST() function.

The CUME_DIST() function calculates the cumulative distribution of a value within a group of values. Simply put, it calculates the relative position of a value in a group of values.

The following shows the syntax of the CUME_DIST() function:

 CUME_DIST() OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
Code language: SQL (Structured Query Language) (sql)
Let’s examine this syntax in detail.

PARTITION BY clause 
The PARTITION BY clause distributes rows into multiple partitions to which the CUME_DIST() function is applied.

The PARTITION BY clause is optional. The CUME_DIST() function will treat the whole result set as a single partition if you omit the PARTITION BY clause.

ORDER BY clause 
The ORDER BY clause specifies the logical order of rows in each partition to which the CUME_DIST() function is applied. The ORDER BY clause considers NULL values as the lowest possible values.

Return value 
The result of CUME_DIST() is greater than 0 and less than or equal to 1.

0 < CUME_DIST() <= 1
Code language: SQL (Structured Query Language) (sql)
The function returns the same cumulative distribution values for the same tie values.

SQL Server CUME_DIST() examples 
Let’s take some examples of using the CUME_DIST() function.

Using SQL Server CUME_DIST() function over a result set example 
The following statement calculates the sales percentile for each sales staff in 2017:

SELECT 
    CONCAT_WS(' ',first_name,last_name) full_name,
    net_sales, 
    CUME_DIST() OVER (
        ORDER BY net_sales DESC
    ) cume_dist
FROM 
    sales.vw_staff_sales t
INNER JOIN sales.staffs m on m.staff_id = t.staff_id
WHERE 
    year = 2017;
Code language: SQL (Structured Query Language) (sql)
Here is the result:

SQL Server CUME_DIST Function over result set example
As shown in the output, 50% of the sales staff have net sales greater than 285K.

Using SQL Server CUME_DIST() function over a partition example 
This example uses the CUME_DIST() function to calculate the sales percentile for each sales staff in 2016 and 2017.

SELECT 
    CONCAT_WS(' ',first_name,last_name) full_name,
    net_sales, 
    year,
    CUME_DIST() OVER (
        PARTITION BY year
        ORDER BY net_sales DESC
    ) cume_dist
FROM 
    sales.vw_staff_sales t
INNER JOIN sales.staffs m on m.staff_id = t.staff_id
WHERE 
    year IN (2016,2017);
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server CUME_DIST Function over partition example
In this example:

The PARTITION BYclause distributed the rows into two partitions by year, 2016 and 2017.
The ORDER BY clause sorted rows in each partition by net sales from high to low to which the CUME_DIST() function is applied.
To get the top 20% of sales staff by net sales in 2016 and 2017, you use the following query:

WITH cte_sales AS (
    SELECT 
        CONCAT_WS(' ',first_name,last_name) full_name,
        net_sales, 
        year,
        CUME_DIST() OVER (
            PARTITION BY year
            ORDER BY net_sales DESC
        ) cume_dist
    FROM 
        sales.vw_staff_sales t
        INNER JOIN sales.staffs m  
            ON m.staff_id = t.staff_id
    WHERE 
        year IN (2016,2017)
)
SELECT 
    * 
FROM 
    cte_sales
WHERE 
    cume_dist <= 0.20;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server CUME_DIST Function - top 20 percent sales staff by net sales
In this tutorial, you have learned how to use the SQL Server CUME_DIST() function to calculate the cumulative distribution of a value in a group of values.

Was this tutorial helpful?  


SQL Server DENSE_RANK Function
Summary: in this tutorial, you will learn how to use the SQL Server DENSE_RANK() function to assign a rank to each row within a partition of a result set, with no gaps in ranking values.

Introduction to SQL Server DENSE_RANK() function 
The DENSE_RANK() is a window function that assigns a rank to each row within a partition of a result set. Unlike the RANK() function, the DENSE_RANK() function returns consecutive rank values. Rows in each partition receive the same ranks if they have the same values.

The syntax of the DENSE_RANK() function is as follows:

DENSE_RANK() OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
Code language: SQL (Structured Query Language) (sql)
The DENSE_RANK() function is applied to the rows of each partition defined by the PARTITION BY clause, in a specified order, defined by ORDER BY clause. It resets the rank when the partition boundary is crossed.

The PARITION BY clause is optional. If you omit it, the function will treat the whole result set as a single partition.

SQL Server DENSE_RANK() function illustration 
The following statements create a new table named dense_rank_demo and insert some rows into that table:

CREATE TABLE sales.dense_rank_demo (
	v VARCHAR(10)
);
	
INSERT INTO sales.dense_rank_demo(v)
VALUES('A'),('B'),('B'),('C'),('C'),('D'),('E');
	
SELECT * FROM sales.dense_rank_demo;
Code language: SQL (Structured Query Language) (sql)
The following statement uses both DENSE_RANK() and RANK() functions to assign a rank to each row of the result set:

SELECT
	v,
	DENSE_RANK() OVER (
		ORDER BY v
	) my_dense_rank,
	RANK() OVER (
		ORDER BY v
	) my_rank
FROM
	sales.dense_rank_demo;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server DENSE_RANK Function illustration
SQL Server DENSE_RANK() function examples 
We will use the production.products table to demonstrate the DENSE_RANK() function:

products
Using SQL Server DENSE_RANK() over a result set example 
The following example uses the DENSE_RANK() function to rank products by list prices:

SELECT
	product_id,
	product_name,
	list_price,
	DENSE_RANK () OVER ( 
		ORDER BY list_price DESC
	) price_rank 
FROM
	production.products;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server DENSE_RANK Function Over Result Set Example
Using SQL Server DENSE_RANK() over partitions example 
The following statement ranks products in each category by list prices. It returns only the top 3 products per category by list prices.

SELECT * FROM (
	SELECT
		product_id,
		product_name,
		category_id,
		list_price,
		DENSE_RANK () OVER ( 
			PARTITION BY category_id
			ORDER BY list_price DESC
		) price_rank 
	FROM
		production.products
) t
WHERE price_rank < 3;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server DENSE_RANK Function Over Partition Example
In this tutorial, you have learned how to use the SQL Server DENSE_RANK() function to assign a rank to each row within a partition of a result set, with no gaps in rank values.

Was this tutorial helpful?


SQL Server FIRST_VALUE Function
Summary: in this tutorial, you will learn how to use the SQL Server FIRST_VALUE() function to get the first value in an ordered partition of a result set.

SQL Server FIRST_VALUE() function overview 
The FIRST_VALUE() function is a window function that returns the first value in an ordered partition of a result set.

The following shows the syntax of the FIRST_VALUE() function:

FIRST_VALUE ( scalar_expression )  
OVER ( 
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
    
Code language: SQL (Structured Query Language) (sql)
In this syntax:

scalar_expression 
scalar_expression is an expression evaluated against the value of the first row of the ordered partition of a result set. The scalar_expression can be a column, subquery, or expression that evaluates to a single value. It cannot be a window function.

PARTITION BY clause 
The PARTITION BY clause distributes rows of the result set into partitions to which the FIRST_VALUE() function is applied. If you skip the PARTITION BY clause, the FIRST_VALUE() function will treat the whole result set as a single partition.

ORDER BY clause 
The ORDER BY clause specifies the logical order of the rows in each partition to which the FIRST_VALUE()function is applied.

rows_range_clause 
The rows_range_clause further limits the rows within the partition by defining start and end points.

SQL Server FIRST_VALUE() function examples 
The following statement creates a new view named sales.vw_category_sales_volume that returns the number of products sold by product category and year.

CREATE VIEW 
    sales.vw_category_sales_volume 
AS
SELECT 
    category_name, 
    YEAR(order_date) year, 
    SUM(quantity) qty
FROM 
    sales.orders o
INNER JOIN sales.order_items i 
    ON i.order_id = o.order_id
INNER JOIN production.products p 
    ON p.product_id = i.product_id
INNER JOIN production.categories c 
    ON c.category_id = p.product_id
GROUP BY 
    category_name, 
    YEAR(order_date);
Code language: SQL (Structured Query Language) (sql)
Here is the data from the view:

SELECT 
    *
FROM 
    sales.vw_category_sales_volume
ORDER BY 
    year, 
    category_name, 
    qty;
Code language: SQL (Structured Query Language) (sql)
SQL Server FIRST_VALUE view sample
A) Using FIRST_VALUE() over a result set example 
This example uses FIRST_VALUE() function to return category name with the lowest sales volume in 2017:

SELECT 
    category_name,
    year,
    qty,
    FIRST_VALUE(category_name) OVER(
        ORDER BY qty
    ) lowest_sales_volume
FROM 
    sales.vw_category_sales_volume
WHERE
    year = 2017;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server FIRST_VALUE over result set example
In this example:

The PARTITION BY clause was not specified therefore the whole result set was treated as a single partition.
The ORDER BY clause sorted rows in each partition by quantity (qty) from low to high.
B) Using FIRST_VALUE() over partitions example 
The following example uses the FIRST_VALUE() function to return product categories with the lowest sales volumes in 2016 and 2017.

SELECT 
    category_name,
    year,
    qty,
    FIRST_VALUE(category_name) OVER(
        `PARTITION BY` year
        ORDER BY qty
    ) lowest_sales_volume
FROM 
    sales.vw_category_sales_volume
WHERE
    year BETWEEN 2016 AND 2017;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server FIRST_VALUE over partition example
In this example:

The PARTITION BY clause distributed rows by year into two partitions, one for 2016 and the other for 2017.
The ORDER BY clause sorted rows in each partition by quantity (qty) from low to high.
The FIRST_VALUE() function is applied to each partition separately. For the first partition, it returned Electric Bikes and for the second partition it returned Comfort Bicycles because these categories were the first rows in each partition.
In this tutorial, you have learned how to use the SQL Server FIRST_VALUE() function to return the first value in an ordered partition of a result set.

Was this tutorial helpful?

SQL Server LAG Function
Summary: in this tutorial, you will learn how to use the LAG() function to access a row at a specific physical offset which comes before the current row.

Overview of SQL Server LAG() function 
SQL Server LAG() is a window function that provides access to a row at a specified physical offset which comes before the current row.

In other words, by using the LAG() function, from the current row, you can access data of the previous row, or the row before the previous row, and so on.

The LAG() function can be very useful for comparing the value of the current row with the value of the previous row.

The following shows the syntax of the LAG() function:

LAG(return_value ,offset [,default]) 
OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

 return_value 
The return value of the previous row based on a specified offset. The return value must evaluate to a single value and cannot be another window function.

 offset 
The number of rows back from the current row from which to access data.  offset can be an expression, subquery, or column that evaluates to a positive integer.

The default value of offset is 1 if you don’t specify it explicitly.

 default 
default is the value to be returned if offset goes beyond the scope of the partition. It defaults to NULL if it is not specified.

 PARTITION BY clause 
The PARTITION BY clause distributes rows of the result set into partitions to which the LAG() function is applied.

If you omit the PARTITION BY clause, the function will treat the whole result set as a single partition.

 ORDER BY clause 
The ORDER BY clause specifies the logical order of the rows in each partition to which the LAG() function is applied.

SQL Server LAG() function examples 
We will reuse the view sales.vw_netsales_brands created in the LEAD() function tutorial for the demonstration.

The following query shows the data from the sales.vw_netsales_brands view:

SELECT 
	*
FROM 
	sales.vw_netsales_brands
ORDER BY 
	year, 
	month, 
	brand_name, 
	net_sales;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server LAG Function Sample View
A) Using SQL Server LAG() function over a result set example 
This example uses the LAG() function to return the net sales of the current month and the previous month in the year 2018:

WITH cte_netsales_2018 AS(
	SELECT 
		month, 
		SUM(net_sales) net_sales
	FROM 
		sales.vw_netsales_brands
	WHERE 
		year = 2018
	GROUP BY 
		month
)
SELECT 
	month,
	net_sales,
	LAG(net_sales,1) OVER (
		ORDER BY month
	) previous_month_sales
FROM 
	cte_netsales_2018;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server LAG Function Over Result Set
In this example:

First, the CTE returns net sales aggregated by month.
Then, the outer query uses the LAG() function to return sales of the previous month.
B) Using SQL Server LAG() function over partitions example 
The following statement uses the LAG() function to compare the sales of the current month with the previous month of each brand in the year 2018:

SELECT 
	month,
	brand_name,
	net_sales,
	LAG(net_sales,1) OVER (
		PARTITION BY brand_name
		ORDER BY month
	) next_month_sales
FROM 
	sales.vw_netsales_brands
WHERE
	year = 2018;
Code language: SQL (Structured Query Language) (sql)
This picture shows the output:

SQL Server LAG Function Over Partition
In this example:

The PARTITION BY clause divided rows into partitions by brand name.
For each partition (or brand name), the ORDER BY clause sorts the rows by month.
For each row in each partition, the LAG() function returns the net sales of the previous row.
To compare the sales of the current month with the previous month of net sales by brand in 2018, you use the following query:

WITH cte_sales AS (
	SELECT 
		month,
		brand_name,
		net_sales,
		LAG(net_sales,1) OVER (
			PARTITION BY brand_name
			ORDER BY month
		) previous_sales
	FROM 
		sales.vw_netsales_brands
	WHERE
		year = 2018
)
SELECT 
	month, 
	brand_name,
	net_sales, 
	previous_sales,
	FORMAT(
		(net_sales - previous_sales)  / previous_sales,
		'P'
	) vs_previous_month
FROM
	cte_sales;
Code language: SQL (Structured Query Language) (sql)
The output is as follows:

SQL Server LAG Function Data Comparison
In this tutorial, you have learned how to use the SQL Server LAG() function to access a row at a specific physical offset which follows the current row.

Was this tutorial helpful?

SQL Server LAST_VALUE Function
Summary: in this tutorial, you will learn how to use the SQL Server LAST_VALUE() function to get the last value in an ordered partition of a result set.

SQL Server LAST_VALUE() function overview 
The LAST_VALUE() function is a window function that returns the last value in an ordered partition of a result set.

The following shows the syntax of the LAST_VALUE() function:

LAST_VALUE ( scalar_expression )  
OVER ( 
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)    
Code language: SQL (Structured Query Language) (sql)
In this syntax:

scalar_expression 
scalar_expression is an expression evaluated against the value of the last row in an ordered partition of the result set. The scalar_expression can be a column, subquery, or expression evaluates to a single value. It cannot be a window function.

PARTITION BY clause 
The PARTITION BY clause distributes rows of the result set into partitions to which the LAST_VALUE() function is applied. If you skip the PARTITION BY clause, the LAST_VALUE() function will treat the whole result set as a single partition.

ORDER BY clause 
The ORDER BY clause specifies the logical order of the rows in each partition to which the LAST_VALUE()function is applied.

rows_range_clause 
The rows_range_clause further limits the rows within a partition by defining start and end points.

SQL Server LAST_VALUE() function examples 
We will use the sales.vw_category_sales_volume view created in the FIRST_VALUE() function tutorial to demonstrate how the LAST_VALUE()function works.

The following query returns data from the view:

SELECT 
    category_name, 
    year, 
    qty
FROM 
    sales.vw_category_sales_volume
ORDER BY 
    year, 
    category_name, 
    qty;
Code language: SQL (Structured Query Language) (sql)
SQL Server LAST_VALUE sample view
A) Using LAST_VALUE() over a result set example 
This example uses LAST_VALUE() function to return category name with the highest sales volume in 2016:

SELECT 
    category_name,
    year,
    qty,
    LAST_VALUE(category_name) OVER(
        ORDER BY qty
         RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING
    ) highest_sales_volume
FROM 
    sales.vw_category_sales_volume
WHERE
    year = 2016;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server LAST_VALUE over result set example
In this example:

The PARTITION BY clause was not specified therefore the whole result set was treated as a single partition.
The ORDER BY clause sorted rows in each partition by quantity (qty) from low to high.
The RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING clause defined the frame in the partition starting from the first row and ending at the last row.
B) Using LAST_VALUE() over partitions example 
The following example uses the LAST_VALUE() function to return product categories with the highest sales volumes in 2016 and 2017.

SELECT 
    category_name,
    year,
    qty,
    LAST_VALUE(category_name) OVER(
			PARTITION BY year
        ORDER BY qty
        RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING
    ) highest_sales_volume
FROM 
    sales.vw_category_sales_volume
WHERE
    year IN (2016,2017);
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server LAST_VALUE over partition example
In this example:

The PARTITION BY clause distributed rows by year into two partitions, one for 2016 and the other for 2017.
The ORDER BY clause sorted rows in each partition by quantity (qty) from low to high.
The RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING clause defines the frame starting from the first row and ending at the last row of the partition.
The LAST_VALUE() function was applied to each partition separately. For the first partition, it returned Electric Bikes and for the second partition it returned Comfort Bicycles because these categories were the last rows in each partition.
In this tutorial, you have learned how to use the SQL Server LAST_VALUE() function to return the last value in an ordered partition of a result set.

Was this tutorial helpful?

SQL Server LEAD Function
Summary: in this tutorial, you will learn how to use the SQL Server LEAD() function to access a row at a specific physical offset which follows the current row.

Overview of SQL Server LEAD() function 
SQL Server LEAD() is a window function that provides access to a row at a specified physical offset which follows the current row.

For example, by using the LEAD() function, from the current row, you can access data of the next row, or the row after the next row, and so on.

The LEAD() function can be very useful for comparing the value of the current row with the value of the following row.

The following shows the syntax of the LEAD() function:

LEAD(return_value ,offset [,default]) 
OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

 return_value 
The return value of the following row based on a specified offset. The return value must evaluate to a single value and cannot be another window function.

 offset 
offset is the number of rows forward from the current row from which to access data. The offset can be an expression, subquery, or column that evaluates to a positive integer.

The default value of offset is 1 if you don’t specify it explicitly.

 default 
The function returns default if offset goes beyond the scope of the partition. If not specified, it defaults to NULL.

 PARTITION BY clause 
The PARTITION BY clause distributes rows of the result set into partitions to which the LEAD() function is applied.

If you do not specify the PARTITION BY clause, the function treats the whole result set as a single partition.

 ORDER BY clause 
The ORDER BY clause specify logical order of the rows in each partition to which the LEAD() function is applied.

SQL Server LEAD() function examples 
Let’s create a new view named sales.vw_netsales_brands for the demonstration:

CREATE VIEW sales.vw_netsales_brands
AS
	SELECT 
		c.brand_name, 
		MONTH(o.order_date) month, 
		YEAR(o.order_date) year, 
		CONVERT(DEC(10, 0), SUM((i.list_price * i.quantity) * (1 - i.discount))) AS net_sales
	FROM sales.orders AS o
		INNER JOIN sales.order_items AS i ON i.order_id = o.order_id
		INNER JOIN production.products AS p ON p.product_id = i.product_id
		INNER JOIN production.brands AS c ON c.brand_id = p.brand_id
	GROUP BY c.brand_name, 
			MONTH(o.order_date), 
			YEAR(o.order_date);
Code language: SQL (Structured Query Language) (sql)
The following query returns the data from the sales.vw_netsales_brands view:

SELECT 
	*
FROM 
	sales.vw_netsales_brands
ORDER BY 
	year, 
	month, 
	brand_name, 
	net_sales;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server LEAD Function Sample View
A) Using SQL Server LEAD() function over a result set example 
The following statement uses the LEAD() function to return the net sales of the current month and the next month in the year 2017:

WITH cte_netsales_2017 AS(
	SELECT 
		month, 
		SUM(net_sales) net_sales
	FROM 
		sales.vw_netsales_brands
	WHERE 
		year = 2017
	GROUP BY 
		month
)
SELECT 
	month,
	net_sales,
	LEAD(net_sales,1) OVER (
		ORDER BY month
	) next_month_sales
FROM 
	cte_netsales_2017;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server LEAD Function Over Result Set Example
In this example:

First, the CTE returns net sales aggregated by month.
Then, the outer query uses the LEAD() function to return the following month sales for each month.
By doing this, you can easily compare the sales of the current month with the next month.

B) Using SQL Server LEAD() function over partitions example 
The following statement uses the LEAD() function to compare the sales of the current month with the next month of each brand in the year 2018:

SELECT 
	month,
	brand_name,
	net_sales,
	LEAD(net_sales,1) OVER (
		PARTITION BY brand_name
		ORDER BY month
	) next_month_sales
FROM 
	sales.vw_netsales_brands
WHERE
	year = 2018;
Code language: SQL (Structured Query Language) (sql)
This picture shows the output:

SQL Server LEAD Function Over Partition Example
In this example:

The PARTITION BY clause divided rows into partitions by brand name.
For each partition (or brand name), the ORDER BY clause sorts the rows by month.
For each row in each partition, the LEAD() function returns the net sales of the following row.
In this tutorial, you have learned how to use the SQL Server LEAD() function to access a row at a specific physical offset which follows the current row.

Was this tutorial helpful?

SQL Server LEAD Function
Summary: in this tutorial, you will learn how to use the SQL Server LEAD() function to access a row at a specific physical offset which follows the current row.

Overview of SQL Server LEAD() function 
SQL Server LEAD() is a window function that provides access to a row at a specified physical offset which follows the current row.

For example, by using the LEAD() function, from the current row, you can access data of the next row, or the row after the next row, and so on.

The LEAD() function can be very useful for comparing the value of the current row with the value of the following row.

The following shows the syntax of the LEAD() function:

LEAD(return_value ,offset [,default]) 
OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

 return_value 
The return value of the following row based on a specified offset. The return value must evaluate to a single value and cannot be another window function.

 offset 
offset is the number of rows forward from the current row from which to access data. The offset can be an expression, subquery, or column that evaluates to a positive integer.

The default value of offset is 1 if you don’t specify it explicitly.

 default 
The function returns default if offset goes beyond the scope of the partition. If not specified, it defaults to NULL.

 PARTITION BY clause 
The PARTITION BY clause distributes rows of the result set into partitions to which the LEAD() function is applied.

If you do not specify the PARTITION BY clause, the function treats the whole result set as a single partition.

 ORDER BY clause 
The ORDER BY clause specify logical order of the rows in each partition to which the LEAD() function is applied.

SQL Server LEAD() function examples 
Let’s create a new view named sales.vw_netsales_brands for the demonstration:

CREATE VIEW sales.vw_netsales_brands
AS
	SELECT 
		c.brand_name, 
		MONTH(o.order_date) month, 
		YEAR(o.order_date) year, 
		CONVERT(DEC(10, 0), SUM((i.list_price * i.quantity) * (1 - i.discount))) AS net_sales
	FROM sales.orders AS o
		INNER JOIN sales.order_items AS i ON i.order_id = o.order_id
		INNER JOIN production.products AS p ON p.product_id = i.product_id
		INNER JOIN production.brands AS c ON c.brand_id = p.brand_id
	GROUP BY c.brand_name, 
			MONTH(o.order_date), 
			YEAR(o.order_date);
Code language: SQL (Structured Query Language) (sql)
The following query returns the data from the sales.vw_netsales_brands view:

SELECT 
	*
FROM 
	sales.vw_netsales_brands
ORDER BY 
	year, 
	month, 
	brand_name, 
	net_sales;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server LEAD Function Sample View
A) Using SQL Server LEAD() function over a result set example 
The following statement uses the LEAD() function to return the net sales of the current month and the next month in the year 2017:

WITH cte_netsales_2017 AS(
	SELECT 
		month, 
		SUM(net_sales) net_sales
	FROM 
		sales.vw_netsales_brands
	WHERE 
		year = 2017
	GROUP BY 
		month
)
SELECT 
	month,
	net_sales,
	LEAD(net_sales,1) OVER (
		ORDER BY month
	) next_month_sales
FROM 
	cte_netsales_2017;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server LEAD Function Over Result Set Example
In this example:

First, the CTE returns net sales aggregated by month.
Then, the outer query uses the LEAD() function to return the following month sales for each month.
By doing this, you can easily compare the sales of the current month with the next month.

B) Using SQL Server LEAD() function over partitions example 
The following statement uses the LEAD() function to compare the sales of the current month with the next month of each brand in the year 2018:

SELECT 
	month,
	brand_name,
	net_sales,
	LEAD(net_sales,1) OVER (
		PARTITION BY brand_name
		ORDER BY month
	) next_month_sales
FROM 
	sales.vw_netsales_brands
WHERE
	year = 2018;
Code language: SQL (Structured Query Language) (sql)
This picture shows the output:

SQL Server LEAD Function Over Partition Example
In this example:

The PARTITION BY clause divided rows into partitions by brand name.
For each partition (or brand name), the ORDER BY clause sorts the rows by month.
For each row in each partition, the LEAD() function returns the net sales of the following row.
In this tutorial, you have learned how to use the SQL Server LEAD() function to access a row at a specific physical offset which follows the current row.

Was this tutorial helpful?

SQL Server NTILE Function
Summary: in this tutorial, you will learn how to use the SQL Server NTILE() function to distribute rows of an ordered partition into a specified number of buckets.

Introduction to SQL Server NTILE() function 
The SQL Server NTILE() is a window function that distributes rows of an ordered partition into a specified number of approximately equal groups, or buckets. It assigns each group a bucket number starting from one. For each row in a group, the NTILE() function assigns a bucket number representing the group to which the row belongs.

The syntax of the NTILE() function is as follows:

NTILE(buckets) OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
Code language: SQL (Structured Query Language) (sql)
Let’s examine the syntax in detail:

buckets 
The number of buckets into which the rows are divided. The buckets can be an expression or subquery that evaluates to a positive integer. It cannot be a window function.

PARTITION BY clause 
The PARTITION BY clause distributes rows of a result set into partitions to which the NTILE() function is applied.

ORDER BY clause 
The ORDER BY clause specifies the logical order of rows in each partition to which the NTILE() is applied.

If the number of rows is not divisible by the buckets, the NTILE() function returns groups of two sizes with the difference by one. The larger groups always come before the smaller group in the order specified by the ORDER BY in the OVER() clause.

On the other hand, if the total of rows is divisible by the buckets, the function divides evenly the rows among buckets.

SQL Server NTILE() function illustration 
The following statement creates a new table named ntile_demo that stores 10 integers:

CREATE TABLE sales.ntile_demo (
	v INT NOT NULL
);
	
INSERT INTO sales.ntile_demo(v) 
VALUES(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
	
	
SELECT * FROM sales.ntile_demo;
Code language: SQL (Structured Query Language) (sql)
This statement uses the NTILE() function to divide ten rows into three groups:

SELECT 
	v, 
	NTILE (3) OVER (
		ORDER BY v
	) buckets
FROM 
	sales.ntile_demo;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server NTILE Function
As clearly shown in the output, the first group has four rows and the other two groups have three rows.

The following statement uses the NTILE() function to distribute rows into five buckets:

SELECT 
	v, 
	NTILE (5) OVER (
		ORDER BY v
	) buckets
FROM 
	sales.ntile_demo;
Code language: SQL (Structured Query Language) (sql)
The output is as follows:

SQL Server NTILE Function with 5 groups
As you can see, the output has five groups with the same number of rows in each.

SQL Server NTILE() function examples 
Let’s create a view to demonstrate the NTILE() function.

The following statement creates a view that returns the net sales in 2017 by months.

CREATE VIEW sales.vw_netsales_2017 AS
SELECT 
	c.category_name,
	DATENAME(month, o.shipped_date) month, 
	CONVERT(DEC(10, 0), SUM(i.list_price * quantity * (1 - discount))) net_sales
FROM 
	sales.orders o
INNER JOIN sales.order_items i ON i.order_id = o.order_id
INNER JOIN production.products p on p.product_id = i.product_id
INNER JOIN production.categories c on c.category_id = p.category_id
WHERE 
	YEAR(shipped_date) = 2017
GROUP BY
	c.category_name,
	DATENAME(month, o.shipped_date);
Code language: SQL (Structured Query Language) (sql)
SELECT 
    category_name, 
    month,
    net_sales 
FROM 
   sales.vw_netsales_2017 
ORDER BY 
   category_name, 
   net_sales;
Code language: CSS (css)
Here is the result:

SQL Server NTILE sample view
Using SQL Server NTILE() function over a query result set example 
The following example uses the NTILE() function to distribute the months to 4 buckets based on net sales:

WITH cte_by_month AS(
	SELECT
		month, 
		SUM(net_sales) net_sales
	FROM 
		sales.vw_netsales_2017
	GROUP BY 
		month
)
SELECT
	month, 
	FORMAT(net_sales,'C','en-US') net_sales,
	NTILE(4) OVER(
		ORDER BY net_sales DESC
	) net_sales_group
FROM 
	cte_by_month;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server NTILE Function Over Result Set
Using SQL Server NTILE() function over partitions example 
This example uses the NTILE() function to divide the net sales by month into 4 groups for each product category:

SELECT
	category_name,
	month, 
	FORMAT(net_sales,'C','en-US') net_sales,
	NTILE(4) OVER(
		PARTITION BY category_name
		ORDER BY net_sales DESC
	) net_sales_group
FROM 
	sales.vw_netsales_2017;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial output:

SQL Server NTILE Function Over Partition Example
In this tutorial, you have learned how to use the SQL Server NTILE() function to distribute rows of an ordered partition into a specified number of buckets.

Was this tutorial helpful?

SQL Server PERCENT_RANK Function
Summary: in this tutorial, you will learn how to use the SQL Server PERCENT_RANK() function to calculate the relative rank of a row within a group of rows.

SQL Server PERCENT_RANK() function overview 
The PERCENT_RANK() function is similar to the CUME_DIST() function. The PERCENT_RANK() function evaluates the relative standing of a value within a partition of a result set.

The following illustrates the syntax of the SQL Server PERCENT_RANK() function:

PERCENT_RANK() OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

PARTITION BY 
The PARTITION BY clause distributes the rows into multiple partitions to which the PERCENT_RANK() function is applied. The PARTITION BY clause is optional. If you skip it, the function will treat the whole result set as a single partition.

ORDER BY 
The ORDER BY clause specifies the logic order of rows in each partition. Because PERCENT_RANK() is order sensitive, the order_by_clause is required.

Return value 
The result of PERCENT_RANK() is greater than 0 and less than or equal to 1.

0 < PERCENT_RANK() <= 1
Code language: SQL (Structured Query Language) (sql)
The first row has a rank value of zero. Tie values evaluate to the same cumulative distribution value.

The PERCENT_RANK() function includes NULL values by default and treats them as the lowest possible values.

SQL Server PERCENT_RANK() examples 
Let’s take some examples of using the PERCENT_RANK() function.

The following statement creates a new view named sales.vw_staff_sales for the demonstration.

CREATE VIEW sales.vw_staff_sales(
    staff_id, 
    year, 
    net_sales
) AS
SELECT 
    staff_id, 
    YEAR(order_date), 
    ROUND(SUM(quantity*list_price*(1-discount)),0)
FROM 
    sales.orders o
INNER JOIN sales.order_items i on i.order_id = o.order_id
WHERE 
    staff_id IS NOT NULL
GROUP BY 
    staff_id, 
    YEAR(order_date);
Code language: SQL (Structured Query Language) (sql)
Using SQL Server PERCENT_RANK() function over a result set example 
This example uses the PERCENT_RANK() function to calculate the sales percentile of each sales staff in 2016:

SELECT 
    CONCAT_WS(' ',first_name,last_name) full_name,
    net_sales, 
    PERCENT_RANK() OVER (
        ORDER BY net_sales DESC
    ) percent_rank
FROM 
    sales.vw_staff_sales t
INNER JOIN sales.staffs m on m.staff_id = t.staff_id
WHERE 
    YEAR = 2016;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server PERCENT_RANK Function Over Result Set Example
To make the output more readable, you can use the FORMAT() function to format the percent rank in percentage (%):

SELECT 
    CONCAT_WS(' ',first_name,last_name) full_name,
    net_sales, 
    FORMAT(
        PERCENT_RANK() OVER (
            ORDER BY net_sales DESC
        ) ,
    'P') percent_rank

FROM 
    sales.vw_staff_sales t
INNER JOIN sales.staffs m on m.staff_id = t.staff_id
WHERE 
    YEAR = 2016;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the new output:

SQL Server PERCENT_RANK Function Over Result Set with format example
Using SQL Server PERCENT_RANK() function over partitions example 
The following example uses the PERCENT_RANK() to calculate the sales percentile for each staff in 2016 and 2017.

SELECT 
    year,
    CONCAT_WS(' ',first_name,last_name) full_name,
    net_sales, 
    FORMAT(
        PERCENT_RANK() OVER (
            PARTITION BY year
            ORDER BY net_sales DESC
        ) ,
    'P') percent_rank

FROM 
    sales.vw_staff_sales t
INNER JOIN sales.staffs m on m.staff_id = t.staff_id
WHERE 
    YEAR IN (2016,2017);
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server PERCENT_RANK Function Over Partition example
In this example:

The PARTITION BYclause distributed the rows by year into two partitions, one for 2016 and the other for 2017.
The ORDER BY clause sorted rows in each partition by net sales from high to low.
The PERCENT_RANK() function is applied to each partition separately and recomputed the rank when crossing the partition’s boundary.
In this tutorial, you have learned how to use the SQL Server PERCENT_RANK() function to calculate the relative rank of a row within a group of rows.

Was this tutorial helpful?

SQL Server RANK Function
Summary: in this tutorial, you will learn how to use SQL Server RANK() function to calculate a rank for each row within a partition of a result set.

Introduction to SQL Server RANK() function 
The RANK() function is a window function that assigns a rank to each row within a partition of a result set.

The rows within a partition that have the same values will receive the same rank. The rank of the first row within a partition is one. The RANK() function adds the number of tied rows to the tied rank to calculate the rank of the next row, therefore, the ranks may not be consecutive.

The following shows the syntax of the RANK() function:

RANK() OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, the PARTITION BY clause divides the rows of the result set partitions to which the function is applied.
Second, the ORDER BY clause specifies the logical sort order of the rows in each a partition to which the function is applied.
The RANK() function is useful for top-N and bottom-N reports.

SQL Server RANK() illustration 
First, create a new table named sales.rank_demo that has one column:

CREATE TABLE sales.rank_demo (
	v VARCHAR(10)
);
Code language: SQL (Structured Query Language) (sql)
Second, insert some rows into the sales.rank_demo table:

INSERT INTO sales.rank_demo(v)
VALUES('A'),('B'),('B'),('C'),('C'),('D'),('E');
Code language: SQL (Structured Query Language) (sql)
Third, query data from the sales.rank_demo table:

SELECT v FROM sales.rank_demo;
Code language: SQL (Structured Query Language) (sql)
Fourth, use the ROW_NUMBER() to assign ranks to the rows in the result set of sales.rank_demo table:

SELECT
	v,
	RANK () OVER ( 
		ORDER BY v 
	) rank_no 
FROM
	sales.rank_demo;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server RANK Function Example
As shown clearly from the output, the second and third rows receive the same rank because they have the same value B. The fourth and fifth rows get the rank 4 because the RANK() function skips the rank 3 and both of them also have the same values.

SQL Server RANK() function examples 
We’ll use the production.products table to demonstrate the RANK() function:

products
Using SQL Server RANK() function over a result set example 
The following example uses the RANK() function to assign ranks to the products by their list prices:

SELECT
	product_id,
	product_name,
	list_price,
	RANK () OVER ( 
		ORDER BY list_price DESC
	) price_rank 
FROM
	production.products;
Code language: SQL (Structured Query Language) (sql)
Here is the result set:

SQL Server RANK Function Over Result Set Example
In this example, because we skipped the PARTITION BY clause, the RANK() function treated the whole result set as a single partition.

The RANK() function assigns a rank to each row within the result set sorted by list price from high to low.

Using SQL Server RANK() function over partitions example 
This example uses the RANK() function to assign a rank to each product by list price in each brand and returns products with rank less than or equal to three:

SELECT * FROM (
	SELECT
		product_id,
		product_name,
		brand_id,
		list_price,
		RANK () OVER ( 
			PARTITION BY brand_id
			ORDER BY list_price DESC
		) price_rank 
	FROM
		production.products
) t
WHERE price_rank <= 3;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server RANK Function Over Partition Example
In this example:

First, the PARTITION BY clause divides the products into partitions by brand Id.
Second, the ORDER BY clause sorts products in each partition by list prices.
Third, the outer query returns the products whose rank values are less than or equal to three.
The RANK() function is applied to each row in each partition and reinitialized when crossing the partition’s boundary.

In this tutorial, you have learned how to use the SQL Server RANK() function to assign a rank to each row within a partition of a result set.

SQL Server ROW_NUMBER Function
Summary: in this tutorial, you will learn how to use the SQL Server ROW_NUMBER() function to assign a sequential integer to each row of a result set.

Introduction to SQL Server ROW_NUMBER() function 
The ROW_NUMBER() is a window function that assigns a sequential integer to each row within the partition of a result set. The row number starts with 1 for the first row in each partition.

The following shows the syntax of the ROW_NUMBER() function:

ROW_NUMBER() OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
Code language: SQL (Structured Query Language) (sql)
Let’s examine the syntax of the ROW_NUMBER() function in detail.

PARTITION BY 
The PARTITION BY clause divides the result set into partitions (another term for groups of rows). The ROW_NUMBER() function is applied to each partition separately and reinitialized the row number for each partition.

The PARTITION BY clause is optional. If you skip it, the ROW_NUMBER() function will treat the whole result set as a single partition.

ORDER BY 
The ORDER BY clause defines the logical order of the rows within each partition of the result set. The ORDER BY clause is mandatory because the ROW_NUMBER() function is order-sensitive.

SQL Server ROW_NUMBER() function examples 
We’ll use the sales.customers table from the sample database to demonstrate the ROW_NUMBER() function.

customers
Using SQL Server ROW_NUMBER() function over a result set example 
The following statement uses the ROW_NUMBER() to assign each customer row a sequential number:

SELECT 
   ROW_NUMBER() OVER (
	ORDER BY first_name
   ) row_num,
   first_name, 
   last_name, 
   city
FROM 
   sales.customers;
Code language: SQL (Structured Query Language) (sql)
Here is the partial output:

SQL Server ROW_NUMBER Function over whole result set example
In this example, we skipped the PARTITION BY clause, therefore, the ROW_NUMBER() treated the whole result set as a single partition.

Using SQL Server ROW_NUMBER() over partitions example 
The following example uses the ROW_NUMBER() function to assign a sequential integer to each customer. It resets the number when the city changes:

SELECT 
   first_name, 
   last_name, 
   city,
   ROW_NUMBER() OVER (
      PARTITION BY city
      ORDER BY first_name
   ) row_num
FROM 
   sales.customers
ORDER BY 
   city;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the partial output:

SQL Server ROW_NUMBER Function over partition example
In this example, we used the PARTITION BY clause to divide the customers into partitions by city. The row number was reinitialized when the city changed.

Using SQL Server ROW_NUMBER() for pagination 
The ROW_NUMBER() function is useful for pagination in applications. For example, you can display a list of customers by page, where each page has 10 rows.

The following example uses the ROW_NUMBER() to return customers from rows 11 to 20, which is the second page:

WITH cte_customers AS (
    SELECT 
        ROW_NUMBER() OVER(
             ORDER BY 
                first_name, 
                last_name
        ) row_num, 
        customer_id, 
        first_name, 
        last_name
     FROM 
        sales.customers
) SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    cte_customers
WHERE 
    row_num > 10 AND 
    row_num <= 20;
Code language: SQL (Structured Query Language) (sql)
The output is as follows:

SQL Server ROW_NUMBER Function for pagination
In this example:

First, the CTE used the ROW_NUMBER() function to assign every row in the result set to a sequential integer.
Second, the outer query returned the rows of the second page, which have row numbers between 11 and 20.
Summary 
Use the ROW_NUMBER() function to assign a sequential integer to each row within a partition of a query.
Was this tutorial helpful?