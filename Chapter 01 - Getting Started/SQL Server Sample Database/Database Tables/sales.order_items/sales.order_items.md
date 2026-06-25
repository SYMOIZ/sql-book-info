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
