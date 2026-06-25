Indexes are special data structures associated with tables or views that help speed up the query. SQL Server provides two types of indexes: clustered index and non-clustered index.

In this section, you will learn everything you need to know about indexes to come up with a good index strategy and optimize your queries.

Clustered indexes – introduction to clustered indexes and learn how to create clustered indexes for tables.
Create nonclustered indexes – learn how to create non-clustered indexes using the CREATE INDEX statement.
Rename indexes – replace the current index name with the new name using sp_rename stored procedure and SQL Server Management Studio.
Disable indexes – show you how to disable indexes of a table to make the indexes ineffective.
Enable indexes – learn various statements to enable one or all indexes on a table.
Unique indexes – enforce the uniqueness of values in one or more columns.
Drop indexes – describe how to drop indexes from one or more tables.
Indexes with included columns – guide you on how to add non-key columns to a nonclustered index to improve the speed of queries.
Filtered indexes – learn how to create an index on a portion of rows in a table.
Indexes on computed columns – walk you through how to simulate function-based indexes using the indexes on computed columns.


QL Server Clustered Indexes
Summary: in this tutorial, you will learn about the SQL Server clustered index and how to define a clustered index for a table.

Introduction to SQL Server clustered indexes 
The following statement creates a new table named production.parts that consists of two columns part_id and part_name:

CREATE TABLE production.parts(
    part_id   INT NOT NULL, 
    part_name VARCHAR(100)
);
Code language: SQL (Structured Query Language) (sql)
And this statement inserts some rows into the production.parts table:

INSERT INTO 
    production.parts(part_id, part_name)
VALUES
    (1,'Frame'),
    (2,'Head Tube'),
    (3,'Handlebar Grip'),
    (4,'Shock Absorber'),
    (5,'Fork');
Code language: SQL (Structured Query Language) (sql)
The production.parts table does not have a primary key. Therefore SQL Server stores its rows in an unordered structure called a heap.

When you query data from the production.parts table, the query optimizer needs to scan the whole table to search.

For example, the following SELECT statement finds the part with id 5:

SELECT 
    part_id, 
    part_name
FROM 
    production.parts
WHERE 
    part_id = 5;
Code language: SQL (Structured Query Language) (sql)
If you display the estimated execution plan in SQL Server Management Studio, you’ll see how SQL Server came up with the following query plan:


Note that to display the estimated execution plan in SQL Server Management Studio, you click the Display Estimated Execution Plan button or select the query and press the keyboard shortcut Ctrl+L:

SQL Server Display Estimated Execution Plan
Because the production.parts table has only five rows, the query executes very fast. However, if the table contains a large number of rows, it’ll take a lot of time and resources to search for data.

To resolve this issue, SQL Server provides a dedicated structure to speed up the retrieval of rows from a table called index.

SQL Server has two types of indexes: clustered index and non-clustered index. We will focus on the clustered index in this tutorial.

A clustered index stores data rows in a sorted structure based on its key values. Each table has only one clustered index because data rows can be only sorted in one order. A table that has a clustered index is called a clustered table.

The following picture illustrates the structure of a clustered index:


A clustered index organizes data using a special structured so-called B-tree (or balanced tree) which enables searches, inserts, updates, and deletes in logarithmic amortized time.

In this structure, the top node of the B-tree is called the root node. The nodes at the bottom level are called the leaf nodes. Any index levels between the root and the leaf nodes are known as intermediate levels.

In the B-Tree, the root node and intermediate-level nodes contain index pages that hold index rows. The leaf nodes contain the data pages of the underlying table. The pages in each level of the index are linked using another structure called a doubly-linked list.

SQL Server Clustered Index and Primary Key Constraint 
When you create a table with a primary key, SQL Server automatically creates a corresponding clustered index that includes primary key columns.

This statement creates a new table named production.part_prices with a primary key that includes two columns: part_id and valid_from.

CREATE TABLE production.part_prices(
    part_id int,
    valid_from date,
    price decimal(18,4) not null,
    PRIMARY KEY(part_id, valid_from) 
);
Code language: SQL (Structured Query Language) (sql)

