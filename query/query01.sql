PRAGMA foreign_keys = ON;
.print "Query01 : Best Selling Products of Each Store"
SELECT Store AS "Store Name",
    Product AS "Product Name",
    Quantity,
    Total AS "Total Sales(BAHT)"
FROM (SELECT store_name AS Store,
        product_name AS Product,
        SUM(quantity) AS Quantity,
        SUM(unit_price * quantity) AS Total,
        RANK() OVER (PARTITION BY store.store_id 
                    ORDER BY SUM(quantity) DESC) AS Ranking
    FROM orderItem
    INNER JOIN store ON store.store_id = orderItem.store_id
    INNER JOIN product ON product.product_id = orderItem.product_id
    GROUP BY store.store_id, product.product_id)
WHERE Ranking = 1
ORDER BY Store;
