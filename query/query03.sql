PRAGMA foreign_keys = ON;
.print 'Query03 : TOP 3 Employee.'
SELECT employee.f_name,
    employee.l_name,
    SUM(product.unit_price * orderItem.quantity) AS total_sales
FROM employee
JOIN orderRecord ON orderRecord.employee_id = employee.employee_id
JOIN orderItem ON orderItem.order_id = orderRecord.order_id
JOIN product ON product.product_id = orderItem.product_id
GROUP BY employee.f_name, employee.l_name
HAVING total_sales > 1000
ORDER BY total_sales DESC
LIMIT 3;