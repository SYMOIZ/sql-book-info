SQL Server triggers are special stored procedures that are executed automatically in response to the database object, database, and server events. SQL Server provides three type of triggers:

Data manipulation language (DML) triggers which are invoked automatically in response to INSERT, UPDATE, and DELETE events against tables.
Data definition language (DDL) triggers which fire in response to CREATE, ALTER, and DROP statements. DDL triggers also fire in response to some system stored procedures that perform DDL-like operations.
Logon triggers which fire in response to LOGON events
In this section, you will learn how to effectively use triggers in SQL Server.

Creating a trigger in SQL Server – show you how to create a trigger in response to insert and delete events.
Creating an INSTEAD OF trigger – learn about the INSTEAD OF trigger and its practical applications.
Creating a DDL trigger – learn how to create a DDL trigger to monitor the changes made to the structures of database objects such as tables, views, and indexes.
Disabling triggers – learn how to disable a trigger of a table temporarily so that it does not fire when associated events occur.
Enabling triggers – show you how to enable a trigger.
Viewing the definition of a trigger – provide you with various ways to view the definition of a trigger.
Listing all triggers in SQL Server – show you how to list all triggers in a SQL Server by querying data from the sys.triggers view.
Removing triggers – guide you how to drop one or more existing trigger.

SQL Server CREATE TRIGGER
Summary: in this tutorial, you will learn how to use the SQL Server CREATE TRIGGER statement to create a new trigger.

Introduction to SQL Server CREATE TRIGGER statement 
The CREATE TRIGGER statement allows you to create a new trigger that is fired automatically whenever an event such as INSERT, DELETE, or UPDATE occurs against a table.

The following illustrates the syntax of the CREATE TRIGGER statement:

CREATE TRIGGER [schema_name.]trigger_name
ON table_name
AFTER  {[INSERT],[UPDATE],[DELETE]}
[NOT FOR REPLICATION]
AS
{sql_statements}
Code language: SQL (Structured Query Language) (sql)
In this syntax:

The schema_name is the name of the schema to which the new trigger belongs. The schema name is optional.
The trigger_name is the user-defined name for the new trigger.
The table_name is the table to which the trigger applies.
The event is listed in the AFTER clause. The event could be INSERT, UPDATE, or DELETE. A single trigger can fire in response to one or more actions against the table.
The NOT FOR REPLICATION option instructs SQL Server not to fire the trigger when data modification is made as part of a replication process.
The sql_statements is one or more Transact-SQL used to carry out actions once an event occurs.
“Virtual” tables for triggers: INSERTED and DELETED 
SQL Server provides two virtual tables that are available specifically for triggers called INSERTED and DELETED tables. SQL Server uses these tables to capture the data of the modified row before and after the event occurs.

The following table shows the content of the INSERTED and DELETED tables before and after each event:

DML event	INSERTED table holds	DELETED table holds
INSERT	rows to be inserted	empty
UPDATE	new rows modified by the update	existing rows modified by the update
DELETE	empty	rows to be deleted
SQL Server CREATE TRIGGER example 
Let’s look at an example of creating a new trigger. We will use the production.products table from the sample database for the demonstration.

products
1) Create a table for logging the changes 
The following statement creates a table named production.product_audits to record information when an INSERT or DELETE event occurs against the production.products table:

CREATE TABLE production.product_audits(
    change_id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' or operation='DEL')
);
Code language: SQL (Structured Query Language) (sql)
The production.product_audits table has all the columns from the production.products table. In addition, it has a few more columns to record the changes e.g., updated_at, operation, and the change_id.

2) Creating an after DML trigger 
First, to create a new trigger, you specify the name of the trigger and schema to which the trigger belongs in the CREATE TRIGGER clause:

CREATE TRIGGER production.trg_product_audit
Code language: SQL (Structured Query Language) (sql)
Next, you specify the name of the table, which the trigger will fire when an event occurs, in the ON clause:

ON production.products
Code language: SQL (Structured Query Language) (sql)
Then, you list the one or more events which will call the trigger in the AFTER clause:

AFTER INSERT, DELETE
Code language: SQL (Structured Query Language) (sql)
The body of the trigger begins with the AS keyword:

AS
BEGIN
Code language: SQL (Structured Query Language) (sql)
After that, inside the body of the trigger, you set the SET NOCOUNT to ON to suppress the number of rows affected messages from being returned whenever the trigger is fired.

SET NOCOUNT ON;
Code language: SQL (Structured Query Language) (sql)
The trigger will insert a row into the production.product_audits table whenever a row is inserted into or deleted from the production.products table. The data for insert is fed from the INSERTED and DELETED tables via the UNION ALL operator:

INSERT INTO
    production.product_audits
        (
            product_id,
            product_name,
            brand_id,
            category_id,
            model_year,
            list_price,
            updated_at,
            operation
        )
SELECT
    i.product_id,
    product_name,
    brand_id,
    category_id,
    model_year,
    i.list_price,
    GETDATE(),
    'INS'
FROM
    inserted AS i
UNION ALL
    SELECT
        d.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        d.list_price,
        getdate(),
        'DEL'
    FROM
        deleted AS d;
Code language: SQL (Structured Query Language) (sql)
The following put all parts together:

CREATE TRIGGER production.trg_product_audit
ON production.products
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO production.product_audits(
        product_id, 
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price, 
        updated_at, 
        operation
    )
    SELECT
        i.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        i.list_price,
        GETDATE(),
        'INS'
    FROM
        inserted i
    UNION ALL
    SELECT
        d.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        d.list_price,
        GETDATE(),
        'DEL'
    FROM
        deleted d;
END
Code language: SQL (Structured Query Language) (sql)
Finally, you execute the whole statement to create the trigger. Once the trigger is created, you can find it under the triggers folder of the table as shown in the following picture:

SQL Server Create Trigger Example
3) Testing the trigger 
The following statement inserts a new row into the production.products table:

INSERT INTO production.products(
    product_name, 
    brand_id, 
    category_id, 
    model_year, 
    list_price
)
VALUES (
    'Test product',
    1,
    1,
    2018,
    599
);
Code language: SQL (Structured Query Language) (sql)
Because of the INSERT event, the production.trg_product_audit trigger of production.products table was fired.

Let’s examine the contents of the production.product_audits table:

SELECT 
    * 
FROM 
    production.product_audits;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server Create Trigger - After Insert Example
The following statement deletes a row from the production.products table:

DELETE FROM 
    production.products
WHERE 
    product_id = 322;
Code language: SQL (Structured Query Language) (sql)
As expected, the trigger was fired and inserted the deleted row into the production.product_audits table:

SELECT 
    * 
FROM 
    production.product_audits;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server Create Trigger - After delete Example
In this tutorial, you have learned how to create a trigger in SQL Server to respond to one or more events such as insert and delete.

Was this tutorial helpful? 


SQL Server INSTEAD OF Trigger
 Summary: in this tutorial, you will learn how to use SQL Server INSTEAD OF trigger to insert data into an underlying table via a view.

What is an INSTEAD OF trigger 
An INSTEAD OF trigger is a trigger that allows you to skip an INSERT, DELETE, or UPDATE statement to a table or a view and execute other statements defined in the trigger instead. The actual insert, delete, or update operation does not occur at all.

In other words, an INSTEAD OF trigger skips a DML statement and execute other statements.

SQL Server INSTEAD OF trigger syntax 
The following illustrates the syntax of how to create an INSTEAD OF trigger:

CREATE TRIGGER [schema_name.] trigger_name
ON {table_name | view_name }
INSTEAD OF {[INSERT] [,] [UPDATE] [,] [DELETE] }
AS
{sql_statements}
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the trigger and optionally the name of the schema to which the trigger belongs in the CREATE TRIGGER clause.
Second, specify the name of the table or view which the trigger associated with.
Third, specify an event such as INSERT, DELETE, or UPDATE which the trigger will fire in the INSTEAD OF clause. The trigger may be called to respond to one or multiple events.
Fourth, place the trigger body after the AS keyword. A trigger’s body may consist of one or more Transact-SQL statements.
SQL Server INSTEAD OF trigger example 
A typical example of using an INSTEAD OF trigger is to override an insert, update, or delete operation on a view.

