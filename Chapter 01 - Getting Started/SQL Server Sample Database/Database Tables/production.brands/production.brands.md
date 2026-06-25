Table production.brands 
The  production.brands table stores the brand’s information of bikes, for example, Electra, Haro, and Heller.

CREATE TABLE production.brands (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);
Code language: SQL (Structured Query Language) (sql)
