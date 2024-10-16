create table categories (
	category_id int,
    category varchar(255),
    primary key(category_id)
);

INSERT INTO categories (category_id, category) 
VALUES 
(1, 'Technology'),
(2, 'Health'),
(3, 'Education'),
(4, 'Sports'),
(5, 'Entertainment'),
(6, 'Science'),
(7, 'Finance'),
(8, 'Travel'),
(9, 'Fashion'),
(10, 'Food');
