-- This is a query to show TOP 3 Employee who makes the most profit. by using SUM(product.unit_price * orderItem.quantity) AS "total_sales(BAHT)"   

PRAGMA foreign_keys = ON;
.print 'Query04 : TOP 3 Employee who makes the most profit.'
SELECT employee.f_name,
    employee.l_name,
    SUM(product.unit_price * orderItem.quantity) AS "total_sales(BAHT)"
FROM employee
JOIN orderRecord ON orderRecord.employee_id = employee.employee_id
JOIN orderItem ON orderItem.order_id = orderRecord.order_id
JOIN product ON product.product_id = orderItem.product_id
GROUP BY employee.f_name, employee.l_name -- group by employee name for get the sum of total sales of each employee
HAVING "total_sales(BAHT)" > 1000 -- get only employee who makes the most profit more than 1000
ORDER BY "total_sales(BAHT)" DESC -- order by descending
LIMIT 3; -- get only top 3 employee who makes the most profit

-- Path: query/query04.sql
