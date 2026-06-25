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
