SQL Server Tutorial
SQL Server Tutorial
Welcome to the SQLServerTutorial.Net website!

If you are looking for an easy, fast, and efficient way to master SQL Server, you are in the right place.

Our SQL Server tutorials are practical and packed with many hands-on activities.

After completing the entire tutorial, you will be able to:

Query data efficiently from tables in the SQL Server database.
Create database objects such as tables, views, indexes, sequences, synonyms, stored procedures, user-defined functions, and triggers.
Manage SQL Server database efficiently.
SQL Server is a relational database management system (RDBMS) developed and marketed by Microsoft. As a database server, the primary function of the SQL Server is to store and retrieve data used by other applications.


Getting Started with SQL Server
This section helps you get started with the SQL Server quickly. After completing this section, you will have a good understanding of the SQL Server and know how to install the SQL Server Developer Edition for practicing.

SQL Server Basics
The SQL server basics section shows you how to use the Transact-SQL (T-SQL) to interact with SQL Server databases. You will learn how to manipulate data from the database such as querying, inserting, updating, and deleting data.

SQL Server Views
This section introduces you to the SQL Server views and discusses the advantage and disadvantages of the database views. You will learn everything you need to know to manipulate views effectively in SQL Server.

SQL Server Indexes
In this section, you will learn everything you need to know about the SQL Server indexes to come up with a good index strategy and optimize your queries.

SQL Server Stored Procedures
This section introduces you to the SQL Server stored procedures. After completing the section, you will be able to develop complex stored procedures using Transact-SQL constructs.

SQL Server User-defined Functions
In this section, you will learn about SQL Server user-defined functions including scalar-valued functions and table-valued functions to simplify your development.

SQL Server Triggers
SQL Server triggers are special stored procedures that are executed automatically in response to the database object, database, and server events.
SQL Server Functions 
In this section, you’ll find the commonly used SQL Server functions, such as aggregate functions, date functions, string functions, system functions, and window functions.


SQL Server Aggregate Functions
This tutorial introduces you to the SQL Server aggregate functions and shows you how to use them to calculate aggregates.

SQL Server Date Functions
This page lists the most commonly used SQL Server Date functions that allow you to handle date and time date effectively.

SQL Server String Functions
This tutorial provides with many useful SQL Server String functions that allow you to manipulate character string effectively.

SQL Server System Functions
This page provides you with the commonly used system functions in SQL Server that return objects, values, and settings in SQL Server.

SQL Server Window Functions
SQL Server Window Functions calculate an aggregate value based on a group of rows and return multiple rows for each group.

What is SQL Server
SQL Server is a relational database management system (RDBMS) developed and marketed by Microsoft.

Similar to other RDBMS software, SQL Server is built on top of SQL, a standard programming language for interacting with relational databases. SQL Server is tied to Transact-SQL, or T-SQL, Microsoft’s implementation of SQL, which includes a set of proprietary programming constructs.

SQL Server has been exclusively available on the Windows environment for over 20 years. In 2016, Microsoft made it available on Linux. SQL Server 2017 became generally available in October 2016 and was compatible with both Windows and Linux.

SQL Server Architecture 
The following diagram illustrates the architecture of the SQL Server:

What is SQL Server - SQL Server Architecture 
SQL Server consists of two main components:

Database Engine
SQLOS
Database Engine 
The core component of the SQL Server is the Database Engine, which comprises a relational engine that processes queries and a storage engine that manages database files, pages, indexes, etc.

Additionally, the database engine creates database objects such as stored procedures, views, and triggers.

Relational Engine 
The Relational Engine contains the components that determine the optimal method for executing a query. It is also known as the query processor.

The relational engine requests data from the storage engine based on the input query and processes the results.

Some tasks of the relational engine include querying processing, memory management, thread and task management, buffer management, and distributed query processing.

Storage Engine 
The storage engine is responsible for storing and retrieving data from the storage systems such as disks and SAN.