If you add a primary key constraint to an existing table that already has a clustered index, SQL Server will enforce the primary key using a non-clustered index:

This statement defines a primary key for the production.parts table:

ALTER TABLE production.parts
ADD PRIMARY KEY(part_id);
Code language: SQL (Structured Query Language) (sql)
SQL Server created a non-clustered index for the primary key.


Using SQL Server CREATE CLUSTERED INDEX statement to create a clustered index. 
When a table does not have a primary key, which is very rare, you can use the CREATE CLUSTERED INDEX statement to add a clustered index to it.

The following statement creates a clustered index for the production.parts table:

CREATE CLUSTERED INDEX ix_parts_id
ON production.parts (part_id);  
Code language: SQL (Structured Query Language) (sql)
If you open the Indexes node under the table name, you will see the new index name ix_parts_id with type Clustered.


When executing the following statement, the SQL Server traverses the index (Clustered Index Seek) to locate the rows, which is faster than scanning the whole table.

SELECT 
    part_id, 
    part_name
FROM 
    production.parts
WHERE 
    part_id = 5;
Code language: SQL (Structured Query Language) (sql)

SQL Server CREATE CLUSTERED INDEX syntax 
The syntax for creating a clustered index is as follows:

CREATE CLUSTERED INDEX index_name
ON schema_name.table_name (column_list);  
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the clustered index after the CREATE CLUSTERED INDEX clause.
Second, specify the schema and table name on which you want to create the index.
Third, list one or more columns included in the index.
Summary 
A clustered index physically organizes the data in a table according to the index key.
When creating a table with a primary key, SQL Server automatically creates a clustered index based on the primary key columns.
A table has only one clustered index.
Use the CREATE CLUSTERED INDEX statement to create a new clustered index for a table.


SQL Server CREATE INDEX
Summary: in this tutorial, you will learn how to use the SQL Server CREATE INDEX statement to create nonclustered indexes for tables.

Introduction to SQL Server non-clustered indexes 
A nonclustered index is a data structure that improves the speed of data retrieval from tables. Unlike a clustered index, a nonclustered index sorts and stores data separately from the data rows in the table. It is a copy of selected columns of data from a table with the links to the associated table.

Like a clustered index, a nonclustered index uses the B-tree structure to organize its data.

A table may have one or more nonclustered indexes and each non-clustered index may include one or more columns in a table.

The following picture illustrates the structure of a non-clustered index:

SQL Server nonclustered index
Besides storing the index key values, the leaf nodes also store row pointers to the data rows that contain the key values. These row pointers are also known as row locators.

If the underlying table is a clustered table, the row pointer is the clustered index key. In case the underlying table is a heap, the row pointer points to the row of the table.

SQL Server CREATE INDEX statement 
To create a non-clustered index, you use the CREATE INDEX statement:

CREATE [NONCLUSTERED] INDEX index_name
ON table_name(column_list);
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the index after the CREATE NONCLUSTERED INDEX clause. Note that the NONCLUSTERED keyword is optional.
Second, specify the table name on which you want to create the index and a list of columns of that table as the index key columns.
SQL Server CREATE INDEX statement examples 
We will use the sales.customers from the sample database for the demonstration.

customers
The sales.customers table is a clustered table because it has a primary key customer_id.

1) Using the CREATE INDEX statement to create a nonclustered index for one column example 
This statement finds customers who are located in Atwater:

SELECT 
    customer_id, 
    city
FROM 
    sales.customers
WHERE 
    city = 'Atwater';
Code language: SQL (Structured Query Language) (sql)
If you display the estimated execution plan, you will see that the query optimizer scans the clustered index to find the row. This is because the sales.customers table does not have an index for the city column.


To improve the speed of this query, you can create a new index named ix_customers_city for the city column:

CREATE INDEX ix_customers_city
ON sales.customers(city);
Code language: SQL (Structured Query Language) (sql)
Now, if you display the estimated execution plan of the above query again, you will find that the query optimizer uses the nonclustered index ix_customers_city:

