-- Piyush Choudhari TEAIDA26
select * from categories;

update categories
set category = 'Fintech'
where category_id = 1;


create view category_view as
select category_id, category from categories;
select * from category_view;

-- Piyush Choudhari TEAIDA26

select * from products
where products.product_name = 'Laptop' and products.model_year > 2022;