SQLOS 
Under the relational engine and storage engine lies the SQL Server Operating System, or SQLOS.

SQLOS provides various operating system services such as memory and I/O management, as well as exception handling and synchronization services.

SQL Server Services and Tools 
Microsoft offers both data management and business intelligence (BI) tools and services alongside SQL Server.

For data management, SQL Server includes SQL Server Integration Services (SSIS), SQL Server Data Quality Service, and SQL Server Master Data Services.

For database development, SQL Server provides SQL Server Data tools; and for managing, deploying, and monitoring databases, SQL Server has the SQL Server Management Studio (SSMS).

For data analysis, SQL Server offers SQL Server Analysis Services (SSAS). SQL Server Reporting Services (SSRS) provides reports and data visualization. The Machine Learning Services technology first appeared first in SQL Server 2016, originally known as the R Services.

SQL Server Editions 
SQL Server has four primary editions, each offering different bundled services and tools. Two editions are available free of charge:

SQL Server Developer Edition is intended for database development and testing purposes.

SQL Server Express Edition is suitable for small databases with a storage capacity of up to 10 GB.

For larger and more critical applications, SQL Server offers the Enterprise edition, which includes all SQL Server’s features.

SQL Server Standard Edition has a subset of features available in the Enterprise Edition and imposes limitations on the server, including restrictions on the number of processor cores and memory configurations.

SQL Server Web Edition is a good option for web hosting companies due to its low total cost of ownership.

For detailed information on the SQL Server Editions, check out the available Server Server 2022 Editions.

Summary 
SQL server architecture includes a database engine and SQL server operation system (SQLOS)
SQL server offers a set of tools for working with data effectively.
SQL server has different editions including developer edition, expression, enterprise, and standard.  


Install SQL Server
Summary: in this tutorial, you will learn to install SQL Server 2022 Developer Edition and SQL Server Management Studio (SSMS).

Install SQL Server 2022 Developer Edition 
Download SQL Server 2022 
To download SQL Server 2022, click the link below:

Download the SQL Server

Microsoft offers some editions of SQL Server. For learning purposes, you can download the Developer edition.

Step 1. The downloader will ask you to select the installation type. Choose the Download Media option, which allows you to download the setup files first and install the SQL Server later:


Step 2. Choose the folder to store the installation files, then click the Download button:


Step 3. The downloader will start downloading the installation files. This process may take some minutes, depending on your internet speed.


Step 4. Once the download is complete, open the folder where the downloaded file is stored:

Step 5. Open the SQLServer2022-DEV-x64-ENU file to launch the installation. It will extract the files to a directory and start the installation process.

Install SQL Server 2022 developer edition 
Step 1. After launching the installer, the SQL Server Installation Center window appears; select the Installation option on the left:


Step 2. Select the Developer edition to install and click the Next button:


Step 3. Check the “I accept the license terms.” and click the Next button:


Step 4. If you don’t want to get the updates for the SQL Server, uncheck the “Use Microsoft Update to check for updates (recommended)” option, and then click the Next button:


Step 5. The installation will check for prerequisites before proceeding. If no error occurs, click the Next button:


Step 6. Uncheck the Aruze extension for SQL Server:


Step 7. Select the features you want to install. For learning purposes, you need the Database Engine Services, and click the Next button to continue:


Step 8. Enter the instance ID of the SQL Server and click the Next button. The instance ID defaults to MSSQLServer:


Step 9.  Specify the service accounts and collation configuration. Use the default settings and click the Next button:


Step 10.  Specify database engine authentication security mode. Select the Mixed Mode (1), and enter the password for system administration (sa) account (2& 3), and add the current user as a SQL Server Administrator (4):


Make sure to store this password in a secure place, as you’ll need it to connect to the SQL Server later.

Step 11. Verify that the SQL Server 2022 features are installed.



Step 12. Click the Close button to complete the installation.

