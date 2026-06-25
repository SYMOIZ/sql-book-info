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
