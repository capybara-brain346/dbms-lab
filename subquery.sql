-- Piyush Choudhari TEAIDA26
select products.product_name, categories.category
from products, categories
where product_id in (select products.product_id from products where products.list_price > 500);