Congratulation!  you have successfully installed SQL Server 2022 Developer Edition.

Microsoft SQL Server Management Studio (SSMS) 
To interact with SQL Server, you can use a SQL Server client tool such as SQL Server Management Studio (SSMS) provided by Microsoft.

The SQL Server Management Studio is software for querying, designing, and managing SQL Server on your local computer, a remote server, or in the cloud. It provides you with tools to configure, monitor, and administer SQL Server instances.

Download SQL Server Management Studio 
First, download the SSMS from the Microsoft website via the following link:

Download SQL Server Management Studio

Second, double-click the installation file SSMS-Setup-ENU.exe to launch the installer. The installation process of SMSS is straightforward. you need to follow the screen sequence.

Install SQL Server Management Studio 
Step 1. Click the Install button:


Step 2. Wait for a few minutes while the installer setting up the software:


Step 3. Once setup is completed, click the Close button:


Now, you should have SQL Server 2022 and SQL Server Management Studio installed on your computer. Next, you will learn how to connect to the SQL Server from the SQL Server Management Studio.

Connect to the SQL Server
Summary: in this tutorial, you will learn how to connect to SQL Server from the SQL Server Management Studio and execute a query.

Connect to the SQL Server using SSMS 
To connect to the SQL Server using the Microsoft SQL Server Management Studio, follow these steps:

Step 1. Launch the Microsoft SQL Server Management Studio:


Step 2. Choose the Database Engine…  from the Connect menu under the Object Explorer:


Step 3. Enter the following information:

Server Type: Database Engine
Server name: localhost
Authentication: SQL Server Authentication
Login: sa
Password: (The one you entered during the installation.)
Check the Remember Password.
Encryption: Optional
Click the Connect button to connect to the SQL Server:

Connect to Local Server Server
If the connection is successful, you will see the following Object Explorer panel:

Connect Microsoft SQL Server Management Studio
Execute a query 
To execute a query you follow these steps:

First, right-click on the localhost (SQL Server …) node and choose the New Query menu item:


Second, enter the following query in the Editor

select @@version;
Code language: SQL (Structured Query Language) (sql)
This query returns the version of the SQL Server.

Third, click the Execute button:


The Results window shows the version of the SQL Server as shown in the above screenshot. A quick way to execute a query is to press the F5 keyboard shortcut.

Now, you should know how to connect to an SQL Server and execute a query from the SSMS.

SQL Server Sample Database
Summary: in this tutorial, you’ll learn about the SQL Server sample database called BikeStores.

The following illustrates the BikeStores database diagram:


As you can see from the diagram, the BikeStores sample database has two schemas sales and production, and these schemas have nine tables.

Database Tables 
Table sales.stores 
The  sales.stores table includes the store’s information. Each store has a store name, contact information such as phone and email, and an address including street, city, state, and zip code.

CREATE TABLE sales.stores (
	store_id INT IDENTITY (1, 1) PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);
Code language: SQL (Structured Query Language) (sql)
Table sales.staffs 
The  sales.staffs table stores the essential information of staffs including first name, last name. It also contains the communication information such as email and phone.

A staff works at a store specified by the value in the store_id column. A store can have one or more staffs.

A staff reports to a store manager specified by the value in the manager_id column. If the value in the manager_id is null, then the staff is the top manager.

If a staff no longer works for any stores, the value in the active column is set to zero.