Suppose, an application needs to insert new brands into the production.brands table. However, the new brands should be stored in another table called production.brand_approvals for approval before inserting into the production.brands table.

To accomplish this, you create a view called production.vw_brands for the application to insert new brands. If brands are inserted into the view, an INSTEAD OF trigger will be fired to insert brands into the production.brand_approvals table.

The following picture illustrates the process:

SQL Server INSTEAD OF trigger illustration
This diagram does not show the schema name of all the database objects for the sake of simplicity.

The following statement creates a new table named production.brand_approvals for storing pending approval brands:

CREATE TABLE production.brand_approvals(
    brand_id INT IDENTITY PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
The following statement creates a new view named production.vw_brands against the production.brands and production.brand_approvals tables:

CREATE VIEW production.vw_brands 
AS
SELECT
    brand_name,
    'Approved' approval_status
FROM
    production.brands
UNION
SELECT
    brand_name,
    'Pending Approval' approval_status
FROM
    production.brand_approvals;
Code language: SQL (Structured Query Language) (sql)
Once a row is inserted into the production.vw_brands view, we need to route it to the production.brand_approvals table via the following INSTEAD OF trigger:

CREATE TRIGGER production.trg_vw_brands 
ON production.vw_brands
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO production.brand_approvals ( 
        brand_name
    )
    SELECT
        i.brand_name
    FROM
        inserted i
    WHERE
        i.brand_name NOT IN (
            SELECT 
                brand_name
            FROM
                production.brands
        );
END
Code language: SQL (Structured Query Language) (sql)
The trigger inserts the new brand name into the production.brand_approvals if the brand name does not exist in the production.brands.

Let’s insert a new brand into the production.vw_brands view:

INSERT INTO production.vw_brands(brand_name)
VALUES('Eddy Merckx');
Code language: SQL (Structured Query Language) (sql)
This INSERT statement fired the INSTEAD OF trigger to insert a new row into the production.brand_approvals table.

If you query data from the production.vw_brands table, you will see a new row appear:

SELECT
	brand_name,
	approval_status
FROM
	production.vw_brands;
Code language: SQL (Structured Query Language) (sql)
SQL Server INSTEAD OF trigger example
The following statement shows the contents of the production.brand_approvals table:

SELECT 
	*
FROM 
	production.brand_approvals;
Code language: SQL (Structured Query Language) (sql)
SQL Server INSTEAD OF trigger - pending table
In this tutorial, you have learned about SQL Server INSTEAD OF trigger and how to create an INSTEAD OF trigger for inserting data into an underlying table via a view.

Was this tutorial helpful?


SQL Server DDL Trigger
Summary: in this tutorial, you will learn how to use the SQL Server data definition language (DDL) trigger to monitor the changes made to the database objects.

Introduction to SQL Server DDL triggers 
SQL Server DDL triggers respond to server or database events rather than to table data modifications. These events created by the Transact-SQL statement that normally starts with one of the following keywords CREATE, ALTER, DROP, GRANT, DENY, REVOKE, or UPDATE STATISTICS.

For example, you can write a DDL trigger to log whenever a user issues a CREATE TABLE or ALTER TABLE statement.

The DDL triggers are useful in the following cases:

Record changes in the database schema.
Prevent some specific changes to the database schema.
Respond to a change in the database schema.
The following shows the syntax of creating a DDL trigger:

CREATE TRIGGER trigger_name
ON { DATABASE |  ALL SERVER}
[WITH ddl_trigger_option]
FOR {event_type | event_group }
AS {sql_statement}
Code language: SQL (Structured Query Language) (sql)
 trigger_name 
Specify the user-defined name of trigger after the CREATE TRIGGER keywords. Note that you don’t have to specify a schema for a DDL trigger because it isn’t related to an actual database table or view.

 DATABASE | ALL SERVER 
Use DATABASE if the trigger respond to database-scoped events or ALL SERVER if the trigger responds to the server-scoped events.

 ddl_trigger_option 
The ddl_trigger_option specifies ENCRYPTION and/or EXECUTE AS clause. ENCRYPTION encrypts the definition of the trigger. EXECUTE AS defines the security context under which the trigger is executed.

 event_type | event_group 
The event_type indicates a DDL event that causes the trigger to fire e.g., CREATE_TABLE, ALTER_TABLE, etc.

The event_group is a group of event_type event such as DDL_TABLE_EVENTS.

A trigger can subscribe to one or more events or groups of events.

Creating a SQL Server DDL trigger example 
Suppose you want to capture all the modifications made to the database index so that you can better monitor the performance of the database server which relates to these index changes.

First, create a new table named index_logs to log the index changes:

CREATE TABLE index_logs (
    log_id INT IDENTITY PRIMARY KEY,
    event_data XML NOT NULL,
    changed_by SYSNAME NOT NULL
);
GO
Code language: SQL (Structured Query Language) (sql)
Next, create a DDL trigger to track index changes and insert events data into the index_logs table:

CREATE TRIGGER trg_index_changes
ON DATABASE
FOR	
    CREATE_INDEX,
    ALTER_INDEX, 
    DROP_INDEX
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO index_logs (
        event_data,
        changed_by
    )
    VALUES (
        EVENTDATA(),
        USER
    );
END;
GO
Code language: SQL (Structured Query Language) (sql)
In the body of the trigger, we used the EVENTDATA() function that returns the information about server or database events. The function is only available inside DDL or logon trigger.

Then, create indexes for the first_name and last_name columns of the sales.customers table:

CREATE NONCLUSTERED INDEX nidx_fname
ON sales.customers(first_name);
GO

CREATE NONCLUSTERED INDEX nidx_lname
ON sales.customers(last_name);
GO
Code language: SQL (Structured Query Language) (sql)
After that, query data from the index_changes table to check whether the index creation event was captured by the trigger properly:

SELECT 
    *
FROM
    index_logs;
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server DDL Trigger Example
If you click on the cell of the event_data column, you can view XML data of the event as follows:

SQL Server DDL Trigger EventData XML
In this tutorial, you have learned how to create a SQL Server DDL trigger that responds to one or more DDL events.

Was this tutorial helpful?

SQL Server DISABLE TRIGGER
Summary: In this tutorial, you will learn how to use the SQL Server DISABLE TRIGGER statement to disable a trigger.

Introduction SQL Server DISABLE TRIGGER 
Sometimes, for the troubleshooting or data recovering purpose, you may want to disable a trigger temporarily. To do this, you use the DISABLE TRIGGER statement:

DISABLE TRIGGER [schema_name.][trigger_name] 
ON [object_name | DATABASE | ALL SERVER]
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the schema to which the trigger belongs and the name of the trigger that you want to disable after the DISABLE TRIGGER keywords.
Second, specify the table name or view that the trigger was bound to if the trigger is a DML trigger. Use DATABASE if the trigger is DDL database-scoped trigger, or SERVER if the trigger is DDL server-scoped trigger.
SQL Server DISABLE TRIGGER example 
The following statement creates a new table named sales.members for the demonstration:

CREATE TABLE sales.members (
    member_id INT IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    member_level CHAR(10) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
The following statement creates a trigger that is fired whenever a new row is inserted into the sales.members table. For the demonstration purpose, the trigger just returns a simple message.

CREATE TRIGGER sales.trg_members_insert
ON sales.members
AFTER INSERT
AS
BEGIN
    PRINT 'A new member has been inserted';
END;
Code language: SQL (Structured Query Language) (sql)
The following statement inserts a new row into the sales.members table:

INSERT INTO sales.members(customer_id, member_level)
VALUES(1,'Silver');
Code language: SQL (Structured Query Language) (sql)
Because of the INSERT event, the triggered was fired and printed out the following message:

A new member has been inserted
Code language: SQL (Structured Query Language) (sql)
To disable the sales.trg_members_insert trigger, you use the following DISABLE TRIGGER statement:

DISABLE TRIGGER sales.trg_members_insert 
ON sales.members;
Code language: SQL (Structured Query Language) (sql)
Now if you insert a new row into the sales.members table, the trigger will not be fired.

INSERT INTO sales.members(customer_id, member_level)
VALUES(2,'Gold');
Code language: SQL (Structured Query Language) (sql)
It means that the trigger has been disabled.

Note that the trigger definition is still there on the table. If you view the trigger in the SQL Server Management Studio (SSMS), you will notice a red cross icon on the disabled trigger name:

SQL Server DISABLE TRIGGER example
Disable all trigger on a table 
To disable all triggers on a table, you use the following statement:

DISABLE TRIGGER ALL ON table_name;
Code language: SQL (Structured Query Language) (sql)
In this statement, you just need to specify the name of the table to disable all triggers that belong to that table.

The following statement creates a new trigger on the sales.members table which is fired after delete event:

CREATE TRIGGER sales.trg_members_delete
ON sales.members
AFTER DELETE
AS
BEGIN
    PRINT 'A new member has been deleted';
END;
Code language: SQL (Structured Query Language) (sql)
To disable all triggers on the sales.members table, you use the following statement:

DISABLE TRIGGER ALL ON sales.members;
Code language: SQL (Structured Query Language) (sql)
The following picture shows the status of all triggers that belongs to the sales.members table:

SQL Server disable all triggers of a table
Disable all triggers on a database 
To disable all triggers on the current database, you use the following statement:

DISABLE TRIGGER ALL ON DATABASE;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server DISABLE TRIGGER statement to disable a trigger.

Was this tutorial helpful?

SQL Server ENABLE TRIGGER
Summary: in this tutorial, you will learn how to use the SQL Server ENABLE TRIGGER statement to enable a trigger.

Introduction to SQL Server ENABLE TRIGGER statement 
The ENABLE TRIGGER statement allows you to enable a trigger so that the trigger can be fired whenever an event occurs.

The following illustrates the syntax of the ENABLE TRIGGER statement:

ENABLE TRIGGER [schema_name.][trigger_name] 
ON [object_name | DATABASE | ALL SERVER]
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the trigger that you want to enable. Optionally, you can specify the name of the schema to which the trigger belongs.
Second, specify the table to which the trigger belongs if the trigger is a DML trigger. Use DATABASE if the trigger is a DDL database-scoped trigger or ALL SERVER if the trigger is DDL server-scoped trigger.
SQL Server ENABLE TRIGGER example 
We will use the sales.members table created in the DISABLE TRIGGER tutorial for the demonstration.

To enable the sales.sales.trg_members_insert trigger, you use the following statement:

ENABLE TRIGGER sales.trg_members_insert
ON sales.members;
Code language: SQL (Structured Query Language) (sql)
Once enabled, you can see the status of the trigger via the SQL Server Management Studio as shown in the following picture:

SQL Server ENABLE TRIGGER example
Enable all triggers of a table 
To enable all triggers of a table, you use the following statement:

ENABLE TRIGGER ALL ON table_name;
Code language: SQL (Structured Query Language) (sql)
In this syntax, you just have to specify the name of the table that you want to enable all associated triggers.

For example, to enable all triggers of the sales.members table, you use the following statement:

The following picture shows the status of all triggers defined for the sales.members table:

SQL Server ENABLE ALL TRIGGER example
Enable all triggers of a database 
To enable all triggers on the current database, you use the following statement:

ENABLE TRIGGER ALL ON DATABASE; 
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use the SQL Server ENABLE TRIGGER statement to enable a trigger of a table. You also learned how to enable all triggers of a table and a database.

Was this tutorial helpful?

SQL Server View Trigger Definition
Summary: in this tutorial, you will learn various ways to view SQL Server trigger definition.

Getting trigger definition by querying from a system view 
You can get the definition of a trigger by querying data against the sys.sql_modules view:

SELECT 
    definition   
FROM 
    sys.sql_modules  
WHERE 
    object_id = OBJECT_ID('sales.trg_members_delete'); 
Code language: SQL (Structured Query Language) (sql)
Here is the output:

SQL Server View Trigger Definition - querying system view
In this query, you pass the name of the trigger which you want to get the definition to the OBJECT_ID() function in the WHERE clause.

Getting trigger definition using OBJECT_DEFINITION function 
You can get the definition of a trigger using the OBJECT_DEFINITION function as follows:

SELECT 
    OBJECT_DEFINITION (
        OBJECT_ID(
            'sales.trg_members_delete'
        )
    ) AS trigger_definition;
Code language: SQL (Structured Query Language) (sql)
In this query, you pass the trigger name to the OBJECT_ID function to get the ID of the trigger. Then, you use the OBJECT_DEFINITION() function to get the Transact-SQL source text of the definition of a trigger based on its ID.

Getting trigger definition using sp_helptext stored procedure 
The simplest way to get the definition of a trigger is to use the sp_helptext stored procedure as follows:

EXEC sp_helptext 'sales.trg_members_delete' ;
Code language: SQL (Structured Query Language) (sql)
The sp_helptext stored procedure returns the definition used to create an object, in this case, a trigger.

Getting trigger definition using SSMS 
To view the definition of a DML trigger:

First, in Object Explorer, connect to the database and expand that instance.
Second, expand the database and table which contains the trigger that you want to view the definition.
Third, expand Triggers, right-click the trigger you want to view the definition, and then click Modify. The trigger definition appears in the query window.
SQL Server View Trigger Definition
In this tutorial, you have learned various ways to view the definition of a trigger.

Was this tutorial helpful?

SQL Server List All Triggers
To list all triggers in a SQL Server, you query data from the sys.triggers view:

SELECT  
    name,
    is_instead_of_trigger
FROM 
    sys.triggers  
WHERE 
    type = 'TR';
Code language: SQL (Structured Query Language) (sql)
The following picture shows the output:

SQL Server List Triggers
Was this tutorial helpful?
SQL Server DROP TRIGGER
Summary: in this tutorial, you will learn how to use the SQL Server DROP TRIGGER statement to remove existing triggers.

Introduction SQL Server DROP TRIGGER statements 
The SQL Server DROP TRIGGER statement drops one or more triggers from the database. The following illustrates the syntax of the DROP TRIGGER statement that removes DML triggers:

DROP TRIGGER [ IF EXISTS ] [schema_name.]trigger_name [ ,...n ];
Code language: SQL (Structured Query Language) (sql)
In this syntax:

IF EXISTS conditionally removes the trigger only when it already exists.
schema_name is the name of the schema to which the DML trigger belongs.
trigger_name is the name of the trigger that you wish to remove.
If you want to remove multiple triggers at once, you need to separate triggers by commas.

To remove one or more DDL triggers, you use the following form of the DROP TRIGGER statement:

DROP TRIGGER [ IF EXISTS ] trigger_name [ ,...n ]   
ON { DATABASE | ALL SERVER };
Code language: SQL (Structured Query Language) (sql)
In this syntax:

DATABASE indicates that the scope of the DDL trigger applies to the current database.
ALL SERVER indicates the scope of the DDL trigger applies to the current server.
To remove a LOGON event trigger, you use the following syntax:

DROP TRIGGER [ IF EXISTS ] trigger_name [ ,...n ]   
ON ALL SERVER;
Code language: SQL (Structured Query Language) (sql)
Notice that when you drop a table, all triggers associated with the table are also removed automatically.

SQL Server DROP TRIGGER examples 
A) SQL Server DROP TRIGGER – drop a DML trigger example 
The following statement drops a DML trigger named sales.trg_member_insert:

DROP TRIGGER IF EXISTS sales.trg_member_insert;
Code language: SQL (Structured Query Language) (sql)
B) SQL Server DROP TRIGGER – drop a DDL trigger example 
The following statement removes the trg_index_changes trigger:

DROP TRIGGER IF EXISTS trg_index_changes;
Code language: SQL (Structured Query Language) (sql)
In this tutorial, you have learned how to use remove a trigger using the DROP TRIGGER statement.

Was this tutorial helpful?


