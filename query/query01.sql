PRAGMA foreign_key=ON;
-- .print "Query01 : BUU Group's top3 best-selling product."
-- SELECT store_name AS 'Store Name',
--     product_name AS 'Product Name',
--     sum(orderItem.quantity) AS 'Quantity'
-- FROM orderItem
-- INNER JOIN store ON store.store_id = orderItem.store_id
-- INNER JOIN product ON product.product_id = orderItem.product_id
-- WHERE store.store_name LIKE 'BUU%'
-- GROUP BY orderItem.store_id, orderItem.product_id
-- ORDER BY sum(orderItem.quantity) DESC
-- LIMIT 3;

.print "Query01 : BUU Group's top3 best-selling product."
SELECT store_name AS 'Store Name',
    product_name AS 'Store Name',
    sum(orderItem.quantity) AS 'Quantity',
    unit_price * quantity AS 'Profit'
FROM orderItem
INNER JOIN store ON store.store_id = orderItem.store_id
INNER JOIN product ON product.product_id = orderItem.product_id
WHERE store_name LIKE 'BUU%'
GROUP BY orderItem.store_id , orderItem.product_id
ORDER BY sum(orderItem.quantity) DESC
LIMIT 3;