SQL Server CREATE INDEX one column index seek
2) Using the CREATE INDEX statement to create a nonclustered index for multiple columns 
The following statement finds the customer whose last name is Berg and the first name is Monika:

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Berg' AND 
    first_name = 'Monika';
Code language: SQL (Structured Query Language) (sql)
SQL Server CREATE INDEX on multiple columns index scan
The query optimizer scans the clustered index to locate the customer.

To speed up the retrieval of data, you can create a nonclustered index that includes both last_name and first_name columns:

CREATE INDEX ix_customers_name 
ON sales.customers(last_name, first_name);
Code language: SQL (Structured Query Language) (sql)
Now, the query optimizer uses the index ix_customers_name to find the customer.

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Berg' AND 
    first_name = 'Monika';
Code language: SQL (Structured Query Language) (sql)
SQL Server CREATE INDEX on multiple columns index seek
When you create a nonclustered index that consists of multiple columns, the order of the columns in the index is very important. You should place the columns that you often use to query data at the beginning of the column list.

For example, the following statement finds customers whose last name is Albert. Because the last_name is the leftmost column in the index, the query optimizer can leverage the index and use the index seek method for searching:

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Albert';
Code language: SQL (Structured Query Language) (sql)

This statement finds customers whose first name is Adam. It also leverages the ix_customer_name index. But it needs to scan the whole index for searching, which is slower than index seek.

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    first_name = 'Adam';
Code language: SQL (Structured Query Language) (sql)
SQL Server CREATE INDEX multiple columns not leftmost column index scan
Therefore, it is a good practice to place the columns that you often use to query data at the beginning of the column list of the index.

Summary 
A non-clustered index copies the table data and stores it in a separate data structure (B-tree).
A table can have multiple non-clustered indexes.
Use the CREATE INDEX statement to create a non-clustered index to enhance the query speed.
Was this tutorial helpful?

SQL Server Rename Index
Summary: in this tutorial, you will learn how to rename an index using the system stored procedure sp_rename and SQL Server Management Studio.

Renaming an index using the system stored procedure sp_rename 
The sp_rename is a system stored procedure that allows you to rename any user-created object in the current database including table, index, and column.

The statement renames an index:

EXEC sp_rename 
    index_name, 
    new_index_name, 
    N'INDEX';  
Code language: SQL (Structured Query Language) (sql)
or you can use the explicit parameters:

EXEC sp_rename 
    @objname = N'index_name', 
    @newname = N'new_index_name',   
    @objtype = N'INDEX';
Code language: SQL (Structured Query Language) (sql)
For example, the following statement renames the index ix_customers_city of the sales.customers table to ix_cust_city:

EXEC sp_rename 
        @objname = N'sales.customers.ix_customers_city',
        @newname = N'ix_cust_city' ,
        @objtype = N'INDEX';
Code language: SQL (Structured Query Language) (sql)
or in short:

EXEC sp_rename 
        N'sales.customers.ix_customers_city',
        N'ix_cust_city' ,
        N'INDEX';
Code language: SQL (Structured Query Language) (sql)
Renaming an index using the SQL Server Management Studio (SSMS) 
To change the name of an index to the new one using the SSMS, you follow these steps:

First, navigate to the database, table name, and indexes:

Second, right-click on the index to which you want to change the name and choose the rename menu item. In the following picture, we will rename the index ix_customers_name of the sales.customers table:

SQL Server Rename Index using SSMS
Third, type the new name and press enter. The following picture shows the ix_customers_name index change to ix_cust_fullname:


In this tutorial, you have learned how to rename an index using sp_rename stored procedure and SQL Server Management Studio.

Was this tutorial helpful?

SQL Server Disable Indexes
Summary: in this tutorial, you will learn how to use the ALTER TABLE statement to disable the indexes of a table.

SQL Server Disable Index statements 
To disable an index, you use the ALTER INDEX statement as follows:

ALTER INDEX index_name
ON table_name
DISABLE;
Code language: SQL (Structured Query Language) (sql)
To disable all indexes of a table, you use the following form of the ALTER INDEX statement:

ALTER INDEX ALL ON table_name
DISABLE;
Code language: SQL (Structured Query Language) (sql)
If you disable an index, the query optimizer will not consider that disabled index for creating query execution plans.

When you disable an index on a table, SQL Server keeps the index definition in the metadata and the index statistics in nonclustered indexes. However, if you disable a nonclustered or clustered index on a view, SQL Server will physically delete all the index data.

If you disable a clustered index of a table, you cannot access the table data using data manipulation language such as SELECT, INSERT, UPDATE, and DELETE until you rebuild or drop the index.

SQL Server disable index examples 
Let’s take some examples of disabling indexes to have a better understanding.

A) Disabling an index example 
This example uses the ALTER INDEX to disable the ix_cust_city index on the sales.customers table:

ALTER INDEX ix_cust_city 
ON sales.customers 
DISABLE;
Code language: SQL (Structured Query Language) (sql)
As a result, the following query, which finds customers who locate in San Jose , cannot leverage the disabled index:

SELECT    
    first_name, 
    last_name, 
    city
FROM    
    sales.customers
WHERE 
    city = 'San Jose';
Code language: SQL (Structured Query Language) (sql)
Here is the estimated query execution plan:

SQL Server Disable Index - disable one index example
B) Disabling all indexes of a table example 
This statement disables all indexes of the sales.customers table:

ALTER INDEX ALL ON sales.customers
DISABLE;
Code language: SQL (Structured Query Language) (sql)
Hence, you cannot access data in the table anymore.

SELECT * FROM sales.customers;
Code language: SQL (Structured Query Language) (sql)
Here is the error message:

The query processor is unable to produce a plan because the index 'PK__customer__CD65CB855363011F' on table or view 'customers' is disabled.
Code language: JavaScript (javascript)
Note that you will learn how to enable the index in the next tutorial.

In this tutorial, you have learned how to use the ALTER INDEX statement to disable indexes of a table.

Was this tutorial helpful?

SQL Server Enable Indexes
Summary: in this tutorial, you will learn how to use various statements to enable one or all disabled indexes on a table.

Sometimes, you need to disable an index before doing a large update on a table. By disabling the index, you can speed up the update process by avoiding the index writing overhead.

After completing the update to the table, you need to enable the index. Since the index was disabled, you can rebuild the index but cannot just simply enable it. Because after the update operation, the index needs to be rebuilt to reflect the new data in the table.

In SQL Server, you can rebuild an index by using the ALTER INDEX statement or DBCC DBREINDEX command.

Enable index using ALTER INDEX and CREATE INDEX statements 
This statement uses the ALTER INDEX statement to “enable” or rebuild an index on a table:

ALTER INDEX index_name 
ON table_name  
REBUILD;
Code language: SQL (Structured Query Language) (sql)
This statement uses the CREATE INDEX statement to enable the disabled index and recreate it:

CREATE INDEX index_name 
ON table_name(column_list)
WITH(DROP_EXISTING=ON)
Code language: SQL (Structured Query Language) (sql)
The following statement uses the ALTER INDEX statement to enable all disabled indexes on a table:

ALTER INDEX ALL ON table_name
REBUILD;
Code language: SQL (Structured Query Language) (sql)
Enable indexes using DBCC DBREINDEX statement 
This statement uses the DBCC DBREINDEX to enable an index on a table:

DBCC DBREINDEX (table_name, index_name);
Code language: SQL (Structured Query Language) (sql)
This statement uses the DBCC DBREINDEX to enable all indexes on a table:

DBCC DBREINDEX (table_name, " ");  
Code language: SQL (Structured Query Language) (sql)
Enable indexes example 
The following example uses the ALTER INDEX statement to enable all indexes on the sales.customers table from the sample database:

ALTER INDEX ALL ON sales.customers
REBUILD;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned various statements including ALTER INDEX, CREATE INDEX, and DBCC DBREINDEX to enable one or all indexes on a table.

