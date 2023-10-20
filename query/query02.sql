-- อาจเปลี่ยนเป็น Online order

PRAGMA foreign_key=ON;
.print 'Query02 : The amount of revenue of stores in 2023 or Online order.'
SELECT store.store_name as 'Store Name',
    SUM(quantity*unit_price) as 'Revenue'
FROM orderRecord
INNER JOIN orderItem ON orderItem.order_id = orderRecord.order_id
INNER JOIN store ON store.store_id = orderItem.store_id
INNER JOIN product ON product.product_id = orderItem.product_id
WHERE orderRecord.status_order == 'Succeed' AND 
    strftime('%Y', orderRecord.date_order) = '2023'
GROUP BY orderItem.store_id;

-- qurey Online order in orderRecord and detail
SELECT orderRecord.order_id AS "Order",
    orderRecord.date_order AS "Date",
    orderRecord.online_status AS "Online Status",
    GROUP_CONCAT(orderItem.product_id, '
') AS "Product ID",
    GROUP_CONCAT(orderItem.quantity, '
') AS "Quantity",
    GROUP_CONCAT(product.unit_price, '
') AS "Unit Price",
    SUM(orderItem.quantity*product.unit_price) AS "total_price",
    employee.f_name||' '||employee.l_name AS "Manage"
FROM orderRecord
INNER JOIN employee ON employee.employee_id = orderRecord.employee_id
INNER JOIN orderItem ON orderItem.order_id = orderRecord.order_id
INNER JOIN product ON product.product_id = orderItem.product_id
WHERE orderRecord.online_status = 1
GROUP BY orderItem.order_id;


-- , (
--     -- total price of each product  in orderItem
--     SELECT 
--         SUM(orderItem.quantity * product.unit_price) AS total_price
--     FROM orderItem
--     INNER JOIN product ON product.product_id = orderItem.product_id
--     GROUP BY orderItem.order_id
-- )