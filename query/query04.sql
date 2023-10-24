PRAGMA foreign_keys = ON;
.print 'Query04 : TOP 3 Employee who makes'
.print 'the most profit.'
SELECT employee.f_name,
    employee.l_name,
    SUM(product.unit_price * orderItem.quantity) AS "total_sales(bath)"
FROM employee
JOIN orderRecord ON orderRecord.employee_id = employee.employee_id
JOIN orderItem ON orderItem.order_id = orderRecord.order_id
JOIN product ON product.product_id = orderItem.product_id
GROUP BY employee.f_name, employee.l_name
HAVING "total_sales(bath)" > 1000
ORDER BY "total_sales(bath)" DESC
LIMIT 3;