Was this tutorial helpful?

SQL Server Unique Index
Summary: in this tutorial, you will learn about SQL Server unique indexes and how to use them to enforce the uniqueness of values in one or more columns of a table.

SQL Server unique index overview 
A unique index ensures the index key columns do not contain any duplicate values.

A unique index may consist of one or many columns. If a unique index has one column, the values in this column will be unique. In case the unique index has multiple columns, the combination of values in these columns is unique.

Any attempt to insert or update data into the unique index key columns that cause the duplicate will result in an error.

A unique index can be clustered or non-clustered.

To create a unique index, you use the CREATE UNIQUE INDEX statement as follows:

CREATE UNIQUE INDEX index_name
ON table_name(column_list);
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the unique index after the CREATE UNIQUE INDEX keywords.
Second, specify the name of the table to which the index is associated and a list of columns that will be included in the index.
SQL Server unique index examples 
Let’s take some examples of using unique indexes.

1) Creating a SQL Server unique index for one column example 
This query finds the customer with the email 'caren.stephens@msn.com':

SELECT
    customer_id, 
    email 
FROM
    sales.customers
WHERE 
    email = 'caren.stephens@msn.com';
Code language: SQL (Structured Query Language) (sql)
SQL Server UNIQUE Index - Clustered Index Scan
The query optimizer has to scan the whole clustered index to find the row.

To speed up the retrieval of the query, you can add a non-clustered index to the email column.

However, with the assumption that each customer will have a unique email, you can create a unique index for the email column.

Because the sales.customers table already has data, you need to check duplicate values in the email column first:

SELECT 
    email, 
    COUNT(email)
FROM 
    sales.customers
GROUP BY 
    email
HAVING 
    COUNT(email) > 1;
Code language: SQL (Structured Query Language) (sql)
The query returns an empty result set. It means that there are no duplicate values in the email column.

Therefore, you can go ahead to create a unique index for the email column of the sales.customers table:

CREATE UNIQUE INDEX ix_cust_email 
ON sales.customers(email);
Code language: SQL (Structured Query Language) (sql)
From now on, the query optimizer will leverage the ix_cust_email index and use the index seek method to search for rows by email.

SQL Server UNIQUE Index - Index Seek
2) Creating a SQL Server unique index for multiple columns 
First, create a table named t1 that has two columns for the demonstration:

CREATE TABLE t1 (
    a INT, 
    b INT
);
Code language: SQL (Structured Query Language) (sql)
Next, create a unique index that includes both a and b columns:

CREATE UNIQUE INDEX ix_uniq_ab 
ON t1(a, b);
Code language: SQL (Structured Query Language) (sql)
Then, insert a new row into the t1 table:

INSERT INTO t1(a,b) VALUES(1,1);
Code language: SQL (Structured Query Language) (sql)
After that, insert another row into the t1 table. Note that the value 1 is repeated in the a column, but the combination of values in the column a and b is not duplicate:

INSERT INTO t1(a,b) VALUES(1,2);
Code language: SQL (Structured Query Language) (sql)
Finally, insert a row that already exists into the t1 table:

INSERT INTO t1(a,b) VALUES(1,2);
Code language: SQL (Structured Query Language) (sql)
SQL Server issues an error::

Cannot insert duplicate key row in object 'dbo.t1' with unique index 'ix_ab'. The duplicate key value is (1, 2).
Code language: JavaScript (javascript)
SQL Server unique index and NULL 
NULL is special. It is a marker that indicates the missing information or not applicable.

NULL is not even equal to itself. However, when it comes to a unique index, SQL Server treats NULL values the same. It means that if you create a unique index on a nullable column, you can have only one NULL value in this column

The following statements create a new table named t2 and define a unique index on the a column:

CREATE TABLE t2(
    a INT
);

CREATE UNIQUE INDEX a_uniq_t2
ON t2(a);
Code language: SQL (Structured Query Language) (sql)
This query inserts NULL into the a column of the t2 table:

