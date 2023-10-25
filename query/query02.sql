PRAGMA foreign_keys = ON;
.print 'Query02 : The amount of revenueb of stores in 2023 or Online order.'
SELECT store.store_name as 'Store Name',
    SUM(quantity*unit_price) as 'Revenue(BATH)' -- sum of quantity mutiply by unit price
FROM orderRecord
INNER JOIN orderItem ON orderItem.order_id = orderRecord.order_id
INNER JOIN store ON store.store_id = orderItem.store_id
INNER JOIN product ON product.product_id = orderItem.product_id
-- get only the year 2023 and completed order status because we want to get the revenue of the store in 2023
WHERE orderRecord.order_status == 'Completed' AND 
    strftime('%Y', orderRecord.date_order) = '2023'
GROUP BY orderItem.store_id;

-- Path: query/query02.sql