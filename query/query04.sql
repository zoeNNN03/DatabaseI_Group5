PRAGMA foreign_key=ON;
.print "Query04 : From question 3, list of all products ordered from BUUshop (sorted by product name from lowest to highest)."
SELECT DISTINCT(product_name) AS 'Product Name',
    SUM(orderItem.quantity) AS 'Quantity'
FROM orderRecord
INNER JOIN orderItem ON orderItem.order_id = orderRecord.order_id
INNER JOIN storeProduct ON storeProduct.product_id = orderItem.product_id
INNER JOIN product ON product.product_id = orderItem.product_id
WHERE orderRecord.online_status = 1 AND
    storeProduct.store_id = 2
GROUP BY product_name
ORDER BY product_name ASC;