INSERT INTO t2(a) VALUES(NULL);
Code language: SQL (Structured Query Language) (sql)
However, when executing the above query again, the SQL Server issues an error due to duplicate NULL values:

]Cannot insert duplicate key row in object 'dbo.t2' with unique index 'a_uniq_t2'. The duplicate key value is (<NULL>). (2601)
Code language: SQL (Structured Query Language) (sql)
Unique index vs. UNIQUE constraint 
Both unique index and UNIQUE constraint enforces the uniqueness of values in one or many columns. SQL Server validates duplicates in the same manner for both unique index and unique constraint.

When you create a unique constraint, behind the scene, SQL Server creates a unique index associated with this constraint.

However, creating a unique constraint on columns makes the objective of the unique index clear.

In this tutorial, you have learned about the SQL Server unique index and how to create a unique index for one or many columns of a table

SQL Server DROP INDEX
Summary: in this tutorial, you will learn how to use the SQL Server DROP INDEX statement to remove existing indexes.

SQL Server DROP INDEX statement overview 
The DROP INDEX statement removes one or more indexes from the current database. Here is the syntax of the DROP INDEX statement:

DROP INDEX [IF EXISTS] index_name
ON table_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the index that you want to remove after the DROP INDEX clause.
Second, specify the name of the table to which the index belongs.
Removing a nonexisting index will result in an error. However, you can use the IF EXISTS option to conditionally drop the index and avoid the error.

Note that the IF EXISTS option has been available since SQL Server 2016 (13.x).

The DROP INDEX statement does not remove indexes created by PRIMARY KEY or UNIQUE constraints. To drop indexes associated with these constraints, you use the ALTER TABLE DROP CONSTRAINT statement.

To remove multiple indexes from one or more tables at the same time, you specify a comma-separated list of index names with the corresponding table names after the DROP INDEX clause as shown in the following query:

DROP INDEX [IF EXISTS] 
    index_name1 ON table_name1,
    index_name2 ON table_name2,
    ...;
Code language: SQL (Structured Query Language) (sql)
SQL Server DROP INDEX statement examples 
We will use the sales.customers table from the sample database for the demonstration.

customers
The following picture shows the indexes of the sales.customers table:


A) Using SQL Server DROP INDEX to remove one index example 
This statement uses the DROP INDEX statement to remove the ix_cust_email index from the sales.customers table:

DROP INDEX IF EXISTS ix_cust_email
ON sales.customers;
Code language: SQL (Structured Query Language) (sql)
If you check the indexes of the sales.customers table, you will see that the ix_cust_email index was deleted.

SQL Server DROP INDEX one index example
B)Using SQL Server DROP INDEX to remove multiple indexes example 
The following example uses the DROP INDEX statement to remove the ix_cust_city, ix_cust_fullname indexes from the sales.customers table:

DROP INDEX 
    ix_cust_city ON sales.customers,
    ix_cust_fullname ON sales.customers;
Code language: SQL (Structured Query Language) (sql)
The sales.customers table now has no non-clustered index:

SQL Server DROP INDEX multiple indexes example
In this tutorial, you have learned how to use the SQL Server DROP INDEX statement to remove one or many indexes from tables.

Was this tutorial helpful?

SQL Server Indexes with Included Columns
Summary: in this tutorial, you will learn how to use indexes with included columns to improve the speed of queries.

Introduction to SQL Server indexes with included columns 
We will use the sales.customers table from the sample database for the demonstration.

customers
The following statement creates a unique index for the email column:

CREATE UNIQUE INDEX ix_cust_email 
ON sales.customers(email);
Code language: SQL (Structured Query Language) (sql)
This statement finds the customer whose email is 'aide.franco@msn.com':

SELECT    
    customer_id, 
    email
FROM    
    sales.customers
WHERE 
    email = 'aide.franco@msn.com';
Code language: SQL (Structured Query Language) (sql)
If you display the estimated execution plan for the above query, you will find that the query optimizer uses the index seek operation on the non-clustered index.

index with included columns
However, consider the following example:

SELECT    
	first_name,
	last_name, 
	email
