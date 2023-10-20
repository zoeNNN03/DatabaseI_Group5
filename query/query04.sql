-- อาจเปลี่ยนเป็นการคิดกำไลของทุกสินค้าที่ขายได้ในร้านค้าที่กำหนด
-- อยากมี payment ด้วย แต่ตอนนี้ ขก ค่อยทำ
PRAGMA foreign_keys = ON;
.print "Query04 : Online order."
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