-- This is a query to show best selling products of each store. by using RANK() OVER (PARTITION BY store.store_id ORDER BY SUM(quantity) DESC) AS Ranking

PRAGMA foreign_keys = ON; -- enable foreign key
.print "Query01 : Best Selling Products of Each Store" -- set encoding to UTF-8
SELECT Store AS "Store Name",
    Product AS "Product Name",
    Quantity,
    Total AS "Total Sales(BAHT)"
FROM (SELECT store_name AS Store,
        product_name AS Product,
        SUM(quantity) AS Quantity,
        SUM(unit_price * quantity) AS Total,
        RANK() OVER (PARTITION BY store.store_id 
                    ORDER BY SUM(quantity) DESC) AS Ranking -- ranking by quantity of each product in each store order by descending
    FROM orderItem
    INNER JOIN store ON store.store_id = orderItem.store_id
    INNER JOIN product ON product.product_id = orderItem.product_id
    GROUP BY store.store_id, product.product_id) -- subquery for ranking
WHERE Ranking = 1 -- get only the best selling product of each store
ORDER BY Store;

-- Path: query/query01.sql