FROM    
	sales.customers
WHERE email = 'aide.franco@msn.com';
Code language: SQL (Structured Query Language) (sql)
Here is the execution plan:


In this execution plan:

First, the query optimizer uses the index seek on the non-clustered index ix_cust_email to find the email and customer_id.


Second, the query optimizer uses the key lookup on the clustered index of the sales.customers table to find the first name and last name of the customer by customer id.


Third, for each row found in the non-clustered index, it matches with rows found in the clustered index using nested loops.

As you can see the cost for key lookup is about 50% of the query, which is quite expensive.

To help reduce this key lookup cost, SQL Server allows you to extend the functionality of a non-clustered index by including non-key columns.

By including non-key columns in non-clustered indexes, you can create nonclustered indexes that cover more queries.

Note that when an index contains all the columns referenced by a query, the index is typically referred to as covering the query.

First, drop the index ix_cust_email from the sales.customers table:

DROP INDEX ix_cust_email 
ON sales.customers;
Code language: SQL (Structured Query Language) (sql)
Then, create a new index ix_cust_email_inc that includes two columns first name and last name:

CREATE UNIQUE INDEX ix_cust_email_inc
ON sales.customers(email)
INCLUDE(first_name,last_name);
Code language: SQL (Structured Query Language) (sql)
Now, the query optimizer will solely use the non-clustered index to return the requested data of the query:


An index with included columns can greatly improve query performance because all columns in the query are included in the index; The query optimizer can locate all columns values within the index without accessing table or clustered index resulting in fewer disk I/O operations.

The syntax for creating an index with included columns 
The following illustrates the syntax for creating a non-clustered index with included columns:

CREATE [UNIQUE] INDEX index_name
ON table_name(key_column_list)
INCLUDE(included_column_list);
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the index after CREATE INDEX clause. If the index is unique, you need to add the UNIQUE keyword.
Second, specify the name of the table and a list of key column list for the index after the ON clause.
Third, list a comma-separated list of included columns in the INCLUDE clause.
In this tutorial, you have learned how to use SQL Server indexes with included columns to improve the query performance.

Was this tutorial helpful? 

SQL Server Filtered Indexes
Summary: in this tutorial, you will learn how to use the SQL Server filtered indexes to create optimized non-clustered indexes for tables.

Introduction to SQL Server filtered indexes 
A nonclustered index, when used properly, can greatly improve the performance of queries. However, the benefits of nonclustered indexes come at costs: storage and maintenance.

First, it takes additional storage to store the copy of data of the index key columns.
Second, when you insert, update, or delete rows from the table, SQL Server needs to update the associated non-clustered index.
It would be inefficient if applications just query a portion of rows of a table. This is why the filtered indexes come into play.

A filtered index is a nonclustered index with a predicate that allows you to specify which rows should be added to the index.

The following syntax illustrates how to create a filtered index:

CREATE INDEX index_name
ON table_name(column_list)
WHERE predicate;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the filtered index after the CREATE INDEX clause.
Second, list the table name with a list of key columns that will be included in the index.
Third, use a WHERE clause with a predicate to specify which rows of the table should be included in the index.
SQL Server filtered index example 
We will use the sales.customers table from the sample database for the demonstration:

customers
The sales.customers table has the phone column which contains many NULL values:

SELECT 
    SUM(CASE
            WHEN phone IS NULL
            THEN 1
            ELSE 0
        END) AS [Has Phone], 
    SUM(CASE
            WHEN phone IS NULL
            THEN 0
            ELSE 1
        END) AS [No Phone]
FROM 
    sales.customers;
Code language: SQL (Structured Query Language) (sql)
Has Phone   No Phone
----------- -----------
1267        178

(1 row affected)
This phone column is a good candidate for the filtered index.

This statement creates a filtered index for the phone column of the sales.customers table:

CREATE INDEX ix_cust_phone
ON sales.customers(phone)
WHERE phone IS NOT NULL;
Code language: SQL (Structured Query Language) (sql)
The following query finds the customer whose phone number is (281) 363-3309:

