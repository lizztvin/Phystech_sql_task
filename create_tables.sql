CREATE TABLE public.customer_and_transaction_1nf (
	transaction_id int4 NOT NULL,
	product_id int4 NOT NULL,
	customer_id int4 NOT NULL,
	transaction_date date NOT NULL,
	online_order bool NULL,
	order_status varchar(50) NULL,
	brand varchar(100) NULL,
	product_line varchar(100) NULL,
	product_class varchar(50) NULL,
	product_size varchar(50) NULL,
	list_price numeric(10, 2) NULL,
	standard_cost numeric(10, 2) NULL,
	CONSTRAINT customer_and_transaction_1nf_pkey PRIMARY KEY (transaction_id)
);

CREATE TABLE products_2NF (
    product_id SERIAL PRIMARY KEY,
    brand VARCHAR(100) NOT NULL,
    product_line VARCHAR(100),
    product_class VARCHAR(50),
    product_size VARCHAR(50),
    UNIQUE (brand, product_line, product_class, product_size)
);

CREATE TABLE transactions_2NF (
    transaction_id INTEGER PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products_2NF(product_id),
    customer_id INTEGER NOT NULL,
    transaction_date DATE NOT NULL,
    online_order BOOLEAN,
    order_status VARCHAR(50),
    list_price DECIMAL(10,2),
    standard_cost DECIMAL(10,2)
);

CREATE TABLE brands_3NF (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(100) UNIQUE
);

CREATE TABLE product_lines_3NF (
    product_line_id SERIAL PRIMARY KEY,
    product_line_name VARCHAR(100) UNIQUE
);

CREATE TABLE product_classes_3NF (
    product_class_id SERIAL PRIMARY KEY,
    product_class_name VARCHAR(50) UNIQUE
);

CREATE TABLE product_sizes_3NF (
    product_size_id SERIAL PRIMARY KEY,
    product_size_name VARCHAR(50) UNIQUE
);

CREATE TABLE brand_product_lines_3NF (
    brand_id INTEGER NOT NULL REFERENCES brands_3NF(brand_id),
    product_line_id INTEGER NOT NULL REFERENCES product_lines_3NF(product_line_id),
    PRIMARY KEY (brand_id, product_line_id)
);

CREATE TABLE products_3NF (
    product_id SERIAL PRIMARY KEY,
    brand_id INTEGER NOT NULL REFERENCES brands_3NF(brand_id),
    product_line_id INTEGER REFERENCES product_lines_3NF(product_line_id),
    product_class_id INTEGER REFERENCES product_classes_3NF(product_class_id),
    product_size_id INTEGER REFERENCES product_sizes_3NF(product_size_id),
    UNIQUE (brand_id, product_line_id, product_class_id, product_size_id)
);

CREATE TABLE transactions_3NF (
    transaction_id INTEGER PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products_3NF(product_id),
    customer_id INTEGER NOT NULL,
    transaction_date DATE NOT NULL,
    online_order BOOLEAN,
    order_status VARCHAR(50),
    list_price DECIMAL(10,2),
    standard_cost DECIMAL(10,2)
);