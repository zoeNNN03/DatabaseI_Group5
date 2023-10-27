-- This is a query to show best selling products of each store. by using RANK() OVER (PARTITION BY store.store_id ORDER BY SUM(quantity) DESC) AS Ranking

PRAGMA foreign_keys = ON; -- enable foreign key
.print "Query01 : Best Selling Products of Each Store" -- set encoding to UTF-8
SELECT Store AS "Store Name",
    Product AS "Product Name",
    Quantity,
    Total AS "Total Sales(BAHT)"
FROM (SELECT store_name AS Store,
        product_name AS Product,
        SUM(quantity) AS Quantity, -- sum of quantity
        SUM(unit_price * quantity) AS Total, -- sum of unit price mutiply by quantity
        RANK() OVER (PARTITION BY store.store_id -- partition the store by store_id
                    ORDER BY SUM(quantity) DESC) AS Ranking -- rank the product by quantity
    FROM orderItem
    INNER JOIN store ON store.store_id = orderItem.store_id
    INNER JOIN product ON product.product_id = orderItem.product_id
    GROUP BY store.store_id, product.product_id)
WHERE Ranking = 1 -- get only the first rank
ORDER BY Store;

-- Path: query/query01.sql
