PRAGMA foreign_keys = ON;
.print 'Query02 : The amount of revenue'
.print 'of stores in 2023 or Online order.'
SELECT store.store_name as 'Store Name',
    SUM(quantity*unit_price) as 'Revenue(BATH)'
FROM orderRecord
INNER JOIN orderItem ON orderItem.order_id = orderRecord.order_id
INNER JOIN store ON store.store_id = orderItem.store_id
INNER JOIN product ON product.product_id = orderItem.product_id
WHERE orderRecord.order_status == 'Completed' AND 
    strftime('%Y', orderRecord.date_order) = '2023'
GROUP BY orderItem.store_id;
