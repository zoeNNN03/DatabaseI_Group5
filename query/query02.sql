PRAGMA foreign_key=ON;
.print 'Query02 : The amount of revenue of stores in 2023.'
SELECT store.store_name as 'Store Name',
    product.product_name as 'Product Name',
    SUM(quantity)*unit_price as 'Revenue',
    status_order
FROM orderRecord
INNER JOIN orderItem ON orderItem.order_id = orderRecord.order_id
INNER JOIN store ON store.store_id = orderItem.store_id
INNER JOIN product ON product.product_id = orderItem.product_id
WHERE orderRecord.status_order == 'Succeed' AND 
    strftime('%Y', orderRecord.date_order) = '2023'
GROUP BY orderItem.store_id