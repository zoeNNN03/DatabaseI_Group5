-- This is a query to show amount of revenue of stores in 2023 or Online order. by using SUM(quantity*unit_price) AS "Revenue(BAHT)"

PRAGMA foreign_keys = ON;
.print 'Query02 : The amount of revenue of stores in 2023.'
SELECT store.store_name as 'Store Name',
    SUM(quantity*unit_price) as 'Revenue(BAHT)' -- sum of quantity mutiply by unit price
FROM orderRecord
INNER JOIN orderItem ON orderItem.order_id = orderRecord.order_id
INNER JOIN store ON store.store_id = orderItem.store_id
INNER JOIN product ON product.product_id = orderItem.product_id
WHERE orderRecord.order_status == 'Completed' AND 
    strftime('%Y', orderRecord.date_order) = '2023'
GROUP BY orderItem.store_id;