SELECT    
    first_name,
    last_name, 
    phone
FROM    
    sales.customers
WHERE phone = '(281) 363-3309';
Code language: SQL (Structured Query Language) (sql)
Here is the estimated execution plan:

SQL Server Filtered Index example
The query optimizer can leverage the filtered index ix_cust_phone for searching.

Note that to improve the key lookup, you can use an index with included columns, which includes both first_name and last_name columns in the index:

CREATE INDEX ix_cust_phone
ON sales.customers(phone)
INCLUDE (first_name, last_name)
WHERE phone IS NOT NULL;
Code language: SQL (Structured Query Language) (sql)
Benefits of filtered indexes 
As mentioned earlier, filtered indexes can help you save spaces especially when the index key columns are sparse. Sparse columns are the ones that have many NULL values.

In addition, filtered indexes reduce the maintenance cost because only a portion of data rows, not all, needs to be updated when the data in the associated table changes.

In this tutorial, you have learned how to use the SQL Server filtered indexes to create optimized nonclustered indexes for tables.

SQL Server Indexes on Computed Columns
Summary: in this tutorial, you will learn how to simulate function-based indexes in SQL Server using indexes on computed columns.

Introduction to indexes on computed columns 
See the following sales.customers table from the sample database.

customers
This query finds the customer whose local part of the email address is 'garry.espinoza';

SELECT    
    first_name,
    last_name,
    email
FROM    
    sales.customers
WHERE 
    SUBSTRING(email, 0, 
        CHARINDEX('@', email, 0)
    ) = 'garry.espinoza';
Code language: SQL (Structured Query Language) (sql)
Here is the estimated execution plan of the query:

SQL Server Index on computed column - clustered index scan
As clearly shown in the output, the query optimizer needs to scan the whole clustered index for locating the customer, which is not efficient.

If you have worked with Oracle or PostgreSQL, you may know that Oracle supports function-based indexes and PostgreSQL has expression-based indexes. These kinds of indexes allow you to index the result of a function or an expression which will improve the performance of queries whose WHERE clause contains the function and expression.

In SQL Server, you can use an index on a computed column to achieve the similar effect of a function-based index:

First, create a computed column based on the expression on the WHERE clause.
Second, create a nonclustered index for the computed column.
For example, to search for customers based on local parts of their email addresses, you use these steps:

First, add a new computed column to the sales.customers table:

ALTER TABLE sales.customers
ADD 
    email_local_part AS 
        SUBSTRING(email, 
            0, 
            CHARINDEX('@', email, 0)
        );
Code language: SQL (Structured Query Language) (sql)
Then, create an index on the email_local_part column:

CREATE INDEX ix_cust_email_local_part
ON sales.customers(email_local_part);
Code language: SQL (Structured Query Language) (sql)
Now, you can use the email_local_part column instead of the expression in the WHERE clause to find customers by the local part of the email address:

SELECT    
    first_name,
    last_name,
    email
FROM    
    sales.customers
WHERE 
    email_local_part = 'garry.espinoza';
Code language: SQL (Structured Query Language) (sql)
The query optimizer uses the index seek operation on the ix_cust_email_local_part index as shown in the following picture:


Requirements for indexes on computed columns 
To create an index on a computed column, the following requirements must be met:

The functions involved in the computed column expression must have the same owner as the table.
The computed column expression must be deterministic. It means that expression always returns the same result for a given set of inputs.
The computed column must be precise, which means its expression must not contain any FLOAT or REAL data types.
The result of the computed column expression cannot evaluate to the TEXT, NTEXT, or IMAGE data types.
The ANSI_NULLS option must be set to ON when the computed column is defined using the CREATE TABLE or ALTER TABLE statement. In addition, the options ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, QUOTED_IDENTIFIER, and CONCAT_NULL_YIELDS_NULL must also be set to ON, and NUMERIC_ROUNDABORT must be set to OFF.
In this tutorial, you have learned how to use the SQL Server indexes on computed columns to improve the speed of queries that involved expressions.

Was this tutorial helpful?

