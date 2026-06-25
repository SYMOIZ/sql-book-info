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


