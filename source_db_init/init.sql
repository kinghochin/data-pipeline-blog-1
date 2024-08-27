CREATE TABLE wines (
    product_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    price DECIMAL(5,2),
    user_rating DECIMAL(2,1) CHECK (user_rating >= 1 AND user_rating <= 5)
);

INSERT INTO wines (title, release_date, price, user_rating) VALUES
('J P Chenet Sauvignon Blanc 75Cl', '2024-07-16', 12.99, 4.8),
('Lillet Rosé Wine-Based Aperitif 75cl', '2024-07-16', 9.99, 4.9),
('19 Crimes Red Wine 75Cl', '2024-07-16', 19.99, 2.9),
('Freixenet Brut Royal 75cl', '2024-07-16', 11.99, 4.5);

CREATE TABLE wine_category (
    category_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES wines(product_id),
    category_name VARCHAR(50) NOT NULL
);

INSERT INTO wine_category (product_id, category_name) VALUES
(1, 'white'),
(1, 'italian'),
(2, 'red'),
(3, 'sparkling'),
(3, 'french'),
(4, 'rose'),
(4, 'french');

CREATE TABLE grapes (
    grape_id SERIAL PRIMARY KEY,
    grape_name VARCHAR(255) NOT NULL
);

CREATE TABLE wine_grapes (
    product_id INTEGER REFERENCES wines(product_id),
    grape_id INTEGER REFERENCES grapes(grape_id),
    PRIMARY KEY (product_id, grape_id)
);

INSERT INTO grapes (grape_name) VALUES
('Cabernet Sauvignon'), 
('Cabernet Franc'),
('Grenache'),
('Malbec'),
('Chardonnay'),
('Sauvignon blanc'),
('Shiraz');

INSERT INTO wine_grapes (product_id, grape_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 7),
(4, 4),
(4, 5),
(4, 6);