CREATE TABLE sales.staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	FOREIGN KEY (store_id) 
        REFERENCES sales.stores (store_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) 
        REFERENCES sales.staffs (staff_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
Code language: SQL (Structured Query Language) (sql)
Table production.categories 
The production.categories table stores the bike’s categories such as children bicycles, comfort bicycles, and electric bikes.

CREATE TABLE production.categories (
	category_id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Table production.brands 
The  production.brands table stores the brand’s information of bikes, for example, Electra, Haro, and Heller.

CREATE TABLE production.brands (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
Table production.products 
The production.products table stores the product’s information such as name, brand, category, model year, and list price.

Each product belongs to a brand specified by the brand_id column. Hence, a brand may have zero or many products.

Each product also belongs a category specified by the category_id column. Also, each category may have zero or many products.

CREATE TABLE production.products (
	product_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) 
        REFERENCES production.categories (category_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) 
        REFERENCES production.brands (brand_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);
Code language: SQL (Structured Query Language) (sql)
Table sales.customers 
The  sales.customers table stores customer’s information including first name, last name, phone, email, street, city, state and zip code.

CREATE TABLE sales.customers (
	customer_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);
Code language: SQL (Structured Query Language) (sql)
Table sales.orders 
The sales.orders table stores the sales order’s header information including customer, order status, order date, required date, shipped date.

It also stores the information on where the sales transaction was created (store) and who created it (staff).

Each sales order has a row in the sales_orders table. A sales order has one or many line items stored in the sales.order_items table.

CREATE TABLE sales.orders (
	order_id INT IDENTITY (1, 1) PRIMARY KEY,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_date DATE NOT NULL,
	required_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) 
        REFERENCES sales.customers (customer_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) 
        REFERENCES sales.stores (store_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) 
        REFERENCES sales.staffs (staff_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
Code language: SQL (Structured Query Language) (sql)
Table sales.order_items 
The sales.order_items table stores the line items of a sales order. Each line item belongs to a sales order specified by the order_id column.

A sales order line item includes product, order quantity, list price, and discount.

CREATE TABLE sales.order_items(
	order_id INT,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (order_id, item_id),
	FOREIGN KEY (order_id) 
        REFERENCES sales.orders (order_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) 
        REFERENCES production.products (product_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);
Code language: SQL (Structured Query Language) (sql)
Table production.stocks 
The production.stocks table stores the inventory information i.e. the quantity of a particular product in a specific store.

CREATE TABLE production.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) 
        REFERENCES sales.stores (store_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) 
        REFERENCES production.products (product_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);
Code language: SQL (Structured Query Language) (sql)
Click the following link to download the sample database script:


Load Sample Database
Summary: in this tutorial, you will learn how to create a new database in SQL Server and execute the script to load the sample database.

First, you need to download the following zip file if you have not done so:

Download SQL Server Sample Database

Second, uncompress the zip file, you will see three SQL script files:

 BikeStores Sample Database - create objects.sql – this file is for creating database objects including schemas and tables.
 BikeStores Sample Database - load data.sql – this file is for inserting data into the tables
 BikeStores Sample Database - drop all objects.sql – this file is for removing the tables and their schemas from the sample database. It is useful when you want to refresh the sample database.
Third, let’s create a database, create the schemas and tables, and load the sample data.

Step 1 
Connect to the SQL Server by (1) choosing the server name, (2) enter the user and (3) password and (4) click the Connect button.


Step 2 
Right-click the Databases node in the Object Explorer and select the New Database… menu item


Step 3 
(1) Enter the Database name as BikeStores and (2) click the OK button to create the new database.


Step 4 
If everything is fine, you will see the database BikeStores appears under Databases node as shown in the screenshot below:


Step 5 
From the File menu, choose Open > File… menu item to open a script file.


Step 6 
Select the BikeStores Sample Database – create objects.sql file and click the Open button


Step 7 
Click the Execute button to execute the SQL script.


You should see the following result indicated that the query executed successfully.


If you expand the BikeStores > Tables, you will see the schemas and their tables are created as shown below:


Step 8 
Open the file for loading data into the tables.


Step 9 
Choose the BikeStores Sample Database – load data.sql file and click the Open button.


Step 10 
Click the Execute button to load data into the tables.

You should see the following message indicating that all the statements in the script were executed successfully.


In this tutorial, you have learned how to load the BikeStores sample database into the SQL Server.   


Import Data All tables from bike store sample database