-- Piyush Choudhari TEAIDA26
create table products (
	product_id int,
    product_name varchar(255),
    brand_id int,
    category_id int,
    model_year year,
    list_price int,
    primary key(product_id),
    foreign key(brand_id) references brands(brand_id),
    foreign key(category_id) references categories(category_id)
);

alter table products
add column color varchar(10);
-- TEAIDA26
alter table products
drop column color;

describe products;

INSERT INTO products (product_id, product_name, brand_id, category_id, model_year, list_price)
VALUES
(1, 'Laptop', 1, 1, 2023, 1200),
(2, 'Smartphone', 2, 1, 2022, 800),
(3, 'Fitness Tracker', 3, 2, 2021, 150),
(4, 'Basketball', 4, 4, 2023, 50),
(5, 'TV', 5, 5, 2022, 1000),
(6, 'Microscope', 6, 6, 2021, 300),
(7, 'Guitar', 7, 5, 2023, 500),
(8, 'Backpack', 8, 8, 2022, 100),
(9, 'Running Shoes', 9, 4, 2023, 120),
(10, 'Blender', 10, 10, 2021, 70);