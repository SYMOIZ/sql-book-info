Table production.categories 
The production.categories table stores the bike’s categories such as children bicycles, comfort bicycles, and electric bikes.

CREATE TABLE production.categories (
	category_id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
