-- This is a query Online order in orderRecord and detail. by using GROUP_CONCAT(product_upc, '

PRAGMA foreign_keys = ON;
.print "Query03 : qurey Online order in orderRecord and detail."
SELECT orderRecord.order_id AS "Order",
    orderRecord.date_order AS "Date",
    orderRecord.online_status AS "Online Status",
-- group concat for get all product_id, unit_price and quantity in one row if there are more than one product in one order of each order
    GROUP_CONCAT(product.product_upc, '
') AS "UPC Code",
    GROUP_CONCAT(orderItem.quantity, '
') AS "Quantity",
    GROUP_CONCAT(product.unit_price, '
') AS "Unit Price(BAHT)",
-- sum of quantity mutiply by unit price
    SUM(orderItem.quantity*product.unit_price) AS "total_price(BAHT)",
-- employee name who make the order by concat first name and last name as one column
    employee.f_name||' '||employee.l_name AS "Manage"
FROM orderRecord
INNER JOIN employee ON employee.employee_id = orderRecord.employee_id
INNER JOIN orderItem ON orderItem.order_id = orderRecord.order_id
INNER JOIN product ON product.product_id = orderItem.product_id
WHERE orderRecord.online_status = 1 -- get only online order
GROUP BY orderItem.order_id;

-- Path: query/query03.sql